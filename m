Return-Path: <stable+bounces-20989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B73D85C69C
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C47E1C20FE9
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EBC151CD0;
	Tue, 20 Feb 2024 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hhkpe9uI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A3614F9DA;
	Tue, 20 Feb 2024 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463003; cv=none; b=aGlmagwoWinYYI1GhvlDnrwtM5zGfyuRWVlbiUv2/OWjSHRSY2wjTEvDzFCCwQ6GYlYHQ4KJX1xsrB/hVZx2qKS6aAfBvg/z8bAPFihn3Kqcbn8y4HpmmHeYfnlgk6MbHuL/auOrNLwCtnaDMGJmuXbrhqqETc/m+uK0yBEx1Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463003; c=relaxed/simple;
	bh=ASNGwt6pQ1RdASretdKUfruVxOJlirAbpyUizWmxo5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZVFEO56E3yHQO04EZp93BSS4Xoib9XZqGhIW1ukr4zT24sCOy96p/JTvKIOiQU12b+melP3/RqlkiVwsr4Cq+cD1C+BSxFcqjZcSOyxK2+ed0NNlpiAVmThCYsnzsG0ooFp2lEr7XfM+cwKH2eK0Ehcrs0+xb67mc0xYWTbAbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hhkpe9uI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F169C433C7;
	Tue, 20 Feb 2024 21:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708463003;
	bh=ASNGwt6pQ1RdASretdKUfruVxOJlirAbpyUizWmxo5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hhkpe9uIHLWsg9hbll8iOVc6ZTHbdmWSA2nYaJKDG4dUpa4jlh7Zkt4+HDU4vHx5y
	 fkjb33AmXNRCR/zyjUG56hbFRNQ+meYbjv92SrnIH+DaOR6/5W2gmyoY2H/pImMbMr
	 NF2i4fkPG1Ia7mN8U3OAwcXwI48rjoUK9R5o35ZE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lee Duncan <lduncan@suse.com>,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1 075/197] scsi: Revert "scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock"
Date: Tue, 20 Feb 2024 21:50:34 +0100
Message-ID: <20240220204843.322992450@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220204841.073267068@linuxfoundation.org>
References: <20240220204841.073267068@linuxfoundation.org>
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

From: Lee Duncan <lduncan@suse.com>

commit 977fe773dcc7098d8eaf4ee6382cb51e13e784cb upstream.

This reverts commit 1a1975551943f681772720f639ff42fbaa746212.

This commit causes interrupts to be lost for FCoE devices, since it changed
sping locks from "bh" to "irqsave".

Instead, a work queue should be used, and will be addressed in a separate
commit.

Fixes: 1a1975551943 ("scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock")
Signed-off-by: Lee Duncan <lduncan@suse.com>
Link: https://lore.kernel.org/r/c578cdcd46b60470535c4c4a953e6a1feca0dffd.1707500786.git.lduncan@suse.com
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/fcoe/fcoe_ctlr.c |   20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -319,17 +319,16 @@ static void fcoe_ctlr_announce(struct fc
 {
 	struct fcoe_fcf *sel;
 	struct fcoe_fcf *fcf;
-	unsigned long flags;
 
 	mutex_lock(&fip->ctlr_mutex);
-	spin_lock_irqsave(&fip->ctlr_lock, flags);
+	spin_lock_bh(&fip->ctlr_lock);
 
 	kfree_skb(fip->flogi_req);
 	fip->flogi_req = NULL;
 	list_for_each_entry(fcf, &fip->fcfs, list)
 		fcf->flogi_sent = 0;
 
-	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
+	spin_unlock_bh(&fip->ctlr_lock);
 	sel = fip->sel_fcf;
 
 	if (sel && ether_addr_equal(sel->fcf_mac, fip->dest_addr))
@@ -700,7 +699,6 @@ int fcoe_ctlr_els_send(struct fcoe_ctlr
 {
 	struct fc_frame *fp;
 	struct fc_frame_header *fh;
-	unsigned long flags;
 	u16 old_xid;
 	u8 op;
 	u8 mac[ETH_ALEN];
@@ -734,11 +732,11 @@ int fcoe_ctlr_els_send(struct fcoe_ctlr
 		op = FIP_DT_FLOGI;
 		if (fip->mode == FIP_MODE_VN2VN)
 			break;
-		spin_lock_irqsave(&fip->ctlr_lock, flags);
+		spin_lock_bh(&fip->ctlr_lock);
 		kfree_skb(fip->flogi_req);
 		fip->flogi_req = skb;
 		fip->flogi_req_send = 1;
-		spin_unlock_irqrestore(&fip->ctlr_lock, flags);
+		spin_unlock_bh(&fip->ctlr_lock);
 		schedule_work(&fip->timer_work);
 		return -EINPROGRESS;
 	case ELS_FDISC:
@@ -1707,11 +1705,10 @@ static int fcoe_ctlr_flogi_send_locked(s
 static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *fcf;
-	unsigned long flags;
 	int error;
 
 	mutex_lock(&fip->ctlr_mutex);
-	spin_lock_irqsave(&fip->ctlr_lock, flags);
+	spin_lock_bh(&fip->ctlr_lock);
 	LIBFCOE_FIP_DBG(fip, "re-sending FLOGI - reselect\n");
 	fcf = fcoe_ctlr_select(fip);
 	if (!fcf || fcf->flogi_sent) {
@@ -1722,7 +1719,7 @@ static int fcoe_ctlr_flogi_retry(struct
 		fcoe_ctlr_solicit(fip, NULL);
 		error = fcoe_ctlr_flogi_send_locked(fip);
 	}
-	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
+	spin_unlock_bh(&fip->ctlr_lock);
 	mutex_unlock(&fip->ctlr_mutex);
 	return error;
 }
@@ -1739,9 +1736,8 @@ static int fcoe_ctlr_flogi_retry(struct
 static void fcoe_ctlr_flogi_send(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *fcf;
-	unsigned long flags;
 
-	spin_lock_irqsave(&fip->ctlr_lock, flags);
+	spin_lock_bh(&fip->ctlr_lock);
 	fcf = fip->sel_fcf;
 	if (!fcf || !fip->flogi_req_send)
 		goto unlock;
@@ -1768,7 +1764,7 @@ static void fcoe_ctlr_flogi_send(struct
 	} else /* XXX */
 		LIBFCOE_FIP_DBG(fip, "No FCF selected - defer send\n");
 unlock:
-	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
+	spin_unlock_bh(&fip->ctlr_lock);
 }
 
 /**



