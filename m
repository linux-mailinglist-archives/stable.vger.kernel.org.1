Return-Path: <stable+bounces-103848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C249EF9D0
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0076D179F3D
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9342D223C5A;
	Thu, 12 Dec 2024 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LUtzkp52"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50152223711;
	Thu, 12 Dec 2024 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025780; cv=none; b=h62MavvzIc64HRTtj9Ayt1UYVe6xh9JF8zqUIil65ZAuoYywy0e/HdVIxEHJyOr/buDBtQkW1dOd1EdyB8SWcnvm2weHG/v/H3pncEQSYp9AJa4PWzQbfLKCgEqDgTSCMh401Op++QYkookW+BykkFWiQwOOB7lJL4Okb/QuXrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025780; c=relaxed/simple;
	bh=bVNkL9gZgQn98tFEgoYbVmKWFgVqR/7P1T3I6KEmu88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UeD08+VVeOYPp4GCuqTeWU8F9xdg0V9oz/vSro3jOjkj9DP1WcFyUe2AdJbIsZlf5a0zwQz7iWUMz/1PpOOxtxSWjKeLF3R3x9LOIzJiG4XHdzyj4T6+nBvdX8MJKQQgdM2CwF43JlBmnKCGoac1dlvC8GuzB8L2P9E80kkq0L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LUtzkp52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0ECC4CED0;
	Thu, 12 Dec 2024 17:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734025780;
	bh=bVNkL9gZgQn98tFEgoYbVmKWFgVqR/7P1T3I6KEmu88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LUtzkp52wd+ghgktyH8q6vb1cC2N0+A8XnW5UnDuS/Rm5im/asV+Ui32+A/qFZH6A
	 nLBZcb8N4eioTEpHE2QycCD6kD72ZNCYveIAl94zYpAhNo2H6cZdKsTeWpkllZNEEE
	 GNHzk9+Wq+II5Y+DP1KXbnPCxWJg7524/gFvsb3Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Prike Liang <Prike.Liang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 286/321] drm/amdgpu: set the right AMDGPU sg segment limitation
Date: Thu, 12 Dec 2024 16:03:24 +0100
Message-ID: <20241212144241.281335723@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144229.291682835@linuxfoundation.org>
References: <20241212144229.291682835@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prike Liang <Prike.Liang@amd.com>

[ Upstream commit e2e97435783979124ba92d6870415c57ecfef6a5 ]

The driver needs to set the correct max_segment_size;
otherwise debug_dma_map_sg() will complain about the
over-mapping of the AMDGPU sg length as following:

WARNING: CPU: 6 PID: 1964 at kernel/dma/debug.c:1178 debug_dma_map_sg+0x2dc=
/0x370
[  364.049444] Modules linked in: veth amdgpu(OE) amdxcp drm_exec gpu_sched=
 drm_buddy drm_ttm_helper ttm(OE) drm_suballoc_helper drm_display_helper dr=
m_kms_helper i2c_algo_bit rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs lockd grace=
 netfs xt_conntrack xt_MASQUERADE nf_conntrack_netlink xfrm_user xfrm_algo =
iptable_nat xt_addrtype iptable_filter br_netfilter nvme_fabrics overlay nf=
netlink_cttimeout nfnetlink openvswitch nsh nf_conncount nf_nat nf_conntrac=
k nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c bridge stp llc amd_atl intel_rapl=
_msr intel_rapl_common sunrpc sch_fq_codel snd_hda_codec_realtek snd_hda_co=
dec_generic snd_hda_scodec_component snd_hda_codec_hdmi snd_hda_intel snd_i=
ntel_dspcfg edac_mce_amd binfmt_misc snd_hda_codec snd_pci_acp6x snd_hda_co=
re snd_acp_config snd_hwdep snd_soc_acpi kvm_amd snd_pcm kvm snd_seq_midi s=
nd_seq_midi_event crct10dif_pclmul ghash_clmulni_intel sha512_ssse3 snd_raw=
midi sha256_ssse3 sha1_ssse3 aesni_intel snd_seq nls_iso8859_1 crypto_simd =
snd_seq_device cryptd snd_timer rapl input_leds snd
[  364.049532]  ipmi_devintf wmi_bmof ccp serio_raw k10temp sp5100_tco soun=
dcore ipmi_msghandler cm32181 industrialio mac_hid msr parport_pc ppdev lp =
parport drm efi_pstore ip_tables x_tables pci_stub crc32_pclmul nvme ahci l=
ibahci i2c_piix4 r8169 nvme_core i2c_designware_pci realtek i2c_ccgx_ucsi v=
ideo wmi hid_generic cdc_ether usbnet usbhid hid r8152 mii
[  364.049576] CPU: 6 PID: 1964 Comm: rocminfo Tainted: G           OE     =
 6.10.0-custom #492
[  364.049579] Hardware name: AMD Majolica-RN/Majolica-RN, BIOS RMJ1009A 06=
/13/2021
[  364.049582] RIP: 0010:debug_dma_map_sg+0x2dc/0x370
[  364.049585] Code: 89 4d b8 e8 36 b1 86 00 8b 4d b8 48 8b 55 b0 44 8b 45 =
a8 4c 8b 4d a0 48 89 c6 48 c7 c7 00 4b 74 bc 4c 89 4d b8 e8 b4 73 f3 ff <0f=
> 0b 4c 8b 4d b8 8b 15 c8 2c b8 01 85 d2 0f 85 ee fd ff ff 8b 05
[  364.049588] RSP: 0018:ffff9ca600b57ac0 EFLAGS: 00010286
[  364.049590] RAX: 0000000000000000 RBX: ffff88b7c132b0c8 RCX: 00000000000=
00027
[  364.049592] RDX: ffff88bb0f521688 RSI: 0000000000000001 RDI: ffff88bb0f5=
21680
[  364.049594] RBP: ffff9ca600b57b20 R08: 000000000000006f R09: ffff9ca600b=
57930
[  364.049596] R10: ffff9ca600b57928 R11: ffffffffbcb46328 R12: 00000000000=
00000
[  364.049597] R13: 0000000000000001 R14: ffff88b7c19c0700 R15: ffff88b7c90=
59800
[  364.049599] FS:  00007fb2d3516e80(0000) GS:ffff88bb0f500000(0000) knlGS:=
0000000000000000
[  364.049601] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  364.049603] CR2: 000055610bd03598 CR3: 00000001049f6000 CR4: 00000000003=
50ef0
[  364.049605] Call Trace:
[  364.049607]  <TASK>
[  364.049609]  ? show_regs+0x6d/0x80
[  364.049614]  ? __warn+0x8c/0x140
[  364.049618]  ? debug_dma_map_sg+0x2dc/0x370
[  364.049621]  ? report_bug+0x193/0x1a0
[  364.049627]  ? handle_bug+0x46/0x80
[  364.049631]  ? exc_invalid_op+0x1d/0x80
[  364.049635]  ? asm_exc_invalid_op+0x1f/0x30
[  364.049642]  ? debug_dma_map_sg+0x2dc/0x370
[  364.049647]  __dma_map_sg_attrs+0x90/0xe0
[  364.049651]  dma_map_sgtable+0x25/0x40
[  364.049654]  amdgpu_bo_move+0x59a/0x850 [amdgpu]
[  364.049935]  ? srso_return_thunk+0x5/0x5f
[  364.049939]  ? amdgpu_ttm_tt_populate+0x5d/0xc0 [amdgpu]
[  364.050095]  ttm_bo_handle_move_mem+0xc3/0x180 [ttm]
[  364.050103]  ttm_bo_validate+0xc1/0x160 [ttm]
[  364.050108]  ? amdgpu_ttm_tt_get_user_pages+0xe5/0x1b0 [amdgpu]
[  364.050263]  amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0xa12/0xc90 [amdgpu]
[  364.050473]  kfd_ioctl_alloc_memory_of_gpu+0x16b/0x3b0 [amdgpu]
[  364.050680]  kfd_ioctl+0x3c2/0x530 [amdgpu]
[  364.050866]  ? __pfx_kfd_ioctl_alloc_memory_of_gpu+0x10/0x10 [amdgpu]
[  364.051054]  ? srso_return_thunk+0x5/0x5f
[  364.051057]  ? tomoyo_file_ioctl+0x20/0x30
[  364.051063]  __x64_sys_ioctl+0x9c/0xd0
[  364.051068]  x64_sys_call+0x1219/0x20d0
[  364.051073]  do_syscall_64+0x51/0x120
[  364.051077]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  364.051081] RIP: 0033:0x7fb2d2f1a94f

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 870dd78d5a21a..30e3cc9c25d03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1678,6 +1678,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
=20
 	mutex_init(&adev->mman.gtt_window_lock);
=20
+	dma_set_max_seg_size(adev->dev, UINT_MAX);
 	/* No others user of address space so set it to 0 */
 	r =3D ttm_bo_device_init(&adev->mman.bdev,
 			       &amdgpu_bo_driver,
--=20
2.43.0




