Return-Path: <stable+bounces-217907-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDZsGEKYnWnwQgQAu9opvQ
	(envelope-from <stable+bounces-217907-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 13:23:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE88186E4C
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 13:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E67E30A5E9A
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 12:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246C3396D0D;
	Tue, 24 Feb 2026 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B72TYvp2"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013049.outbound.protection.outlook.com [40.107.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B233396B91;
	Tue, 24 Feb 2026 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771935780; cv=fail; b=ihuy/n7sb9NKYLxtQAz76HbXdSjlMn/Jn+UJ40fxe0+ZO8TpoOfYOCrcZEjxYhKTARAjm2G9hh31fEKyeWSXzWhlW8AwwlBPm/CWPKF763/F8ZjesafjaPGDZp6kUFgWRs1Wi2QPHWYgIlpaSyy+hV4EungCRfbcEkr2DflwvoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771935780; c=relaxed/simple;
	bh=aTQuVkQnoklRQsRjWyOQJkjg7+2vYUdawDkAmDfv6nE=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e8VbRaieAWjU80EsRZp2Qky76axJ75J3MDc7VEKSeClsTn6eroP41vWsz2gn+Bwyo2IOHZw0YN9UZsPML4xA9sg/7oOGRjTvqIuKBWuwSgspeFkKi2RBva8CJjF+vy5yyHUXndc7dgGdJJwe9iM/Bz3WfO0GRp6eo6/HXl1K/vI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=B72TYvp2; arc=fail smtp.client-ip=40.107.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xq4W+gfEa+vB3OwJfl1PRPrC+aQW9teLjgCm6hAAmkx9IoyshUilvKKPdz1k1Q8bnKWthl51AA+ihHt7o9DbOI25FEIpUDnL9QiQYja4OGU8mQNnRjs44wOWBxFa0yT0sF+gt/vmYLIpPhM15aEd5UhoNlWlU+rScGX5/Vq7YfSla9Jlnd99WVSKYnyXJ6Xtbc6bSrzuz9nfQI0IhApt1d1rVB5WqZbSCWhs+sIHdb3GA1fOVltl+b0wnBK76v34mNqoWEWhDBY8S4rLRc4mG1MB5k4Rt2U4pZLovTpGUnQkpGHBSldGVwHU13GAf6WqahKEnBwPQr+BEMqsebqBRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfME3h7UIRqdZB08XBZLbsOYbylhdRAB8yQywpePCMQ=;
 b=MoTxPMXrjlSbwbfFduJ2i2x6gL2Kr04qfKEOf6Vho/PwVgZTvMzy2Iq28gUnHwerUbK0iP9ECP2BDYIu7y199blJI5QZhC8XpMlaAlAW5zLmF5ScQuF2fOi6cmrlCb7EU9BDuQEqXT4W+NJrj8Cp/RqMFMxHAeGR92VRClKpyjYzmLKtcnB8+r/7PG58gisNICEt5MLWZf8ejgASIxMIdfdcQc3Gb6K/Aop8r4giDozgnUGMCByWkSXj+QTRR6gg9LmG3wXRwUWPfNITRD5Ihdgq5CL1M/3yht9bAw+LWQ+kBJN5/8AUOsb8aLjCRlWcCNB596uxWjT1ABAJzm2sWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfME3h7UIRqdZB08XBZLbsOYbylhdRAB8yQywpePCMQ=;
 b=B72TYvp2l/nwWJGxU4epFZRqPEf8PZHF8rs1UmqLt32bydxNsFrUbuX2HYeIYoHQV4jvCd3W1FfsKXhgVagis6cX1jP/V/G7lLrv6WG9fovaomLJ0RJwCWGkWqTkKnU5IKQuC+slb+VGfoTvtoKTh0kUn8vAgZQFJHUy8DBwO/w=
Received: from PH5P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::17)
 by BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 12:22:56 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:510:34a:cafe::39) by PH5P220CA0002.outlook.office365.com
 (2603:10b6:510:34a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 12:23:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 12:22:54 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 06:22:53 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 06:22:53 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 06:22:53 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61OCMlFn2715733;
	Tue, 24 Feb 2026 06:22:48 -0600
Message-ID: <57e05b57556e94ed666acd8b4c542efc28e7408b.camel@ti.com>
Subject: Re: [PATCH net 2/3] net: ethernet: ti: icssg_common: set
 irq_disabled after disabling TX IRQ
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <danishanwar@ti.com>, <rogerq@kernel.org>,
	<horms@kernel.org>, <mwalle@kernel.org>, <nm@ti.com>, <v-singh1@ti.com>,
	<vadim.fedorenko@linux.dev>, <matthias.schiffer@ew.tq-group.com>,
	<vigneshr@ti.com>, <m-malladi@ti.com>, <jacob.e.keller@intel.com>,
	<stable@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, <s-vadapalli@ti.com>
Date: Tue, 24 Feb 2026 17:54:18 +0530
In-Reply-To: <20260223184840.06069afa@kernel.org>
References: <20260220041431.372610-1-s-vadapalli@ti.com>
		<20260220041431.372610-3-s-vadapalli@ti.com>
	 <20260223184840.06069afa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|BLAPR10MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: 62cb82e1-52a1-4d0c-c592-08de739f6fe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3BmUnFubDJ6Mm9KOFVjYk0zK2xHdUJMejJubjltcVJhcjI2aEp6OGc3VDIw?=
 =?utf-8?B?N2p0eWJkbDJuczV6aUUxZTNyOHAxNUR2V1ZnbTdzbyt2a3p4US80TnRpZUw5?=
 =?utf-8?B?bDBMZGcxN1V1V1RWQzVqUlQ2MytwbHlBTGhvUCtsdkRFSlJvM3FnWFc2alg2?=
 =?utf-8?B?OTdLYWxSdGd1S3BMVXJMM1ZRT0RFU1JUMUN4RWwyKzdWdGRZMXM0MUNFREVI?=
 =?utf-8?B?TUs0akVQYm9ONk9LcmQ5T041NGY5bTIzOHpnMXRRTFJMYmFHNUU4RlFtWFdP?=
 =?utf-8?B?S080Z2d4MnZycHNWemJjU1o2eTA4cDM4eE5HN0hrQTBFa3hoZGIxejJBWTRy?=
 =?utf-8?B?ODhlbXczaUtjNUI4aUZTMC9pUEhBRkZrT2I4QXBCK2tUZFQ5MXJ4c29QOTJN?=
 =?utf-8?B?cjNMOGFzT3EwTERhMjRZSTFIUVhaMk1seVE1T3VjWUtBK2dGcVpERFRDblh6?=
 =?utf-8?B?MjVzNDc5eDV3OUpGbW5uTi9vZThneEUxZHVwSlpPOHpUOEUxTForSllacVBs?=
 =?utf-8?B?Tjd2eHM3VlhjM3pUOVJ3K2V5YmY0eUg1QnY0aDVpSTE4SW9zY0pXQzBMZG42?=
 =?utf-8?B?QzhtczhiR0R0NlhjVlNxbStGd1B1bFNYY2dkclNhUHV2RjNMbG1IT3ZadEZy?=
 =?utf-8?B?bjg0UEVyazJ1Zi9CNmdVNDEwZXNxVkdlWkNubXl4cnIrOWw0djVUVlV5T3Jw?=
 =?utf-8?B?VjVOemRSRkFUKy9VcS9ncVhDUHQ3MDVXRTU3b1pISUxQdHNHbWJITU8vQ1F3?=
 =?utf-8?B?ZUNZblRrR29SaVJtWW5YWnR1U3lNQUI1RFlSVExXM0JBakZZUjBaVTRLMXBC?=
 =?utf-8?B?bXlkQjdySEVOYURjY2tRMnVQc1NZQzRJVzB5OFVQZnBRb3hrS2xXeTJnalVO?=
 =?utf-8?B?OUYyd0Fmd3pBMk9wL1o5cUd0S2Y2aythQ1FYek1YU3YxeHFtdWJuN2dNYkpN?=
 =?utf-8?B?MmNZWGdLcEhkOGdESnh4bG9zaHpONzRleVZuME1XcDNsQVFOOEh3Ym40MXR0?=
 =?utf-8?B?cDJRZWF4akp0Tk5Odm5FRDJWZkdPU25rSGMvOEw4K3JvT2Rub2t1b0g0aXJR?=
 =?utf-8?B?RGRxd0pVMTNnMnFDMlJlTU96blZEYWEvZllteDJ5VUpzUW8xbVdpVGQxcEY1?=
 =?utf-8?B?WGhGZi9RcWFFWnBGa2VPTmpOSCt4eFRDY2krYXRBaVhUMVFVSnhWQTZHUUNp?=
 =?utf-8?B?YzA4eExyYkN0ditES2xmaksySkJ5bEZXdWhpa3FoN3BCMDBGR05hN25TNHlj?=
 =?utf-8?B?U2xkK0hUWDJBLzZSeU1nS0hwVHU2anhrdTFGdnB6MXlMTmFNNzI4TXQvMTRu?=
 =?utf-8?B?dFlTaWp4WEQrMzg0dFdtWHNTNGVsek4ybHF0RkZuTk5UNVlOYjcyR0Rhd3pa?=
 =?utf-8?B?ZG1qdTFQS3NncTVqUGg4MVlDL2V4ZFJScWFobzZYMTVyaTZ4b2sxb1prRXk1?=
 =?utf-8?B?aFFma1hrWmc0blVUazNOMklCSGYzNjRqOE0weUN0S0huT241dkg2Z290K3lC?=
 =?utf-8?B?Q0tSdFhjYTVRMjZhUkxWMmg1bFlUMW9VNk1jR2FGWDBYMlFKT0Q0WFFtc05X?=
 =?utf-8?B?RGJqdER4VE5NWFdBV3VobkJMY0tiK0NqSFpNaWxXYklFNnFOQ2VMeGNna2k2?=
 =?utf-8?B?TFhoS0ZvQVRQN3NFeGZKVEFPczdUeEV4SGE4U0ZnT08xQVJDZzJCNVBrWTI0?=
 =?utf-8?B?UTlFY2RxM21tWURwaEV3cTZ0VUJBaWdYcVlmRXd0UjBXNzN5TXMzbnpBK1Jn?=
 =?utf-8?B?V0MrV0FXUVZqVSs0dkRTSVRWUWNzdzh1Y0RjVTZlN09sOFNUd1M4NHZCN29R?=
 =?utf-8?B?T3UvSUdPSFpOUDIxY2tMTkRPRksrRnp3WGJ2QnFPS3BEczMreE44VUhmWlVE?=
 =?utf-8?B?MVNUeUQzUkZnblhaR2tOY0FEdkpBTXZHbVZpNnpRSnljcUVQMWtPcWFlbSsy?=
 =?utf-8?B?R2dyZk9tOTlVTHR1cWVuT09LZWxFUEE3cVpyLzNPQmtsTkZzNS83cVo0SWRj?=
 =?utf-8?B?SDZnZDRIOU9kZ1J3a0NNeWxnYXBEMlF2WUtZcnV0ZUlzSzhHeGROZ1UzNlRI?=
 =?utf-8?B?Q1NONUFIWTBJSmNwaVQ1OFRtejZzdHV4WE82aGF4TFM2SkV3QWVyRnloaEZ4?=
 =?utf-8?B?anB2MktXZ2pjU0VWQTVYL0djWlIzcnFJMGJtZFpYMTZkUTBDOFZ5bzB0WWdM?=
 =?utf-8?B?SSs2TWV1dVoveUo5dWJGT29kN2QzOS9HVTlENDN0VHhqSHN5dHIwUnMzWlYx?=
 =?utf-8?B?YTVueU9kZDA1enhMcHI1Sml4cGp3PT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CsbJUVZzEgo9CV+aff5KWosB30izHtFsPAo7b67ijy89QiaHmwgn3+Su5O/pwCEjHvOnLVkkw99PX8t65gBGd0GIBNOVmAQUZ01QVT4fCI+zlkd0nFhT2bXh9Dd37UOhP45bAszpzp8tDoagO9+AFHjNXGI2fPSaCmod45fisORPYo/dvstvEwC8so23i2pCVrtOtyQZ+Ht08tHx2sMVNLVNHbJFu5q4xfTJckFPhADqoGsnoYXedheT4iP39Bv6SNqqlB0NdGLMbIDKuupTo+4CWY4NHJOOJ72+xzEiOvGQdKKo0gxVcJ9tmD3YAOQk2s9XtM6+YJD4v9fP7ATWarec91nNESsBvHZZTFVwbMAOrEc6UECPwv6WDpx278b9ZUurcA8uMH/jjF5bTsX7OWGvCDbfBtAKg8s7aW1MI5AmakzvuzZ2rBXpzaKkm+Zf
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 12:22:54.6780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62cb82e1-52a1-4d0c-c592-08de739f6fe4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5156
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-217907-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:mid,ti.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: AAE88186E4C
X-Rspamd-Action: no action

On Mon, 2026-02-23 at 18:48 -0800, Jakub Kicinski wrote:
> On Fri, 20 Feb 2026 09:41:58 +0530 Siddharth Vadapalli wrote:
> > The 'irq_disabled' variable indicates the current state of the TX IRQ a=
nd
> > is used by the TX NAPI handler to determine whether the IRQ should be
> > enabled.
> >=20
> > Currently, 'irq_disabled' is set before actually disabling the IRQ by
> > invoking disable_irq_nosync(). In an SMP environment, this leads to a r=
ace
> > condition wherein the processor taking the interrupt sets 'irq_disabled=
'
> > while another processor executing a previous instance of the TX NAPI
> > handler sees 'irq_disabled' set and invokes enable_irq() before the TX =
IRQ
> > is actually disabled by disable_irq_nosync(). This results in the follo=
wing
> > warning:
> > 	Unbalanced enable for IRQ ...
>=20
> AFAICT the flow on the Tx bug is not buggy, owner ship of the IRQ
> vector passes handler -> NAPI -> timer. I don't see how those can
> race.

The issue is seen in practice. Interrupt coalescing (hrtimer) isn't used.
The call sequence leading to the warning is:
	net_rx_action
		__napi_poll
			NAPI TX Handler
It does seem strange that the 'net_rx_action' leads to the NAPI TX Handler.
However, it is exactly this path that causes the warning, and it is due to
this that we could end up in the following situation:

			CPU0					=09
				CPU1
		----------------
								--------------
1.	TX HARD IRQ Handler entered				NAPI TX
Handler is running
2.	irq_disabled is
set							Sees irq_disabled being set
3.	Starts executing disable_irq_nosync()		Invokes
enable_irq() for TX IRQ before its really disabled
								=09
			[UNBALANCED IRQ WARNING IS DISPLAYED]

Regards,
Siddharth.

