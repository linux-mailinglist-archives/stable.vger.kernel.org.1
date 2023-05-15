Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B05703472
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242983AbjEOQsc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243026AbjEOQs1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:48:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1845264
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:48:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45F676293A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43962C433EF;
        Mon, 15 May 2023 16:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169293;
        bh=+2yp2JZNnH3vb7kUTFV1x1f0Lj4yA0UeVTtFeSiOoFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ahuz9yrsKmQWw7ldpw4ZX6y9Pt3twwQf5urLDkD974y4ccPALjHkIob3vbDAurjVa
         jzBWVM9enbn0pqQl1HB4yJYsAE5VoCPfnFgLu4GE6ASxhJpvS+bCqVG83gOltjsHBP
         Kg6dCeWcpAgyCgBQwQOLzbmQrQNERi83tjlRrJUM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Can Guo <quic_cang@quicinc.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Alice Chao <alice.chao@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 013/246] scsi: ufs: core: mcq: Fix &hwq->cq_lock deadlock issue
Date:   Mon, 15 May 2023 18:23:45 +0200
Message-Id: <20230515161723.012143659@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alice Chao <alice.chao@mediatek.com>

[ Upstream commit 948afc69615167a3c82430f99bfd046332b89912 ]

When ufshcd_err_handler() is executed, CQ event interrupt can enter waiting
for the same lock. This can happen in ufshcd_handle_mcq_cq_events() and
also in ufs_mtk_mcq_intr(). The following warning message will be generated
when &hwq->cq_lock is used in IRQ context with IRQ enabled. Use
ufshcd_mcq_poll_cqe_lock() with spin_lock_irqsave instead of spin_lock to
resolve the deadlock issue.

[name:lockdep&]WARNING: inconsistent lock state
[name:lockdep&]--------------------------------
[name:lockdep&]inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
[name:lockdep&]kworker/u16:4/260 [HC0[0]:SC0[0]:HE1:SE1] takes:
  ffffff8028444600 (&hwq->cq_lock){?.-.}-{2:2}, at:
ufshcd_mcq_poll_cqe_lock+0x30/0xe0
[name:lockdep&]{IN-HARDIRQ-W} state was registered at:
  lock_acquire+0x17c/0x33c
  _raw_spin_lock+0x5c/0x7c
  ufshcd_mcq_poll_cqe_lock+0x30/0xe0
  ufs_mtk_mcq_intr+0x60/0x1bc [ufs_mediatek_mod]
  __handle_irq_event_percpu+0x140/0x3ec
  handle_irq_event+0x50/0xd8
  handle_fasteoi_irq+0x148/0x2b0
  generic_handle_domain_irq+0x4c/0x6c
  gic_handle_irq+0x58/0x134
  call_on_irq_stack+0x40/0x74
  do_interrupt_handler+0x84/0xe4
  el1_interrupt+0x3c/0x78
<snip>

Possible unsafe locking scenario:
       CPU0
       ----
  lock(&hwq->cq_lock);
  <Interrupt>
    lock(&hwq->cq_lock);
  *** DEADLOCK ***
2 locks held by kworker/u16:4/260:

[name:lockdep&]
 stack backtrace:
CPU: 7 PID: 260 Comm: kworker/u16:4 Tainted: G S      W  OE
6.1.17-mainline-android14-2-g277223301adb #1
Workqueue: ufs_eh_wq_0 ufshcd_err_handler

 Call trace:
  dump_backtrace+0x10c/0x160
  show_stack+0x20/0x30
  dump_stack_lvl+0x98/0xd8
  dump_stack+0x20/0x60
  print_usage_bug+0x584/0x76c
  mark_lock_irq+0x488/0x510
  mark_lock+0x1ec/0x25c
  __lock_acquire+0x4d8/0xffc
  lock_acquire+0x17c/0x33c
  _raw_spin_lock+0x5c/0x7c
  ufshcd_mcq_poll_cqe_lock+0x30/0xe0
  ufshcd_poll+0x68/0x1b0
  ufshcd_transfer_req_compl+0x9c/0xc8
  ufshcd_err_handler+0x3bc/0xea0
  process_one_work+0x2f4/0x7e8
  worker_thread+0x234/0x450
  kthread+0x110/0x134
  ret_from_fork+0x10/0x20

Fixes: ed975065c31c ("scsi: ufs: core: mcq: Add completion support in poll")
Reviewed-by: Can Guo <quic_cang@quicinc.com>
Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Alice Chao <alice.chao@mediatek.com>
Link: https://lore.kernel.org/r/20230424080400.8955-1-alice.chao@mediatek.com
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufs-mcq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 31df052fbc417..202ff71e1b582 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -299,11 +299,11 @@ EXPORT_SYMBOL_GPL(ufshcd_mcq_poll_cqe_nolock);
 unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
 				       struct ufs_hw_queue *hwq)
 {
-	unsigned long completed_reqs;
+	unsigned long completed_reqs, flags;
 
-	spin_lock(&hwq->cq_lock);
+	spin_lock_irqsave(&hwq->cq_lock, flags);
 	completed_reqs = ufshcd_mcq_poll_cqe_nolock(hba, hwq);
-	spin_unlock(&hwq->cq_lock);
+	spin_unlock_irqrestore(&hwq->cq_lock, flags);
 
 	return completed_reqs;
 }
-- 
2.39.2



