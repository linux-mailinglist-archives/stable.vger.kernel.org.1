Return-Path: <stable+bounces-93772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F739D0A9D
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 09:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11DFC2810D9
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 08:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B29D13D50C;
	Mon, 18 Nov 2024 08:07:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFF7405FB
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 08:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731917275; cv=none; b=WoVwqYwtiQVRQ1Riqs5xZfyN75SCB1hlBrK9vofl87wDDh0JtApo39UfjU263vqHobRyJwxRBOf5p9DEhwCMA7S4KagfnujDLEnJwEYtbxXigy4PA3r7XXcf3WK2NrGW36Dl29R7BmbSvTD30gn2NNwaH/CadJlvDX2uB15OKYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731917275; c=relaxed/simple;
	bh=1Xlz4/oIFHCLg1jEs4vVAvr3NYWYztsxh9UI2qX+7AM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OPFDB8i5/PoF2J5nDYJZ2QrgaKBQA6g6iWltc6SjR8zUR/Ek5IMOUoB21SpRGnJYpO3rESe6F4sZFF3cPfDKHF1gOjttPOO7wu2Bb0gxFbu7zwrtFJCq8IWLUSo9kYV2XPJ39rSQnwRZAWyQqRkp2Nk1Jx269bXka2e1bZTMlP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI7L4qM020653;
	Mon, 18 Nov 2024 00:07:51 -0800
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xusq16pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 18 Nov 2024 00:07:51 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Mon, 18 Nov 2024 00:07:50 -0800
Received: from pek-blan-cn-d1.wrs.com (128.224.34.185) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Mon, 18 Nov 2024 00:07:50 -0800
From: Bin Lan <bin.lan.cn@windriver.com>
To: <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
Subject: [PATCH 6.6] drm/amd/pm: Vangogh: Fix kernel memory out of bounds write
Date: Mon, 18 Nov 2024 16:08:12 +0800
Message-ID: <20241118080812.960909-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: edNMl2pOpyHZ-sKdoQoWk5Oc4SwLnSHX
X-Proofpoint-ORIG-GUID: edNMl2pOpyHZ-sKdoQoWk5Oc4SwLnSHX
X-Authority-Analysis: v=2.4 cv=d9mnygjE c=1 sm=1 tr=0 ts=673af5d7 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=VlfZXiiP6vEA:10 a=VwQbUJbxAAAA:8 a=V2sgnzSHAAAA:8 a=zd2uoN0lAAAA:8 a=t7CeM3EgAAAA:8 a=5cPpX14MogTr20BxmYkA:9
 a=Z31ocT7rh6aUJxSkT1EX:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_04,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411180067

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

[ Upstream commit 4aa923a6e6406b43566ef6ac35a3d9a3197fa3e8 ]

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
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20241025145639.19124-1-tursulin@igalia.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 0880f58f9609f0200483a49429af0f050d281703)
Cc: stable@vger.kernel.org # v6.6+
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index f46cda889483..454216bd6f1d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -256,10 +256,9 @@ static int vangogh_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	if (smu_version >= 0x043F3E00)
-		smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_3);
-	else
-		smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_2);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_2);
+	smu_table->gpu_metrics_table_size = max(smu_table->gpu_metrics_table_size, sizeof(struct gpu_metrics_v2_3));
+	smu_table->gpu_metrics_table_size = max(smu_table->gpu_metrics_table_size, sizeof(struct gpu_metrics_v2_4));
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err1_out;
-- 
2.43.0


