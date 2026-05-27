Return-Path: <stable+bounces-254682-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNyKGhdZF2oPBQgAu9opvQ
	(envelope-from <stable+bounces-254682-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 22:50:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D12985EA33E
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 22:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6757D3056357
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 20:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F4D3B775E;
	Wed, 27 May 2026 20:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fprnDga/"
X-Original-To: stable@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46C33B637F
	for <stable@vger.kernel.org>; Wed, 27 May 2026 20:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779915016; cv=fail; b=NsZAtgfTjDArtcRdo811ZP9tHZ7bUrV/7lqDB42FEOvDqZVJotJLOL705Ifry+Pss5uZywQl4u3QEF6E8yW+0nwOmMIZRX6lq+vrwNfSF5sT6MEhVXsG02bLQxAapSBOVgHPPYxUXBh91070QNKCqP/RKp+CUWgA7fkX3KkNzsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779915016; c=relaxed/simple;
	bh=hR+5dG7avbDIQCnUAPK3S4I841RlvgIaUMfRQScTffM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bhosCiHmCM9DqtjuWErJsKaMRfgJip0PGpDSR1IjxYyquPFWXbBIZVcgLEgGFI3CfoH+RNFaOrmp+jk0eGVB1xh/A8KWWrQr8EcUOmpHi+OQ1f/MWVEOkRYNWZMMxz4hgiNYYoTWVOTSZaZOyP5Qm6LrW9eT6AqmNFes+NVg1uE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fprnDga/; arc=fail smtp.client-ip=52.101.53.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMp3TB3d7zv5SpC+paAoydT47x4JkMSpUBGYsUagVTlX8VtU3QvvP+FQY4uROcXviMgO9tMrkc0vmos+EB09ejB7T2j6lpFxVQzQo7Ac8d9Ob5eQROQjPpdvcPWk+wUwFQO8qJMumRmEvyC5w2fGWYhFjPHyg8TZXBM/V3Sp6D+HQNRYrkPKJtH7t4xa/tM3jEJXDP0DsSzmbrR82jeAFyssn7GzcFB2NIWr7hM96uVUrOuR3gsAqAJWqGzrpn0Q+grMmzdP4mjDgLnUOHKiWu3SEApUqfhKWdTVjjdeauHSQRCf+UeVqVqvI7UV9XFTFRkQk+xxZNtRuFLBWJUrJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBl4GdsSyqTdU7XneFi7ldy3GGtgRnMPZasG+yFvaK0=;
 b=zCZ+RcR86Rll+fHZbVNXt+0uSg2axZAKlmDTHTKPKmXMG8gggXUfBcUqy5n5eE1PI9sLVWhArCK3H6IbefwXDM55k9mQ2D1HpG2mBzsVZJQUrmtU1UEX67rH/rUR6X+E6UxsxYg5K06i9kojukZIKIYnfYkZLOQ84THRgkIQ7nbhva/LtXrsPUdocDGB7QR9hk4xEOg2I8KZwu51Xigi+Lgpmg0SLa0nUh2KVgEAtfI+o3nPc0tt99U1rSjjd3daAQF9MkKCH/FMKt9VWVe5DhGI/EGadRd0CMG/wj2uky6t2FL9NvBoOG1lQ3V+asWYynxi18yi8jLhT7EDUolHQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBl4GdsSyqTdU7XneFi7ldy3GGtgRnMPZasG+yFvaK0=;
 b=fprnDga/A1ZDQCyJDwqlgYbpR8E8ue9UyMIO9Y267wmo6lWK+rIiR1qez2L2YRTDEoGJcE9JST4EZihWR8N7htGZWJo3XFjOppIWTEZEroo2TjFUvhcYiBKAdV+0ArOu65bvugJ5mhRAp2fMHaIc5WU9kANAC2sO7jiwC+GOrqQ=
Received: from DS1PR03CA0005.namprd03.prod.outlook.com (2603:10b6:8:450::18)
 by IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 20:50:08 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:8:450:cafe::93) by DS1PR03CA0005.outlook.office365.com
 (2603:10b6:8:450::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 20:50:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 20:50:08 +0000
Received: from yunxiali-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 15:50:06 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
CC: Tao Zhou <tao.zhou1@amd.com>, Guchun Chen <guchun.chen@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <stable@vger.kernel.org>, Yunxiang Li
	<Yunxiang.Li@amd.com>
Subject: [PATCH] drm/amdgpu/gfx9: guard fault IRQ puts in hw_fini
Date: Wed, 27 May 2026 16:49:40 -0400
Message-ID: <20260527204940.1741202-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|IA1PR12MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: 518d4ac9-79bf-43d6-cfc2-08debc3189d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	LVr4uA6bznBCM86sR46sjf76yvESM/ZYJoeZw3KZfiOGFPcDjOZW6QgSwtcQ93uehX47mYNxMCzAhUKjMOyZIjj8XA3Vss1g/e3EFs2JZU1jPCbVPcJwMhq5IVYKzu9DKUwLdjMAsAap5FAMLnI9AV4Lkx8tTXsDPMSzU2NQCWURvSrRJzBaK1CTfHxOKZvhvWBNLg1aDPncPzqmPDTSTlkC1YtQPRlooOpw0ed2AoAjl+tqWJRK1kiHYc95OjUZxAVzXD5Y6Bq0keBPIQJwX8iQtnpvOEBCvXVS3N6C9c8aEvv/PWhJoBPcwl2E0MhxIPRWnJil+I0g0nyS4BId0soAlfMn0jjH9rhnAYQhdmu183K7t2ZvrTC0ZCuOKBNq3CpeeysslNy4K4Q6poERcHzc6Eo3lclIzJkNzmOUA65uiCOCLCdC2NpFwUVyr0psP2xsg4ztxs+Z82WgNf3xuDAtgWk1gMjwSY192+HsBulB2nBaTCbDv0PLI1sVzHKkruf54BMCe/tAB+jmXAxmfiAEdgl5Q6/4aOcUuFexFEV6JMwzNwI2Gfc6MorCnKUypWY7VwKknx45TBih6e/Qjphi080Kk07RCIiQ6BALVkLLy8YfpG6sWSDkFoReENuKEYJyNpiWgxsohA80uwUdf9oRF/ltPUGraHoJTntV+PX8IxbeGMOhNhVbW8lN6llTxkwM93rXfs/UKFiGJ72nbPbC5SRkYxCzu3XaEGkFWP4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	C8klLFtscVSgYVT8/q9NqAqcqlvytrnNqHipwRcHgpoly8QeEPaCWhA+6YUuxELQvbPnhRIrcegOCA2KdHdlGtviJJ0wYbT8WfhI4SJFGUfHRomN122fk80RUUYzwMUccTYlZEARpamg9n03+7Ydnj1dlKiaW8uO8P1SBzDfyfxN2K9YRc4F+6zULFrFtCXG4lq56q6meFpTK9HXkKdMs5MNeQdBvE/y5egXkfdLZ4xNZxel+LuTDh9wxGs96HryIBXglm0XOLSciKZDlmPFj0tMkV8yT2ea33vPz5bh2ASzwzcfEfOTojTwutzB+RORftddGRjOa9q3v8U5r3yfEeoOkHG5oakEaR4tlxCgFq4zGmBE7BPVYZfoUWk96MwIAcQYTpJULy6i7rPT4MMZ2NML4mu6FRNV7EiYOSFsfknP7gn1ArAcKa6lIzFtn2mI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 20:50:08.3979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 518d4ac9-79bf-43d6-cfc2-08debc3189d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6460
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254682-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Yunxiang.Li@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:email,amd.com:mid,amd.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D12985EA33E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

gfx_v9_0_hw_fini() unconditionally puts priv_reg_irq, priv_inst_irq,
bad_op_irq and cp_ecc_error_irq, but the matching gets in
gfx_v9_0_late_init() and amdgpu_gfx_ras_late_init() may be skipped
on SR-IOV VF, partial late_init failure, or an earlier IP init
failure.  When hw_fini then runs, the unmatched puts underflow the
refcounts and trip the amdgpu_irq_put() WARN:

  WARNING: CPU: 4 PID: 6367 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:676
  RIP: amdgpu_irq_put+0xc6/0xe0 [amdgpu]
  Call Trace:
   gfx_v9_0_hw_fini+0x200/0x9a0 [amdgpu]
   amdgpu_ip_block_hw_fini+0x29/0xc0 [amdgpu]
   amdgpu_device_fini_hw+0x309/0x5f0 [amdgpu]
   amdgpu_driver_unload_kms+0x7c/0x90 [amdgpu]
   amdgpu_pci_remove+0x51/0x90 [amdgpu]

Guard each put with amdgpu_irq_enabled() so hw_fini only releases
IRQs that are currently held.

Fixes: d97b02bb9c7aa ("drm/amdgpu/gfx: disable gfx9 cp_ecc_error_irq only when enabling legacy gfx ras")
Cc: stable@vger.kernel.org
Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index bf270e605949f..e5a3735d98342 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4057,11 +4057,14 @@ static int gfx_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+	if (amdgpu_irq_enabled(adev, &adev->gfx.cp_ecc_error_irq, 0))
 		amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
-	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
-	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
-	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
+	if (amdgpu_irq_enabled(adev, &adev->gfx.priv_reg_irq, 0))
+		amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
+	if (amdgpu_irq_enabled(adev, &adev->gfx.priv_inst_irq, 0))
+		amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+	if (amdgpu_irq_enabled(adev, &adev->gfx.bad_op_irq, 0))
+		amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
 
 	/* DF freeze and kcq disable will fail */
 	if (!amdgpu_ras_intr_triggered())
-- 
2.51.2


