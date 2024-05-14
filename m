Return-Path: <stable+bounces-44963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88308C5524
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B3C1C237B7
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F1574C1B;
	Tue, 14 May 2024 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oZmq7UW1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEC63D0D1;
	Tue, 14 May 2024 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687684; cv=none; b=TbQmhGUaX5SthDCEFuP4qmkuJrEqY2Wk0+l61uozM/DEzi5SfzivX+KRZw3ApUUwyF/C9rCxNZjsndc/n6fikterKGChDlf/drjZtq5Beky4ETpLOQpT9F46ZxLXP4Y/2DWkNNFiYjabpeil6X+AMe4g+0utWWc2Ppc9D36NVo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687684; c=relaxed/simple;
	bh=Cr7CroHDu+FZcnz9rILmT6qfVFQhw42DpHxtyx0VZHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIrq5ZVWVTX0GRIi1wWBSYOPzOKWPLV3a/Dpnlu2YpEgxPqK24tzfsNtyfyrcmRnT/oSbVo4+C48ASCuNpXjDANksBycg7gx41IGg61ueb9+t73fpcXjXCKkh3JQ5izT998D1o0OwOezkX59Uai8w4bmoeTAFSfrfFNpdzyM0vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oZmq7UW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C0AC2BD10;
	Tue, 14 May 2024 11:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687684;
	bh=Cr7CroHDu+FZcnz9rILmT6qfVFQhw42DpHxtyx0VZHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oZmq7UW1czcyRib4kIYb/J8N4Y6gDVJicRCOPMQQbOmtkAS2MzuuJeemsGWwGgR/S
	 pmBGgdp8gQqI5+VbVXhh+aALVEmnUVAXk/1KkqWavA1WG7oA0GQ8hlNH7KM3Hky3hh
	 NSAPqQnqw882a7LWsqWWpAnKeF3MpG0PUatzO17w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guangwu Zhang <guazhang@redhat.com>,
	Saurav Kashyap <skashyap@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 069/168] scsi: bnx2fc: Remove spin_lock_bh while releasing resources after upload
Date: Tue, 14 May 2024 12:19:27 +0200
Message-ID: <20240514101009.300049333@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101006.678521560@linuxfoundation.org>
References: <20240514101006.678521560@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Saurav Kashyap <skashyap@marvell.com>

[ Upstream commit c214ed2a4dda35b308b0b28eed804d7ae66401f9 ]

The session resources are used by FW and driver when session is offloaded,
once session is uploaded these resources are not used. The lock is not
required as these fields won't be used any longer. The offload and upload
calls are sequential, hence lock is not required.

This will suppress following BUG_ON():

[  449.843143] ------------[ cut here ]------------
[  449.848302] kernel BUG at mm/vmalloc.c:2727!
[  449.853072] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[  449.858712] CPU: 5 PID: 1996 Comm: kworker/u24:2 Not tainted 5.14.0-118.=
el9.x86_64 #1
Rebooting.
[  449.867454] Hardware name: Dell Inc. PowerEdge R730/0WCJNT, BIOS 2.3.4 1=
1/08/2016
[  449.876966] Workqueue: fc_rport_eq fc_rport_work [libfc]
[  449.882910] RIP: 0010:vunmap+0x2e/0x30
[  449.887098] Code: 00 65 8b 05 14 a2 f0 4a a9 00 ff ff 00 75 1b 55 48 89 =
fd e8 34 36 79 00 48 85 ed 74 0b 48 89 ef 31 f6 5d e9 14 fc ff ff 5d c3 <0f=
> 0b 0f 1f 44 00 00 41 57 41 56 49 89 ce 41 55 49 89 fd 41 54 41
[  449.908054] RSP: 0018:ffffb83d878b3d68 EFLAGS: 00010206
[  449.913887] RAX: 0000000080000201 RBX: ffff8f4355133550 RCX: 000000000d4=
00005
[  449.921843] RDX: 0000000000000001 RSI: 0000000000001000 RDI: ffffb83da53=
f5000
[  449.929808] RBP: ffff8f4ac6675800 R08: ffffb83d878b3d30 R09: 00000000000=
efbdf
[  449.937774] R10: 0000000000000003 R11: ffff8f434573e000 R12: 00000000000=
01000
[  449.945736] R13: 0000000000001000 R14: ffffb83da53f5000 R15: ffff8f43d4e=
a3ae0
[  449.953701] FS:  0000000000000000(0000) GS:ffff8f529fc80000(0000) knlGS:=
0000000000000000
[  449.962732] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  449.969138] CR2: 00007f8cf993e150 CR3: 0000000efbe10003 CR4: 00000000003=
706e0
[  449.977102] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  449.985065] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  449.993028] Call Trace:
[  449.995756]  __iommu_dma_free+0x96/0x100
[  450.000139]  bnx2fc_free_session_resc+0x67/0x240 [bnx2fc]
[  450.006171]  bnx2fc_upload_session+0xce/0x100 [bnx2fc]
[  450.011910]  bnx2fc_rport_event_handler+0x9f/0x240 [bnx2fc]
[  450.018136]  fc_rport_work+0x103/0x5b0 [libfc]
[  450.023103]  process_one_work+0x1e8/0x3c0
[  450.027581]  worker_thread+0x50/0x3b0
[  450.031669]  ? rescuer_thread+0x370/0x370
[  450.036143]  kthread+0x149/0x170
[  450.039744]  ? set_kthread_struct+0x40/0x40
[  450.044411]  ret_from_fork+0x22/0x30
[  450.048404] Modules linked in: vfat msdos fat xfs nfs_layout_nfsv41_file=
s rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver dm_service_time qedf qed c=
rc8 bnx2fc libfcoe libfc scsi_transport_fc intel_rapl_msr intel_rapl_common=
 x86_pkg_temp_thermal intel_powerclamp dcdbas rapl intel_cstate intel_uncor=
e mei_me pcspkr mei ipmi_ssif lpc_ich ipmi_si fuse zram ext4 mbcache jbd2 l=
oop nfsv3 nfs_acl nfs lockd grace fscache netfs irdma ice sd_mod t10_pi sg =
ib_uverbs ib_core 8021q garp mrp stp llc mgag200 i2c_algo_bit drm_kms_helpe=
r syscopyarea sysfillrect sysimgblt mxm_wmi fb_sys_fops cec crct10dif_pclmu=
l ahci crc32_pclmul bnx2x drm ghash_clmulni_intel libahci rfkill i40e libat=
a megaraid_sas mdio wmi sunrpc lrw dm_crypt dm_round_robin dm_multipath dm_=
snapshot dm_bufio dm_mirror dm_region_hash dm_log dm_zero dm_mod linear rai=
d10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx raid=
6_pq libcrc32c crc32c_intel raid1 raid0 iscsi_ibft squashfs be2iscsi bnx2i =
cnic uio cxgb4i cxgb4 tls
[  450.048497]  libcxgbi libcxgb qla4xxx iscsi_boot_sysfs iscsi_tcp libiscs=
i_tcp libiscsi scsi_transport_iscsi edd ipmi_devintf ipmi_msghandler
[  450.159753] ---[ end trace 712de2c57c64abc8 ]---

Reported-by: Guangwu Zhang <guazhang@redhat.com>
Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20240315071427.31842-1-skashyap@marvell.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/bnx2fc/bnx2fc_tgt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_tgt.c b/drivers/scsi/bnx2fc/bnx2fc_=
tgt.c
index 9200b718085c4..5015d9b0817ac 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_tgt.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_tgt.c
@@ -833,7 +833,6 @@ static void bnx2fc_free_session_resc(struct bnx2fc_hba =
*hba,
=20
 	BNX2FC_TGT_DBG(tgt, "Freeing up session resources\n");
=20
-	spin_lock_bh(&tgt->cq_lock);
 	ctx_base_ptr =3D tgt->ctx_base;
 	tgt->ctx_base =3D NULL;
=20
@@ -889,7 +888,6 @@ static void bnx2fc_free_session_resc(struct bnx2fc_hba =
*hba,
 				    tgt->sq, tgt->sq_dma);
 		tgt->sq =3D NULL;
 	}
-	spin_unlock_bh(&tgt->cq_lock);
=20
 	if (ctx_base_ptr)
 		iounmap(ctx_base_ptr);
--=20
2.43.0




