Return-Path: <stable+bounces-63815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C35941AC7
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01AA81C22A82
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4857183CD5;
	Tue, 30 Jul 2024 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dVnytoTz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814A81448FA;
	Tue, 30 Jul 2024 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358040; cv=none; b=SlBKBZ4mIQXexBEiZ0u62FDCSbU3VfugAjuz+Bkx3HU/jQLptzl/sc+rL5wBBYy3PXHZTbTf4LmAerS2fgTPwCslhGZEQtonTr4DA4hCrvIYrg4+OtLEy/c3elG+gC/2nPD87/eD04Zlk0DB3NqysWpZWTzKetdpji+JqWY59G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358040; c=relaxed/simple;
	bh=1gRndLNCQkM1vlIVLYr22f5Qbb1CluSiZqRF0gmzw1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPtH0yns2t+ULzUawIhFoCavUq18m62Q7nmENiXBqJJ3y/NtWXTPF0fz1SdRzhtwtsJHdUOn7zldbNeL987ko+P04DEj8V2pMy7hZB1SgrrMP17eLzCyxsG1HKaCibjX/ZWJL5bBYJ9/2gE1ppp7vkUqGmCglyZztHBid6h7fao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dVnytoTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08742C32782;
	Tue, 30 Jul 2024 16:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722358040;
	bh=1gRndLNCQkM1vlIVLYr22f5Qbb1CluSiZqRF0gmzw1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dVnytoTzqZDRZAe432Mg5xSiER1nFYqI5cQnGLX03PUnxfegjoT3EvNeWn6g1CGee
	 F7ucLYlmfvHmtU111WZgwUkKZn/wVuV2DGWzysgWFGJ4so8fiDhejZSq+j0wzcZAL1
	 +PzzRJNtUAeNv7fdZ8DUGZ398NSVz0V/yn1K7/rQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shreyas Deodhar <sdeodhar@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1 351/440] scsi: qla2xxx: Complete command early within lock
Date: Tue, 30 Jul 2024 17:49:44 +0200
Message-ID: <20240730151629.529894982@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shreyas Deodhar <sdeodhar@marvell.com>

commit 4475afa2646d3fec176fc4d011d3879b26cb26e3 upstream.

A crash was observed while performing NPIV and FW reset,

 BUG: kernel NULL pointer dereference, address: 000000000000001c
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 1 PREEMPT_RT SMP NOPTI
 RIP: 0010:dma_direct_unmap_sg+0x51/0x1e0
 RSP: 0018:ffffc90026f47b88 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: 0000000000000021 RCX: 0000000000000002
 RDX: 0000000000000021 RSI: 0000000000000000 RDI: ffff8881041130d0
 RBP: ffff8881041130d0 R08: 0000000000000000 R09: 0000000000000034
 R10: ffffc90026f47c48 R11: 0000000000000031 R12: 0000000000000000
 R13: 0000000000000000 R14: ffff8881565e4a20 R15: 0000000000000000
 FS: 00007f4c69ed3d00(0000) GS:ffff889faac80000(0000) knlGS:0000000000000000
 CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000000000000001c CR3: 0000000288a50002 CR4: 00000000007706e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
 <TASK>
 ? __die_body+0x1a/0x60
 ? page_fault_oops+0x16f/0x4a0
 ? do_user_addr_fault+0x174/0x7f0
 ? exc_page_fault+0x69/0x1a0
 ? asm_exc_page_fault+0x22/0x30
 ? dma_direct_unmap_sg+0x51/0x1e0
 ? preempt_count_sub+0x96/0xe0
 qla2xxx_qpair_sp_free_dma+0x29f/0x3b0 [qla2xxx]
 qla2xxx_qpair_sp_compl+0x60/0x80 [qla2xxx]
 __qla2x00_abort_all_cmds+0xa2/0x450 [qla2xxx]

The command completion was done early while aborting the commands in driver
unload path but outside lock to avoid the WARN_ON condition of performing
dma_free_attr within the lock. However this caused race condition while
command completion via multiple paths causing system crash.

Hence complete the command early in unload path but within the lock to
avoid race condition.

Fixes: 0367076b0817 ("scsi: qla2xxx: Perform lockless command completion in abort path")
Cc: stable@vger.kernel.org
Signed-off-by: Shreyas Deodhar <sdeodhar@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20240710171057.35066-7-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_os.c |    5 -----
 1 file changed, 5 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1869,14 +1869,9 @@ __qla2x00_abort_all_cmds(struct qla_qpai
 	for (cnt = 1; cnt < req->num_outstanding_cmds; cnt++) {
 		sp = req->outstanding_cmds[cnt];
 		if (sp) {
-			/*
-			 * perform lockless completion during driver unload
-			 */
 			if (qla2x00_chip_is_down(vha)) {
 				req->outstanding_cmds[cnt] = NULL;
-				spin_unlock_irqrestore(qp->qp_lock_ptr, flags);
 				sp->done(sp, res);
-				spin_lock_irqsave(qp->qp_lock_ptr, flags);
 				continue;
 			}
 



