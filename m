Return-Path: <stable+bounces-220496-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPO3OvY3o2lx+gQAu9opvQ
	(envelope-from <stable+bounces-220496-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAA81C63BF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E29D432823BE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76E93C85E6;
	Sat, 28 Feb 2026 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hV4UJ8i3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696EF481642;
	Sat, 28 Feb 2026 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300381; cv=none; b=dAUh4S6ZlX5rtEsh6mypr8wv4d/qOr2i9Qt6FcmBR/Hxv/Jo3f5hejJ4VGa01erFjrWHM8Ox2n9YgOlVuBAdXqvEw4S0SiRP76/zGegi8Jx5fF77+tT0D4lgzEq/mIVSdz21lAqr1E/VhaD/AqVmZ6kTzu6XNF09mazcEP+BF0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300381; c=relaxed/simple;
	bh=jlnQChbr8HUhHwG/JR8f/1rKBO3Lt3uODy66onsJy7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxUXwNeimmhn5HFQLg7/HvfPh3WdPDzRoLYmjKbM5xcSbk7skjO9IEbhGFnyrT957rcQ50ssQO4tdJw2YVA55wrGkPMnsCsl4KjUV5KKkFGpU4H05K6GCXFN5AnUhxRvCGU7tDHwMFNuqLM+8l6LKpLT2Rq+NX86xzWrLzb2/90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hV4UJ8i3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26C5C19423;
	Sat, 28 Feb 2026 17:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300381;
	bh=jlnQChbr8HUhHwG/JR8f/1rKBO3Lt3uODy66onsJy7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hV4UJ8i3EB7d/x51xtNK8cDDfaSBiBBR+nlUDW4L2Cjcv/ZQmvUYsfuy365HLFnQ3
	 uHjBye0dc25KmMbjIsDFj16DVasWbKEAjfidA8jN6yW/NwLZDg7DA62LYywPjttIkN
	 /nG1rqRPcVPsQmQEjL5OoH88KLh8gybHbP8ksVt35Uuv4luNzfRzLFugbLhv0wKU0W
	 mGOjZ2bz+iVrSVinNdQFbqqAf1pJoG46fNp+nDbQERAiyPtjYfsk9ynb7teBlJQAsh
	 6U73kU3WWbwAr4nbfC9RAxFCv5S+TkHvQ2RtXHZQpWYHsHVR0LElI1Q0AOhDDzLa4g
	 9TWHkDVDbyWUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lijo Lazar <lijo.lazar@amd.com>,
	Mangesh Gadre <Mangesh.Gadre@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 417/844] drm/amdgpu: Skip vcn poison irq release on VF
Date: Sat, 28 Feb 2026 12:25:30 -0500
Message-ID: <20260228173244.1509663-418-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220496-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7AAA81C63BF
X-Rspamd-Action: no action

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit 8980be03b3f9a4b58197ef95d3b37efa41a25331 ]

VF doesn't enable VCN poison irq in VCNv2.5. Skip releasing it and avoid
call trace during deinitialization.

[   71.913601] [drm] clean up the vf2pf work item
[   71.915088] ------------[ cut here ]------------
[   71.915092] WARNING: CPU: 3 PID: 1079 at /tmp/amd.aFkFvSQl/amd/amdgpu/amdgpu_irq.c:641 amdgpu_irq_put+0xc6/0xe0 [amdgpu]
[   71.915355] Modules linked in: amdgpu(OE-) amddrm_ttm_helper(OE) amdttm(OE) amddrm_buddy(OE) amdxcp(OE) amddrm_exec(OE) amd_sched(OE) amdkcl(OE) drm_suballoc_helper drm_display_helper cec rc_core i2c_algo_bit video wmi binfmt_misc nls_iso8859_1 intel_rapl_msr intel_rapl_common input_leds joydev serio_raw mac_hid qemu_fw_cfg sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua efi_pstore ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 hid_generic crct10dif_pclmul crc32_pclmul polyval_clmulni polyval_generic ghash_clmulni_intel usbhid 8139too sha256_ssse3 sha1_ssse3 hid psmouse bochs i2c_i801 ahci drm_vram_helper libahci i2c_smbus lpc_ich drm_ttm_helper 8139cp mii ttm aesni_intel crypto_simd cryptd
[   71.915484] CPU: 3 PID: 1079 Comm: rmmod Tainted: G           OE      6.8.0-87-generic #88~22.04.1-Ubuntu
[   71.915489] Hardware name: Red Hat KVM/RHEL, BIOS 1.16.3-2.el9_5.1 04/01/2014
[   71.915492] RIP: 0010:amdgpu_irq_put+0xc6/0xe0 [amdgpu]
[   71.915768] Code: 75 84 b8 ea ff ff ff eb d4 44 89 ea 48 89 de 4c 89 e7 e8 fd fc ff ff 5b 41 5c 41 5d 41 5e 5d 31 d2 31 f6 31 ff e9 55 30 3b c7 <0f> 0b eb d4 b8 fe ff ff ff eb a8 e9 b7 3b 8a 00 66 2e 0f 1f 84 00
[   71.915771] RSP: 0018:ffffcf0800eafa30 EFLAGS: 00010246
[   71.915775] RAX: 0000000000000000 RBX: ffff891bda4b0668 RCX: 0000000000000000
[   71.915777] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   71.915779] RBP: ffffcf0800eafa50 R08: 0000000000000000 R09: 0000000000000000
[   71.915781] R10: 0000000000000000 R11: 0000000000000000 R12: ffff891bda480000
[   71.915782] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
[   71.915792] FS:  000070cff87c4c40(0000) GS:ffff893abfb80000(0000) knlGS:0000000000000000
[   71.915795] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   71.915797] CR2: 00005fa13073e478 CR3: 000000010d634006 CR4: 0000000000770ef0
[   71.915800] PKRU: 55555554
[   71.915802] Call Trace:
[   71.915805]  <TASK>
[   71.915809]  vcn_v2_5_hw_fini+0x19e/0x1e0 [amdgpu]

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index cebee453871c1..006a154511971 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -521,7 +521,9 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
 		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
 			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 
-		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
+		/* VF doesn't enable interrupt operations for RAS */
+		if (!amdgpu_sriov_vf(adev) &&
+		    amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
 			amdgpu_irq_put(adev, &vinst->ras_poison_irq, 0);
 	}
 
-- 
2.51.0


