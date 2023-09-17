Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BA07A3C5B
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240997AbjIQU3z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241054AbjIQU3r (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:29:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFA510B
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:29:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13719C433C7;
        Sun, 17 Sep 2023 20:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982581;
        bh=3/7SNU99+q6Xv7kU7AxqmlFKT9p1AD0Y+/qK9A6EHrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o/0kUS3S4yTId72aQ7Emfa5xRkND5mivdSYK705eLKdbw5UbFuyu6PjLvbM4UpJJ5
         FL/UbAGFWxJHNTt4i4HH6An435qQsW2XGxu7iyrqEWO7kbD1hCfuT7TJLi5ynvZ7lT
         D3i/A79nl+fdWmUcuFoEY3fg74HX8r92cDhqqDm4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chengfeng Ye <dg573847474@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 292/511] scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock
Date:   Sun, 17 Sep 2023 21:11:59 +0200
Message-ID: <20230917191120.891421208@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengfeng Ye <dg573847474@gmail.com>

[ Upstream commit 1a1975551943f681772720f639ff42fbaa746212 ]

There is a long call chain that &fip->ctlr_lock is acquired by isr
fnic_isr_msix_wq_copy() under hard IRQ context. Thus other process context
code acquiring the lock should disable IRQ, otherwise deadlock could happen
if the IRQ preempts the execution while the lock is held in process context
on the same CPU.

[ISR]
fnic_isr_msix_wq_copy()
 -> fnic_wq_copy_cmpl_handler()
 -> fnic_fcpio_cmpl_handler()
 -> fnic_fcpio_flogi_reg_cmpl_handler()
 -> fnic_flush_tx()
 -> fnic_send_frame()
 -> fcoe_ctlr_els_send()
 -> spin_lock_bh(&fip->ctlr_lock)

[Process Context]
1. fcoe_ctlr_timer_work()
 -> fcoe_ctlr_flogi_send()
 -> spin_lock_bh(&fip->ctlr_lock)

2. fcoe_ctlr_recv_work()
 -> fcoe_ctlr_recv_handler()
 -> fcoe_ctlr_recv_els()
 -> fcoe_ctlr_announce()
 -> spin_lock_bh(&fip->ctlr_lock)

3. fcoe_ctlr_recv_work()
 -> fcoe_ctlr_recv_handler()
 -> fcoe_ctlr_recv_els()
 -> fcoe_ctlr_flogi_retry()
 -> spin_lock_bh(&fip->ctlr_lock)

4. -> fcoe_xmit()
 -> fcoe_ctlr_els_send()
 -> spin_lock_bh(&fip->ctlr_lock)

spin_lock_bh() is not enough since fnic_isr_msix_wq_copy() is a
hardirq.

These flaws were found by an experimental static analysis tool I am
developing for irq-related deadlock.

The patch fix the potential deadlocks by spin_lock_irqsave() to disable
hard irq.

Fixes: 794d98e77f59 ("[SCSI] libfcoe: retry rejected FLOGI to another FCF if possible")
Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
Link: https://lore.kernel.org/r/20230817074708.7509-1-dg573847474@gmail.com
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/fcoe/fcoe_ctlr.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 558f3f4e18593..303ecbd86b68a 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -319,16 +319,17 @@ static void fcoe_ctlr_announce(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *sel;
 	struct fcoe_fcf *fcf;
+	unsigned long flags;
 
 	mutex_lock(&fip->ctlr_mutex);
-	spin_lock_bh(&fip->ctlr_lock);
+	spin_lock_irqsave(&fip->ctlr_lock, flags);
 
 	kfree_skb(fip->flogi_req);
 	fip->flogi_req = NULL;
 	list_for_each_entry(fcf, &fip->fcfs, list)
 		fcf->flogi_sent = 0;
 
-	spin_unlock_bh(&fip->ctlr_lock);
+	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
 	sel = fip->sel_fcf;
 
 	if (sel && ether_addr_equal(sel->fcf_mac, fip->dest_addr))
@@ -699,6 +700,7 @@ int fcoe_ctlr_els_send(struct fcoe_ctlr *fip, struct fc_lport *lport,
 {
 	struct fc_frame *fp;
 	struct fc_frame_header *fh;
+	unsigned long flags;
 	u16 old_xid;
 	u8 op;
 	u8 mac[ETH_ALEN];
@@ -732,11 +734,11 @@ int fcoe_ctlr_els_send(struct fcoe_ctlr *fip, struct fc_lport *lport,
 		op = FIP_DT_FLOGI;
 		if (fip->mode == FIP_MODE_VN2VN)
 			break;
-		spin_lock_bh(&fip->ctlr_lock);
+		spin_lock_irqsave(&fip->ctlr_lock, flags);
 		kfree_skb(fip->flogi_req);
 		fip->flogi_req = skb;
 		fip->flogi_req_send = 1;
-		spin_unlock_bh(&fip->ctlr_lock);
+		spin_unlock_irqrestore(&fip->ctlr_lock, flags);
 		schedule_work(&fip->timer_work);
 		return -EINPROGRESS;
 	case ELS_FDISC:
@@ -1713,10 +1715,11 @@ static int fcoe_ctlr_flogi_send_locked(struct fcoe_ctlr *fip)
 static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *fcf;
+	unsigned long flags;
 	int error;
 
 	mutex_lock(&fip->ctlr_mutex);
-	spin_lock_bh(&fip->ctlr_lock);
+	spin_lock_irqsave(&fip->ctlr_lock, flags);
 	LIBFCOE_FIP_DBG(fip, "re-sending FLOGI - reselect\n");
 	fcf = fcoe_ctlr_select(fip);
 	if (!fcf || fcf->flogi_sent) {
@@ -1727,7 +1730,7 @@ static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 		fcoe_ctlr_solicit(fip, NULL);
 		error = fcoe_ctlr_flogi_send_locked(fip);
 	}
-	spin_unlock_bh(&fip->ctlr_lock);
+	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
 	mutex_unlock(&fip->ctlr_mutex);
 	return error;
 }
@@ -1744,8 +1747,9 @@ static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 static void fcoe_ctlr_flogi_send(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *fcf;
+	unsigned long flags;
 
-	spin_lock_bh(&fip->ctlr_lock);
+	spin_lock_irqsave(&fip->ctlr_lock, flags);
 	fcf = fip->sel_fcf;
 	if (!fcf || !fip->flogi_req_send)
 		goto unlock;
@@ -1772,7 +1776,7 @@ static void fcoe_ctlr_flogi_send(struct fcoe_ctlr *fip)
 	} else /* XXX */
 		LIBFCOE_FIP_DBG(fip, "No FCF selected - defer send\n");
 unlock:
-	spin_unlock_bh(&fip->ctlr_lock);
+	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
 }
 
 /**
-- 
2.40.1



