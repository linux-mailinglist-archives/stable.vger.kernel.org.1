Return-Path: <stable+bounces-88175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02109B0692
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 17:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35CF2B247D2
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 15:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F6B14A0A7;
	Fri, 25 Oct 2024 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EnOUtW9y"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECCF1494B1
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868212; cv=none; b=TiyYKb804S/C2ixJNnNLTvdoP5wLQrP5Y4rQnn340qgQ3SqTR/Nrc0HdlpaO7aQQQSi5IRnPs5dmFutkP82ysKBzEBcJIx8Aw2pvCs1qi6cLF/uR8+bXy561bPyBGXNzcq8eTz7dgXHRmzA4iOIpf2/ephdxOIZBLGGyb25ipoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868212; c=relaxed/simple;
	bh=RTk8NNlnpTBj8MXCgCfHCa71//F3c/0VB+S5f5ft4OM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FV81Tn6zGhyMwPsZdK7FmAryDsuSgSt8miraD/E7Ww4OzTLqaG8S0xRaqPTBvyd1hz0tt5K+V4If3FfGteQiapcf+jA+KO8xmyCFCii1GxWmRlxdME3WD018Kj0oPqGtgrmnY1FLpISOjZfpF5dDaBP9p7ofs9eNpX3Zuydtzbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=EnOUtW9y; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=38w381jfO7L81MVCdsxP78TLje/dPc0fgxLzoRvawAU=; b=EnOUtW9yvJU+zEOEDeFQpt+J6v
	msjY0cNo+oW1YBg+GyYWfpo/5vF2pImy16lJjhVi5uJ4vj8Rxf96jJ5nhum5Ho8Wh739SjCtnjX+N
	kGvnooihh2PzdTe3YROE2OIBiixCJdM0wiSm5OQFpIc8uBSi2CJUT+KsBEbQji0pi4uhyfc4/fazC
	LsTwYDv69yBo7BzU7mYL01Pt2phJC9OD2KnK26nK6o+e/T7aLNEp/XZJ4p4dauXIrpgnQCjGRMpX0
	QolkSqfFqHHBDsLxyM25TClQV1Z4FDNQLSSCUWM0IoWPrOTL0kmYmpHcD0oMNJu3ISBQWvzdZNW17
	G97MjSsw==;
Received: from [90.241.98.187] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t4Lk1-00F4I9-Fw; Fri, 25 Oct 2024 16:56:41 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Evan Quan <evan.quan@amd.com>,
	Wenyou Yang <WenYou.Yang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/amd/pm: Vangogh: Fix kernel memory out of bounds write
Date: Fri, 25 Oct 2024 15:56:39 +0100
Message-ID: <20241025145639.19124-1-tursulin@igalia.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

KASAN reports that the GPU metrics table allocated in
vangogh_tables_init() is not large enough for the memset done in
smu_cmn_init_soft_gpu_metrics(). Condensed report follows:

[   33.861314] BUG: KASAN: slab-out-of-bounds in smu_cmn_init_soft_gpu_metrics+0x73/0x200 [amdgpu]
[   33.861799] Write of size 168 at addr ffff888129f59500 by task mangoapp/1067
...
[   33.861808] CPU: 6 UID: 1000 PID: 1067 Comm: mangoapp Tainted: G        W          6.12.0-rc4 #356 1a56f59a8b5182eeaf67eb7cb8b13594dd23b544
[   33.861816] Tainted: [W]=WARN
[   33.861818] Hardware name: Valve Galileo/Galileo, BIOS F7G0107 12/01/2023
[   33.861822] Call Trace:
[   33.861826]  <TASK>
[   33.861829]  dump_stack_lvl+0x66/0x90
[   33.861838]  print_report+0xce/0x620
[   33.861853]  kasan_report+0xda/0x110
[   33.862794]  kasan_check_range+0xfd/0x1a0
[   33.862799]  __asan_memset+0x23/0x40
[   33.862803]  smu_cmn_init_soft_gpu_metrics+0x73/0x200 [amdgpu 13b1bc364ec578808f676eba412c20eaab792779]
[   33.863306]  vangogh_get_gpu_metrics_v2_4+0x123/0xad0 [amdgpu 13b1bc364ec578808f676eba412c20eaab792779]
[   33.864257]  vangogh_common_get_gpu_metrics+0xb0c/0xbc0 [amdgpu 13b1bc364ec578808f676eba412c20eaab792779]
[   33.865682]  amdgpu_dpm_get_gpu_metrics+0xcc/0x110 [amdgpu 13b1bc364ec578808f676eba412c20eaab792779]
[   33.866160]  amdgpu_get_gpu_metrics+0x154/0x2d0 [amdgpu 13b1bc364ec578808f676eba412c20eaab792779]
[   33.867135]  dev_attr_show+0x43/0xc0
[   33.867147]  sysfs_kf_seq_show+0x1f1/0x3b0
[   33.867155]  seq_read_iter+0x3f8/0x1140
[   33.867173]  vfs_read+0x76c/0xc50
[   33.867198]  ksys_read+0xfb/0x1d0
[   33.867214]  do_syscall_64+0x90/0x160
...
[   33.867353] Allocated by task 378 on cpu 7 at 22.794876s:
[   33.867358]  kasan_save_stack+0x33/0x50
[   33.867364]  kasan_save_track+0x17/0x60
[   33.867367]  __kasan_kmalloc+0x87/0x90
[   33.867371]  vangogh_init_smc_tables+0x3f9/0x840 [amdgpu]
[   33.867835]  smu_sw_init+0xa32/0x1850 [amdgpu]
[   33.868299]  amdgpu_device_init+0x467b/0x8d90 [amdgpu]
[   33.868733]  amdgpu_driver_load_kms+0x19/0xf0 [amdgpu]
[   33.869167]  amdgpu_pci_probe+0x2d6/0xcd0 [amdgpu]
[   33.869608]  local_pci_probe+0xda/0x180
[   33.869614]  pci_device_probe+0x43f/0x6b0

Empirically we can confirm that the former allocates 152 bytes for the
table, while the latter memsets the 168 large block.

Root cause appears that when GPU metrics tables for v2_4 parts were added
it was not considered to enlarge the table to fit.

The fix in this patch is rather "brute force" and perhaps later should be
done in a smarter way, by extracting and consolidating the part version to
size logic to a common helper, instead of brute forcing the largest
possible allocation. Nevertheless, for now this works and fixes the out of
bounds write.

v2:
 * Drop impossible v3_0 case. (Mario)

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: 41cec40bc9ba ("drm/amd/pm: Vangogh: Add new gpu_metrics_v2_4 to acquire gpu_metrics")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Evan Quan <evan.quan@amd.com>
Cc: Wenyou Yang <WenYou.Yang@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: <stable@vger.kernel.org> # v6.6+
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 22737b11b1bf..1fe020f1f4db 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -242,7 +242,9 @@ static int vangogh_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = max(sizeof(struct gpu_metrics_v2_3), sizeof(struct gpu_metrics_v2_2));
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_2);
+	smu_table->gpu_metrics_table_size = max(smu_table->gpu_metrics_table_size, sizeof(struct gpu_metrics_v2_3));
+	smu_table->gpu_metrics_table_size = max(smu_table->gpu_metrics_table_size, sizeof(struct gpu_metrics_v2_4));
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err1_out;
-- 
2.46.0


