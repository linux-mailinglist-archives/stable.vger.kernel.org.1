Return-Path: <stable+bounces-147029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBE4AC55DD
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6664A4909
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE1227D766;
	Tue, 27 May 2025 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RKvhJAgK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C868278750;
	Tue, 27 May 2025 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748366053; cv=none; b=bt1l36rDJF+NS75ClyF9Jsbr4bkngufFpvCcwwMrVol6O7xTg748cjm2omw+qt/mZWWBdeV40vknWyT9pDEHOUQOQgrVNQBh3X89ZIWCxJt6Dwllu3wCxFP7bGNv4kpng6DJA2nr26qu2tHEg5hFK/sYEqUM0OgTOty44LJslXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748366053; c=relaxed/simple;
	bh=Rei3Ll0eH4Sl4bJbZaBJxH5Vxl+m95N0cumP5V+SWHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zdtemnd0sAXJK4VHmvA40kwKWGviwzbhCCMGoMeo7L3qHViTjWkk123o3+Ii3ylzaBrazVagu4iHc0Ncc01uYn9EV72eCLW99W20KcpZbHhXdhMAJ8nN5aKc8ArAdKznMGUojTAEmVhN7X+1lawwuMjusmVqgesXuMKHOIMo3tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RKvhJAgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09E8C4CEE9;
	Tue, 27 May 2025 17:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748366053;
	bh=Rei3Ll0eH4Sl4bJbZaBJxH5Vxl+m95N0cumP5V+SWHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RKvhJAgKg1Wj2ax0zDRKQxXSHsAXFLMlKJ+Zl8AI+v6Cxr3upRaUGWYYwgZ14/Z6O
	 v+gFWFKrNvJ4kgPT0akwUXoThdKnNJNkHBZvY1QRS5QxnBYcl0At9MF40zbUkuyUyG
	 Q1NVn0QqyRVeqQtyrJMezbH/cTl+DNnwxehni934=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anderson Nascimento <anderson@allelesecurity.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.12 574/626] can: bcm: add missing rcu read protection for procfs content
Date: Tue, 27 May 2025 18:27:47 +0200
Message-ID: <20250527162508.295510218@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Hartkopp <socketcan@hartkopp.net>

commit dac5e6249159ac255dad9781793dbe5908ac9ddb upstream.

When the procfs content is generated for a bcm_op which is in the process
to be removed the procfs output might show unreliable data (UAF).

As the removal of bcm_op's is already implemented with rcu handling this
patch adds the missing rcu_read_lock() and makes sure the list entries
are properly removed under rcu protection.

Fixes: f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly synchronize_rcu()")
Reported-by: Anderson Nascimento <anderson@allelesecurity.com>
Suggested-by: Anderson Nascimento <anderson@allelesecurity.com>
Tested-by: Anderson Nascimento <anderson@allelesecurity.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20250519125027.11900-2-socketcan@hartkopp.net
Cc: stable@vger.kernel.org # >= 5.4
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/can/bcm.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -219,7 +219,9 @@ static int bcm_proc_show(struct seq_file
 	seq_printf(m, " / bound %s", bcm_proc_getifname(net, ifname, bo->ifindex));
 	seq_printf(m, " <<<\n");
 
-	list_for_each_entry(op, &bo->rx_ops, list) {
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(op, &bo->rx_ops, list) {
 
 		unsigned long reduction;
 
@@ -275,6 +277,9 @@ static int bcm_proc_show(struct seq_file
 		seq_printf(m, "# sent %ld\n", op->frames_abs);
 	}
 	seq_putc(m, '\n');
+
+	rcu_read_unlock();
+
 	return 0;
 }
 #endif /* CONFIG_PROC_FS */
@@ -858,7 +863,7 @@ static int bcm_delete_rx_op(struct list_
 						  REGMASK(op->can_id),
 						  bcm_rx_handler, op);
 
-			list_del(&op->list);
+			list_del_rcu(&op->list);
 			bcm_remove_op(op);
 			return 1; /* done */
 		}
@@ -878,7 +883,7 @@ static int bcm_delete_tx_op(struct list_
 	list_for_each_entry_safe(op, n, ops, list) {
 		if ((op->can_id == mh->can_id) && (op->ifindex == ifindex) &&
 		    (op->flags & CAN_FD_FRAME) == (mh->flags & CAN_FD_FRAME)) {
-			list_del(&op->list);
+			list_del_rcu(&op->list);
 			bcm_remove_op(op);
 			return 1; /* done */
 		}
@@ -1300,7 +1305,7 @@ static int bcm_rx_setup(struct bcm_msg_h
 					      bcm_rx_handler, op, "bcm", sk);
 		if (err) {
 			/* this bcm rx op is broken -> remove it */
-			list_del(&op->list);
+			list_del_rcu(&op->list);
 			bcm_remove_op(op);
 			return err;
 		}



