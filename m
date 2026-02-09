Return-Path: <stable+bounces-214877-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFGjCLBbiWkZ7gQAu9opvQ
	(envelope-from <stable+bounces-214877-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 04:59:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8179310B7B8
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 04:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4DCD300639E
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 03:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8532C08C8;
	Mon,  9 Feb 2026 03:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aQ1rOwdW"
X-Original-To: stable@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012036.outbound.protection.outlook.com [52.101.53.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E40428506C;
	Mon,  9 Feb 2026 03:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770609557; cv=fail; b=utLwtBSKB6+tmY8EUoay/0chlBLuq6Ld5Lf7kpPOs4l0yhGmoxxLTPEmBKwHgNQU6bT26E2Edcidhh90BmMLrcEl5FgYw4/F21+GzKIxjYbEyHTju3PXYaKGmns0vZflALD9F05lDjXl36mvLxnLO2yWGGVb5T+N7lrRjql0SGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770609557; c=relaxed/simple;
	bh=56I3M2twcPwThMRVBlPYfvPfzWCmX2x0xce+o+bGSjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l0sMw1xnj78Pux9g6QqE0lWnGuyAOsYtRmoyX2AdFGItDzC3BLUgfE//XD8AHwwauwnlOdmCsef7Wdo83vsunKeWYQ3ZtOtSyBJIKc25lirYpRmFOMvVqHerDVulDmxqT+HMiIkRkGaeZ/ETyCiAgbSeqTk1XJF2bOKj1KM23FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aQ1rOwdW; arc=fail smtp.client-ip=52.101.53.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/75e9Eklp7Jked8qfYLjyTysBTBb13o9Pw3uzd6pbyqaQ+KXlcN+pokUCvMqmqN0f9V9IOpPxdpc6IsH1kU4H2lU4N5hhkQI61WW4uoKgAxKxpRj3jYqtJOoBtDJ5ARPJsvWMBXoEQCv9S5bfPbE54B0t6NiHYoJODB2w7WE0UGjlaqV0O0506zfoYJMTjoeFsXzjDuO+quJnL5Z7vZVJDP8vaD19A6yz/h47bYXbM7c5BeIgwPyrNhnzxTsf5Q4SzNjvaKbwyPfmmTGcwzjsymAKgsDBeiMXz5LeWkPVaA4L0gyiJnraCVTheMNAYQ/x3juz6NPSKtU9pxal6VHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rzi9nd6f49DaG0B/0IlF/65s40OMn+mLBT95HdKE8ks=;
 b=bUJgTKefTbuy8m6IIchJhWRihQjnucCRWEa9rZ2hzfAVIEsrDrCpB8K/Bgj/r3hxg9G3iIxkekrqF2PW8NHnH2Ac5HKczb19DXdLamUVFAdX1WqSYz8jfrck7S1QZr1C6YiApoipq72jKA2+Q62OwPTLJ0vk+OeIqGVPxJEloLilCz9vUELsNpFlVuRKdAzKfKbqBunGyJzeeRMBI/f8GmT76mizWJPB7iwM5kcr0X1fb4ERMQ5z1S74Wiv1fYbIl58H5TIMOZJMbfx6QzvOmKw7o7In8hNbC18rJ5fU87UsgmHZ9kovhnRneC1jQjkvGZeuPwW4adz36kNsMAHPJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rzi9nd6f49DaG0B/0IlF/65s40OMn+mLBT95HdKE8ks=;
 b=aQ1rOwdWJPnsz5nsMedCDP91IUZrusmoYLSH51Egb0HPJ7KJCwW0Bg94PK/AutPMbxWHqQd2V2licYaljt1ZC3CqNkJ3xXqbIt0/mnv6O90fttDRcfdcvKTkZB7o8OOm1E5cZu9no6htEBwhQv9bZ73My7DpzP+M/047rNC/sDc=
Received: from SJ0PR05CA0070.namprd05.prod.outlook.com (2603:10b6:a03:332::15)
 by DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 03:59:13 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:332:cafe::f8) by SJ0PR05CA0070.outlook.office365.com
 (2603:10b6:a03:332::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.5 via Frontend Transport; Mon, 9
 Feb 2026 03:59:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 03:59:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sun, 8 Feb
 2026 21:59:11 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 8 Feb
 2026 21:59:11 -0600
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 8 Feb 2026 21:59:06 -0600
Message-ID: <f391338d-49bd-4383-a8cd-0dd8073da764@amd.com>
Date: Mon, 9 Feb 2026 09:29:05 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 2/2] sched/topology: Fix sched domain build error for
 GNR, CWF in SNC-3 mode
To: Greg KH <gregkh@linuxfoundation.org>, Tim Chen
	<tim.c.chen@linux.intel.com>
CC: <stable@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Ingo
 Molnar" <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Tim Chen
	<tim.c.chen@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, "Len
 Brown" <len.brown@intel.com>, <linux-kernel@vger.kernel.org>, Chen Yu
	<yu.c.chen@intel.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Zhao
 Liu" <zhao1.liu@intel.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>
References: <cover.1768948644.git.tim.c.chen@linux.intel.com>
 <741531fc98d3c3d364451113b26c4900a868348a.1768948644.git.tim.c.chen@linux.intel.com>
 <2026020701-ether-wieldable-f250@gregkh>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <2026020701-ether-wieldable-f250@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: afdec58d-0a35-493a-61a6-08de678f9606
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SGdTT2xWUm8yU2lnNGRMUFJFWXhTcWpnbHE5QmUrM1pQbEtLYW8vMGtuT1E2?=
 =?utf-8?B?SURKcTdqYkI3T3JYMEg1NGYzdG8zR0l5ODlZUFNZM0Q3YmRLUnpManZwaHl5?=
 =?utf-8?B?WWs3MFkvVkc5d2FVbnhHb29OQngrZ3VRVUNOTGZFekZkdERGZUdVMzVubFhj?=
 =?utf-8?B?WlF3a1c1WVJReGdpd1VrRmIvWFhHM3VrRE9sS2tzSGRRd21KRm5GZk8waUo4?=
 =?utf-8?B?MWFqZi9neGRDYnhDUXVuT2hyTjJIMzRoRUlOR25pck1ZVGg4RCt5MjhWRllN?=
 =?utf-8?B?eno4RmdQcThNVStjYTdvUDdCWXBFOGxzTERlM04xSDJNa1hXZXRlaURYK0xF?=
 =?utf-8?B?MWIxaS95QUsvSVNDUDJjY0RraUxNTmNhU2t6NHhLb2RITUk2R2tYQ1puSHFz?=
 =?utf-8?B?amRCV3ZhL3VVOXFQbjFobUFaQnBCektTMDlmcGNwSzJMbmUvQlFBbGRlUnFK?=
 =?utf-8?B?Ukd2SXJZYjlwZHJDNnY3VFVBek5TZ21hdVN1dmF6MmdqVVRuOFp6OEl6WWhx?=
 =?utf-8?B?bWJGaWRFTEdoMUJzQkhoUWY3TW1xQU5KMVlTMncwVlZzSVNCb3laTDVUVlFr?=
 =?utf-8?B?MFp3UGkwUkNaSUFqd1M2RitsUUFFaTdld2VwYk5ZenFHNEc2QWNpbXZ3VVJz?=
 =?utf-8?B?S284ejFCODlrL1BVVEZKa0ExaFM5QzRkRi9ObU9rd1o4SFV4NjFGMWNMR3VK?=
 =?utf-8?B?Y1l4UWRmSGFldmlJNlRvU2drc3lqMlJyRXhmNUVEUkViMmVickJvSHFyUXRn?=
 =?utf-8?B?dWJhNWdlVjRhMDkrbGtHNWlxZHh3R2RoQlg1ZksxMXczVkRNMW1JcCtEWVNZ?=
 =?utf-8?B?WjVZODA1aDYxNFBSeGUrVGpOOXpSeTRRZlZHUU5YUEZFNkUrcVV3VUp5OVow?=
 =?utf-8?B?ei9Xa0FhUzRZRGw0TWF5WStaeDVLUWJaeG1ieGV6M3EvdWs2NUpRbXJIL244?=
 =?utf-8?B?dXd1aGt6UUlRTWZaY2I5ZkdRU0Z1TnI1ZFRiUEprRU5jdnZQbmtsNU5jenN3?=
 =?utf-8?B?akVBbDlCK3BPOEJtQmJjNzJsMXRncUY0M1JwV3dCclBvNkwvYzVNeGVhbER4?=
 =?utf-8?B?Tmt2N0svSlFNS0RhUzgxUW9saDJQT0lZWHBaYTQ0bmVQQlhGYk5neStBb29C?=
 =?utf-8?B?MkFjbk16RmNTK1VYSXprdlBZUGorcHk4V3VaS0YwWkFVZm94dVVYZGxJak0v?=
 =?utf-8?B?VzdwZXo5QTB0TFV4QXU2MXhtUktnZkdDaXNvRlFaSW12LzQ0blI1SDZWM0pv?=
 =?utf-8?B?cGFBZWhhb2pCWUJpYXhSUktUcDNMajY1Ui9BZlBsQWkrSE8wN0pzR1QvS3pV?=
 =?utf-8?B?bUZxdmQvcElGT2VHeXRtdTM0Qjd2S0EyMlZwRk51SWJFam1XNFJPSnZ1cVhL?=
 =?utf-8?B?cCtvQU11RG4rODVITVlMcThrQ0tWKzBxMDBzNHFhL1hKUmlGc0QxaEZVSEx4?=
 =?utf-8?B?RkZ2R2RhN2xEbkVzZXl1clNpL0FnUThBQ25PTys0cXFxa2dnQ255OU8rNS9L?=
 =?utf-8?B?UGc3VGxuVVQ0cTNaZUlXWGtmTjlBVnpHdTFCTExsNGIxK05iZVVyVldRa2Yy?=
 =?utf-8?B?T3o3S3o3T2tJTzI3NkhCbWhFNCtDaEtmZU9NZGowVmlyS0VuOGZjTjFOR1BJ?=
 =?utf-8?B?NHk5UG1Kb28yNitiUmNZekJ5MnpFdUI5aHBFQ1hzaHJpQkdXbzlEOXdUU1JF?=
 =?utf-8?B?dUx2VTM0S25WT0x5YUd6Zmtsbkxqc2pmeGtKQ05TVWw4Q2FrYlppSFVGSmQ0?=
 =?utf-8?B?VUZIR1hGc2RCLyttdTNDTFVOZXFjMUt4TFBxZzlOS3R3bFRKZHlzMURDTzM0?=
 =?utf-8?B?T3BBOGxYalVhUDUzVTczczNmdHM0NU8wNWoyT09zWXhTLzJwMHo2eHBXUSto?=
 =?utf-8?B?L3lXV2R4WU1WUjh5Q0ZnaE5oSGJCeVVEVy9QKzc3N0JFVkYrVDBkMUNOeUNr?=
 =?utf-8?B?UTFheHRHalFyMkNrZXl6TEczcnAxNS9DODJscmxyTk1pUEZ3K09TVUc2Y2E1?=
 =?utf-8?B?ajYrcUVmSDQ5VFVUU0hnTlV4bXlJM1hWUVZVT0V5SHRmbjMxVFllVUdsTUdZ?=
 =?utf-8?B?SXJyZUVSb0xvR0R6b2dsaUpqa3VjcFRRdEQ2eFcyczRMTDI2QWVrOXYwZ0ll?=
 =?utf-8?B?K2RxT2oramhqeDBiMzZUdTlFeGUwcE16WjNjQVZHVEM5eld6aExTSW8wL2Ju?=
 =?utf-8?B?cVVxeFE4UXlkSnRyUkNRK1E0ODFvdzZmQmNTdDZ1VkRpb3pmRkdXTGVub3JP?=
 =?utf-8?B?S2ZvSGovM0dYamRsenFFWmFKWGp3PT0=?=
X-Forefront-Antispam-Report:
 CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 dlpbeYg7zog7Yaa/YQhGaO/B034KF2XADRO1W4JAvQuxNglp7Zj9edo5KB67/ApJeoay/E8WQbcS9Fo36kr1p/9+v/v0xirexvn+DPQv116Ky8eZtyKvdDxFoHDjumQMjucvebomtC24IA4OSBHO1WacDuOo5KxIgaUhF48hgANrXx+jkQ9r+DBRvZRRRanKHhXm25XLu0jtx2+8SeBIzlGCK3jVDjCRkW5J5zzOoF551EVmhzPyxuPl5q8veTRp/FNZqMoHeYO1RO5O8KIhtzZRIxeWyWywGZTykwfPT/0/ZQVQL0J6YqxIm0IXCXHUHTc0k1GC1O3sxxvjhoLvhjiFJ92/xCX0CROJ0MLE5Oq6RbXKBJXAL4aRwnAt8w++sSfbF/KFJHCvy0nqVWP/yBG2VWdDhzl1FJmEAgC3QNQifRCv46+TYmejWPCjLE+6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 03:59:12.7084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afdec58d-0a35-493a-61a6-08de678f9606
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214877-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kprateek.nayak@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8179310B7B8
X-Rspamd-Action: no action

Hello Greg,

On 2/7/2026 8:59 PM, Greg KH wrote:
> This breaks the build:
>   CC      arch/x86/kernel/smpboot.o
> arch/x86/kernel/smpboot.c:548:5: error: no previous prototype for ‘arch_sched_node_distance’ [-Werror=missing-prototypes]
>   548 | int arch_sched_node_distance(int from, int to)
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> How was it tested?

I believe this build issue was fixed by upstream commit 73cbcfe255f7
("sched/topology,x86: Fix build warning")

(Full upstream SHA: 73cbcfe255f7edca915d978a7d1b0a11f2d62812)

P.S. It cherry-picks cleanly on top of "Linux 6.18.9".

-- 
Thanks and Regards,
Prateek


