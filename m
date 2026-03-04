Return-Path: <stable+bounces-223087-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DiRLWtaqGmZtgAAu9opvQ
	(envelope-from <stable+bounces-223087-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 17:14:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5604E203F7D
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 17:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1AF3301DF6F
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 16:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E848E348463;
	Wed,  4 Mar 2026 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EFxRmzp/"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011029.outbound.protection.outlook.com [52.101.65.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1719346791;
	Wed,  4 Mar 2026 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640341; cv=fail; b=ZxpfziDlCqSUIEk8gO6jWnDZvi06WpFXhJV2lL67Isfw9H18Rcr/vwapN45zTucVv4RUX3BHr0Z2UmbYHkSiakukAua+tDYvG3To6jarZKqFL/OlnCHU0Wi8H4FKbPBPMAy9yH6TeO0GvbDlxf9FCLaTfyfK1kUEJVM2jUPJ8Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640341; c=relaxed/simple;
	bh=bCwtHKGuL7OxZmeJEsq601lF1jDO1YIKoku57SDX73U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dbqSY0D6PLCmKlk6r16Vi65XUHOMbOhej08ytMpA571/8dN0v31o8xWJVPgqpsh8OcmtbM+nAYn/FQwqCdl7PRYNUS6c6qXMBCndoewbhM97qHP+aNgVOOR1xxWp05SIYv4cA2t2WWCX4enesRQZWCACRK14NHaZ8IU7TNwWsig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EFxRmzp/; arc=fail smtp.client-ip=52.101.65.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxjQdiqm1sjw8aU8Sx6I+sXbTRxLtdSYlSvRIK6ieZTIY8lRMzt7BNbn0orrfEo8XJqeDoj4qb1rOJvpr1YT55T9jTFGxHe0g/WRomtx345JVy0uuiCmNSfs5+fShNv2Un1K65jp17bg+DaSF5lGxxsCaKRe8q+LOcTdmcm/fflV/s/jctma3mgTJwrlVSypnDtuNWpxapU+tyVXwcIW5Kd+0j5Pyz0Upt2gQ1DskS3T9ZVp7Qt2L8LDmkxhnQCHDcW06pLNXQ/MULsOf+hh2NVETCGo6Hvw6uMSFQVlgQIzJJW7hh6OwOzSKReJNjZuoVk8a2/4UizDOe+gpv2/xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K15K5XWoELxMoigTWBKzikEw/fglqd9hyHUPO8woUSc=;
 b=BrumrvaEBXBkoofEsbmw8h5PUv6+EIzKVVmCik86CuI37R5U5MHabCflY/PSFexgBM7egBpp0Rwbo72w9IWGu/FV3pPb9xQvewWXFl5tGnwsgH2uDeH8qEsPWx9xKEeuMfc7eypzr5v/XpwwUPlWe3eVnrYmMILjZzdM+yd1ewKPg6lGUcJ3UgiRHm23OrOvzDp2eh/bvC/fKYjN2yzkyOZVc2KKlHKc1DpPUET85KGvE3HSxIcZ0eWVkRNRoGH+4HcBawCBghPTVw6B4YAvb5BRc63Ug8+X2caaCj/8f+9UXCExD+ukGQANRggPChEcV0/bvxMTSThWmhMybELvWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K15K5XWoELxMoigTWBKzikEw/fglqd9hyHUPO8woUSc=;
 b=EFxRmzp/SiYKG1ZJ3Y95HI+dY8RMGYFzOI8vTzaxZk+WKNco7uaUbkY/nhH31Svr+kcRQSA9CtQo0koMjZouRd/YF6pP7/H75OZYEsJ29n6CQPO3fwUrCIcnrJnud/O4qZVmzodQEPJRKGW6KfSYuh8wtwy3IqVtW5vjB+ZgRnA01zUDcAJnMJjNqrl3H4JNZNp0Gl16XB40Ljr3+I4g0W/1c5GgKeXSQqAouIagbFIpoebQV5/EB8Bid50iz1SwfdtjC9ej4Oc+oAL0Bg9AvnhM/AMXHI6vOc6Th9lx+xjVOali0Jbml+diPuMbSpDM0eYRTuw/rIQyJm9i6atlPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB8PR04MB6812.eurprd04.prod.outlook.com (2603:10a6:10:f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 16:05:36 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 16:05:35 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: stable <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: netdev@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH stable 6.6] net: dsa: properly keep track of conduit reference
Date: Wed,  4 Mar 2026 18:02:44 +0200
Message-ID: <20260304160244.1626303-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIZP296CA0019.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::6) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB8PR04MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 64795ba0-9d5f-4b22-a532-08de7a07de73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|19092799006|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	uiWu+vkmIuCwGox4tKz5fryxP2ehSDVKrwDGL5eeVJPrQ/nKRePMSXYzbhCwXXw8puA1YT3a2AbwzuRJMZuxv5n8PQ6cY2aIjmz2Fcp+3YkTXXu2NOwrE8Sp96RhI7rhcZlb82boiOjvPk1V+HdSodJV0AxT4ghdp29HRMu2EkIq5J4SD13V6ePrGksGLSRULV/3W2Fz1rk2F1h18v0272HzY5HJqGJaKSCl2mPZXeK0sN4Y0/2Be+8i0I2Mv4p9fn1htdnuTETb03tD44gRGGjA0TRFsLy4V2Mj1Y733gsIENwVT1Sq31b3ac7TKy4mJNiWOJJ6g64qlLDRDzcM4SZ97nAdRGWMp1SmvkAvquwOzUWGtDVu1363AvULw5bR9sSFGXp7uwX9AxiIRAn7NH8WREXtT/OmAW+aSK28b7eCHZA4Z06M1Hl6z614VgQupqAyaaClApW10wIG1hDqUst31ve8zVX8iXvUyurXVsDOHZY4I9BU9QjOdQ8mLNMlYGVYdLv5a4pT97gXQX91Gzj0iXvkA45VcsCSgEEJ+3GEQjUMAvrbj0/Xf4FOdWR3cAOd66rnLUOU7cZxYvsKvsVCkuJR40hmugsrxyxVJZsjhcfg2yK0bCfmHU4adC0IPzgxpvBAiMsXDAv+tS8bdZYJoJyyTM3YGmIKDTD+LicdBhH37KzSBGjJTUKm19Jw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(19092799006)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDFZYnVFUmwzTndOV0RBWjJVRWw4VjFEd1JNY2hKZGlvbVRacUd5NmhXYVhx?=
 =?utf-8?B?QkNyVkY3MHdXcmYzVDlhc0ZzT3pYb3NVOVNWNDdtR1dLcEdidkQveFYrbkIr?=
 =?utf-8?B?b3dBck1LUjFDUG9NUTdyNUFOMDI2ZCtIZlBIYUxVQUszQlE5bWg0SUdQZjBF?=
 =?utf-8?B?cXdzbmthNDl3a0I3dzR1cWlwblhrb3hrd2FnbU5seERnWjgvWWdJbHhoSVpq?=
 =?utf-8?B?Wmk3akNYbnFVNTlwUDd1dWZkLzhkV0RWbGpqVmdHb0lML3JROG9iUTFjWGo1?=
 =?utf-8?B?YlZwQXZKcFdZNWN3VGpnZldKYUlEVVIyd2F6WFhrMzU0Nndld3RSZGZ2Vmor?=
 =?utf-8?B?VVdJaTk1YTBydGdUVFBIWUlwdk52cE5reDJwYjRjbTZ0cGo5ei80QmtFcWdZ?=
 =?utf-8?B?ZGJtaEY5Y1dTZWtiOXR5RlVFYVpJRU0wM2xHZ05YNE9wajVYWFFnR3RldTBS?=
 =?utf-8?B?N2l3bFJkdDZuMXIraGhPanMzZ21ILzdYOTdGbG1Xd2o5Z2hCOEt4eGJERVNm?=
 =?utf-8?B?U3BuVmxzbHlsY291VTRFWXhSbW9td014WHhtcG0wM2QrSUJjWEdjVGEwWTFj?=
 =?utf-8?B?ckFXSWxtU1BaTHpVZVF2bGFJQm81VDg2RWpwdmZZNDVDK0FoRVpKZHNqSVBV?=
 =?utf-8?B?ODY4bUFmTXNrbzNrNmsxYUlCclZZK2t0NmNJOTBwaFdPZFhEYU5HRk0vMlVm?=
 =?utf-8?B?UER3Y0xwSWtEdHpoeW9zTVkxODErTnU4Q1ZHQldDM1o5MUR6aEZGdW9adGFp?=
 =?utf-8?B?eUFUdUpWTEEvSHE2UGhMeis2VWY5akNpTXl2RUxWd1R0TzFRQTJxekszRHov?=
 =?utf-8?B?dGRma05ieUZjMWZSSnorUUhON3BTcG9KV21FZlltMGVBVk96MXdBdjN0dHRq?=
 =?utf-8?B?VTN2OXlSYUlWTlBScnRRbkM0Y1dQcWdEd0hEVGNpdVYyRkFKakZiWmx2eEZs?=
 =?utf-8?B?MmZFcVkrQ0tDTTJLWWtFSGdoN3JMNzR5ZEN6czNzT0gxbUhhd2gxa2swR1Jv?=
 =?utf-8?B?RjdhbFFyNWZCV21FYlFiTUJYMDNrNUFVV3M5MVBTWDM4eDdwV0xPbjhFMUdx?=
 =?utf-8?B?aDVNTzQyUDYvYVNocDc3ZWMrdjJ0MnppOWs4akRtSlErV0VFcHJ6alBPL2VD?=
 =?utf-8?B?cUtISUZQY2ZxdWg1MWIzcCtQeTcrUkJVS3ZkZWpOaFJnYzEyV1RKVmxGYmRZ?=
 =?utf-8?B?Qk94MGt5MjluTmVXcVBRNTdXNDB6YTNuZi82YkNBUEpJQjNaWEQxb3U3SzlD?=
 =?utf-8?B?VXVnTFMyOVdaMjlmdTNURnA3clhidk1Ib29NVXJvUzNqdjQzZERRUzJ3Rld1?=
 =?utf-8?B?VVFlQTY2NVM4cUZOSmI5L0FOUS8zVzdlTWxnenBZS3FwTU5XUy9BcGZpNDF5?=
 =?utf-8?B?WVZRVVBlS1E1WXNZNW1vNGNnVm0ydThjOGdOdkVST20zblFEWDB3YkVRTFcw?=
 =?utf-8?B?THJ3QkhTTm40aHdodWg4eDB6ZE1ZQ1ZBQ0ZEblgzdDFzYjBBNUpQSTMzZlk1?=
 =?utf-8?B?c1U0RUVRRGZlTG5GdUtTZzNjZmdFREFmT1hvdDRyRSt2WGJLMExzbEdPWEhx?=
 =?utf-8?B?UVM3ZHg4VWQxY3Voemo4WDhhdjJqWnNJTC9LeDR3VGRHd0IzTnVidjJHVFpO?=
 =?utf-8?B?S2tOOStFU3B3bm05di9lUURPU0tSS1JXTmZ6VE1KSjh4YlZVeXBvM0M2RkhH?=
 =?utf-8?B?bFRRckZIK0s0QXVTU01USmI4QkRDWURaMU1lcWhtNnM0aEU2a2s3VEkxTDZx?=
 =?utf-8?B?TXdiQWIxMlNqelN3Q0w0d3JhWWJlRjNhWXpkdTVyK1lBV2lydTVZSFplZFNC?=
 =?utf-8?B?eFQzNU1ZZloyRDkxc1JzTXNURnY3aWdzdlpkTmozNmNYYXJLTW4rRXdyYmFy?=
 =?utf-8?B?VFNvVXRXZEVxaHVKTkVHam1yZUNjL2VKT1V5Nzc4dFFld2pXYWI3VGRYeFBR?=
 =?utf-8?B?UjJ2TlM0ZGpsMHpESE9MYzdUb2VQSW5NWWNPY3JVYThEcTlPdjdONEQwbU5V?=
 =?utf-8?B?WUxlSStKWjlVRGx5R2NCM1ZLVXBCMjNvMS9pWUlETWRmY2hNMEM4cExyeXF4?=
 =?utf-8?B?bk9RbXVmQlN4eW9WNGJjMFlsK20xWU9rOVhTM2xoQnVrMGQyR3piN0dxTGtI?=
 =?utf-8?B?UUM1aFpQRy9uUjVKS1ByK2hCTHJ0WVc2bUJqZWQxMlVIcjd3SkpyMGtVODFT?=
 =?utf-8?B?bW9WVlZKMWZJeGx0OEk1RGF2aHE3d0UrL0xTT3Q4ZDVSelBiT1JmVUJPRGV3?=
 =?utf-8?B?aWRURnZoL0xFZlN5UWRHVmwrTmZCWDZzZzNKQmRzM3NkOWt5MVM5VW84NnZL?=
 =?utf-8?B?eDg4VDluSkRUem9LMS81Q09lR3FsazYvcGMvRitOekZLMm5RUkMwZVRobWor?=
 =?utf-8?Q?76b6JCVCc0Fejj7wNLlf2kTFTxN+ef/2SpnbfJxbhDMOe?=
X-MS-Exchange-AntiSpam-MessageData-1: S57Om/gvgcxTk46wrgekm4YbrBSswMPwqcY=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64795ba0-9d5f-4b22-a532-08de7a07de73
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 16:05:35.2843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3uMjxOSaCKZ+bSbtT9Bi9fqu4XRyAMd9Q/JHyusNnOe4L7MRTq+O3XEgR1LdIRl1qdnnMpqdIkJXjV5Nx1eWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6812
X-Rspamd-Queue-Id: 5604E203F7D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,iscas.ac.cn,gmail.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223087-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Action: no action

commit 06e219f6a706c367c93051f408ac61417643d2f9 upstream.

Problem description
-------------------

DSA has a mumbo-jumbo of reference handling of the conduit net device
and its kobject which, sadly, is just wrong and doesn't make sense.

There are two distinct problems.

1. The OF path, which uses of_find_net_device_by_node(), never releases
   the elevated refcount on the conduit's kobject. Nominally, the OF and
   non-OF paths should result in objects having identical reference
   counts taken, and it is already suspicious that
   dsa_dev_to_net_device() has a put_device() call which is missing in
   dsa_port_parse_of(), but we can actually even verify that an issue
   exists. With CONFIG_DEBUG_KOBJECT_RELEASE=y, if we run this command
   "before" and "after" applying this patch:

(unbind the conduit driver for net device eno2)
echo 0000:00:00.2 > /sys/bus/pci/drivers/fsl_enetc/unbind

we see these lines in the output diff which appear only with the patch
applied:

kobject: 'eno2' (ffff002009a3a6b8): kobject_release, parent 0000000000000000 (delayed 1000)
kobject: '109' (ffff0020099d59a0): kobject_release, parent 0000000000000000 (delayed 1000)

2. After we find the conduit interface one way (OF) or another (non-OF),
   it can get unregistered at any time, and DSA remains with a long-lived,
   but in this case stale, cpu_dp->conduit pointer. Holding the net
   device's underlying kobject isn't actually of much help, it just
   prevents it from being freed (but we never need that kobject
   directly). What helps us to prevent the net device from being
   unregistered is the parallel netdev reference mechanism (dev_hold()
   and dev_put()).

Actually we actually use that netdev tracker mechanism implicitly on
user ports since commit 2f1e8ea726e9 ("net: dsa: link interfaces with
the DSA master to get rid of lockdep warnings"), via netdev_upper_dev_link().
But time still passes at DSA switch probe time between the initial
of_find_net_device_by_node() code and the user port creation time, time
during which the conduit could unregister itself and DSA wouldn't know
about it.

So we have to run of_find_net_device_by_node() under rtnl_lock() to
prevent that from happening, and release the lock only with the netdev
tracker having acquired the reference.

Do we need to keep the reference until dsa_unregister_switch() /
dsa_switch_shutdown()?
1: Maybe yes. A switch device will still be registered even if all user
   ports failed to probe, see commit 86f8b1c01a0a ("net: dsa: Do not
   make user port errors fatal"), and the cpu_dp->conduit pointers
   remain valid.  I haven't audited all call paths to see whether they
   will actually use the conduit in lack of any user port, but if they
   do, it seems safer to not rely on user ports for that reference.
2. Definitely yes. We support changing the conduit which a user port is
   associated to, and we can get into a situation where we've moved all
   user ports away from a conduit, thus no longer hold any reference to
   it via the net device tracker. But we shouldn't let it go nonetheless
   - see the next change in relation to dsa_tree_find_first_conduit()
   and LAG conduits which disappear.
   We have to be prepared to return to the physical conduit, so the CPU
   port must explicitly keep another reference to it. This is also to
   say: the user ports and their CPU ports may not always keep a
   reference to the same conduit net device, and both are needed.

As for the conduit's kobject for the /sys/class/net/ entry, we don't
care about it, we can release it as soon as we hold the net device
object itself.

History and blame attribution
-----------------------------

The code has been refactored so many times, it is very difficult to
follow and properly attribute a blame, but I'll try to make a short
history which I hope to be correct.

We have two distinct probing paths:
- one for OF, introduced in 2016 in commit 83c0afaec7b7 ("net: dsa: Add
  new binding implementation")
- one for non-OF, introduced in 2017 in commit 71e0bbde0d88 ("net: dsa:
  Add support for platform data")

These are both complete rewrites of the original probing paths (which
used struct dsa_switch_driver and other weird stuff, instead of regular
devices on their respective buses for register access, like MDIO, SPI,
I2C etc):
- one for OF, introduced in 2013 in commit 5e95329b701c ("dsa: add
  device tree bindings to register DSA switches")
- one for non-OF, introduced in 2008 in commit 91da11f870f0 ("net:
  Distributed Switch Architecture protocol support")

except for tiny bits and pieces like dsa_dev_to_net_device() which were
seemingly carried over since the original commit, and used to this day.

The point is that the original probing paths received a fix in 2015 in
the form of commit 679fb46c5785 ("net: dsa: Add missing master netdev
dev_put() calls"), but the fix never made it into the "new" (dsa2)
probing paths that can still be traced to today, and the fixed probing
path was later deleted in 2019 in commit 93e86b3bc842 ("net: dsa: Remove
legacy probing support").

That is to say, the new probing paths were never quite correct in this
area.

The existence of the legacy probing support which was deleted in 2019
explains why dsa_dev_to_net_device() returns a conduit with elevated
refcount (because it was supposed to be released during
dsa_remove_dst()). After the removal of the legacy code, the only user
of dsa_dev_to_net_device() calls dev_put(conduit) immediately after this
function returns. This pattern makes no sense today, and can only be
interpreted historically to understand why dev_hold() was there in the
first place.

Change details
--------------

Today we have a better netdev tracking infrastructure which we should
use. Logically netdev_hold() belongs in common code
(dsa_port_parse_cpu(), where dp->conduit is assigned), but there is a
tradeoff to be made with the rtnl_lock() section which would become a
bit too long if we did that - dsa_port_parse_cpu() also calls
request_module(). So we duplicate a bit of logic in order for the
callers of dsa_port_parse_cpu() to be the ones responsible of holding
the conduit reference and releasing it on error. This shortens the
rtnl_lock() section significantly.

In the dsa_switch_probe() error path, dsa_switch_release_ports() will be
called in a number of situations, one being where dsa_port_parse_cpu()
maybe didn't get the chance to run at all (a different port failed
earlier, etc). So we have to test for the conduit being NULL prior to
calling netdev_put().

There have still been so many transformations to the code since the
blamed commits (rename master -> conduit, commit 0650bf52b31f ("net:
dsa: be compatible with masters which unregister on shutdown")), that it
only makes sense to fix the code using the best methods available today
and see how it can be backported to stable later. I suspect the fix
cannot even be backported to kernels which lack dsa_switch_shutdown(),
and I suspect this is also maybe why the long-lived conduit reference
didn't make it into the new DSA probing paths at the time (problems
during shutdown).

Because dsa_dev_to_net_device() has a single call site and has to be
changed anyway, the logic was just absorbed into the non-OF
dsa_port_parse().

Tested on the ocelot/felix switch and on dsa_loop, both on the NXP
LS1028A with CONFIG_DEBUG_KOBJECT_RELEASE=y.

Reported-by: Ma Ke <make24@iscas.ac.cn>
Closes: https://lore.kernel.org/netdev/20251214131204.4684-1-make24@iscas.ac.cn/
Fixes: 83c0afaec7b7 ("net: dsa: Add new binding implementation")
Fixes: 71e0bbde0d88 ("net: dsa: Add support for platform data")
Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://patch.msgid.link/20251215150236.3931670-1-vladimir.oltean@nxp.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ backport: "conduit" -> "master" in code, kept original commit message ]
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
It was brought to my knowledge that this was classified as a fix for
CVE-2025-71152. My opinion is that the importance is overblown, but
nonetheless, a backport to linux-6.6.y was requested.

This conflicts with commit 6ca80638b90c ("net: dsa: Use conduit and user
terms") which renamed "master" to "conduit". For the backport I am using
the vintage-correct "master" term. I didn't edit the commit message
though, which talks about a "conduit". In the docs at
https://docs.kernel.org/networking/dsa/dsa.html
we do say the following, so I expect a clear association of the two
terms from readers familiar with the subsystem:

  NB: for the past 15 years, the DSA subsystem had been making use of
  the terms “master” (rather than “conduit”) and “slave” (rather than
  “user”). These terms have been removed from the DSA codebase and
  phased out of the uAPI.

Tested on the same hardware (NXP LS1028A) that the original patch was
also submitted on.
---
 include/net/dsa.h |  1 +
 net/dsa/dsa.c     | 59 +++++++++++++++++++++++++++--------------------
 2 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 0b9c6aa27047..0bfe02f93476 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -297,6 +297,7 @@ struct dsa_port {
 	struct devlink_port	devlink_port;
 	struct phylink		*pl;
 	struct phylink_config	pl_config;
+	netdevice_tracker	master_tracker;
 	struct dsa_lag		*lag;
 	struct net_device	*hsr_dev;
 
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index ea3082740936..395899a2bc21 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1257,14 +1257,25 @@ static int dsa_port_parse_of(struct dsa_port *dp, struct device_node *dn)
 	if (ethernet) {
 		struct net_device *master;
 		const char *user_protocol;
+		int err;
 
+		rtnl_lock();
 		master = of_find_net_device_by_node(ethernet);
 		of_node_put(ethernet);
-		if (!master)
+		if (!master) {
+			rtnl_unlock();
 			return -EPROBE_DEFER;
+		}
+
+		netdev_hold(master, &dp->master_tracker, GFP_KERNEL);
+		put_device(&master->dev);
+		rtnl_unlock();
 
 		user_protocol = of_get_property(dn, "dsa-tag-protocol", NULL);
-		return dsa_port_parse_cpu(dp, master, user_protocol);
+		err = dsa_port_parse_cpu(dp, master, user_protocol);
+		if (err)
+			netdev_put(master, &dp->master_tracker);
+		return err;
 	}
 
 	if (link)
@@ -1397,37 +1408,30 @@ static struct device *dev_find_class(struct device *parent, char *class)
 	return device_find_child(parent, class, dev_is_class);
 }
 
-static struct net_device *dsa_dev_to_net_device(struct device *dev)
-{
-	struct device *d;
-
-	d = dev_find_class(dev, "net");
-	if (d != NULL) {
-		struct net_device *nd;
-
-		nd = to_net_dev(d);
-		dev_hold(nd);
-		put_device(d);
-
-		return nd;
-	}
-
-	return NULL;
-}
-
 static int dsa_port_parse(struct dsa_port *dp, const char *name,
 			  struct device *dev)
 {
 	if (!strcmp(name, "cpu")) {
 		struct net_device *master;
+		struct device *d;
+		int err;
 
-		master = dsa_dev_to_net_device(dev);
-		if (!master)
+		rtnl_lock();
+		d = dev_find_class(dev, "net");
+		if (!d) {
+			rtnl_unlock();
 			return -EPROBE_DEFER;
+		}
 
-		dev_put(master);
+		master = to_net_dev(d);
+		netdev_hold(master, &dp->master_tracker, GFP_KERNEL);
+		put_device(d);
+		rtnl_unlock();
 
-		return dsa_port_parse_cpu(dp, master, NULL);
+		err = dsa_port_parse_cpu(dp, master, NULL);
+		if (err)
+			netdev_put(master, &dp->master_tracker);
+		return err;
 	}
 
 	if (!strcmp(name, "dsa"))
@@ -1495,6 +1499,9 @@ static void dsa_switch_release_ports(struct dsa_switch *ds)
 	struct dsa_vlan *v, *n;
 
 	dsa_switch_for_each_port_safe(dp, next, ds) {
+		if (dsa_port_is_cpu(dp) && dp->master)
+			netdev_put(dp->master, &dp->master_tracker);
+
 		/* These are either entries that upper layers lost track of
 		 * (probably due to bugs), or installed through interfaces
 		 * where one does not necessarily have to remove them, like
@@ -1639,8 +1646,10 @@ void dsa_switch_shutdown(struct dsa_switch *ds)
 	/* Disconnect from further netdevice notifiers on the master,
 	 * since netdev_uses_dsa() will now return false.
 	 */
-	dsa_switch_for_each_cpu_port(dp, ds)
+	dsa_switch_for_each_cpu_port(dp, ds) {
 		dp->master->dsa_ptr = NULL;
+		netdev_put(dp->master, &dp->master_tracker);
+	}
 
 	rtnl_unlock();
 out:
-- 
2.43.0


