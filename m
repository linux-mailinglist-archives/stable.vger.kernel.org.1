Return-Path: <stable+bounces-144736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D498FABB47E
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 07:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF663B683F
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 05:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F28F1F1311;
	Mon, 19 May 2025 05:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vhpj9kbU"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B1BA2D
	for <stable@vger.kernel.org>; Mon, 19 May 2025 05:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747633862; cv=fail; b=cM8ss39uzmtgroQFpHVK54yn3V8A9GfPDFbIy2aFfp05qnkppaPueFeDwGqLPDecElsDqZpHXDkwolzogqrnYnr1+b1VJS6B8QjcQTJJ73xvWoLKXA5rCGQhbBNyq9wAKgJXYmWZsQmsKu+L0BDphS4v9Q0F9E3tNP94H8AEdy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747633862; c=relaxed/simple;
	bh=e7W0yxoPdPRiz3Wp65kkuB3gDx1SAOENeuQ18t7hnQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VJLQ7Y+5masepbr78sMSSxOOyC23gJQENs3qxJ06uAZXu+r5mlUMbYIJfDSVVAEynCBDA4wzp+Arlm6zW/rpFQ86AE7q5js67kWf9+i5qOkMuc6tBB0UdfSraur3QbidWiBygLl4/sqDrrM97QodsM39UO8UG2fur3OIAp9XX44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vhpj9kbU; arc=fail smtp.client-ip=40.107.101.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZwxpWjjHpRhbyzljSLHeNZDg9svOx48at9+1h1yTJDMib9YFAsi3ZLErhOnIk+I0lMTOXgoNj9VIdLhx8HyikzDc+lAKIJy3TOr2clTFKKFngsVfDua5MRH+OHDstzhU8HdGv+3tpa82Nsep9ia2WOioEwZsu6H8JRSOi6vu+Tu+NTWCS/ubVlxVtEnEczkW7R24JZzQBipWTwaSdzKQ+1WFV+B3nArb80zy3H9gJ/YqGe+hg/dZE+/c3ZqWuUSLnHZCH6puJCxsi8hrQ5PA37yFoAYC/SiTpUJFAzOD5v+0Nlo62QcpQA7s8V78lPEx42D12UCa/JcKRZB4ySnkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmK1DX/8UeETn1hnf67f/8G2YIdeDS+nQluDYa3QHX4=;
 b=l7Epo+roGPo1TqCklH4X3FXhRyjyp79r9x7FdrDYMCCTC7FlJ8NkXicaXbvQhond/MIXFHLsxfCYmmUeL0V1eLtrhtFsAm7EJGtgg3wOztTQP0zjkHm0Yiqcw1O9/R/x1+l+V5Oxkk0/M7sJ5kM15mF8P/FKLGSEi8OrHHLLG3r+SbbH/Ow2kjrh0mm9/Zncfg+xQ0lyoUcexqTz1QPkrVGhcwe3/KUikA7Z2hxnN/BUSO35wxNgAWRs145ZUupC0B1QDJ2ol9Bm7oFiNJAM3qUo0Hbe7jFx3vvUdcm2259DExyNZ45Kfs20Aca2cxT/dWNmNAhQooYIljRW/Y+KJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=e16-tech.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmK1DX/8UeETn1hnf67f/8G2YIdeDS+nQluDYa3QHX4=;
 b=vhpj9kbUq6xmuU+4Reyz1OSD2YzjbzrR8XdbFWDqp3OY81NO7OjI4CBJv3G+c0rpM/V6sKXIFMwYpNDvbEHRP5mBZBnHrgMO3p4ZdWtKM1T5F/duwAGwBC2meZ9NWA2vkBXwfORICJ/YHBtNFmTidXnvotUF4yWc80MX/nZ6l6I=
Received: from SN7P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::29)
 by SN7PR12MB6767.namprd12.prod.outlook.com (2603:10b6:806:269::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 19 May
 2025 05:50:57 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:124:cafe::d3) by SN7P222CA0015.outlook.office365.com
 (2603:10b6:806:124::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Mon,
 19 May 2025 05:50:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8746.27 via Frontend Transport; Mon, 19 May 2025 05:50:56 +0000
Received: from [10.85.46.226] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 00:50:54 -0500
Message-ID: <ca423257-633e-4ce1-b88d-328dc54d4a80@amd.com>
Date: Mon, 19 May 2025 11:20:52 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iommu crash when boot kernel 5.15.179 on DELL R7715/AMD 9015
To: Wang Yugui <wangyugui@e16-tech.com>, <stable@vger.kernel.org>, "Vasant
 Hegde" <vasant.hegde@amd.com>, Santosh Shukla <santosh.shukla@amd.com>
References: <20250518145453.EF51.409509F4@e16-tech.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250518145453.EF51.409509F4@e16-tech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|SN7PR12MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: 998a7e4a-9992-42df-f457-08dd96991fce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXkvcGUxNUk2aXlINVg0d09kaDgra0tNaU1sY0FteEIxNTJnRC9XbUQyeG1q?=
 =?utf-8?B?Q29WNUEzZ1ZCRWIxeG5KM0J2cW1kRndNZC9ZdFhOd2ZVYXljWFZBaEJYd0V2?=
 =?utf-8?B?bndteVB0RUkyYUhhOUdsSURXdi9HK29sRmZKUDhPN0d4Um5mMmFkRU91SWhr?=
 =?utf-8?B?YXUrbkNFa3VZQWlqRDRmZ21uMWNudmhNdDRUdUxzcFJQTnNXZTFBNlE0S3o4?=
 =?utf-8?B?YXBvWU5CdFFUaGo0Ui9QZFhoVFhhZlkwL3hwc2UwckNJRFQxZUlTeG5GcE05?=
 =?utf-8?B?NUMrT2tlbUVJT21yQWJzcE8rMWxjSDNRWWpxQUFwR1Z6bWVTM2VuaHBocVVJ?=
 =?utf-8?B?OGg1OXJqTitpdkF1KzRZVytKT0NrVHdkcWdhdzA3OG1Sc2ZVTndMOHhnMDFK?=
 =?utf-8?B?cTF2WW02Si9NMCtxNUVaeEJRMzUvWnE5Z01mcldsY3RCK1o0eXowSFVnN0lv?=
 =?utf-8?B?NGJpM3N4WEsrcEswM0ExYW9pdU13T0x0bWY2b0lDbkg2U0s1aGtJKzRFbEhQ?=
 =?utf-8?B?YkVtYnZDSGprRW9LUHhUMktPNm45azM4UGZaT0U4V2I5ZGpVaFFURUsrL0ta?=
 =?utf-8?B?MlBEWU1SUjJJUUlOWmptVkJqRkFPYkhETlF4TkdVSHBTREpNTXhCaVlLNXVG?=
 =?utf-8?B?Q2JOdEZWeExEWmI1bFFqY0pscnoxOFo1UU9RQmtDY3ZmS3g1SWI4bVlIdExW?=
 =?utf-8?B?Mzd6RnRGWW1EcFNrc1lDUmtxOEt0NUlndHc5NERJaTlZNW9FUUJrWUNlbTVY?=
 =?utf-8?B?d216ZnU4VWhnbkQxTEdwV2tock4vNUUrbzhiTFpSQlVzbnNqV1V1RmxtdlF1?=
 =?utf-8?B?YmdNTFhjVVZqOHBuNFAzOCtKenpOendSTnI5NUtLKzc2QmFvVHBWMUpwTWUr?=
 =?utf-8?B?aUhZVDNjcHpENTNJbVN4Rjd1Ynl6cnlMUTJkYzAyd2F0NjRRU1pxclNlVHhO?=
 =?utf-8?B?amRla29rZkZvZnlLTW9FZWhIdUJyTHpoa01ndHRUS01zSTBHWUlKQlFUS3pQ?=
 =?utf-8?B?Tlo1YTMvTlVuM2JzazQ0bHl0ZHY3MHJpUXM3dVRsREdxTG5nRnFNYWd6cFQ3?=
 =?utf-8?B?N0pyckZsWUpCSVhTY3FiM0dCczVnM2tZQ1FzZ2dObUxEZHp4YWtVcVBGTlVw?=
 =?utf-8?B?T2tVTzEwanFNSGJJUTN1ZUFKWU5zS0U0MWh5V1FvZFp2T21zSU5lK1dqV0dn?=
 =?utf-8?B?cmV2YklrdnMwVm94TE40Q0J4c1h0bWozK3kydUZpck1UN3c4WUhYRmQ0WlFN?=
 =?utf-8?B?SGpvK0t5OURjQmt4WDFUcktJMXBCT3BVUjdMNWtoODN4ZGpNTE5IMWtJYkJl?=
 =?utf-8?B?TVBNWmE3MTIwYjUyeXJ2THRnQnZMc0FrUVJDMmFQN2ROZ3pmc1d6K3U1MzNS?=
 =?utf-8?B?T2x6Si9rN2czMWxENXBzUVJmajNiREFTQVJ4YnRsRTYzWjR4OEtPY05JZjZU?=
 =?utf-8?B?dE9scHNxSnN4NmFLQ3c2VmFJeXQyNnVVVnAzNDl3TU5jYlJjU1JBUk51WlVu?=
 =?utf-8?B?N1hzckJqaks1bW9QWWdBUFp5eU5LSnBFWVNQbERIU0NnRmhqZ010WTNiRko1?=
 =?utf-8?B?Q1ZLNStMSGxhNE9yR2RkZVpLeTZVLzRmRjg3OXdyUDhOamF4MDBIOCtRV1A4?=
 =?utf-8?B?NEdRVzVUeXUwTkl6bDUyRDZoSUhhL1VlTVdVYlpvWnplYWtKMitBQ3FFekNL?=
 =?utf-8?B?U1E2S016ZmxhZGRQalFyNjJkaytjRFhxS0FYOW5KSUVhY21pVzlQOHJOOGJK?=
 =?utf-8?B?VENFMWV2dnVYOHo2QXdyS3VaMFZaSUJaOFRMSFQ5cHJITlJRU1FqUXFtRzBF?=
 =?utf-8?B?N1Nua0xuaVZ6THN1ZDU5Q3dFWUdZQ0ZkSEFZUUNZcEhkQURrMTVhQkdFOU5R?=
 =?utf-8?B?ZzN5dGtSTUNpWGkxbVU5bTRPM0lmcDFMR2ZpWG1SZWZIOHNHYmY5dzBsaEtm?=
 =?utf-8?B?YXg2eG1ja3FJcXZQZy9uU1U0TDhwM0MzZS81dm0velRwMUY0c01PSnBabFRl?=
 =?utf-8?B?SjFoTDdtOWdBSGVWTG1XWjdEYUpwanhtaU9CUEtxRkVEZ2hHVlZMeVZBb3RR?=
 =?utf-8?Q?NE+i85?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 05:50:56.3555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 998a7e4a-9992-42df-f457-08dd96991fce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6767



On 5/18/2025 12:24 PM, Wang Yugui wrote:
> Hi,
> 
> iommu crash when kernel 5.15.179 boot on DELL R7715/AMD 9015.
> but kernel 6.1.133/6.6.86 boot well.
> 
> It is the first time  to boot kernel 5.15.y on  DELL R7715/AMD 9015, so yet no
> more info about  other 5.15.y kernel version.
> 
> It seems iommu related, but  seems no relationship to
> 5.15.181
> iommu-amd-return-an-error-if-vcpu-affinity-is-set-fo.patch
> 5.15.182
> iommu-amd-fix-potential-buffer-overflow-in-parse_ivrs_acpihid.patch
> 

Hi,

Could you please provide more details such as
1. What distro you are using
2. Steps to reproduce
3. Kernel config
4. Hardware details about the machine

Also have you tried bisecting the kernel (between 5.15.y to 6.1.y
) ? It can help find the commit that fixes the kernel.

Thanks
Sairaj

> dmesg output:
> [    4.658313] Trying to unpack rootfs image as initramfs...
> [    4.663349] BUG: kernel NULL pointer dereference, address: 0000000000000030
> [    4.664346] #PF: supervisor read access in kernel mode
> [    4.664346] #PF: error_code(0x0000) - not-present page
> [    4.664346] PGD 0
> [    4.664346] Oops: 0000 [#1] SMP NOPTI
> [    4.664346] CPU: 8 PID: 1 Comm: swapper/0 Not tainted 5.15.179-1.el9.x86_64 #1
> [    4.664346] Hardware name: Dell Inc. PowerEdge R7715/0KRFPX, BIOS 1.1.2 02/20/2025
> [    4.664346] RIP: 0010:sysfs_add_link_to_group+0x12/0x60
> [    4.664346] Code: cb ff ff 48 89 ef 5d 41 5c e9 ca b4 ff ff 5d 41 5c c3 cc cc cc cc 66 90 0f 1f 44 00 00 41 55 49 89 cd 41 54 49 89 d4 31 d2 55 <48> 8b 7f 30 e8 a5 b2 ff ff 48 85 c0 74 29 48 89 c5 4c 89 e6 48 89
> [    4.664346] RSP: 0018:ff3f20b800047c28 EFLAGS: 00010246
> [    4.664346] RAX: 0000000000000001 RBX: ff25a0fc800530a8 RCX: ff25a0fc82cdb410
> [    4.664346] RDX: 0000000000000000 RSI: ffffffff904726e7 RDI: 0000000000000000
> [    4.664346] RBP: ff25a0fc801320d0 R08: ff3f20b800047d00 R09: ff3f20b800047d00
> [    4.664346] R10: 0720072007200720 R11: 0720072007200720 R12: ff25a0fc801320d0
> [    4.664346] R13: ff25a0fc82cdb410 R14: ff3f20b800047d00 R15: 0000000000000000
> [    4.664346] FS:  0000000000000000(0000) GS:ff25a10c1d400000(0000) knlGS:0000000000000000
> [    4.664346] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    4.664346] CR2: 0000000000000030 CR3: 0000001036a10001 CR4: 0000000000771ee0
> [    4.664346] PKRU: 55555554
> [    4.664346] Call Trace:
> [    4.664346]  <TASK>
> [    4.664346]  ? show_trace_log_lvl+0x1c1/0x2d9
> [    4.664346]  ? show_trace_log_lvl+0x1c1/0x2d9
> [    4.664346]  ? iommu_device_link+0x3f/0xb0
> [    4.664346]  ? __die_body.cold+0x8/0xd
> [    4.664346]  ? page_fault_oops+0xac/0x140
> [    4.664346]  ? exc_page_fault+0x62/0x130
> [    4.664346]  ? asm_exc_page_fault+0x22/0x30
> [    4.664346]  ? sysfs_add_link_to_group+0x12/0x60
> [    4.664346]  iommu_device_link+0x3f/0xb0
> [    4.664346]  __iommu_probe_device+0x188/0x260
> [    4.664346]  ? __iommu_probe_device+0x260/0x260
> [    4.664346]  probe_iommu_group+0x31/0x40
> [    4.664346]  bus_for_each_dev+0x75/0xc0
> [    4.664346]  bus_iommu_probe+0x48/0x2c0
> [    4.664346]  ? kmem_cache_alloc_trace+0x165/0x290
> [    4.664346]  ? __cond_resched+0x16/0x50
> [    4.664346]  bus_set_iommu+0x8c/0xe0
> [    4.664346]  amd_iommu_init_api+0x18/0x34
> [    4.664346]  amd_iommu_init_pci+0x56/0x21c
> [    4.664346]  ? e820__memblock_setup+0x7d/0x7d
> [    4.664346]  state_next+0x19a/0x2d4
> [    4.664346]  ? blake2s_update+0x48/0xc0
> [    4.664346]  ? e820__memblock_setup+0x7d/0x7d
> [    4.664346]  iommu_go_to_state+0x24/0x2c
> [    4.664346]  amd_iommu_init+0xf/0x29
> [    4.664346]  pci_iommu_init+0x16/0x43
> [    4.664346]  do_one_initcall+0x41/0x1d0
> [    4.664346]  do_initcalls+0xc6/0xdf
> [    4.664346]  kernel_init_freeable+0x14e/0x19d
> [    4.664346]  ? rest_init+0xc0/0xc0
> [    4.664346]  kernel_init+0x16/0x130
> [    4.664346]  ret_from_fork+0x1f/0x30
> [    4.664346]  </TASK>
> [    4.664346] Modules linked in:
> [    4.664346] CR2: 0000000000000030
> [    4.664346] ---[ end trace 9672514da279163d ]---
> [    4.664346] RIP: 0010:sysfs_add_link_to_group+0x12/0x60
> [    4.664346] Code: cb ff ff 48 89 ef 5d 41 5c e9 ca b4 ff ff 5d 41 5c c3 cc cc cc cc 66 90 0f 1f 44 00 00 41 55 49 89 cd 41 54 49 89 d4 31 d2 55 <48> 8b 7f 30 e8 a5 b2 ff ff 48 85 c0 74 29 48 89 c5 4c 89 e6 48 89
> [    4.664346] RSP: 0018:ff3f20b800047c28 EFLAGS: 00010246
> [    4.664346] RAX: 0000000000000001 RBX: ff25a0fc800530a8 RCX: ff25a0fc82cdb410
> [    4.664346] RDX: 0000000000000000 RSI: ffffffff904726e7 RDI: 0000000000000000
> [    4.664346] RBP: ff25a0fc801320d0 R08: ff3f20b800047d00 R09: ff3f20b800047d00
> [    4.664346] R10: 0720072007200720 R11: 0720072007200720 R12: ff25a0fc801320d0
> [    4.664346] R13: ff25a0fc82cdb410 R14: ff3f20b800047d00 R15: 0000000000000000
> [    4.664346] FS:  0000000000000000(0000) GS:ff25a10c1d400000(0000) knlGS:0000000000000000
> [    4.664346] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    4.664346] CR2: 0000000000000030 CR3: 0000001036a10001 CR4: 0000000000771ee0
> [    4.664346] PKRU: 55555554
> [    4.664346] Kernel panic - not syncing: Fatal exception
> [    4.664346] Rebooting in 15 seconds..
> 
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2025/05/18
> 
> 


