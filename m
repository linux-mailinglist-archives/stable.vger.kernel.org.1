Return-Path: <stable+bounces-211716-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIihKSoreGl7oQEAu9opvQ
	(envelope-from <stable+bounces-211716-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 04:04:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0028F5B2
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 04:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C86D63025A42
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 03:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0ED2D7DDE;
	Tue, 27 Jan 2026 03:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q4fOJW1/"
X-Original-To: stable@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9EB14A62B
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 03:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483042; cv=fail; b=hiy4KYWizII0F/Mb2UOXxwsFVbqP6jYTa83PFTETUgwjp12uDaAyKvD5oE1WcvkEs+LWwFlAgGsZBvp8L7f9/axwP2hjRg2lPsS076zXcdiKNqxoiit+m0bGUsBUq7jeoHo7Nn8H434eXsroT3qtHiX8hZkC2PYVv0WXrtiFt3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483042; c=relaxed/simple;
	bh=00OgVUezp8ljIDHvWZ79gkPNmra7nGQOK4cRB3yHpmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XxWZXqSaX2hoj80sjDa82ZSh1ndoX93EYQDnh13uVyJjXc34KlLF4QcSkEDU6XEzvWBkc6Jd7ngq6L2xycZsBSgE9w7FW1fTcqPFVO+6KodLEpdmIA00J4ib+KgDozLZEZQKZG00l6MNfBYXTu8WSs1gi57BL7BeQy/ij8r9GqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=q4fOJW1/; arc=fail smtp.client-ip=52.101.61.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdGaNgXV9DhgegSUbwF+AXDoBXJTbTdTXXkD5Yr9RPGlzl2Ute3gMXjCT5NESz0av+81jMVmwgsexlc+9Jrkr/rSHS5HNHCED2YG04FVTsptKE0g8aybyWdiHur5n3dfmIPYajHIZDciyVwtQfssb0ai0SNMKtc+tMwxNdthDvWh7dfijjxScZzt5Q0ukVij19hKIHwYSpEVKpLK0lWmwlm0gRAk/CqpJS9prj0UBGrV6shANnb4LCl2+rJ0KKZVU3+7+YQkzR3l4m4JPqhEu9YM2PuO9/MOuhBxnMG+DD8vx5EuWbe4VHkx7vKXDeKg4h5WtiTt/akTnLVvGDhICQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYEheasXmIUFlWoej8Lxo+e5crJmIs30TZ2LkMrEFGs=;
 b=Jr2rh8LI6cNT3XCEtZnKOvGrsb4fApMN7QYki0LzZSlnlL6UFYmDdGhgDSwQOnpiss56cUCYplJaaqefiu3cmg0DRPZ8zDeg4q1RH0B5MXab+YtTLNM7LDYsjiC/eEqMWS1/DUMT3/1s9B5YtrpEiD1FpiRwwxdmq96+t/xi/e9PmadUQYsfxAF6mXlEgCrt90M4T8Fa7ZFSv9pY+BXX8p9XWXWaNaqSm3DPpPr5b8qBUxb0vjX8gSd0JgqngpBKAEyGcO6nebS+X5IaCQtHHL62HPYarGe4xjUXVhCIJQTACyYUmRYzWPpc6BDRFjGew070IjgjO/EV1YoEUuTYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYEheasXmIUFlWoej8Lxo+e5crJmIs30TZ2LkMrEFGs=;
 b=q4fOJW1//rmac0g2y6Sp9tsI72XhH+7z7c2eHWst1IPCoZRTYPTdihnkF0sVFXVo2ql1T7Q0NBFa8hQIEdgBhqs/E+z4fya2m8UHuHVHSS6mpZuTUw4+KQtyId5vzvKQpoBakF8KQLFO5RVPmXffa2rqyMghpqrS8qzM2q/5fAc=
Received: from CH0PR04CA0033.namprd04.prod.outlook.com (2603:10b6:610:77::8)
 by IA3PR10MB8044.namprd10.prod.outlook.com (2603:10b6:208:515::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 03:03:56 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::6) by CH0PR04CA0033.outlook.office365.com
 (2603:10b6:610:77::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 03:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 03:03:54 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 21:03:35 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 21:03:35 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 26 Jan 2026 21:03:35 -0600
Received: from [10.249.65.208] ([10.249.65.208])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60R33Z5k3920399;
	Mon, 26 Jan 2026 21:03:35 -0600
Message-ID: <f35435d4-e744-4ccf-932b-24166b6223ea@ti.com>
Date: Mon, 26 Jan 2026 21:03:34 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tiL6.18 PATCH] FROMLIST: arm64: dts: ti: k3-am62d2-evm: Fix
 missing RX delay for DP83867 PHY
To: Greg KH <gregkh@linuxfoundation.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <u-kumar1@ti.com>,
	<vigneshr@ti.com>, <stable@vger.kernel.org>
References: <20260124070651.2152967-1-s-vadapalli@ti.com>
 <20260124080029.2810485-1-prc@list.ti.com>
 <2026012406-saga-tactical-fd5e@gregkh>
Content-Language: en-US
From: "Bajjuri, Praneeth" <praneeth@ti.com>
In-Reply-To: <2026012406-saga-tactical-fd5e@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|IA3PR10MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: b9de4482-ec5e-4762-d72e-08de5d50b4db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzZKaS91RkRqd3FQeXRTVFF3cEJ2RHNTeHRmZWJ3TjlMZXdoOTFlcHM0cEU5?=
 =?utf-8?B?OWtjeUZOVGQraG5mcDdjZmVPbTBHR3g1V1EwVGY3WlhwRVlXNm8wSUhySVVK?=
 =?utf-8?B?T1VRK3Mzd0FoNGJTZjdmYXBxdDNQelhWRmRLcU9pNDJxL0FDV29lRU9oWmUy?=
 =?utf-8?B?d1pVcHZSK1MxQ3ZTdTZ3OHo1eDcxa2N0anBYUUtoZFZkellSVWpRblczMWhJ?=
 =?utf-8?B?R2oyb0o3L0dBdWNIVU00ckIzQ2FNMjlQdGxBK2xHcjJMVGltU0FBdGQ2VURj?=
 =?utf-8?B?L2twbHE3bGF3UFhRWEtVMEp6bE1WazNaRXJuTmhwTUwyYnRoV2dCdjVyZCt1?=
 =?utf-8?B?SmlKY3gzbWxzVlk5YVNZTXVjNDZkSkRPUFp6ai90amJRV3U5TDJIbytiNGxX?=
 =?utf-8?B?TExZQjBpa21saHFRVjdvNUxlbHoxMy90ZnhaUTlGSWpjQ1UwcTNvOVRweitD?=
 =?utf-8?B?czVmdEF6QmlBR3dUdTF1NW5TQ2l1ak9pTTEvN0p1Rk9NY2JEcjZMcVNjNzZK?=
 =?utf-8?B?dkFOS2tpbDFOajN5dGlJNVJBREcvbmI1cm1QSGNGWmdzMnIxemFaTnBpVzh2?=
 =?utf-8?B?VVRjR0VGYUV5SDBYZ0c4dnZoMmwyT1hKQkc3WXRlYkxUNWt3SXI0d0t2OUxH?=
 =?utf-8?B?b0ZyRVpMZ3UwaFdUdlhHY2NOdUgrYlhHTHIxaWRWemEyMFZzTHNKaXBoNXE3?=
 =?utf-8?B?NUd4WmM0bkhKOHM0c085VVg0SjFWRDZVQm5FYWcyY3p1YVdNRmljSHhWYjhN?=
 =?utf-8?B?RUFIdGkyYXpmK0lkNFBIUDRWdHgySlAvQWlzc0s5Y0NFYk9sUGU3QW9RNlBo?=
 =?utf-8?B?OUl3VkcyQ1lZb0Vqd1NWRjZTWFlCRnQzcWNWcThWUHhJc05rMDk0ZTRuTkpr?=
 =?utf-8?B?ZGpUa0prRW4xUFNoUk9sOWw4ZDVuVzlaY1hSUXp4TzNzR1VRZkczdURjV3R4?=
 =?utf-8?B?eG9RaWF4bzN3bkFZQkxNK09TNW5YS2l0S0gzaUpGUXlsMDZmc1ZUTW56aUxh?=
 =?utf-8?B?S2dadHpLei95VkFhdEVpeVNxVzdFUDNBVXc3RE9abFJ2bXl2TmlEVjRydU03?=
 =?utf-8?B?QTFlMTZOaEZmMzZrNDZiSFFjSzFYUmVTZTNGNFFzUTlsSEF0RS9IdHZsd09k?=
 =?utf-8?B?VFhoRW9xU055cjNZTElvbGh5MGNnZ09iT1BoTkRuUWcyYXJoTjUyY21wMkhs?=
 =?utf-8?B?V0ZGeWJZWGhFRjI1TWRJT1psbUZkTG1LWDVMcVBISlZ3cFFVT09pMk84bVhS?=
 =?utf-8?B?VENIZ1RDS0tONi9LaGw2WW5DUXIwZjlOaUVkLzM0Rm13TE5Ld3JwbzhOVWRH?=
 =?utf-8?B?U3pHV0JoNDRYakZpL052OHlWTkVGOTFYRmd1ZlZQUW1Lc3pYeWViQnI3Znlz?=
 =?utf-8?B?QW1qNDVucmJuc0l6ckpZbzNqWHRIU0tQYmE1UDJ4V2o3cFJmNzYyM1lVbWxO?=
 =?utf-8?B?dHZLWGUyVUw1NWh5RUNNOFJBb0VGUHZyTVg3VkFXUEFPQnBFb0E4cUdKTGtT?=
 =?utf-8?B?UTJBeUNBOWVYZldVZzh6cUdISTh2RnpSTXJjQ25reWhrSnpSRjQ3R3NzYVQw?=
 =?utf-8?B?OE52RXFJNHRkZ1V1RmxvOHZIS1gvbkErSU5pblVFR2s4RVVndXhzMytJWFhC?=
 =?utf-8?B?VnUvZmJNV0VhZDZjMW5xL3E2WGwvMjB1RnJQZHdobUFnd1J3eU5IQXAzRFRQ?=
 =?utf-8?B?cXdxRnFaRGhieWdCRkhqaXR4RjNBNHVNOUZkOEEzdHRHQXp2YnAyL2YwZE9B?=
 =?utf-8?B?dENDLzNLOTY1b3NKR2RGSEljelJabzlCTlRBcGl5VTlVUmlIYWxlNjg1WlNZ?=
 =?utf-8?B?U2ZGaUVCaWZ5b0NLWlpjYTFHVkZXS2lqeHQ4U2dxN0ZYN1JjM1owSlJlWUw4?=
 =?utf-8?B?R2RsTFhOUHJUTXhscnhKZ1JZZXk1SVpsWDM1M1M5MSsyUm9ub3lZc1Y0cTY5?=
 =?utf-8?B?c1N6Szl6VUcrNWtTMDVpNndXOTlRV0pIZGtmQXhWODJSaGhLaDMyYjJIMk1u?=
 =?utf-8?B?VXJlSGN3SmZVWld4TklETXQwRlQ4Y0RKaHB6RjVFZ3dqSVlsRGdRQnVDWkpS?=
 =?utf-8?B?V2VtSUVyaWNFUzVuV3NhWDFKanRnejhORFRxaE8vL01nZWZOY054UjJSbGE2?=
 =?utf-8?B?Zm4xc1Q4TUJvWlNCRTRkdUJUcXJIblZvVFhIbUZGR3Y5RmowWnB4a3hEdTJ1?=
 =?utf-8?B?N1VHbExMYytESkJ2SzIzbU1rOXA5RWpMQnVtS2haUWtWeTBvRTZtcFJIUjBY?=
 =?utf-8?B?MUs3bzI2YXpPeHdvdTVvdDd0OTd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 03:03:54.5270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9de4482-ec5e-4762-d72e-08de5d50b4db
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8044
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211716-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praneeth@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	SURBL_MULTI_FAIL(0.00)[ti.com:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2E0028F5B2
X-Rspamd-Action: no action



On 1/24/2026 2:23 AM, Greg KH wrote:
> On Sat, Jan 24, 2026 at 02:00:29AM -0600, PRC Automation wrote:
>> ti-kernel / 6.18 / 20260124070651.2152967-1-s-vadapalli
>>
>> PRC Results: FAIL
>>
>> =========================================================
>>    apply-patch: PASS
>> =========================================================
>> Summary:
>> - Patch Series: [tiL6.18 PATCH] FROMLIST: arm64: dts: ti: k3-am62d2-evm: Fix missing RX delay for DP83867 PHY
>> - Submitter: From: Siddharth Vadapalli <s-vadapalli@ti.com>
>> - Date: Date: Sat, 24 Jan 2026 12:36:46 +0530
>> - Num Patches: 1
>> - Mailing List (public inbox) Commit SHA: 17b1d51fe2ff3be3a867d71baf22dbb3153135b6
>>
>> Applied to:
>> - Repository: lcpd-prc-ti-linux-kernel
>> - Base Branch: ti-linux-6.18.y-cicd
>> - Commit Author: Parvathi Pudi <parvathi@couthit.com>
>> - Commit Subject: UPSTREAM: ARM: multi_v7_defconfig: Enable TI PRU Ethernet driver
>> - Commit SHA: 3e1b5fb10cace2688eecd366e85af7c1f5a69fac
>>
>> Patches
>> ----------------------------------------
>> All patches applied
> 
> Was this email ment to be sent to stable@vger.kernel.org?  If not,
> please fix up your scripts.  If so, what are we supposed to do with
> this?

Apologies Greg.
This patch was not intended to be sent to stable, will fix our script.


> 
> thanks,
> 
> greg k-h

