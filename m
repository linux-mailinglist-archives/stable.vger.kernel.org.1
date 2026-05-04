Return-Path: <stable+bounces-243913-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCb2BlQI+Wnx4QIAu9opvQ
	(envelope-from <stable+bounces-243913-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 22:57:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 786FF4C3CFC
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 22:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DA64301E58D
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 20:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7605A3358AD;
	Mon,  4 May 2026 20:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bi9/gCrJ"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013052.outbound.protection.outlook.com [40.107.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A96A32E6BB;
	Mon,  4 May 2026 20:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777928235; cv=fail; b=VB0di/zSk6ehq9XBm+Kp8/d1HA7jyPPPYmAdNlX2nUyn80E0pvQvB3NX5Mv591O5sPTjXJsjIDQmfod1p/y+8xODXTfdqZ74DvgFAVuZ3fAGOyYjtWRK0Tti30MQq3MTTq+JIfMyIrol5itJnHEBXPJ/49O0lPkQzZs2NcH5fzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777928235; c=relaxed/simple;
	bh=tibophtx5/9Eg2qvgpNkw0S3UPk7+5rH5tRSUs4e82c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tNcF/9wvByJ9of+jtuFv72dFfFCYdg47CPhqHeCDJS2sHx4lPeAcj4RwKpmNO/7X2BQrWeBtv9evb1iRc7fLEitgkkpRhN8uau0DnZQ+j3JPKaoHK4Sd42xxHXdQ1FYdoa7+I4/JU2MhfchJJFJCiRSoKJm43HgRdBCstMFz8CY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bi9/gCrJ; arc=fail smtp.client-ip=40.107.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHtP68gjOTjQ3fj6tdyKV91PyLg13YFzRu9TcNFSAsvkbsKEQvSnwbBEsFfBoLAox/puOGHTdA12ZhF7EK1HEoInkawYOp7C8SvyeyIyqybmBub5X2BwqEhL7A2LbedOPXgKVKBjtiP2ydOAl1A+BMKLI8VHZHw3fxOtZH2Z/a110K72m78nJMifJnV/qMC5GXOEY6DdHGbQvFVa4ngbk/4IJTkqhj6C76upypfCv70ewRMoA8wC3/THcnZXwHFaJrHNqtWCH5OMsrc9R+dTn4PrUGyItQqfpQwHhneu5/fPGmHKk6lFD3qb3OGry64YyGmHbolN77Wl0X+FMEHMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ddLiWBpsq8AaxJ6Wyg2xcI0/McTp2JHedYxcgb3L38=;
 b=ktosTjuthKWmwP+fZ+2ZpesrlOCfpOT+MhXFKgh1MK989aGrSNf9qlAY9WaXJnGofiUTa29thxUX8R6dkUGOGHc7f3O6uo4HlQ3crXrdbQch3ozg31NUVahDI81KxizJvNo3i7hQKKGcwt4ifR7t4C938Fcfz1G96hros5atx12ZrzrTDKUTgyc0I7rVQPoCebjy+S/yTbx/RTS2P5akqXixYKoY9wfgXZ0yLpV83Ns+3vRhqkStJUbusaJq6FK1s7U2D1k5cw/exOPQ9Q+XfKY+JeexXPBQEm6OuR4ANeZw3LGhxG16uTcusfFBLNi4SkwLrCkRZIIdz93C464k/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ddLiWBpsq8AaxJ6Wyg2xcI0/McTp2JHedYxcgb3L38=;
 b=bi9/gCrJaMaWdjmbUD1ETQ6EnvlC6tBJIqSsCsXlDd96r2wGL259rLSybLDfH9DNUghElsgtGXsoDphUXcq3GN2v1ym69TNlzeM+3PZ0arK8DFTz9XnNzq4YEOXPspsNKvzZcehm+e3nhjSNXqljUAXa1tcbfRmFfc+mpqhwVNo=
Received: from SA1PR05CA0004.namprd05.prod.outlook.com (2603:10b6:806:2d2::29)
 by SA1PR12MB999086.namprd12.prod.outlook.com (2603:10b6:806:49f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 20:57:07 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:2d2:cafe::f6) by SA1PR05CA0004.outlook.office365.com
 (2603:10b6:806:2d2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.14 via Frontend Transport; Mon,
 4 May 2026 20:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 20:57:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 4 May
 2026 15:57:07 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 May
 2026 15:57:06 -0500
Received: from [10.4.12.116] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 4 May 2026 15:57:06 -0500
Message-ID: <776b2711-7cdb-4e73-9637-763a9d1bc047@amd.com>
Date: Mon, 4 May 2026 16:57:06 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Wrap DCN32 phantom-plane allocation in
 DC_RUN_WITH_PREEMPTION_ENABLED
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, <harry.wentland@amd.com>,
	<sunpeng.li@amd.com>, <alexander.deucher@amd.com>, <christian.koenig@amd.com>
CC: <siqueira@igalia.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<ardb@kernel.org>, <hamza.mahfooz@amd.com>, <Roman.Li@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260504201905.90667-1-mikhail.v.gavrilov@gmail.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20260504201905.90667-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|SA1PR12MB999086:EE_
X-MS-Office365-Filtering-Correlation-Id: c54f6b78-78c9-4e78-5f1a-08deaa1fb429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iTat+fzWut6MN1QOEi9NMBri/nlFr7vgxf7HgbkJYpXpKCF1rG8ivPvFTXTfUrnZBdt1ap8aK/W4D75+HsN/T2c/KJQxENpYDkqnT8ijAm2zC7DM3685YwNXBQW7qqBwhexQGO4jHEQim8YBvnw5TFxJIyUKNY8n1prO2Pst2QOz2umTvPETtCdXfFeil+rJWwleRLLvIDptMQwlqDhOYivKRLFWnNP1Yib8sRYoxZblUBzNSIZLO52uSyKt0aaMybmzhQXyfRat5eNGKvAZIWaFJhot2tdteE5ZIiwT88Ic21cr/42etmpKdOD7cZdFEPBWmZh+QiwSoeppQxOQAs27Cn86xZHV3/WIbH2wPih2tq2Zn65LKII2FVq4UutGkLQnA3QyRxGBbwvleDP1qH9ZfwAr6Mj+dq2tRN2+lgii/jIEdftvSRnwm5V2ywU+yNvDi2h8OSpFtD6u4HOcndOIOnnMHT7OtEglnOSgIQOQhrJf27YtGszghKzJYx5aqqhrFwNKWNhX1+GMC+LV4AaG8In3kb5ZW8PF4QweGE8kSfltXLEr/Ip8LYAh/Nmd7671gAEPnKxP9A2ZkvJBcYAEY8fRZtaZYHbBTR+uisKd3o8N1/6SXOY3IfnaOcxa8Y3AVy1cCzIkOM5EGHb4kYCU7WnudRAdZLQa9VNTYYSZTfiKXqo1jLBN/4vxRkLm64S4i9uDsluzrYScos4G/hwJX1kEnrpmJi4TBfvDyzw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JiopbUDVdu7SJcPlOpSjRLCekJMuAcIxbCBKo3mJEkOUb7TTzPK8+KfuQwsWYxj2z+ZT2ny5JpVC069Vs4/Ll+4KTkDWKJ9UImHFyD9DuFJTnZUxUx2NL45NapH7lcnc1PpTELvOOYJFYMrOa/cOsv6bzO5+VSEtqAm+h16kR+Pv32zyhCXalAKjHjaRvJAEvwf5PZTMK8hVFALF7C5RPz7l1ctv+nJIgikG6iWVVMtSN9CJx+GSg+H9xY7dlVY0ZOiZdbOrbSCfP+djGbS3lWweRBA0kD5UNkMVAaIKMfsPlxpsiGOsv8//rpQe3TI1BJ8K87CyZDQnxV+1hStVfhD1cghzwyd7W2ThKki7OGrvLmCNrRtBRbWQ2sl/F4QFu0q2CjU9vcpLSh6FMtgpm44eqkWcVOoSVl8O4BA9vQrWvnc+bI67yE02mrN24FSv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 20:57:07.5852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c54f6b78-78c9-4e78-5f1a-08deaa1fb429
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999086
X-Rspamd-Queue-Id: 786FF4C3CFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243913-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid];
	FREEMAIL_TO(0.00)[gmail.com,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[igalia.com,gmail.com,ffwll.ch,kernel.org,amd.com,lists.freedesktop.org,vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aurabindo.pillai@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]



On 5/4/26 4:19 PM, Mikhail Gavrilov wrote:
> dcn32_validate_bandwidth() wraps dcn32_internal_validate_bw() with
> DC_FP_START()/DC_FP_END(). On x86 non-RT, DC_FP_START expands into
> kernel_fpu_begin() which takes fpregs_lock(), i.e. local_bh_disable().
> Allocations done inside this region must therefore not sleep.
> 
> The legacy DML1 path through dcn32_full_validate_bw_helper() ->
> dcn32_add_phantom_pipes() -> dcn32_enable_phantom_plane() unconditionally
> calls dc_state_create_phantom_plane() -> dc_create_plane_state(), which
> performs kvzalloc(sizeof(struct dc_plane_state)). On a recent kernel
> sizeof(struct dc_plane_state) is 343736 bytes (335 KiB), well above the
> PAGE_ALLOC_COSTLY_ORDER threshold, so __kvmalloc_node() takes the vmalloc
> path. __get_vm_area_node() then trips its BUG_ON(in_interrupt()) because
> SOFTIRQ_DISABLE_OFFSET is set in preempt_count:
> 
>    kernel BUG at mm/vmalloc.c:3206!
>    RIP: __get_vm_area_node+0x257/0x2d0
>    Workqueue: events_unbound commit_work
>    Call Trace:
>     __vmalloc_node_range_noprof+0x22b/0x570
>     __kvmalloc_node_noprof+0x3d0/0xb40
>     dc_create_plane_state+0x35/0x290 [amdgpu]
>     dc_state_create_phantom_plane+0x1a/0x120 [amdgpu]
>     dcn32_enable_phantom_plane+0x101/0x780 [amdgpu]
>     dcn32_add_phantom_pipes+0x47/0x460 [amdgpu]
>     dcn32_full_validate_bw_helper.constprop.0+0xa46/0x1d70 [amdgpu]
>     dcn32_internal_validate_bw+0x49c/0x1600 [amdgpu]
>     dml1_validate+0x20f/0x800 [amdgpu]
>     dcn32_validate_bandwidth+0x317/0x540 [amdgpu]
>     dc_validate_with_context+0xd34/0x1d30 [amdgpu]
>     dc_commit_streams+0x7ca/0x1810 [amdgpu]
>     amdgpu_dm_commit_streams+0xfd4/0x1e60 [amdgpu]
>     amdgpu_dm_atomic_commit_tail+0x29e/0x3520 [amdgpu]
>     commit_tail+0x204/0x4b0
>     process_one_work+0x8fd/0x16a0
> 
> Per-CPU __preempt_count on the crashing CPU at panic time was 0x202:
> SOFTIRQ_DISABLE_OFFSET (0x200) from fpregs_lock() plus two preempt holds
> from dc_fpu_begin() and kernel_fpu_begin().
> 
> The DML2 paths already wrap their large vzalloc()s in
> DC_RUN_WITH_PREEMPTION_ENABLED() to handle this case (see
> drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c:26 and
> drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c:24). Apply the same
> guard to the DML1 phantom-plane allocation in dcn32_enable_phantom_plane().
> 
> This is a separate class of issue from "drm/amd/display: Fix unsafe uses
> of kernel mode FPU" by Ard Biesheuvel, which addressed callers entering
> DC FP compilation units without DC_FP_START. The bug fixed here is the
> inverse: a sleeping allocator invoked from within an active DC_FP_START
> region.
> 
> Reproducer (RX 7900 XTX, single 4K HDMI display, DCN 3.2): launch any
> workload that produces rapid atomic modeset commits. The most reliable
> trigger observed is launching Rise of the Tomb Raider via Proton and
> repeatedly pressing the Super key during the level loading screen;
> crash occurs within ~4 minutes uptime. Random crashes are also observed
> during routine fullscreen toggles (image viewers, chat applications).
> 
> Hardware verified clean: memtest86+ 4 passes, stressapptest -W -m 32
> 4 hours, both pass with 0 errors. KASAN active, no reports under load.
> 
> Fixes: 235c67634230 ("drm/amd/display: add DCN32/321 specific files for Display Core")
> Cc: stable@vger.kernel.org # v6.0+
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
>   .../drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> index 82f81b586986..3751f7a94a05 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> @@ -92,9 +92,14 @@
>   #include "dml/dcn32/dcn32_fpu.h"
>   
>   #include "dc_state_priv.h"
> +#include "dc_fpu.h"
>   
>   #include "dml2_0/dml2_wrapper.h"
>   
> +#if !defined(DC_RUN_WITH_PREEMPTION_ENABLED)
> +#define DC_RUN_WITH_PREEMPTION_ENABLED(code) code
> +#endif
> +
>   #define DC_LOGGER_INIT(logger)
>   
>   enum dcn32_clk_src_array_id {
> @@ -1684,7 +1689,8 @@ static void dcn32_enable_phantom_plane(struct dc *dc,
>   		if (curr_pipe->top_pipe && curr_pipe->top_pipe->plane_state == curr_pipe->plane_state)
>   			phantom_plane = prev_phantom_plane;
>   		else
> -			phantom_plane = dc_state_create_phantom_plane(dc, context, curr_pipe->plane_state);
> +			DC_RUN_WITH_PREEMPTION_ENABLED(phantom_plane =
> +				dc_state_create_phantom_plane(dc, context, curr_pipe->plane_state));
>   
>   		if (!phantom_plane)
>   			continue;

Thank you very much! I'll add this to our weekly testing before merging.

