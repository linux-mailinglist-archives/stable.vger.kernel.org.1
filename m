Return-Path: <stable+bounces-86256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DC499ECC7
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCDC42839F6
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F173E1C4A08;
	Tue, 15 Oct 2024 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qxIr2TlW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE04F1B2185;
	Tue, 15 Oct 2024 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998297; cv=none; b=lLOhZaoBs+R2UqehW+CGP9CfFsG2GmMoJ8OUY3QSCXQp1bRUgiFNIeqTgLw8Am9uNRMCSr2wnt8N7Thu6lcE/xcCjuSN+K9ZBEw/aS73e1XdiFcAvuhs6cUs2JT4NafBMa8I7B+ryiEsVhQ1ntT4m+w/rmfr/69eBQBBdpado/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998297; c=relaxed/simple;
	bh=V9JjkziwN2MvpqBKzOd2fL7Has1GBVeg8LMTxOkWm0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTNmzMs/vBZID8rFOl7nd4YVYICmdpPaA24ZB7k6dZhO5fSr3M3rww0ZYQkH+xmr6Jh22dVnR2QFHSPETVG0AWHgsVdoxZLpfI+5N2muKrdkk5SHMtt6gSiIhTktfeXeteu6AeNnHT+AGBcTdkfpYdMYWb+H4I8esW/gqFGU+po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qxIr2TlW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5C3C4CEC6;
	Tue, 15 Oct 2024 13:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728998297;
	bh=V9JjkziwN2MvpqBKzOd2fL7Has1GBVeg8LMTxOkWm0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qxIr2TlWr/h/QgBlSwKkHg9ycv6qQc74LtYz2eMOPmXjKu1frN4ZVwvwHDxvfY7jt
	 QME50w//imPopTTceqa1PqEJLivxj+/KOd46qiIk7FxqwPy7XL7NmiVOsf0U2VD0sn
	 wMx/skZxORJqNCCFqGxPRtHnJhMcwu45abi0xfoI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haoran Zhang <wh1sper@zju.edu.cn>,
	Mike Christie <michael.christie@oracle.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 5.10 435/518] vhost/scsi: null-ptr-dereference in vhost_scsi_get_req()
Date: Tue, 15 Oct 2024 14:45:39 +0200
Message-ID: <20241015123933.786458583@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haoran Zhang <wh1sper@zju.edu.cn>

commit 221af82f606d928ccef19a16d35633c63026f1be upstream.

Since commit 3f8ca2e115e5 ("vhost/scsi: Extract common handling code
from control queue handler") a null pointer dereference bug can be
triggered when guest sends an SCSI AN request.

In vhost_scsi_ctl_handle_vq(), `vc.target` is assigned with
`&v_req.tmf.lun[1]` within a switch-case block and is then passed to
vhost_scsi_get_req() which extracts `vc->req` and `tpg`. However, for
a `VIRTIO_SCSI_T_AN_*` request, tpg is not required, so `vc.target` is
set to NULL in this branch. Later, in vhost_scsi_get_req(),
`vc->target` is dereferenced without being checked, leading to a null
pointer dereference bug. This bug can be triggered from guest.

When this bug occurs, the vhost_worker process is killed while holding
`vq->mutex` and the corresponding tpg will remain occupied
indefinitely.

Below is the KASAN report:
Oops: general protection fault, probably for non-canonical address
0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 840 Comm: poc Not tainted 6.10.0+ #1
Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS
1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:vhost_scsi_get_req+0x165/0x3a0
Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 2b 02 00 00
48 b8 00 00 00 00 00 fc ff df 4d 8b 65 30 4c 89 e2 48 c1 ea 03 <0f> b6
04 02 4c 89 e2 83 e2 07 38 d0 7f 08 84 c0 0f 85 be 01 00 00
RSP: 0018:ffff888017affb50 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff88801b000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888017affcb8
RBP: ffff888017affb80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff888017affc88 R14: ffff888017affd1c R15: ffff888017993000
FS:  000055556e076500(0000) GS:ffff88806b100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200027c0 CR3: 0000000010ed0004 CR4: 0000000000370ef0
Call Trace:
 <TASK>
 ? show_regs+0x86/0xa0
 ? die_addr+0x4b/0xd0
 ? exc_general_protection+0x163/0x260
 ? asm_exc_general_protection+0x27/0x30
 ? vhost_scsi_get_req+0x165/0x3a0
 vhost_scsi_ctl_handle_vq+0x2a4/0xca0
 ? __pfx_vhost_scsi_ctl_handle_vq+0x10/0x10
 ? __switch_to+0x721/0xeb0
 ? __schedule+0xda5/0x5710
 ? __kasan_check_write+0x14/0x30
 ? _raw_spin_lock+0x82/0xf0
 vhost_scsi_ctl_handle_kick+0x52/0x90
 vhost_run_work_list+0x134/0x1b0
 vhost_task_fn+0x121/0x350
...
 </TASK>
---[ end trace 0000000000000000 ]---

Let's add a check in vhost_scsi_get_req.

Fixes: 3f8ca2e115e5 ("vhost/scsi: Extract common handling code from control queue handler")
Signed-off-by: Haoran Zhang <wh1sper@zju.edu.cn>
[whitespace fixes]
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Message-Id: <b26d7ddd-b098-4361-88f8-17ca7f90adf7@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/scsi.c |   25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -919,20 +919,23 @@ vhost_scsi_get_req(struct vhost_virtqueu
 		/* virtio-scsi spec requires byte 0 of the lun to be 1 */
 		vq_err(vq, "Illegal virtio-scsi lun: %u\n", *vc->lunp);
 	} else {
-		struct vhost_scsi_tpg **vs_tpg, *tpg;
+		struct vhost_scsi_tpg **vs_tpg, *tpg = NULL;
 
-		vs_tpg = vhost_vq_get_backend(vq);	/* validated at handler entry */
-
-		tpg = READ_ONCE(vs_tpg[*vc->target]);
-		if (unlikely(!tpg)) {
-			vq_err(vq, "Target 0x%x does not exist\n", *vc->target);
-		} else {
-			if (tpgp)
-				*tpgp = tpg;
-			ret = 0;
+		if (vc->target) {
+			/* validated at handler entry */
+			vs_tpg = vhost_vq_get_backend(vq);
+			tpg = READ_ONCE(vs_tpg[*vc->target]);
+			if (unlikely(!tpg)) {
+				vq_err(vq, "Target 0x%x does not exist\n", *vc->target);
+				goto out;
+			}
 		}
-	}
 
+		if (tpgp)
+			*tpgp = tpg;
+		ret = 0;
+	}
+out:
 	return ret;
 }
 



