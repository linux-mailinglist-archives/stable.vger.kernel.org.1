Return-Path: <stable+bounces-174923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD363B365CF
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F49B564520
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1390B23A9A0;
	Tue, 26 Aug 2025 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yxbF6SlH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47B22139C9;
	Tue, 26 Aug 2025 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215673; cv=none; b=mLs8nJ5D9nZftBMkBJIm+c423Ax1ED5XuSVTy3gerfT2UQtfbWW3ASVATx1qBXuDfz/hdDsyeIAftPdt55R5al6AXjBjSwHGbFmTeP77R2Idjl+/4REabpmxCsBnnEg3AuVpybqQOoq4zF1nrmFQjrGEp7ITkm28qLdnoCpLlMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215673; c=relaxed/simple;
	bh=b1CPYhPjK8pO0sqLGRNO5ZMtiE/BpI2TPOuOn+bZWDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZeoRfkwIJLB5gzR8XZc8ERQIJnb5QHMEeP9tCNO4IeJ+Y+3IJwYRmLQS8vP6youDpp6J5NmSyb5KyOSvgTYMCfcxTbK/TaiI2pY7pj7rR6KY6utKBi5GhsweGdjR8yIBbnf+XGfE0pvWFwDs8Qk9pemVHBq0xcJPsXc/6Js3SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yxbF6SlH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5659CC113D0;
	Tue, 26 Aug 2025 13:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756215673;
	bh=b1CPYhPjK8pO0sqLGRNO5ZMtiE/BpI2TPOuOn+bZWDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yxbF6SlHx8TuP1YU+0rxP21pq5Asy0TFk+C2vZBGne7R+C7Xpc3IWVNkmZmMQP2/p
	 DmvdHdFKeq/+xFwN7LXHcXK9UibE0r+aOmYrtaes0YjxB7QNlV+Nqm3g2O9IfFbTDd
	 2hxtbuyiMu3lDPLnPdWVBHCIseET1QL6a58b8a8s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Denis OSTERLAND-HEIM <denis.osterland@diehl.com>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 121/644] pps: fix poll support
Date: Tue, 26 Aug 2025 13:03:32 +0200
Message-ID: <20250826110949.518277935@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>

[ Upstream commit 12c409aa1ec2592280a2ddcc66ff8f3c7f7bb171 ]

Because pps_cdev_poll() returns unconditionally EPOLLIN,
a user space program that calls select/poll get always an immediate data
ready-to-read response. As a result the intended use to wait until next
data becomes ready does not work.

User space snippet:

    struct pollfd pollfd = {
      .fd = open("/dev/pps0", O_RDONLY),
      .events = POLLIN|POLLERR,
      .revents = 0 };
    while(1) {
      poll(&pollfd, 1, 2000/*ms*/); // returns immediate, but should wait
      if(revents & EPOLLIN) { // always true
        struct pps_fdata fdata;
        memset(&fdata, 0, sizeof(memdata));
        ioctl(PPS_FETCH, &fdata); // currently fetches data at max speed
      }
    }

Lets remember the last fetch event counter and compare this value
in pps_cdev_poll() with most recent event counter
and return 0 if they are equal.

Signed-off-by: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
Co-developed-by: Rodolfo Giometti <giometti@enneenne.com>
Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
Fixes: eae9d2ba0cfc ("LinuxPPS: core support")
Link: https://lore.kernel.org/all/f6bed779-6d59-4f0f-8a59-b6312bd83b4e@enneenne.com/
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
Link: https://lore.kernel.org/r/c3c50ad1eb19ef553eca8a57c17f4c006413ab70.camel@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pps/pps.c          | 11 +++++++++--
 include/linux/pps_kernel.h |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 2d008e0d116a..ea966fc67d28 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -41,6 +41,9 @@ static __poll_t pps_cdev_poll(struct file *file, poll_table *wait)
 
 	poll_wait(file, &pps->queue, wait);
 
+	if (pps->last_fetched_ev == pps->last_ev)
+		return 0;
+
 	return EPOLLIN | EPOLLRDNORM;
 }
 
@@ -186,9 +189,11 @@ static long pps_cdev_ioctl(struct file *file,
 		if (err)
 			return err;
 
-		/* Return the fetched timestamp */
+		/* Return the fetched timestamp and save last fetched event  */
 		spin_lock_irq(&pps->lock);
 
+		pps->last_fetched_ev = pps->last_ev;
+
 		fdata.info.assert_sequence = pps->assert_sequence;
 		fdata.info.clear_sequence = pps->clear_sequence;
 		fdata.info.assert_tu = pps->assert_tu;
@@ -272,9 +277,11 @@ static long pps_cdev_compat_ioctl(struct file *file,
 		if (err)
 			return err;
 
-		/* Return the fetched timestamp */
+		/* Return the fetched timestamp and save last fetched event  */
 		spin_lock_irq(&pps->lock);
 
+		pps->last_fetched_ev = pps->last_ev;
+
 		compat.info.assert_sequence = pps->assert_sequence;
 		compat.info.clear_sequence = pps->clear_sequence;
 		compat.info.current_mode = pps->current_mode;
diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
index c7abce28ed29..aab0aebb529e 100644
--- a/include/linux/pps_kernel.h
+++ b/include/linux/pps_kernel.h
@@ -52,6 +52,7 @@ struct pps_device {
 	int current_mode;			/* PPS mode at event time */
 
 	unsigned int last_ev;			/* last PPS event id */
+	unsigned int last_fetched_ev;		/* last fetched PPS event id */
 	wait_queue_head_t queue;		/* PPS event queue */
 
 	unsigned int id;			/* PPS source unique ID */
-- 
2.39.5




