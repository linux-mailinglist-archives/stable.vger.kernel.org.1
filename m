Return-Path: <stable+bounces-1075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E16747F7DE4
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109DC1C2130F
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590C63A8C3;
	Fri, 24 Nov 2023 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WH/Jhfbz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119AD39FE1;
	Fri, 24 Nov 2023 18:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1F4C433C9;
	Fri, 24 Nov 2023 18:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850497;
	bh=Dg++rFiDgJA5dkSSQXXPqIhBFUryKLAsnJxn4GBCMtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WH/Jhfbz6fI+fADBRN3hFmyDKlbDKMs80S0kqrQ3NeaZOS3CG8W1K++4XBn+xLNhH
	 NBx9wUK0RBQJsIECB/QO7BhgCJ1sIP+VDxST7mVWWrCEp6X/v27zet0kU9s9Ms3uQr
	 BSG6a1W+eqXoNcm06YjPp8iA2oD/r7pZdletVqcs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Huang <qu.huang@linux.dev>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 072/491] drm/amdgpu: Fix a null pointer access when the smc_rreg pointer is NULL
Date: Fri, 24 Nov 2023 17:45:08 +0000
Message-ID: <20231124172026.801952032@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Huang <qu.huang@linux.dev>

[ Upstream commit 5104fdf50d326db2c1a994f8b35dcd46e63ae4ad ]

In certain types of chips, such as VEGA20, reading the amdgpu_regs_smc file could result in an abnormal null pointer access when the smc_rreg pointer is NULL. Below are the steps to reproduce this issue and the corresponding exception log:

1. Navigate to the directory: /sys/kernel/debug/dri/0
2. Execute command: cat amdgpu_regs_smc
3. Exception Log::
[4005007.702554] BUG: kernel NULL pointer dereference, address: 0000000000000000
[4005007.702562] #PF: supervisor instruction fetch in kernel mode
[4005007.702567] #PF: error_code(0x0010) - not-present page
[4005007.702570] PGD 0 P4D 0
[4005007.702576] Oops: 0010 [#1] SMP NOPTI
[4005007.702581] CPU: 4 PID: 62563 Comm: cat Tainted: G           OE     5.15.0-43-generic #46-Ubunt       u
[4005007.702590] RIP: 0010:0x0
[4005007.702598] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
[4005007.702600] RSP: 0018:ffffa82b46d27da0 EFLAGS: 00010206
[4005007.702605] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffa82b46d27e68
[4005007.702609] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9940656e0000
[4005007.702612] RBP: ffffa82b46d27dd8 R08: 0000000000000000 R09: ffff994060c07980
[4005007.702615] R10: 0000000000020000 R11: 0000000000000000 R12: 00007f5e06753000
[4005007.702618] R13: ffff9940656e0000 R14: ffffa82b46d27e68 R15: 00007f5e06753000
[4005007.702622] FS:  00007f5e0755b740(0000) GS:ffff99479d300000(0000) knlGS:0000000000000000
[4005007.702626] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[4005007.702629] CR2: ffffffffffffffd6 CR3: 00000003253fc000 CR4: 00000000003506e0
[4005007.702633] Call Trace:
[4005007.702636]  <TASK>
[4005007.702640]  amdgpu_debugfs_regs_smc_read+0xb0/0x120 [amdgpu]
[4005007.703002]  full_proxy_read+0x5c/0x80
[4005007.703011]  vfs_read+0x9f/0x1a0
[4005007.703019]  ksys_read+0x67/0xe0
[4005007.703023]  __x64_sys_read+0x19/0x20
[4005007.703028]  do_syscall_64+0x5c/0xc0
[4005007.703034]  ? do_user_addr_fault+0x1e3/0x670
[4005007.703040]  ? exit_to_user_mode_prepare+0x37/0xb0
[4005007.703047]  ? irqentry_exit_to_user_mode+0x9/0x20
[4005007.703052]  ? irqentry_exit+0x19/0x30
[4005007.703057]  ? exc_page_fault+0x89/0x160
[4005007.703062]  ? asm_exc_page_fault+0x8/0x30
[4005007.703068]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[4005007.703075] RIP: 0033:0x7f5e07672992
[4005007.703079] Code: c0 e9 b2 fe ff ff 50 48 8d 3d fa b2 0c 00 e8 c5 1d 02 00 0f 1f 44 00 00 f3 0f        1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 e       c 28 48 89 54 24
[4005007.703083] RSP: 002b:00007ffe03097898 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[4005007.703088] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f5e07672992
[4005007.703091] RDX: 0000000000020000 RSI: 00007f5e06753000 RDI: 0000000000000003
[4005007.703094] RBP: 00007f5e06753000 R08: 00007f5e06752010 R09: 00007f5e06752010
[4005007.703096] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000022000
[4005007.703099] R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000020000
[4005007.703105]  </TASK>
[4005007.703107] Modules linked in: nf_tables libcrc32c nfnetlink algif_hash af_alg binfmt_misc nls_       iso8859_1 ipmi_ssif ast intel_rapl_msr intel_rapl_common drm_vram_helper drm_ttm_helper amd64_edac t       tm edac_mce_amd kvm_amd ccp mac_hid k10temp kvm acpi_ipmi ipmi_si rapl sch_fq_codel ipmi_devintf ipm       i_msghandler msr parport_pc ppdev lp parport mtd pstore_blk efi_pstore ramoops pstore_zone reed_solo       mon ip_tables x_tables autofs4 ib_uverbs ib_core amdgpu(OE) amddrm_ttm_helper(OE) amdttm(OE) iommu_v       2 amd_sched(OE) amdkcl(OE) drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec rc_core        drm igb ahci xhci_pci libahci i2c_piix4 i2c_algo_bit xhci_pci_renesas dca
[4005007.703184] CR2: 0000000000000000
[4005007.703188] ---[ end trace ac65a538d240da39 ]---
[4005007.800865] RIP: 0010:0x0
[4005007.800871] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
[4005007.800874] RSP: 0018:ffffa82b46d27da0 EFLAGS: 00010206
[4005007.800878] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffa82b46d27e68
[4005007.800881] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9940656e0000
[4005007.800883] RBP: ffffa82b46d27dd8 R08: 0000000000000000 R09: ffff994060c07980
[4005007.800886] R10: 0000000000020000 R11: 0000000000000000 R12: 00007f5e06753000
[4005007.800888] R13: ffff9940656e0000 R14: ffffa82b46d27e68 R15: 00007f5e06753000
[4005007.800891] FS:  00007f5e0755b740(0000) GS:ffff99479d300000(0000) knlGS:0000000000000000
[4005007.800895] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[4005007.800898] CR2: ffffffffffffffd6 CR3: 00000003253fc000 CR4: 00000000003506e0

Signed-off-by: Qu Huang <qu.huang@linux.dev>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 56e89e76ff179..33cada366eeb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -747,6 +747,9 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
 	ssize_t result = 0;
 	int r;
 
+	if (!adev->smc_rreg)
+		return -EPERM;
+
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
@@ -803,6 +806,9 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
 	ssize_t result = 0;
 	int r;
 
+	if (!adev->smc_wreg)
+		return -EPERM;
+
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
-- 
2.42.0




