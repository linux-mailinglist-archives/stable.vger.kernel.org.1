Return-Path: <stable+bounces-120192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E89BFA4CFA9
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 01:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373A83AD3C8
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 00:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6470FBA53;
	Tue,  4 Mar 2025 00:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="A45Ib2/G"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD8410E3
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 00:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741046758; cv=fail; b=ncf+oTFbnVavXkzBByPJCZd1OIgaulJ+Thj42LhZHEhOgA/QDyQIqAqTdMUbixds9X4gQ9NwNxlbNLBB3sc1GW/4+w0QMuZ4Ic1ZXWqulTGTVto7DfmAKSMSP4ilYEsQy7hHMaqsPtueDfF/unbevR0Sa1L40V9B3PExJq/VYZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741046758; c=relaxed/simple;
	bh=vkGRRgxpuNLqGb05NXF7QLaV9+PhRkEiu84RvaQYHRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qJvOudGLPhfuTz2O26+h9BeQPsWl36PlywziNDwv69gu8Yf2fsjXfAUWzKS3XvKtRLjtb5Uv6KU9VfoGE3HgRI7RbfbjFRXwtHfLQwNMQVTfOf4Tbz/+h5CDXEOa0Vj9TvS6k4pIf0rdwYQYeYby+hiSMN26z3KdqmQWhGCk+nY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=A45Ib2/G; arc=fail smtp.client-ip=40.107.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKXi+wukPOAL7fTRMlhydcMzUJZZ3tdeBbIoax5EVDDswND59bbvFe4fbvHIzm17YyQmyMl8YPsldYGsQSGsPGkJOug0/VAe8lvljbDkLh5nPPRUOqbJsiHIhwu3o+UK1XzXtrflST+LSeC63HWW1OCZpy5gI6ilz/cOZCuZACA4Pq4yGG7/N4qdjXKIcqA6g1iRGCo9t+C+eKp15qeEgfoYUq4R1oqO5n4tr2FE5h4iKqnNlyoFonAsgJBNoNeL1riwJqZuGXOkvbEe1J5wSyVGGjnO/UO+Z45lGxxXpVqlZg+EDe7DFQQb0k+Dx81ycboXrCfEISxklUQcy6opNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WEnDWKgkB+lTh5nLFPb156f79a8YdfmuXlW8PM1OGA=;
 b=kr7b+JrVRNF6BO8ONp78/oH+4t/cEON1qIny56X7vCg/NdNWYMnHrlY03QwOH6o/5jNWZ6VeQBrNrykGpS5jz3HpUDWpYoEaVJZ1E3H53S3icM5iMrFhK+cw8Ls8gsv25+FafOeVntaYFV4alsSK7C+Q9FAetuTrGOmrKdXZqJg5walhDgfbfQKPjxatpzgF/lBmO/xjbRVeg3tlbzwPLGEGDjrXOpM+pR1hg/RrttTXSCmHHhW6OPZkLQGOGhbRtXRRh8DG8cPJ5iYvdd5pU9HDKN+yAi7Vlf3VUqamhU8dNdDOJ8HERIazz1lOmlQZfOm+92SB49d/GIQFqzSX8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WEnDWKgkB+lTh5nLFPb156f79a8YdfmuXlW8PM1OGA=;
 b=A45Ib2/GwxSUmpBG/RAfuIxxroXIm+KjZDFLKZvBWu4J3SmRt2PruJwQ4PjEqVqusBQX1wstX7ar4vneRHMf+HjyOgflQzaib6p/zSHpCXVT+949WOYBCOnPCFuPHnatbpe3hJKLloQ3UOf4kZMas9YDf83msDMLBqI0YUTftue257TluHScFGOuXbcLEsy5pJp6euR8Thh+/G2eb1Ogtzw/m+aQi5FQ2aOrRTwivZXB9mgn5hadsdH0aYQc3bnIO6DDe9GIxCacBq1NgzKiTer58jIKYjxggYGITXgMfe7VBuc3y8UdtJhY/hGvaUhBn8jheuepqHtB0ZAfwt1AXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22)
 by VI2PR04MB10954.eurprd04.prod.outlook.com (2603:10a6:800:278::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 00:05:52 +0000
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a]) by AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 00:05:52 +0000
From: Andrei Botila <andrei.botila@oss.nxp.com>
To: andrei.botila@nxp.com
Cc: Andrei Botila <andrei.botila@oss.nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] net: phy: nxp-c45-tja11xx: add TJA112X PHY configuration errata
Date: Tue,  4 Mar 2025 02:05:31 +0200
Message-ID: <20250304000535.4091619-2-andrei.botila@oss.nxp.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304000535.4091619-1-andrei.botila@oss.nxp.com>
References: <20250304000535.4091619-1-andrei.botila@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR10CA0020.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::10) To AS8PR04MB8216.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8216:EE_|VI2PR04MB10954:EE_
X-MS-Office365-Filtering-Correlation-Id: 64120bfc-b31c-4514-bc29-08dd5ab05396
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGhqTDRraEowd2lVSXpsQXpySHZGdHV4MjhYYktQZWw1ZHV2cVZjR0l6ZDBt?=
 =?utf-8?B?Wk5wUGEyd3IvREtpYzk0RWgwbGZIaCtlQlRiUGRRLzJDOHA4Z0F0cldreEd3?=
 =?utf-8?B?NjlYRTlnY1pIUmNiM3l1TzdkY2VtRFNpOVREVHNmUUt4VUR6YnN3dGNsZW44?=
 =?utf-8?B?bTl6NmRzdEFST2kzN0ZJREd4eXFGSGZSODd0ZThVeFc4M0dLaVFpUUNhMUoy?=
 =?utf-8?B?emtmWEI3WWpZOGJzVXViWlFoNm5XaGx4V2N2TWd0V2d5RGtSQ29oSVJHSERP?=
 =?utf-8?B?czNSTk5qUzVZYkhndzdPVUFXcWFhSTYvbXJJVkxXV09JZnJlbDlVYTlsS3ZO?=
 =?utf-8?B?a0hGK1VJbllpMDZyYTBza05XbmlidHdpQkl4Y2Y5VlRkYWhaRFpqTnRydUxz?=
 =?utf-8?B?K2ZZNEd6ZytWam9nY012eVljaHRhVXFmek1ORDRsU0loRFp5bjcxMnBVWVFI?=
 =?utf-8?B?dG9GRlloaGo3dEFRT3lPUDR3Rm1UTHN3NVkrd3BnRmZCZnhMbDVZOGo4Zy9H?=
 =?utf-8?B?LzN6d3k3aGM4T2p0S2JyVXpHdkdTekpHelp4REE0eGxxTTVWbmc0MElDRS9H?=
 =?utf-8?B?MzZLRERRcU1KZTJ5RXJ2NnQ2ZUI3ZGVqVjRjUzNkcFc2OWlOUUdZeUo4MWV0?=
 =?utf-8?B?dTlEM3ZVSnVnYzFoTnBBenhZT2N4V082UkVqR0FXVlFTeUVKWnJkM2F6dC9Y?=
 =?utf-8?B?ZDZIdFpTU3oyb0tIOFpoMVNWcjYyemJ4dkRiR2grR3kxcmRWOEtwNTVkK0Zw?=
 =?utf-8?B?dkZ4aEJMM3d1UmVNb3VYYXRmYTNVRDErVjlxVkp2VGJubXg3ODZ6bmRwdXQz?=
 =?utf-8?B?azJ5VlJqRmVrTzVFekJiTFdQbWZTcGF5bTBsVENJZFZzK3VHZE5US0ZnSzlE?=
 =?utf-8?B?dW81WGQvNXNPVzdFK0owQWxDYStSQXlSdWVNSVY1aGxWbHMweVh0cXQ3MzZ5?=
 =?utf-8?B?cmhqNkhlVVVuUFIxajJBeE1xMHR2cGFNWG1yYjB4dE9OY25vR0h6eTZ2djR4?=
 =?utf-8?B?bS8wSkgvR1hLWVpiYk0ydW5iem1CYVFSaHVlcnRteXYzWE12T3lVazFtVTY0?=
 =?utf-8?B?c294L2NCbzRBR01lYXRSVCs5K09HWjBBcVBTQVg0SWQ5TllMREZBZWltK1Jp?=
 =?utf-8?B?QjhEYnZSeXZxeW5wTStEUVdzTFlnRFBUOUhmZ2ZybmpZdnlDejJwOWwxUHVj?=
 =?utf-8?B?SWczR1RBUkkxR1p3eTlPdlJFYTBSclVybnFUN2ZLUnZldVJ4VTlRcW9YZ2xv?=
 =?utf-8?B?RXREYU9FREV6N2JSSkwzR1o5OVJ4OGwycGpMWW5KRWxpNWhyWE1oK0s3emJG?=
 =?utf-8?B?dCtPaFFRK3NjM0M3SW9CanE1Qm5xdlFvdFZLTk1mY3ZBRi9kblNPVG11WjVj?=
 =?utf-8?B?US8yUjMvTi83VEkxRlVXQXpkRlpNYW9PQ0RYcHRSajhUUFZBemNVTEFBdUhU?=
 =?utf-8?B?QnBSQngzVnJ1b1ZpUzFpdGViL25rbGJ1dGR4SUZNNnA0UFo1dDc3YjI0cTVM?=
 =?utf-8?B?WnFRcFAxTVVUc2lFcVRDb1BFMkdXaUlCREsyYnBORVlGNmhVN1RqdzlxWmdB?=
 =?utf-8?B?cTNWRHU4S3lobyt6UEQza3VUSUgwd1hxYVVhNHlNYjRVdmtBd01xN2pmdWcz?=
 =?utf-8?B?OUt2czVLOTJ4blpSeStJKzhWYmlmb0w1Y0NxeWdPZlliN1ExV084dkpLbk5S?=
 =?utf-8?B?VUJ5YU9XZG1iNEpEY1RDeTJPUGlxWXh1eDFsbTlqK1dkM0hKampkb2w3Unc5?=
 =?utf-8?B?SmlFU0h0MmxNbEhXcnZYMnkxS2dNRmR5VXBDOHJ3ZlpJMzlSRmxXV2Juc2JB?=
 =?utf-8?B?QXdzWHNZR1JCeVNUZFl3SW1oaW4raFVSY1k4KzA5U0NMZVZhcW5DUW8xNU5z?=
 =?utf-8?Q?kT5GRly/UpS6j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amNnSUhwNURqTmdWMHg5QWRDek11SXU1Z2wvc0FXNDlTMjhLMWlXaW1DN0RP?=
 =?utf-8?B?MnVPRTg0Ky94M3FmYllnL296TnJJV2M0d2RMQnRaZFVtSzkvMjcrOGJBQi9r?=
 =?utf-8?B?Z1VmckQybVpFeUMrVWwxSGs0MjlmanQ2bCs0bUlScks2MTdZLzBZeXllYm5v?=
 =?utf-8?B?NXp2eXd2RGN5VU5zaXk1L1Q1QzVtVi94UzhqUkwwOGFQc1dKTDRvSENtaUI2?=
 =?utf-8?B?RS9mRHJuOWtGZy9vR1lVOGkyNDZLUjdyazFvek40dHJsUkJLMHhrQ3plbzZY?=
 =?utf-8?B?WGxIdmxzRDBNbzR3VmFHbmRSbkNrd0E1aVM1dWZyRHlwQ0ZTb1RTWmI5Y2Fy?=
 =?utf-8?B?ay85d2pSallCNU53dmh2VXdXeTZ0RkFlYW9rSzlZSHkzdzhLc2ROY2tKdC81?=
 =?utf-8?B?MThXcDlEOVoyalpubkUwREkrb1VMeGZFTit6RC80c2hGQ3puTUJTcXhNU0Rq?=
 =?utf-8?B?WmRjUjVsVWgxQyt4SGdqc2RSZlU2WmFBbCtSZE93YlhTeTZqNVN5empReWo1?=
 =?utf-8?B?cEV4T2duVmk2dlRrdDRLM3RVUzNOWVN4cSsxTUFOeVRGVFNSb21ZZVcxTk1j?=
 =?utf-8?B?T0ZweVoyUm5EQndjUFNOajltSnMrVkdnWGxQYmJtTVJqR2ZTTnRQcndLdzIw?=
 =?utf-8?B?NkhYeEY2NUYzRThaTmpVZk9BZFRQQW1yL2dIMEFnNVRxdGdRYktGOXJVWUhm?=
 =?utf-8?B?T01MY1gzVGFoYk1WUTM2TzBJYnlNMTB6QU92OVhKaWN6MmZKVzlFamlwSzcw?=
 =?utf-8?B?OXRQckV6dnZrNzYwR1NKSHE2bThIbEdWdHA0MFRrUkIydEVXWWlkYnZrcEQr?=
 =?utf-8?B?ek9NYUQrTXdBQ1hZNngyL1N3OWMxQjlDYk16cjhadWVvZS84TndRWlV2dWlk?=
 =?utf-8?B?TlhScFI0SW5UOUZiL3Jnd0dBTmpndUZrMVo3VE13MnBQMEtrdzhSdVpKRG9P?=
 =?utf-8?B?UkY5aUhMUUtYYytzRDE4WUNSZHFidUZic1ZRVUQ3V2I0WWxqbURvTU4rYnhJ?=
 =?utf-8?B?emNnY1V4a0EycHBmWEtNYzNYSmpBK1NhSHpFUFJDMy9DQWxrMEJ4VVNGSDZM?=
 =?utf-8?B?SnVkYVlkZm1YV0s4S2xYejJ5aDE2UDFXZ0lvR053bHdINTFUU25jaC80ZFR3?=
 =?utf-8?B?cUlvRmV0RFdqY1A2enRSR3N1MlA0K0V3WVQvVHhQa1lmUWRFNWE3WTEwYTkz?=
 =?utf-8?B?dEFDUER4aG80U3FGd0VCdlFmc0pSbVVmM0o2b044aytjK2JXdDRQQk5lcDhG?=
 =?utf-8?B?Q3lJajZWQ1BYNThXemtlODVkeURaQ3VhZUk5QkhxbjkzaXFwSGwwbW0xVlo3?=
 =?utf-8?B?N0NBYzJKOTVYdGdZQVUzVHM5V2hOTjFvTytjVVlIMUdyVy9qYVMweXo4NHo5?=
 =?utf-8?B?UmI0Wjhxb3lVWXU5SGFnUmdRdlp1MWRGR1lJMmh6ZStiWUJyeDEzalQrTThn?=
 =?utf-8?B?b095WU5jMG8xVHlKWlRSM3J5OC9jMGtkb2VKNk1DSm45UHFQcXFOZzQwb082?=
 =?utf-8?B?SlVGSThiUzdJMzVaNGtiRitTYlVreTdBTFRoRDExQWVTWDRWOUE0cTF6QzdD?=
 =?utf-8?B?Wi9hTVdiYWpPL3NtNThoajY5bWg1TG9tdTU4UG5rSXN4TWg4Ui90NDBRd0hw?=
 =?utf-8?B?UFJOMzZuZTdmVmViM2ZzZEVLbUViTnFpeW9tQ2JveThhc0ExdDRBcXUwMnI1?=
 =?utf-8?B?ZEpEQjh0dUZhYk5SSk1YQnBUNk1hQTFkUFZlbDVaQzQ5a2hVcGVqM0tscEF2?=
 =?utf-8?B?aXBjZE5YdUZ4Znh0RndyTVUxemppTXlKWGQrdGlHcmdBR05nYnlQNlhLU1Bw?=
 =?utf-8?B?NCtzbWRiYnpzNzlEaWZNUVU5MlgrYWRscytOS0Q2ckIrb1Y3d2JlWFVHblpw?=
 =?utf-8?B?dDRYaVFWdUI2VzEvZ2dFQmhjeXM5V1NjVU1halIzNTNtNHhnMndocjVhWU9w?=
 =?utf-8?B?RUpXSFJ3K1p4VUdRTkdXVmR6c3VnY25rWVFpY0h6czF6ek9ZbkpSYjU4MWNq?=
 =?utf-8?B?eXJZTjFkNFRGMWJiaStPMzMzYStZcUJRY052S3Q4ODh6bHREM2pOVjNtK2ZK?=
 =?utf-8?B?cnhxVWZhUVM4NHUzYzh2YVl0WTJGQzJnajRzc0hPZFZaWit1QnFpY3hUMTZn?=
 =?utf-8?Q?6NG2t5zDsnZTScSt2r70mfPRQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64120bfc-b31c-4514-bc29-08dd5ab05396
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 00:05:52.1083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDONaFDbT0YJ/Npl6urttXkE0DkansVtYlUjKtmgKYtV3iUXVNkZk5Qj36j8qV7GNcR7QNXPMqd0TMJMYnTelQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10954

The most recent sillicon versions of TJA1120 and TJA1121 can achieve
full silicon performance by putting the PHY in managed mode.

It is necessary to apply these PHY writes before link gets established.
Application of this fix is required after restart of device and wakeup
from sleep.

Cc: stable@vger.kernel.org
Fixes: f1fe5dff2b8a ("net: phy: nxp-c45-tja11xx: add TJA1120 support")
Signed-off-by: Andrei Botila <andrei.botila@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 52 +++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 34231b5b9175..e083b1a714fd 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -22,6 +22,11 @@
 #define PHY_ID_TJA_1103			0x001BB010
 #define PHY_ID_TJA_1120			0x001BB031
 
+#define VEND1_DEVICE_ID3		0x0004
+#define TJA1120_DEV_ID3_SILICON_VERSION	GENMASK(15, 12)
+#define TJA1120_DEV_ID3_SAMPLE_TYPE	GENMASK(11, 8)
+#define DEVICE_ID3_SAMPLE_TYPE_R	0x9
+
 #define VEND1_DEVICE_CONTROL		0x0040
 #define DEVICE_CONTROL_RESET		BIT(15)
 #define DEVICE_CONTROL_CONFIG_GLOBAL_EN	BIT(14)
@@ -1593,6 +1598,50 @@ static int nxp_c45_set_phy_mode(struct phy_device *phydev)
 	return 0;
 }
 
+/* Errata: ES_TJA1120 and ES_TJA1121 Rev. 1.0 — 28 November 2024 Section 3.1 */
+static void nxp_c45_tja1120_errata(struct phy_device *phydev)
+{
+	int silicon_version, sample_type;
+	bool macsec_ability;
+	int phy_abilities;
+	int ret = 0;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_DEVICE_ID3);
+	if (ret < 0)
+		return;
+
+	sample_type = FIELD_GET(TJA1120_DEV_ID3_SAMPLE_TYPE, ret);
+	if (sample_type != DEVICE_ID3_SAMPLE_TYPE_R)
+		return;
+
+	silicon_version = FIELD_GET(TJA1120_DEV_ID3_SILICON_VERSION, ret);
+
+	phy_abilities = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+				     VEND1_PORT_ABILITIES);
+	macsec_ability = !!(phy_abilities & MACSEC_ABILITY);
+	if ((!macsec_ability && silicon_version == 2) ||
+	    (macsec_ability && silicon_version == 1)) {
+		/* TJA1120/TJA1121 PHY configuration errata workaround.
+		 * Apply PHY writes sequence before link up.
+		 */
+		if (!macsec_ability) {
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x4b95);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0xf3cd);
+		} else {
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x89c7);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0893);
+		}
+
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x0476, 0x58a0);
+
+		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, 0x8921, 0xa3a);
+		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, 0x89F1, 0x16c1);
+
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x0);
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0);
+	}
+}
+
 static int nxp_c45_config_init(struct phy_device *phydev)
 {
 	int ret;
@@ -1609,6 +1658,9 @@ static int nxp_c45_config_init(struct phy_device *phydev)
 	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 1);
 	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 2);
 
+	if (phydev->drv->phy_id == PHY_ID_TJA_1120)
+		nxp_c45_tja1120_errata(phydev);
+
 	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PHY_CONFIG,
 			 PHY_CONFIG_AUTO);
 
-- 
2.48.1


