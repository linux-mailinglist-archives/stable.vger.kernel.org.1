Return-Path: <stable+bounces-211194-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDnOMuiocWmjKwAAu9opvQ
	(envelope-from <stable+bounces-211194-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 05:34:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C47D61BD4
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 05:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 299414EFF00
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 04:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0200937F0FB;
	Thu, 22 Jan 2026 04:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jV+kcK+8"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011066.outbound.protection.outlook.com [52.101.62.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E520D33439F;
	Thu, 22 Jan 2026 04:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769056477; cv=fail; b=ND5YcVnOtLKTXYEjFssIEZL7GvzIMlgPcmrHc1Ux38NbYhiL0U2hR7o5cco/K+eZURLy2LLBbbdYJyEeT0pdoD5RFVbGJZtatEiZ5MImJyuCyAQlprNA9AfffaBkdG8Hl9VX7I2r4m/mNZAp/7cJf3tdfMVqxEM54I1k9QDc2oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769056477; c=relaxed/simple;
	bh=6rEgratXPkHrzLUZ+iQQe6Aan7ToTNCY1Ya8CtR6iZE=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oImFXpl1i1L9NgREC6CrHCL1nvwkBPrV5nv9tMZKPGpldzU8W2Fw5BrDPixwiCoJsfKR93/7bKghuhjvC0spDZLWmC6Y+3JLFL+OEVlNluoqjRDdzYqB8MPG8TWTmesvin/bnCZ7HZVzkibanZoONAx3LiWaqAMPBS50zyu6u6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jV+kcK+8; arc=fail smtp.client-ip=52.101.62.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rR1rTX6jahnvsLGZWKXybZCPwExXkYp87W/CKQQlYsLaDvxdWpCwV6hZe5DH9QK2L2USJWA5yf21ASeef7AoQFfUM4bSPYvGlNRDKoFf2RVOaSAZBGlpP1a8o1iUWzZtAGaN1WFKVMtneuFPkzysPcROo8MAJdBE/OD78yX4mW7Uh1S2VDE8PaN9uo61GVWrIdtz58FbJwFOxgVfbd145QUbuhezzDyxSVKvkvm+RfXBVcKi0j2tf7xgLdV+1IZLzUQsTSr23G+vPL+a6ab8H5ba34TfC7Le9n9CPQxTEnxC0j01J5NlJyR9ckyGn4lqQkSGDCWqdsLPYenwrnZtPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rEgratXPkHrzLUZ+iQQe6Aan7ToTNCY1Ya8CtR6iZE=;
 b=JqCH+j6BWUL2mjqDpJMTQXLVAAZqxO/94omd1UmIQ1BcrC17XNxVizbqys6DWSL9jEeRSA0MmclQNDqIKDxrgjzBi3na0B2U9cwIrwbcr8zzBs1H1OlMaccjdMnwwR4XmJymARC+iMlghEGzXKEH4xx3JXVszH05pTbZ+49TNXpEX5bCKFGP0xOflsgoEj7Q546vWAZQtbcoH6jc3or+emvl4P6SEobVVVAq2w2VUlSv4GMhPxcVIc1NRTRck4PBzLNq1iKaZGrnmU+ywZ7YV7/KiKG483TvrSRNig06O7C3jfrgIN03nQZzzXEgT0ZIsOmLLUx36ecSUs2JmcdKJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rEgratXPkHrzLUZ+iQQe6Aan7ToTNCY1Ya8CtR6iZE=;
 b=jV+kcK+87rY5HAmu78UhpSDsSOl2Ck/36fOTma3X91UDe6tmPAcPoTu7dqQ2V8xPRKg4j1xfhxPOMO82Yjqmobi3cMhhFzhrmuC8U1L7VzrhDVHPmC0buZmfPQLRK3udvMvix7Svlxs9/Bo5RArdCCVkDx4GW9BVorpqJbcl0aY=
Received: from DS7P220CA0068.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::23) by
 PH5PR10MB997710.namprd10.prod.outlook.com (2603:10b6:510:39d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 04:34:31 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:8:224:cafe::5b) by DS7P220CA0068.outlook.office365.com
 (2603:10b6:8:224::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 04:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 04:34:30 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 22:34:30 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 22:34:29 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 22:34:29 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60M4YPkF4026212;
	Wed, 21 Jan 2026 22:34:25 -0600
Message-ID: <40720ca3b3b8676aaec55605a70f055418dcb4de.camel@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am62d2-evm: Fix missing RX delay
 for DP83867 PHY
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <bb@ti.com>, <afd@ti.com>,
	<p-bhagat@ti.com>, <gehariprasath@ti.com>, <stable@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Date: Thu, 22 Jan 2026 10:05:45 +0530
In-Reply-To: <32265181-6a16-4cb3-9cc8-52d4265c6646@lunn.ch>
References: <20260121054552.1650926-1-s-vadapalli@ti.com>
	 <32265181-6a16-4cb3-9cc8-52d4265c6646@lunn.ch>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|PH5PR10MB997710:EE_
X-MS-Office365-Filtering-Correlation-Id: be4a9e5d-9b6c-4312-295f-08de596f8914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnF0dkFUWjRwQmF5aTNNV0xpMHowV0dGbWNqemh1MHgwNVBZdXhEMVBkUitk?=
 =?utf-8?B?VTkwZU5lVy81M1g3YTZOMlE3N1IxZkpTQThmVHpMWEdxWENBUXZTR3ExcGpL?=
 =?utf-8?B?YjFjVkNISVAzd0pEYkVod0ZJaHNLNU1uemhUSHJUV1V2SjA4KzVGVVVqdUdJ?=
 =?utf-8?B?MDVCRm5vQnd2WDBnN21wTnFoM3I1RG4rNWVUYm5rK3FINkJ2SHVEczBTWERv?=
 =?utf-8?B?T0xVQ0w3ZUxGejFVMVNNNHZOazNvZi8wR0N6c0FnOTUvMGxEVTRjWTdEUzlm?=
 =?utf-8?B?dHBTZ1BmQXYxeXZsTUt0bEJNa09aRTk5Zm9STlo2c21VYjlvaThaRHVHR1lY?=
 =?utf-8?B?MWhWdExubDlnaWM3NDFLdzZjQkt2TXhjWTNpWG9RWlorQ2lRTG1XQy9RbmZB?=
 =?utf-8?B?Yk1zRzRldDdYeDZYMHFkTGVlUnBueDh0Umplb3NrTFM3dFdoTkliZ3VHUFRR?=
 =?utf-8?B?WUJxMnhhVkV2V2tFeTRDRVlSdzFYdHhMTDdpeDRWdmd4MmxEaFdxYXVNTmJj?=
 =?utf-8?B?Tk1WTVlRaVVkaSt2d0NkemVSYTd3M3dFZG51NnkvMEZ6cUV3cnJlRm0wV0ti?=
 =?utf-8?B?SkxLT3RTbnp3aExHRUFxSXRBMUtqdHhqSnZ3T1drQnUzczZLVTlXc1FBY3Y3?=
 =?utf-8?B?Vmczb0NFU28waVM2R3BFZ1VlaVF4alg0cHlPeDhCRXI4Z0NYWDhkSkw4L2FG?=
 =?utf-8?B?bG9nOURsQ04yOEVPR3NsT3UyOUZFWWRNMW1tUExnOURBMnJVbi80MGIyQ2gv?=
 =?utf-8?B?bEdORmcvOU5iamdLckdKREhkYmlPMjFSU0RVeTJzOERxcW9FVDRWdFE2Vm9i?=
 =?utf-8?B?ODd2Z1VsN3N0bFgxdGs2TVEvdXoxdnVHY1hoS3lsTnpRZ3A2YWdyeEVaaUZh?=
 =?utf-8?B?UVBmUXhjcnoySkE0MUVkeTBiMTNvWDVPbnZ6dlFWNDI5Wlh5MGwzMzFUb3Bo?=
 =?utf-8?B?M1lnOEtaSmxCK2dMYVg2OVBxZVlMNXNpTTYyeFA0SmtrL2F4UHVveXZrUndY?=
 =?utf-8?B?T1RKaVlQNHExY1FwT3dLZEVDbjEzRWwvLzhJanQvbThyVStmZzV2RE53aVBx?=
 =?utf-8?B?WEtLZ0UxYkZGOE92ZGxJZElPaFQwRjJDTUp4Nno5dWNaYVdsemVOb2I3Qjhz?=
 =?utf-8?B?RTczMkdUaEtoQTdnRzVnWkFpd1pqcFJGNzRXaHJwcWVPNUxNMldybzNlejhr?=
 =?utf-8?B?TjhrUWNybzFJODBnaEsveU9QTEthRHU0ZmxsaEYzR1NSV1paM1RaaDN1NFdT?=
 =?utf-8?B?WWpUajhzay9mRkRVanVRY29UM296SHhmRTJBODBMbVRBaVJhZmlYTVhPMkhi?=
 =?utf-8?B?L2VvL1JOamhUbFpQQlQwOHBhTFRxMmMvKzZBSFcybTJuUWY0MEhRcHpySTBp?=
 =?utf-8?B?b2VtS3MxK3NVVmVnZ0hDb0VsRklmWHUvUnFURjBLNFVGUlFyRTd5SkM1MDhu?=
 =?utf-8?B?MGYwKzI1SVdycWpPckt5Z2h4QWo5c3NHZTROM0M4T1FRWXluNS9VUDc1WFdI?=
 =?utf-8?B?Tmhob1dyeTFUMFJBV3VIUEdRQlRrSmJEa3d5bnRBNzZrejdzRFdaRE1BaFpN?=
 =?utf-8?B?NGZSRGdabVA4aUZLQjdRYlNNOGVwNzhqQ0FOejlSTDRnVUlMS2NQOXZHS2Fv?=
 =?utf-8?B?WkpoaUVTMGFrV01pY0NhOVhZUG1sVnUvb0ZHNkp2ZkQ5cGxhWlZJTmQ0Q01B?=
 =?utf-8?B?c05SZHJ3djJwcHJWVE51TlRNeWh1dkd4TmdrQ0FnWUdPK3hWS0U3bGxUVGlY?=
 =?utf-8?B?MWlRK1M0bC83blp6anMzVzlyUi9ZWEdiWnI2L1NVZEFTVkJ5UFZvV3NhcEZF?=
 =?utf-8?B?bzlvRThmMk5QWGxRaUVpaTdIR3podXBwOUFWRFQ1K0RBTHM3bFBUZ2JZdjBk?=
 =?utf-8?B?T3F1WTBBb0c4L3dNUU9TWXNQc1l6OFdQL0Q3cFdmQWtzcy8vOWNEQTl5N0Fx?=
 =?utf-8?B?YVZRc05sWkwvRHVmRzNsWVR2MWNodnYwdWxxaHYwMG4xazhiUHAwZUloa2RL?=
 =?utf-8?B?aDUvZU9FUmNMS3hTV2NCNmVWeTJPbDd2cm5ReVA0SUZFYTB0YTZnR0JXOHNM?=
 =?utf-8?B?bm9xblpXWHhwK2swZGhqMy9HaUlPbGhwU01KTGo5VTBjWnR5ZTRiaE5nMjh1?=
 =?utf-8?B?bkZPM2RxSlRWbC9KYlpJL082S1ZNbWNFRnFyWkZIWDFmbnI4WVRxVVZvRGFM?=
 =?utf-8?B?bW5hY0xJOUR6VWdtRk5xK24zQVlCdlN2TXc5NFBnMkRWM2J2MDdvc0ZhSTFG?=
 =?utf-8?B?cmRQZGtxcGRSY1lsTVExRjcwRm5BPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 04:34:30.8179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be4a9e5d-9b6c-4312-295f-08de596f8914
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997710
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211194-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DMARC_POLICY_ALLOW(0.00)[ti.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3C47D61BD4
X-Rspamd-Action: no action

On Wed, 2026-01-21 at 14:22 +0100, Andrew Lunn wrote:
> On Wed, Jan 21, 2026 at 11:15:50AM +0530, Siddharth Vadapalli wrote:
> > MAC Ports 1 and 2 of the CPSW3G Ethernet Switch in the AM62D2 SoC are b=
oth
> > connected to different instances of the DP83867 Ethernet PHY on the AM6=
2D2
> > EVM, with the 'phy-mode' set to 'rgmii-id'. The DP83867 Ethernet PHY ha=
s to
> > add a 2 nanosecond delay on receive (from wire) based on the EVM design=
.
> >=20
> > Since the device driver for the DP83867 Ethernet PHY coincidentally ass=
umes
> > that a 2 nanosecond receive delay has to be added in the absence of the
> > 'ti,rx-internal-delay' property, Ethernet is functional.
> >=20
> > However, since the device-tree is intended to describe the Hardware, an=
d,
> > the device driver for the DP83867 Ethernet PHY may change in the future=
,
> > add the 'ti,rx-internal-delay' property and assign it the value
> > 'DP83867_RGMIIDCTL_2_00_NS' which corresponds to a 2 nanosecond
> > delay.
>=20
> The driver will not change. Doing so will break boards, causing

Ok.

> regressions. Also, passing PHY_INTERFACE_MODE_RGMII_ID to the PHY
> means the PHY should add 2ns, or the closet it can achieve. The PHY
> driver does not coincidentally assumes that a 2 nanosecond receive
> delay is required, it is required a 2ns delay is added.

A default of 2ns is chosen and is overridden by the value specified in the
device-tree via the
'ti,rx-internal-delay' property. So it is ultimately what is described in
the device-tree that dictates the Hardware and the configuration that the
driver should perform. I agree that in this case the 2ns delay
doesn't have to be described in the device-tree for functionality. But my
question is whether it is wrong or unexpected to specify the delay in the
device-tree when it is simply describing the Hardware?

For further context, U-Boot (Bootloader) uses the Linux device-tree. The U-
Boot PHY driver relies
on the device-tree to specify the delay. Is it incorrect to rely on the
device-tree description for configuring the Hardware? Unlike Linux PHY
driver, the U-Boot PHY driver doesn't assign a default of 2ns. Instead, it
asks for the delay to be specified in the device-tree. While this may seem
like a 'bug' in the U-Boot PHY driver, given that a proper and complete
description of the Hardware is all that the driver expects, wouldn't the
proper 'fix' be to simply describe the same in the device-tree?

Please let me know what you think.

>=20
> So this patch is pointless.
>=20
> Please drop it.

This is required for U-Boot as pointed out above. The reason I didn't
mention it in the commit message earlier is because the patch is simply
describing the Hardware which is what the device-tree does. Mentioning U-
Boot would have taken the conversation in a different direction where the
reader starts questioning why U-Boot PHY driver can't have a default the
way Linux PHY driver does. That would be a valid point if the patch was
violating the device-tree convention or doing something unexpected. Since
that isn't the case, I have kept the description simple, positioning this
patch as a 'fix' in terms of explicitly describing the Hardware through the
device-tree, rather than depending on the driver defaults.

Regards,
Siddharth.

