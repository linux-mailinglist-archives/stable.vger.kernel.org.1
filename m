Return-Path: <stable+bounces-64537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03B7941E46
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646F52857AE
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39D41A76CE;
	Tue, 30 Jul 2024 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lhNo1zR9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619831A76BE;
	Tue, 30 Jul 2024 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360450; cv=none; b=qIQVEHEgy4F/s2zIISHG3ooYdujef68tlx0v7iZEOgnPOcKnhs/TaMHZyLsRG5j/ia8R9e4mF1Sv3c8lQQDlan8jipSKVfk7NPW0jfHsXzL44p+lsoyGQ+BzDXigH0TjpkFosifUfe7UHAdTGM+p7NWv/T5gjH4KlTSMLgwmksY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360450; c=relaxed/simple;
	bh=nSaL7WccMdIpjpLt6bJWiZqYKCgt8SL4wGgppuYLX1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=noKm75dcuuzEX4D+D+ON0yIa4/ARJM6hm+HendkISEUIuU8yIToWSDiBz2iL4qnVWClZe0iCVmel+zpEBQy5h9fXuaX5yiqT9qhtb6h+liy/EfA8JDueyZK/VhGM4JFHfVAz3zCRWTNHPYA5/dK4WkbrFDOPIRwGHyiemfJpEPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lhNo1zR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4B3C32782;
	Tue, 30 Jul 2024 17:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722360450;
	bh=nSaL7WccMdIpjpLt6bJWiZqYKCgt8SL4wGgppuYLX1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lhNo1zR9EuzTMGLzVnI+38wUyN1dp7l5pHBEcZgKiMlW2n8zBo9ZepnoViwESqSG1
	 QrN0rQod1f9UxQ1uhaA6GM+cGsahjuWaWhEGHivgyhoIw92rLyTOpxLAS1VaHyHzBp
	 hb1Kv4UR0q4g0KdNi7q/AqklvHBPGtHb1+YmF/+s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tim Huang <tim.huang@amd.com>,
	Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.10 703/809] drm/amdgpu: add missed harvest check for VCN IP v4/v5
Date: Tue, 30 Jul 2024 17:49:39 +0200
Message-ID: <20240730151752.692780223@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tim Huang <tim.huang@amd.com>

commit fab1ead0ae3a4757afb92ff6909b37d63db17e55 upstream.

To prevent below probe failure, add a check for models with VCN
IP v4.0.6 where VCN1 may be harvested.

v2:
Apply the same check to VCN IP v4.0 and v5.0.

[   54.070117] RIP: 0010:vcn_v4_0_5_start_dpg_mode+0x9be/0x36b0 [amdgpu]
[   54.071055] Code: 80 fb ff 8d 82 00 80 fe ff 81 fe 00 06 00 00 0f 43
c2 49 69 d5 38 0d 00 00 48 8d 71 04 c1 e8 02 4c 01 f2 48 89 b2 50 f6 02
00 <89> 01 48 8b 82 50 f6 02 00 48 8d 48 04 48 89 8a 50 f6 02 00 c7 00
[   54.072408] RSP: 0018:ffffb17985f736f8 EFLAGS: 00010286
[   54.072793] RAX: 00000000000000d6 RBX: ffff99a82f680000 RCX:
0000000000000000
[   54.073315] RDX: ffff99a82f680000 RSI: 0000000000000004 RDI:
ffff99a82f680000
[   54.073835] RBP: ffffb17985f73730 R08: 0000000000000001 R09:
0000000000000000
[   54.074353] R10: 0000000000000008 R11: ffffb17983c05000 R12:
0000000000000000
[   54.074879] R13: 0000000000000000 R14: ffff99a82f680000 R15:
0000000000000001
[   54.075400] FS:  00007f8d9c79a000(0000) GS:ffff99ab2f140000(0000)
knlGS:0000000000000000
[   54.075988] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   54.076408] CR2: 0000000000000000 CR3: 0000000140c3a000 CR4:
0000000000750ef0
[   54.076927] PKRU: 55555554
[   54.077132] Call Trace:
[   54.077319]  <TASK>
[   54.077484]  ? show_regs+0x69/0x80
[   54.077747]  ? __die+0x28/0x70
[   54.077979]  ? page_fault_oops+0x180/0x4b0
[   54.078286]  ? do_user_addr_fault+0x2d2/0x680
[   54.078610]  ? exc_page_fault+0x84/0x190
[   54.078910]  ? asm_exc_page_fault+0x2b/0x30
[   54.079224]  ? vcn_v4_0_5_start_dpg_mode+0x9be/0x36b0 [amdgpu]
[   54.079941]  ? vcn_v4_0_5_start_dpg_mode+0xe6/0x36b0 [amdgpu]
[   54.080617]  vcn_v4_0_5_set_powergating_state+0x82/0x19b0 [amdgpu]
[   54.081316]  amdgpu_device_ip_set_powergating_state+0x64/0xc0
[amdgpu]
[   54.082057]  amdgpu_vcn_ring_begin_use+0x6f/0x1d0 [amdgpu]
[   54.082727]  amdgpu_ring_alloc+0x44/0x70 [amdgpu]
[   54.083351]  amdgpu_vcn_dec_sw_ring_test_ring+0x40/0x110 [amdgpu]
[   54.084054]  amdgpu_ring_test_helper+0x22/0x90 [amdgpu]
[   54.084698]  vcn_v4_0_5_hw_init+0x87/0xc0 [amdgpu]
[   54.085307]  amdgpu_device_init+0x1f96/0x2780 [amdgpu]
[   54.085951]  amdgpu_driver_load_kms+0x1e/0xc0 [amdgpu]
[   54.086591]  amdgpu_pci_probe+0x19f/0x550 [amdgpu]
[   54.087215]  local_pci_probe+0x48/0xa0
[   54.087509]  pci_device_probe+0xc9/0x250
[   54.087812]  really_probe+0x1a4/0x3f0
[   54.088101]  __driver_probe_device+0x7d/0x170
[   54.088443]  driver_probe_device+0x24/0xa0
[   54.088765]  __driver_attach+0xdd/0x1d0
[   54.089068]  ? __pfx___driver_attach+0x10/0x10
[   54.089417]  bus_for_each_dev+0x8e/0xe0
[   54.089718]  driver_attach+0x22/0x30
[   54.090000]  bus_add_driver+0x120/0x220
[   54.090303]  driver_register+0x62/0x120
[   54.090606]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   54.091255]  __pci_register_driver+0x62/0x70
[   54.091593]  amdgpu_init+0x67/0xff0 [amdgpu]
[   54.092190]  do_one_initcall+0x5f/0x330
[   54.092495]  do_init_module+0x68/0x240
[   54.092794]  load_module+0x201c/0x2110
[   54.093093]  init_module_from_file+0x97/0xd0
[   54.093428]  ? init_module_from_file+0x97/0xd0
[   54.093777]  idempotent_init_module+0x11c/0x2a0
[   54.094134]  __x64_sys_finit_module+0x64/0xc0
[   54.094476]  do_syscall_64+0x58/0x120
[   54.094767]  entry_SYSCALL_64_after_hwframe+0x6e/0x76

Signed-off-by: Tim Huang <tim.huang@amd.com>
Reviewed-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
(cherry picked from commit 0b071245ddd98539d4f7493bdd188417fcf2d629)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |    6 ++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |    6 ++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |    6 ++++++
 3 files changed, 18 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1053,6 +1053,9 @@ static int vcn_v4_0_start(struct amdgpu_
 		amdgpu_dpm_enable_uvd(adev, true);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
 		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
@@ -1506,6 +1509,9 @@ static int vcn_v4_0_stop(struct amdgpu_d
 	int i, r = 0;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
 		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -964,6 +964,9 @@ static int vcn_v4_0_5_start(struct amdgp
 		amdgpu_dpm_enable_uvd(adev, true);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
 		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
@@ -1168,6 +1171,9 @@ static int vcn_v4_0_5_stop(struct amdgpu
 	int i, r = 0;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
 		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -722,6 +722,9 @@ static int vcn_v5_0_0_start(struct amdgp
 		amdgpu_dpm_enable_uvd(adev, true);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
 		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
@@ -899,6 +902,9 @@ static int vcn_v5_0_0_stop(struct amdgpu
 	int i, r = 0;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
 		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 



