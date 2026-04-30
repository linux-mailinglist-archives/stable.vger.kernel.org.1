Return-Path: <stable+bounces-242082-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEoNKjkz82mZyQEAu9opvQ
	(envelope-from <stable+bounces-242082-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 12:47:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE454A0FF9
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 12:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 045DF30068C7
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 10:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9783B27C1;
	Thu, 30 Apr 2026 10:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vw5OqCd0"
X-Original-To: stable@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013022.outbound.protection.outlook.com [40.93.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F52319847;
	Thu, 30 Apr 2026 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777546036; cv=fail; b=PNd5FvKC7woxe6nWRQfc3LkVGAL5e8hArEAcYpfWx3OkUt+FzL/JwEd/5NEwKyPrITLKEC5gLqAIWlxqz7KKsRSrysWpAdiHOepA/x4yZYGLTTFYK8ZkLZhTHFtJt7utdeABgyb9ziIrHwcHqjioZBp6QdhwhOWzwCzHxdW0tak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777546036; c=relaxed/simple;
	bh=6Mc7PNlpnjt9P+plcbwRTm63R+pX4tTllRtREBpCtPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nfHrD2y4NRuOmJqQnb8gdq2jrv+uOB71unkD7APu919sThonIkY+aPxFas9dp5ecPy1mKp99wbssZZljoDPhf9B690ajTLvJvID6bRxRxbIob9ep+gFN0SaMwrVuxlqJQUgr39RWsElvcSy9IX6CyJy1YHWrEadjz0x+tjCDPMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vw5OqCd0; arc=fail smtp.client-ip=40.93.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkV7o8aZhy3djfsTQQcjzVnCcrEVHtuD9MPU9KEq8rOV0+iZRW+vgBel1UiEKyIc6njQkb1logx0s8s/nLIfLpu9Iz9OMvUF8kgsW23ijJKUmBOV3qsbkapivgUi7ih5U52nm7bWqSEkjzNQLPcUBHRfl7J7cUEHL2rwH/DSJpIbf6u/GQZMKpKH6Rf3xJtb1V447Feo15EkJls8qDJRrbcBguXb6tVHU9NgFoIoTLdc55q3HmNGth3yA/4c7nNz1gpOU59Vgy+vf1HuaHWJnlf42LVfjM18d/nHlrY/EIi/c73f5mas7YHrzVBb65weTqSzPRnq7eAx8HvOu64yPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhR/EbUqYpP5KaS/X08bjC4a+0IPTtelGJgzjFOFR9c=;
 b=i5W7Ty6lDYHAXgpHF7eLE5ybKfxk2uSp3k05FE39GCIjkZHk+sXGoXtzbSfM68CJXx47rGR9qTWDJ0xURBpo32ehMh88VgeJJjIYqVwfMh8HXktRtbRAn7Jhif5UVgFTgZ2/E4XIkE2pGWHsQV4gR+T8kLJJh0mhXpXEzMn1tMswRSzGTyDqA59zzASL3kTA/cmR8VYOQXcaiJhzBc11YQbayjHkYOf7I6cVrl9lnaU1iJXWJwKdJD63Sx76jVYbXCmx4ev4/G8NK1DAnz3c9ovDC08P+0YhzCTo8Q/5hP4iFI8/AWmsncvcEgxKIcEOu799Xi5QYn2BquzjqvbY6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhR/EbUqYpP5KaS/X08bjC4a+0IPTtelGJgzjFOFR9c=;
 b=vw5OqCd0BkLQ6rawyH82DIA1wWjEi/YyBjP0SaTnGuLVjwuGrygqOq1k9WsHbdaojH1dnMn8T83TC+807bO8I08J6kW+rVkTEiQmj69swg9+y/Iw+kdIvW7GV/UIGFCeW/Pxi4nKrf2q1OZa93jPoZyoerNM3FCvE+lUovTowcI=
Received: from CH5P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::27)
 by IA0PR10MB7351.namprd10.prod.outlook.com (2603:10b6:208:3dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 10:47:12 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::f7) by CH5P223CA0001.outlook.office365.com
 (2603:10b6:610:1f3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Thu,
 30 Apr 2026 10:47:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 10:47:12 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 05:47:11 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 05:47:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Apr 2026 05:47:11 -0500
Received: from [172.24.233.55] (uda0490799.dhcp.ti.com [172.24.233.55] (may be forged))
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63UAl6o61198159;
	Thu, 30 Apr 2026 05:47:07 -0500
Message-ID: <17cbaadb-5aa7-40f4-848c-ba8e88fbd333@ti.com>
Date: Thu, 30 Apr 2026 16:17:05 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] pmdomain: ti_sci: re-sync TIFS with genpd on resume
To: Vitor Soares <ivitro@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, "Santosh
 Shilimkar" <ssantosh@kernel.org>, Ulf Hansson <ulfh@kernel.org>
CC: Vitor Soares <vitor.soares@toradex.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>, Kevin Hilman <khilman@baylibre.com>,
	<vishalm@ti.com>, <d-gole@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
	<stable@vger.kernel.org>, Kendall Willis <k-willis@ti.com>
References: <20260427074808.3244226-2-ivitro@gmail.com>
 <1fb0739e-b84f-42f1-9c96-88b5cc5866a8@ti.com>
 <c0fe43a2339c802e9ce5900092cd530a2ba17a6b.camel@gmail.com>
Content-Language: en-US
From: Sebin Francis <sebin.francis@ti.com>
In-Reply-To: <c0fe43a2339c802e9ce5900092cd530a2ba17a6b.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|IA0PR10MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a60649-3eb2-46e3-180e-08dea6a5d5f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	e3NRIpgmW14OVj9iilvx89NBGPI/AJPPG5eMIXkfSr5He1q0V/QmTHaQTJbjcZ4KNBtBjNlA0lW1a6T45HffPbEON7fvvsma67+D/j9RB/F6NbeQNRQALzjkc5nizoj7Py6cdcllQNB7RwXaZVf+3qagnDUWBAvyOf7IV6JpK0gT+xKc31cG5tiwDdXRQH/uLw4pzGeZO1vjt+AV04qAwgy5v4JVMUDMV7ejKtMt6VVUY9XSAIJKVCS2fk1L4rW4fSdeRpVeD1hTwCp6w05XgLT/4cufhrJO4TKGcnPwjtgYKfFGSM/3Qh83FP5AGowcC+Cf8M8L/zdwqDCdoQWmR4svRkIHQB/tvSJU84ezsazrFEujM0BTDx7UZT0zXlIqqjK+AAtJS6ALAYHnMCjRKqx1Xs0AGjEF/5TdmVafGV71qxZiXBkFODv7zyBPvZRXNeldFjhHbxk4f6fIlJlEWpA6XMqP8pwCeFamW5WzqVcd+l12Qv2MCrOTnlvE+fWeR/jEstGsHK67IWklH7t85sCKmNBpBjC0Fpw8tGf5M54e0ZN5DLKFnADpellZ09YB8KnnqYLYgkcYwIAmsykwMzgdpVUczjlfGjeYNnYURi7n6e07AisZpSf6+T1S3ovI29B85570wRkEQKPmhd6mCxELdVK8qcdvdd5yJfrk0rIX8Kc2gmdBVtvRhJmtX0suzn37Hk/FxDD9aW8H4yyO2roFkCdAu8MpuOD8cH7+q1ZQEIM6S0slifrYcZIC+qvifBP+X3S0bex3BmTq2hwIJw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2wRFw5hZLMpz1zh/Sf4E0sdH7GhZnrZC9/tmH4aLKc8fb33GUGkkAhseFShl1/WrnLsi6QCf7CPe49JaAHgQ/4vFzZyIS/lOcASPkhIdJxU9oDddSLsTEcHbIg8nGF7Y9ncSsuqLIiXb6ODuypksB2/kJ92VowVN61cBpFKF1Yvm5eQGnnhJXt+HgOAEff5GVdnY5JptdAIEra/7rTa846Lhg3ZQiK64LVmmvSL5zdWcwVPzASjDYeAlMid7JSdG58FvTFZgB0fLLXr0bXgiBKHcmrT9UcPjqXrELOVkZIyysj0PqPjPsAAO/Zae2mqzoYiO+lv8KHaOc4rvVl0Y1Fg68vLirmBDxZlUWpHYWqR+ToGoWgRUuGSv1YVjBEwC5nu1dTRWKCkw4I45F+lpzoUxEVbi+IwwxLK5DhW85+LoMPmDtFhs/oMVo1yUsuLQ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 10:47:12.1309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a60649-3eb2-46e3-180e-08dea6a5d5f2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7351
X-Rspamd-Queue-Id: 6AE454A0FF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-242082-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ti.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:dkim,ti.com:mid,toradex.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebin.francis@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

Hi Vitor,

On 29/04/26 21:56, Vitor Soares wrote:
> Hi Vignesh
> 
> Thank you for the review.
> 
> On Wed, 2026-04-29 at 10:03 +0530, Vignesh Raghavendra wrote:
>> Hi Vitor
>>
>> On 27/04/26 13:18, Vitor Soares wrote:
>>> From: Vitor Soares <vitor.soares@toradex.com>
>>>
>>> When a device in a TI SCI power domain is on the wakeup path of a
>>> wakeup-capable child, the suspend path skips genpd_sync_power_off().
>>> No put_device is sent to TIFS and the domain's genpd status remains
>>> ON.
>>
>> Correction of terminologies: TIFS is Root of trust component and is not
>> usually involved in power management, that would be DM (Device Manager)
>>
> 
> Thank you for the clarification. I will address this on v2. Also, I was thinking
> to replace put_device/get_device with ti_sci_pd_power_off/ti_sci_pd_power_on if
> that makes more clear the content.
> 
>> But to be really sure who is doing what, Could you provide an example
>> and the platform on which you see the issue / external abort?
>>
> 
> This was reproduced on our Toradex Verdin AM62P WB and the driver for our Wi-Fi
> module on the SDIO bus calls device_init_wakeup() during the initialization.
> 
> After enter in suspend, it show the following error resume path:
> 
> 
> [   41.759341] Internal error: synchronous external abort: 0000000096000010 [#1]
> SMP
> [   41.843286] CPU: 0 UID: 0 PID: 933 Comm: rtcwake Tainted: G   M       O
> 6.18.21-dirty #3 PREEMPT
> [   41.852762] Tainted: [M]=MACHINE_CHECK, [O]=OOT_MODULE
> [   41.857891] Hardware name: Toradex Verdin AM62P WB on Verdin Development
> Board (DT)
> [   41.865537] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   41.872492] pc : regmap_mmio_read32le+0x8/0x20
> [   41.876941] lr : regmap_mmio_read+0x44/0x70
> [   41.881120] sp : ffff800081fdb8e0
> [   41.884428] x29: ffff800081fdb8e0 x28: 0000000000000000 x27: ffffa95bb64aa9c8
> [   41.891563] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
> [   41.898697] x23: 0000000080000000 x22: ffff000002df5c00 x21: ffff800081fdb9b4
> [   41.905831] x20: 0000000000000100 x19: ffff000001286400 x18: 0000000000000000
> [   41.912965] x17: 2d69696d67722f79 x16: 687020726f662067 x15: ffff00007fb74f40
> [   41.920100] x14: 00000000000002ea x13: 000000000000031f x12: 0000000000000000
> [   41.927234] x11: 00000000000000c0 x10: 00000000000009e0 x9 : ffff800081fdb7a0
> [   41.934368] x8 : ffff00007fb6ce00 x7 : 0000000000000000 x6 : 0000000000000000
> [   41.941502] x5 : ffffa95bb57948d8 x4 : 0000000000000100 x3 : 0000000000000100
> [   41.948636] x2 : ffffa95bb5795034 x1 : 0000000000000100 x0 : ffff80008025d100
> [   41.955770] Call trace:
> [   41.958211]  regmap_mmio_read32le+0x8/0x20 (P)
> [   41.962655]  _regmap_bus_reg_read+0x70/0xb0
> [   41.966839]  _regmap_read+0x64/0xdc
> [   41.970327]  _regmap_update_bits+0xf4/0x140
> [   41.974509]  regmap_update_bits_base+0x64/0x98
> [   41.978952]  sdhci_am654_runtime_resume+0x138/0x208
> [   41.983830]  pm_generic_runtime_resume+0x2c/0x44
> [   41.988445]  __genpd_runtime_resume+0x30/0x7c
> [   41.992804]  genpd_runtime_resume+0xdc/0x2e8
> [   41.997073]  pm_runtime_force_resume+0x68/0xf4
> [   42.001517]  dpm_run_callback+0x8c/0x14c
> [   42.005439]  device_resume+0x11c/0x34c
> [   42.009188]  dpm_resume+0x178/0x1f0
> [   42.012673]  dpm_resume_end+0x18/0x34
> [   42.016332]  suspend_devices_and_enter+0x4a4/0x668
> [   42.021123]  pm_suspend+0x170/0x2dc
> [   42.024610]  state_store+0x80/0x104
> [   42.028096]  kobj_attr_store+0x18/0x2c
> [   42.031845]  sysfs_kf_write+0x7c/0x94
> [   42.035508]  kernfs_fop_write_iter+0x130/0x1fc
> [   42.039949]  vfs_write+0x200/0x370
> [   42.043351]  ksys_write+0x6c/0x100
> [   42.046752]  __arm64_sys_write+0x1c/0x28
> [   42.050673]  invoke_syscall.constprop.0+0x50/0xe4
> [   42.055378]  do_el0_svc+0x40/0xc4
> [   42.058691]  el0_svc+0x40/0x15c
> [   42.061834]  el0t_64_sync_handler+0xa0/0xe4
> [   42.066015]  el0t_64_sync+0x198/0x19c
> [   42.069680] Code: aa0603e0 d65f03c0 f9400000 8b214000 (b9400000)
> 
>>
>>>
>>> TIFS powers off the hardware during deep sleep regardless, since it
>>> was never informed to keep the domain active. On resume, because the
>>> domain's genpd status is ON, no get_device is issued. The driver
>>> then accesses registers of a powered-off domain, causing a
>>> synchronous external abort (AXI bus error, ESR 0x96000010).
>>
>> Hmm, if something is wakeup source, I would expect even TIFS/DM not to
>> turn if off, else module wakeup wouldn't work.
>>
> 
> I tested UART as a wakeup source and I couldn't reproduce this issue. My
> understanding is that UART has its own TI SCI domain and device_may_wakeup() is
> true directly on that domain device, so the set_device_constraint fires
> correctly and DM keeps it powered.
> 
> Here is my tracking of the issue:
> 
> Wi-Fi driver registers as wakeup source:
> device_init_wakeup(mmc0:0001)
> 
> During suspend/resume.
> dpm_suspend()
> ->genpd_suspend_dev(fa20000.mmc)
>     ->ti_sci_pd_suspend(fa20000.mmc)
>        ->ti_sci_pd_set_wkup_constraint(fa20000.mmc)
>          device_may_wakeup(fa20000.mmc)  = false
>          set_device_constraint never sent to DM
> 
> 
> dpm_suspend_noirq()
> ->genpd_finish_suspend(fa20000.mmc)
>    ->device_awake_path(fa20000.mmc) = true
>    ->GENPD_FLAG_ACTIVE_WAKEUP = true
>      genpd status = GENPD_STATE_ON
>      skip power_off (ti_sci_pd_power_off)
> 
> On deep sleep entry, DM powers off fa20000.mmc independently.
> It received no set_device_constraint nor ti_sci_pd_power_off.

In AM62P fa20000.mmc is part of main domain. During deepsleep the entire 
main domain is turned off by the DM, that is why you see the failures.

In-order to debug this we need to check why pd off and pd on call is not 
getting called for fa20000.mmc during suspend and resume.

> 
> I attempted to fix this by calling set_device_constraint when
> device_wakeup_path() is true but it prevented the system from entering deep
> sleep entirely.

In AM62P the DM manager selects the low power mode to enter based on the 
constrains set. The mode selection logic will ensure that if a 
constraint is set on the device, it will select a low power mode in 
which the device is kept on or can wake the system up. the MMC is part 
of main domain and there is no low power mode in which the MMC can stay 
alive or generate a wake up interrupt. so when a constraint is set of 
MMC, we cannot enter any low power mode. that why you see a failure.

Regards
Sebin

> 
> [...]
> 
> Best regards,
> Vitor Soares

