Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3077A7CC3
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbjITMD4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbjITMDz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:03:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210FB93
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:03:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F63DC433C7;
        Wed, 20 Sep 2023 12:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211428;
        bh=/u8PCFBa51Sz7vvIiWlc3zcRC3kVAlP/mUJ+V6vyBP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MZN5ljTzE4pVb5J+tctfYCNu01dby4Sd6idMs03kBzb09S+Yx3VUPUdVCN4V0B6qU
         ZMDeJQcVvRSyJQUGN8aZ/czoaUUpFOSH32EmthcQdJp2rHUXga7US4Zg6wnBSCMdsZ
         czVgNPXJmdCK3hhB9WvvTHvnGYeAon6hL4+0PI7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chengfeng Ye <dg573847474@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 090/186] scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock
Date:   Wed, 20 Sep 2023 13:29:53 +0200
Message-ID: <20230920112840.169303254@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 1c8fa41aa3ab7..57826f7bb9f2a 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -330,16 +330,17 @@ static void fcoe_ctlr_announce(struct fcoe_ctlr *fip)
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
@@ -709,6 +710,7 @@ int fcoe_ctlr_els_send(struct fcoe_ctlr *fip, struct fc_lport *lport,
 {
 	struct fc_frame *fp;
 	struct fc_frame_header *fh;
+	unsigned long flags;
 	u16 old_xid;
 	u8 op;
 	u8 mac[ETH_ALEN];
@@ -742,11 +744,11 @@ int fcoe_ctlr_els_send(struct fcoe_ctlr *fip, struct fc_lport *lport,
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
@@ -1723,10 +1725,11 @@ static int fcoe_ctlr_flogi_send_locked(struct fcoe_ctlr *fip)
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
@@ -1737,7 +1740,7 @@ static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 		fcoe_ctlr_solicit(fip, NULL);
 		error = fcoe_ctlr_flogi_send_locked(fip);
 	}
-	spin_unlock_bh(&fip->ctlr_lock);
+	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
 	mutex_unlock(&fip->ctlr_mutex);
 	return error;
 }
@@ -1754,8 +1757,9 @@ static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 static void fcoe_ctlr_flogi_send(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *fcf;
+	unsigned long flags;
 
-	spin_lock_bh(&fip->ctlr_lock);
+	spin_lock_irqsave(&fip->ctlr_lock, flags);
 	fcf = fip->sel_fcf;
 	if (!fcf || !fip->flogi_req_send)
 		goto unlock;
@@ -1782,7 +1786,7 @@ static void fcoe_ctlr_flogi_send(struct fcoe_ctlr *fip)
 	} else /* XXX */
 		LIBFCOE_FIP_DBG(fip, "No FCF selected - defer send\n");
 unlock:
-	spin_unlock_bh(&fip->ctlr_lock);
+	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
 }
 
 /**
-- 
2.40.1



