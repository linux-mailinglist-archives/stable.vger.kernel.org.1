Return-Path: <stable+bounces-83208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B37996B8F
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 15:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E115281353
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 13:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F56194091;
	Wed,  9 Oct 2024 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="TtJ3oyNF"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2117.outbound.protection.outlook.com [40.107.22.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF09C192B88
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728479792; cv=fail; b=RcIWYHx2YXrO+lstVuUM6rNacABDKcS8u6aTrkMhfipczXzdXCgMVcxL0BGvQ6MD5B1CjVzQIpUgN859e7C6ge5Hc/4J0uGNvlc4y3FQgjGbzGHrHB7pWo5IEao7AdVzT31Ryaljk24dxnYtfoSxmqu22kw8xaBV8hLkqexzNvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728479792; c=relaxed/simple;
	bh=D5yOI+OXM2U9r84J2byyU+b7veAN2R7o8UCo2v3zNis=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jGBLu5o0MDm3bKBvQTJyZE+LMdIIaYnBbYjaY5KnCYsQKNeVHHoSJav+rntiulbfNhNjhNNvWaUzhb8/UqQv8y0TQTFZr6jRNK6njIkqXbr+7TFr3sfbMVoVJ7GxqeMS07EuURe8z7WsZ4MDLa2OT4cIEdSnsI92RpGf97GCX3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=TtJ3oyNF; arc=fail smtp.client-ip=40.107.22.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZ9Z3oa/GF6z0zYUMJa0KOSM+YBpEplJtwuQ+1+gOHCy756LTqIEgC2bRcuJrdHa+uowImuoJCXJ5obpy4GhbZeeCMpsKHMNplgEV1SR8Hr8mFDR082m654WDRbw1XUAXi/Ov5GDyhsG8B39xKJcS+4/GELCrIHVLtcdL4WOa1mx0JcKB058uBZqRxKdC6WTLiYfOpa4Sr+fA8NHtTpfmnw+ZXRa5VppFg3Q0Hf5dtZwhHWYEggTxzW0IOCHk1BXhEYxKtReJ7r5/roVsVpJA+Qpx8knvSK26F8CvU961N4AAz2hZjQ014U5J3u2sdm/cL382immU0vr/1YnXS/Nzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFVHWyvoShcn0W7XcjBx1kntLnPnLlhpIGRoAY69CsY=;
 b=RyXiBwoJbT/f8EhSTfVnNNyO+1aURjMy3NVBd/a0crL95NI7OefCwM1wxsa6qQh1AwdwYJ/dHizqw71rDxnCtWoogf/wV5GxgC1U5xtOPzDFhwPWj9siFCfhQblO6qLKIh+L2MoKyR2nXk4ZATM5eXcrYR4/sFvE0rFC+C48fyUINcuTF1/Z/RC45JpgUj501mUrTun9SZB9/H+XbZJlcwNXJG10jj6LmY2Kw2eHB7jcV5fD8QcTkZw9SH7TgPjhgxJRxVxzpynGH6WEMi2lkWyY4KJm6gQSmYJoH7aEkLM2VbVMDqq9dJwnYdnqZzaKbTj7cRkWoY2XMMqS7OFKXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFVHWyvoShcn0W7XcjBx1kntLnPnLlhpIGRoAY69CsY=;
 b=TtJ3oyNF8oWPoQsD9kotYpI/RtxqUOqwJ8DdTJVhfWM+Y45jCL1omW8cthVgHA4LoNRAArflqqIOgB/iLM+mgc/HIFo2I+BGvH7gFD3QzUXjWNiwrMQXAf/fgGYXo4okTnZ3W1mSTlUdCDaqEocj18rUonlZ1gWTOkcLnx5swOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by GVXPR10MB8313.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 13:16:25 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 13:16:25 +0000
Message-ID: <adce33d0-f68d-4bef-bd37-accdc2e83dde@kontron.de>
Date: Wed, 9 Oct 2024 15:16:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mtd: spi-nand: winbond: Fix 512GW and 02JW OOB layout
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <michael@walle.cc>,
 linux-mtd@lists.infradead.org
Cc: Steam Lin <stlin2@winbond.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Md Sadre Alam <quic_mdalam@quicinc.com>,
 Sridharan S N <quic_sridsn@quicinc.com>, stable@vger.kernel.org
References: <20241009125002.191109-1-miquel.raynal@bootlin.com>
 <20241009125002.191109-2-miquel.raynal@bootlin.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20241009125002.191109-2-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::11) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|GVXPR10MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: e5bae75f-0390-405d-2775-08dce8649383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXdleUhhb1owQnB5WnhjUFpDYUNNWnB2RzM5U1lVKzJRL2MzQ2pQb3ZKVG1T?=
 =?utf-8?B?UHVibkd2WEoyL1FYQ3JzYW5TOUoyZXIvMGg5OVFZYzRLUUxJVjYxczJ0aE42?=
 =?utf-8?B?amVyMlFwYUxJYUEzdGhCV0RZSGpXMWdxZUZ1QkhHYStBMFFMeEN2YS9XWno5?=
 =?utf-8?B?K2JHd3hsSWFEOTV4aTA5cWZvQVo1VVl5RityVEtrQmlneFhaNzcvRUdPZHZx?=
 =?utf-8?B?NmhmUjJYcUdsSUUwc3JGeXRKcXRVYTFsZDQ1VVRmM1lUaVhadWJJTk5KaEJm?=
 =?utf-8?B?b0djaWNGZm5BUnZQU0p5VzRoOVVQbEpEY1h1WjlUWURNTGY4WTJ4UGRPUjJu?=
 =?utf-8?B?bXhkZzNHWmtmc244Z1AreUV4cS9IWXBXTUgxMzJvR1UzWWorSmt1RGFlSjRZ?=
 =?utf-8?B?ZTJkRjk4ZUV0a0UvS29xUk5Jck9VMGxBbFpSR3VFZDkwckdYWEdTVVkvbUQ0?=
 =?utf-8?B?a1UwVFRpV0I1dGw0VnJIczF3aHFDTGM5M0R2bE5Qd05EVW5ERXRLM00zdEFR?=
 =?utf-8?B?RXdYdVc1dU0zQjRhdWFabkc1eG1ta2FXTmdPMFRLWkRIUlZ6NEJQUXd0Z2dP?=
 =?utf-8?B?WHJjTU9GWkhaTjhELzlNei9HbUJhRGkvV1hwckUzc3l5Z0R5OWY3MWpnL2cx?=
 =?utf-8?B?ZnY1VGFLbEdtUmc4dzJUQ0s2eHNCcERhSDR2TmwvMkNsOTRiMktEeHA2c2VQ?=
 =?utf-8?B?cnBLblpuTStGQ3ZuYlRrR0M4Z0puWStDUU8vSFB3aXNNSTAxR25wUzhxLzJn?=
 =?utf-8?B?c2VSZ1V5NWdFVi9yUFgwODlrZlJyMVhLSEpJbm9IbHBzdnIyYzhwYktpWnBa?=
 =?utf-8?B?eUg2ZVkrWEx6VDJvT29nK0R2Z3RnMjN4aXFBYU5lNDNuUXdmSFdVc2h3bVpn?=
 =?utf-8?B?cEZNcnpyQ05ZWUgxd0x2Q0t6d01aOXdpM3RWcFVlSkI2TGN0UU5pdnBoWVVy?=
 =?utf-8?B?cFVJQ1J5ejJ0aU53ZmhHbkd2Y2s3UkhkcG9ELzNYS29UditzSjhyMnVzUndx?=
 =?utf-8?B?QVNpa2ZmSjJ4R2J5S2d2a1QrL2xFUE9acFo3MzFRUHBrZGFMQUM5b3dNNHBD?=
 =?utf-8?B?c1hxOG5IaW9GVXJIOWVnZ0NBazNCeW40UFZFQjFKTm1ZcXI4d00raWJOcFlC?=
 =?utf-8?B?YXRLdUdyNUhqQ2dSTlpPY1cybktLaW9vMjFiNUxXa2NYcXpUREMyRW8xTUpQ?=
 =?utf-8?B?ajhxS2JkcWFPMU5EUHQ2d3plUm1xR0Z3dkhrcDRVVS96MXVkZU9YZ3pTMWE0?=
 =?utf-8?B?b2M4QjkwbjFVVGVzZHdGYmpxbUFGcjJPSTJ0UTVBaVVhaWdhRS96VUJ0dGFF?=
 =?utf-8?B?dEVzaHlNS1lRdXVoblNWTmM2a1oxc2IvOXlTNG9VcTBjbGI0Z1pzNVBHZ2l6?=
 =?utf-8?B?Y2N5QnB1ZTF1R1FWNFVCRWNkMjJjN3h0NCszOGlyakdKSHg3RStyUitEaHQ2?=
 =?utf-8?B?OXg5MTNhWk50T2JEcDVqU05lRkk5YnhKeDRvMVkzamZhM1EwRlFXR210SzYz?=
 =?utf-8?B?bTJNMzl3UFNYN1NQaU1aQVlqZHRlWDJkVE5QbE44R3NGeTJYWkN0aVJ2QTZI?=
 =?utf-8?B?NElGcXZQczZsZDhMNlZ4cEswWHJUUmZ6bFpXNmpzWlFnMlBybjQ3M2JDbEFw?=
 =?utf-8?B?Qm5wVXVIZDkxTkRseHJGblpxSUZVdHRya2VvcTJLZ1YxUnJDZWJYR0luQXBK?=
 =?utf-8?B?RFpxUVAwUWFtQmduNS85L0dWQXNObXMxUTMyRlhKVWdZK3pUbE42UHVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEFlTWhkY1gzckVkR2lqY3Z5QWhmMXM2QXBuUUpxOUVDc0JxcnI2cGtBbmVv?=
 =?utf-8?B?ZWxKMXF6ekJ6bUFsR0tPSjRndWR1ei9ya3dCL0lyZFp3U0pVLzloYk9sdlJS?=
 =?utf-8?B?MkM0NHFJOGR6TThlRGREL0tNd0p6c3dYNDBGdVAzWG5jdE1hM295SXlvT3Ro?=
 =?utf-8?B?V2lIeDhMWVBtUUY5OWYzTEdDVko2OFkxNlpWUXBMTlo0UkkrOUU4VmsrYTRB?=
 =?utf-8?B?SU5XbHZzK0dYMmhPZFdpSER4K2QxSFlkbndxQkVUdkc1ZE1YcjFBeGZVR2Ey?=
 =?utf-8?B?Rks3YTJQODFsSTBDaExNZCtGaGNEM1pJMTk5aG1jckNQQWlzYUdNMWhHNTBw?=
 =?utf-8?B?QURlcjY1SzU4U3VqNndsblVEVThrVmI2ZkYxdDN6QmRVVlNoTzVMRTExWnpU?=
 =?utf-8?B?eDFhRVFBcFpJOXlLWDVRdHY5N1dsQWdGNzZQbkNxK2hoeFB4cWVYWjZ1NWl3?=
 =?utf-8?B?MHpBQzVJcjRtczdjSGdMcWs2UlRRaUppcUJSeVBjN3JrdUJqdlA4M2ZNQkhK?=
 =?utf-8?B?ZGkvSWJkeFc0dmZnT2ljSGlmUk1WWm5QaVo4YmJYbWk3M2g4OW96OVpmT0lS?=
 =?utf-8?B?UWhCaXp4dzYxMWxIUitFYzVWd2FHK2dQUU95MTdSQTIxNnpNb2FUdG5heSti?=
 =?utf-8?B?SnVObGhOd09JaGtvenBLZ1dCT0RSZ0x5QjM1T0dFVlpSSVVGSHRHMkE4d1ZC?=
 =?utf-8?B?b0c1ZDFKOVR5TUNJWWszVWZZTkc2SXV5VVFSWjlGS25iVUhkTFdua2tqOStR?=
 =?utf-8?B?UU16WGJ3MzRxUmRGZys1TUV4SVFhZEFaN1RaWEJ1UWZudW5UU0RGRkVNN0dj?=
 =?utf-8?B?NnFhNWgvV3JMSFVxMU5ZYlFMeTgrbDFkcXJOSmlBYW5DZkJySjcyTUlBa0lB?=
 =?utf-8?B?L3lnK1QwVG12c3NjWUlPa3ZWZlkrOFJNOTR4eTFnUEdwZllQR0dTV0MyZnZh?=
 =?utf-8?B?aWNjM1ZjaENGSitiWFpobytBemFtcXRwYkJ4eEJNcEs2UnZ1NlM2eSsrWGJj?=
 =?utf-8?B?eGZwK2FJSlUxTHhHbWlTRkJCZUdEOXl2bGJoZ01WeXQ4eDhXNktTVmhsOU1h?=
 =?utf-8?B?dnlyQkRIZ0VHQ3kwckoyMnNqMXJ0SE5GTER1T0FLcE1BYi85ZFU0ZVNBWDM0?=
 =?utf-8?B?VW5PNWl3dmJFVjlFbFJYS1BXaE1iTERHTnRMV0Q4ckVZVTVzV3BjZTlqT25T?=
 =?utf-8?B?ODFoczZvZWV5NlAvV2VNc25JaWhMVXhVUXJQQ0FkSkVLRkpGNlhtR2RNWU9H?=
 =?utf-8?B?RS91K25KMERDQXozVG9sVlpFeXMySytYb3d2ejBrWUdKUmdNdEJFaTJUaUwy?=
 =?utf-8?B?MEt1WTdqM21DQTg4bElqUjNVd1RhZlB5WnFXZnRNWXlYa092K08vY3dvUytE?=
 =?utf-8?B?eW1qd3B3b1A1eGJhSWZQMFh2TGlZV0FOdlc1K1VBZWppdVFKTk1DTTJ3RzNP?=
 =?utf-8?B?QWRKRDRWRktsN2plUTl6blIzK3orOFJoczlxcm5LMVlJbnBaZHl2ZkNkU3JC?=
 =?utf-8?B?ZFVvTlpnbjczaE56WldQOTMvZFVBbjFXc2RwYWdKZzNoeC9LT09UdHhRU1Yv?=
 =?utf-8?B?c01JQUY2dFBCeldGNVZlTWNHcWRXNEF6eDQ0OXBycjVQVnYyVFRzMVlVSCt0?=
 =?utf-8?B?SnJRVGJYdUZkUlRUNHdtWVY0Z0dnNmZjZ2pPRDBVb2k1RWd1OVZna2xDYXph?=
 =?utf-8?B?V1BYWnVhN0JEaC9SUVQ0UlVYWVZFV0RxWUc1cWNOU2tqVGI1NHZCQjFaRFRz?=
 =?utf-8?B?TGRpWjVoNjJ2RnlHWXNYN0pjUlNWVG9mMXkxM3ZSTENMNU1MdC8xNlNSemlx?=
 =?utf-8?B?YTBsYVN3SG1WMkduSmF3c0czc0ZMRDgzMFF2MWRpS0docGNFY1dkcjBXQmNq?=
 =?utf-8?B?WUx3NStSNUtNNmJXK2hoSkNYZGM1UlVzSDY4N0ttR1dROE1NYW5JWExvMVNP?=
 =?utf-8?B?ako4VWJDanQyakZnL0RqcVVyaWVZTU9ERGtHL3dpZndpcE1KUFlRRFo5S01W?=
 =?utf-8?B?dG04SnNKSndLOE5CblgrSnUrUG1vbXhnRkF5TmdZbUFUd21sZWxXdUJrbW5q?=
 =?utf-8?B?VEZsSmxJeUFBUkpQcHJSNkcwcG9RNkFxQk9TbHFNM2R4bHFzck45eXpPbncz?=
 =?utf-8?B?aFIzT0tvNzZoS25LVEoza3p2RVdGYjhndXhxUWVEOXdEdVZ3SzRKczZnUDZw?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e5bae75f-0390-405d-2775-08dce8649383
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 13:16:25.0040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjGrmyABq351nliGIvzVP1ZnpmVIFHDiLWXXaMtDrF3Ws83Qc1K3NiRW9IoUei0J4+5FoA9ESR5WIfTHydwD2Hv1P1tf1vbuXxK0XHMrMWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8313

On 09.10.24 2:49 PM, Miquel Raynal wrote:
> Both W25N512GW and W25N02JW chips have 64 bytes of OOB and thus cannot
> use the layout for 128 bytes OOB. Reference the correct layout instead.
> 
> Fixes: 6a804fb72de5 ("mtd: spinand: winbond: add support for serial NAND flash")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

