Return-Path: <stable+bounces-64518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C694F941E31
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ADB71F23DF5
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029651A76BE;
	Tue, 30 Jul 2024 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YtTGfwyV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ECC1A76B2;
	Tue, 30 Jul 2024 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360388; cv=none; b=IV1jt7/cYs5QHF/++b/JvsFSMtN+Pz8bLbFirIHM9yModAEV0G8PeRHeVbda7xApr4J6jVnUSA1exGNBYPlNQ/68wZF7V/qnvRwoKb+tvCW8W+Q1UVXKo11uhld/5g7Nad39BHmw7WBS4EwpAkWgxOFKjg/8q1UA9CRIeANd0so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360388; c=relaxed/simple;
	bh=FZ1kGbSFtHrecN9a//MgQICB/qD/CTgBbq81JIFRP+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JyZpRy3rOPh455Z29ond1DQk7tryd1W2iJgsTNd31QqrgGSSRp0bwZD9uogmC3ehcoCGNfg9Xd2WHnLzlQmZmvlc6Kzcn9VS1GrDXygTH2SHBG9BNaZbQjZlFDMoPMaRLfS8iHmhOaIOayNojgbHHYu4306AgeG72WuZzX6Shr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YtTGfwyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DF8C4AF0A;
	Tue, 30 Jul 2024 17:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722360388;
	bh=FZ1kGbSFtHrecN9a//MgQICB/qD/CTgBbq81JIFRP+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YtTGfwyVI10yrqCF5A/1YyXEMEigE8irIubTw3g1P4QkFExgHbmni2r3+3t8CfC9M
	 M74DC1TzT/jScOIk3jmU8SKEZLyCqv5sH9oQYZbPcBYpEedbCPTpXxufOJ7JNHw9nm
	 ssirGXH9nrHoveW2+Zf3f611pWRN7gd17DVoxXWA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manish Rangankar <mrangankar@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.10 683/809] scsi: qla2xxx: During vport delete send async logout explicitly
Date: Tue, 30 Jul 2024 17:49:19 +0200
Message-ID: <20240730151751.887139890@linuxfoundation.org>
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

From: Manish Rangankar <mrangankar@marvell.com>

commit 76f480d7c717368f29a3870f7d64471ce0ff8fb2 upstream.

During vport delete, it is observed that during unload we hit a crash
because of stale entries in outstanding command array.  For all these stale
I/O entries, eh_abort was issued and aborted (fast_fail_io = 2009h) but
I/Os could not complete while vport delete is in process of deleting.

  BUG: kernel NULL pointer dereference, address: 000000000000001c
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: 0000 [#1] PREEMPT SMP NOPTI
  Workqueue: qla2xxx_wq qla_do_work [qla2xxx]
  RIP: 0010:dma_direct_unmap_sg+0x51/0x1e0
  RSP: 0018:ffffa1e1e150fc68 EFLAGS: 00010046
  RAX: 0000000000000000 RBX: 0000000000000021 RCX: 0000000000000001
  RDX: 0000000000000021 RSI: 0000000000000000 RDI: ffff8ce208a7a0d0
  RBP: ffff8ce208a7a0d0 R08: 0000000000000000 R09: ffff8ce378aac9c8
  R10: ffff8ce378aac8a0 R11: ffffa1e1e150f9d8 R12: 0000000000000000
  R13: 0000000000000000 R14: ffff8ce378aac9c8 R15: 0000000000000000
  FS:  0000000000000000(0000) GS:ffff8d217f000000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 000000000000001c CR3: 0000002089acc000 CR4: 0000000000350ee0
  Call Trace:
  <TASK>
  qla2xxx_qpair_sp_free_dma+0x417/0x4e0
  ? qla2xxx_qpair_sp_compl+0x10d/0x1a0
  ? qla2x00_status_entry+0x768/0x2830
  ? newidle_balance+0x2f0/0x430
  ? dequeue_entity+0x100/0x3c0
  ? qla24xx_process_response_queue+0x6a1/0x19e0
  ? __schedule+0x2d5/0x1140
  ? qla_do_work+0x47/0x60
  ? process_one_work+0x267/0x440
  ? process_one_work+0x440/0x440
  ? worker_thread+0x2d/0x3d0
  ? process_one_work+0x440/0x440
  ? kthread+0x156/0x180
  ? set_kthread_struct+0x50/0x50
  ? ret_from_fork+0x22/0x30
  </TASK>

Send out async logout explicitly for all the ports during vport delete.

Cc: stable@vger.kernel.org
Signed-off-by: Manish Rangankar <mrangankar@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20240710171057.35066-8-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_mid.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -180,7 +180,7 @@ qla24xx_disable_vp(scsi_qla_host_t *vha)
 	atomic_set(&vha->loop_state, LOOP_DOWN);
 	atomic_set(&vha->loop_down_timer, LOOP_DOWN_TIME);
 	list_for_each_entry(fcport, &vha->vp_fcports, list)
-		fcport->logout_on_delete = 0;
+		fcport->logout_on_delete = 1;
 
 	if (!vha->hw->flags.edif_enabled)
 		qla2x00_wait_for_sess_deletion(vha);



