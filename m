Return-Path: <stable+bounces-216273-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA+sMo1Vj2lqQQEAu9opvQ
	(envelope-from <stable+bounces-216273-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:47:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BA81385C7
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A68E3020028
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 16:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB123644A5;
	Fri, 13 Feb 2026 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfMFJYi3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18A336405B
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 16:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771001109; cv=none; b=sFlj1OLmd4u6FkluRBCKWbviLu5XSpq4bk7C/UgIX1K5PXAQQF8BDEAeWQ03R0Q00w1k7Qq/mXiVv6thyqV2rBIWbpRevBH8yCrx9MHpjzaBM0mJ8gzJextLDwp6Y9EpeAy2j/UpCLxRTJKKIBD22nd2REwTON9FKG17AmHapYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771001109; c=relaxed/simple;
	bh=xlEW/75Ja3Bur2TMUDN9o52sDRkidlEl3ZI2muUSUw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UluY5z07KMOmLCylRM5IwSk9FFcKy9EhWU+TEVVTHdoqQWZaDUgYrKnEMG1cct5PmuQ3tBXFyr8m2Vq1nChytrwKI4Vox6FM4S+R+Hs4a7+9QCknYqSspTvXEAg+ktfW61lAPKCtq+vuBQDQt32Ba1Hptjqc1lKbwPTHGBXUh/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfMFJYi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FE0C19424;
	Fri, 13 Feb 2026 16:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771001108;
	bh=xlEW/75Ja3Bur2TMUDN9o52sDRkidlEl3ZI2muUSUw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DfMFJYi3WgtVR3EcQ/H1oG2Jv37HQ2y/W0nMEiXuGFt/19dHBnBFin00W9s6Lwn7S
	 4aOmJiQQjBEN7dyIMqXqK9gMEnKXxFkQObhvKmOZjWgrQrVbTtD2/yAov/Q363XDM9
	 dgtIcbSfZ0EiEZDgq5mwzRwcqaPN9uwpSDewPWJqRArZNtKlzN48uP3W03kt/B8AyP
	 DPsOELVgrjCoLjfLTuI7yE5X5+eR8xj3YowPBPemIdrgkXtnAvdg8B3YL2McS8aERY
	 C1ooEyIKB17x8cvWIn3wpLURMCM/K5k0SMxBPPKY5PzRql/UN9gZGMh3ZXEJklDkPd
	 /6hltBU1rG4Rw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anil Gurumurthy <agurumurthy@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <hmadhani2024@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] scsi: qla2xxx: Free sp in error path to fix system crash
Date: Fri, 13 Feb 2026 11:45:03 -0500
Message-ID: <20260213164503.3564614-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213164503.3564614-1-sashal@kernel.org>
References: <2026021306-playful-overact-2bfb@gregkh>
 <20260213164503.3564614-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,gmail.com,oracle.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-216273-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,oracle.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 46BA81385C7
X-Rspamd-Action: no action

From: Anil Gurumurthy <agurumurthy@marvell.com>

[ Upstream commit 7adbd2b7809066c75f0433e5e2a8e114b429f30f ]

System crash seen during load/unload test in a loop,

[61110.449331] qla2xxx [0000:27:00.0]-0042:0: Disabled MSI-X.
[61110.467494] =============================================================================
[61110.467498] BUG qla2xxx_srbs (Tainted: G           OE    --------  --- ): Objects remaining in qla2xxx_srbs on __kmem_cache_shutdown()
[61110.467501] -----------------------------------------------------------------------------

[61110.467502] Slab 0x000000000ffc8162 objects=51 used=1 fp=0x00000000e25d3d85 flags=0x57ffffc0010200(slab|head|node=1|zone=2|lastcpupid=0x1fffff)
[61110.467509] CPU: 53 PID: 455206 Comm: rmmod Kdump: loaded Tainted: G           OE    --------  ---  5.14.0-284.11.1.el9_2.x86_64 #1
[61110.467513] Hardware name: HPE ProLiant DL385 Gen10 Plus v2/ProLiant DL385 Gen10 Plus v2, BIOS A42 08/17/2023
[61110.467515] Call Trace:
[61110.467516]  <TASK>
[61110.467519]  dump_stack_lvl+0x34/0x48
[61110.467526]  slab_err.cold+0x53/0x67
[61110.467534]  __kmem_cache_shutdown+0x16e/0x320
[61110.467540]  kmem_cache_destroy+0x51/0x160
[61110.467544]  qla2x00_module_exit+0x93/0x99 [qla2xxx]
[61110.467607]  ? __do_sys_delete_module.constprop.0+0x178/0x280
[61110.467613]  ? syscall_trace_enter.constprop.0+0x145/0x1d0
[61110.467616]  ? do_syscall_64+0x5c/0x90
[61110.467619]  ? exc_page_fault+0x62/0x150
[61110.467622]  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
[61110.467626]  </TASK>
[61110.467627] Disabling lock debugging due to kernel taint
[61110.467635] Object 0x0000000026f7e6e6 @offset=16000
[61110.467639] ------------[ cut here ]------------
[61110.467639] kmem_cache_destroy qla2xxx_srbs: Slab cache still has objects when called from qla2x00_module_exit+0x93/0x99 [qla2xxx]
[61110.467659] WARNING: CPU: 53 PID: 455206 at mm/slab_common.c:520 kmem_cache_destroy+0x14d/0x160
[61110.467718] CPU: 53 PID: 455206 Comm: rmmod Kdump: loaded Tainted: G    B      OE    --------  ---  5.14.0-284.11.1.el9_2.x86_64 #1
[61110.467720] Hardware name: HPE ProLiant DL385 Gen10 Plus v2/ProLiant DL385 Gen10 Plus v2, BIOS A42 08/17/2023
[61110.467721] RIP: 0010:kmem_cache_destroy+0x14d/0x160
[61110.467724] Code: 99 7d 07 00 48 89 ef e8 e1 6a 07 00 eb b3 48 8b 55 60 48 8b 4c 24 20 48 c7 c6 70 fc 66 90 48 c7 c7 f8 ef a1 90 e8 e1 ed 7c 00 <0f> 0b eb 93 c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 55 48 89
[61110.467725] RSP: 0018:ffffa304e489fe80 EFLAGS: 00010282
[61110.467727] RAX: 0000000000000000 RBX: ffffffffc0d9a860 RCX: 0000000000000027
[61110.467729] RDX: ffff8fd5ff9598a8 RSI: 0000000000000001 RDI: ffff8fd5ff9598a0
[61110.467730] RBP: ffff8fb6aaf78700 R08: 0000000000000000 R09: 0000000100d863b7
[61110.467731] R10: ffffa304e489fd20 R11: ffffffff913bef48 R12: 0000000040002000
[61110.467731] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[61110.467733] FS:  00007f64c89fb740(0000) GS:ffff8fd5ff940000(0000) knlGS:0000000000000000
[61110.467734] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[61110.467735] CR2: 00007f0f02bfe000 CR3: 00000020ad6dc005 CR4: 0000000000770ee0
[61110.467736] PKRU: 55555554
[61110.467737] Call Trace:
[61110.467738]  <TASK>
[61110.467739]  qla2x00_module_exit+0x93/0x99 [qla2xxx]
[61110.467755]  ? __do_sys_delete_module.constprop.0+0x178/0x280

Free sp in the error path to fix the crash.

Fixes: f352eeb75419 ("scsi: qla2xxx: Add ability to use GPNFT/GNNFT for RSCN handling")
Cc: stable@vger.kernel.org
Signed-off-by: Anil Gurumurthy <agurumurthy@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Himanshu Madhani <hmadhani2024@gmail.com>
Link: https://patch.msgid.link/20251210101604.431868-9-njavali@marvell.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_gs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 4895c04b5e69f..ea310ca8bd5e5 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3921,8 +3921,8 @@ int qla_fab_async_scan(scsi_qla_host_t *vha, srb_t *sp)
 	if (vha->scan.scan_flags & SF_SCANNING) {
 		spin_unlock_irqrestore(&vha->work_lock, flags);
 		ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0x2012,
-		    "%s: scan active\n", __func__);
-		return rval;
+		    "%s: scan active for sp:%p\n", __func__, sp);
+		goto done_free_sp;
 	}
 	vha->scan.scan_flags |= SF_SCANNING;
 	if (!sp)
-- 
2.51.0


