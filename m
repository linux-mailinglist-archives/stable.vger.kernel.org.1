Return-Path: <stable+bounces-48781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F628FEA7F
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B581F245B8
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54E21A01C0;
	Thu,  6 Jun 2024 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WZ6SGXYX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ABF1A01AF;
	Thu,  6 Jun 2024 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683144; cv=none; b=i5oaTHG7stO+okKt33jQcBV56IinFoMLXahPDgt9v1y9luJAQDzpLw2DmS/SbsIaBhAgigz0A0f9UJQRBjB3yghMQjddLFycBAmRqfOB9X2IbFEbBJDOLSQMUROH1MjaNhUWEagvcaWsZ2XIRjex2oNOy5yWGhFY3YJOaVVpKKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683144; c=relaxed/simple;
	bh=BgBjieV6+WDkR0G6F/IeLce9wWNhDHkW3WjiIQ1vb+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pn4fc4Vsj+rbVbF5+JX/EbDtk4i+Wy95t4iinAfDL6+gT8pawvifZTl4l1Wz5Yx5PItxOem8CIGJ+BRC26PqvhychU/ohjKI4MDp8UBxKdT0LdjbjczLho4RLEX4q9/aZydsIfmjJjg1ZrVr1pePFhxcD1rnwpyO5AB9D8DG2aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WZ6SGXYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6394DC2BD10;
	Thu,  6 Jun 2024 14:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683144;
	bh=BgBjieV6+WDkR0G6F/IeLce9wWNhDHkW3WjiIQ1vb+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WZ6SGXYXwJ1BIByBahjXs8WqNf8fGwercwHdakofw/liO98qMd3tSQK4RvZMvW+jy
	 sJ4RcoNwSm5B85HBCjHCGT0ZTJgMT4e1QcJAraIHHL3DsQvIhEuQq+4nT+4uPOtjeE
	 LwO9ZqXYEPAGCtJxB15IJoCjZDZVfo7mQ/f2O3iY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	syzbot+e3973c409251e136fdd0@syzkaller.appspotmail.com,
	"Bai, Shuangpeng" <sjb7183@psu.edu>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 016/473] nilfs2: fix potential hang in nilfs_detach_log_writer()
Date: Thu,  6 Jun 2024 15:59:05 +0200
Message-ID: <20240606131700.379814906@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
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

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

commit eb85dace897c5986bc2f36b3c783c6abb8a4292e upstream.

Syzbot has reported a potential hang in nilfs_detach_log_writer() called
during nilfs2 unmount.

Analysis revealed that this is because nilfs_segctor_sync(), which
synchronizes with the log writer thread, can be called after
nilfs_segctor_destroy() terminates that thread, as shown in the call trace
below:

nilfs_detach_log_writer
  nilfs_segctor_destroy
    nilfs_segctor_kill_thread  --> Shut down log writer thread
    flush_work
      nilfs_iput_work_func
        nilfs_dispose_list
          iput
            nilfs_evict_inode
              nilfs_transaction_commit
                nilfs_construct_segment (if inode needs sync)
                  nilfs_segctor_sync  --> Attempt to synchronize with
                                          log writer thread
                           *** DEADLOCK ***

Fix this issue by changing nilfs_segctor_sync() so that the log writer
thread returns normally without synchronizing after it terminates, and by
forcing tasks that are already waiting to complete once after the thread
terminates.

The skipped inode metadata flushout will then be processed together in the
subsequent cleanup work in nilfs_segctor_destroy().

Link: https://lkml.kernel.org/r/20240520132621.4054-4-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+e3973c409251e136fdd0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e3973c409251e136fdd0
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Cc: "Bai, Shuangpeng" <sjb7183@psu.edu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nilfs2/segment.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2229,6 +2229,14 @@ static int nilfs_segctor_sync(struct nil
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
+		/*
+		 * Synchronize only while the log writer thread is alive.
+		 * Leave flushing out after the log writer thread exits to
+		 * the cleanup work in nilfs_segctor_destroy().
+		 */
+		if (!sci->sc_task)
+			break;
+
 		if (atomic_read(&wait_req.done)) {
 			err = wait_req.err;
 			break;
@@ -2244,7 +2252,7 @@ static int nilfs_segctor_sync(struct nil
 	return err;
 }
 
-static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err)
+static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err, bool force)
 {
 	struct nilfs_segctor_wait_request *wrq, *n;
 	unsigned long flags;
@@ -2252,7 +2260,7 @@ static void nilfs_segctor_wakeup(struct
 	spin_lock_irqsave(&sci->sc_wait_request.lock, flags);
 	list_for_each_entry_safe(wrq, n, &sci->sc_wait_request.head, wq.entry) {
 		if (!atomic_read(&wrq->done) &&
-		    nilfs_cnt32_ge(sci->sc_seq_done, wrq->seq)) {
+		    (force || nilfs_cnt32_ge(sci->sc_seq_done, wrq->seq))) {
 			wrq->err = err;
 			atomic_set(&wrq->done, 1);
 		}
@@ -2390,7 +2398,7 @@ static void nilfs_segctor_notify(struct
 	if (mode == SC_LSEG_SR) {
 		sci->sc_state &= ~NILFS_SEGCTOR_COMMIT;
 		sci->sc_seq_done = sci->sc_seq_accepted;
-		nilfs_segctor_wakeup(sci, err);
+		nilfs_segctor_wakeup(sci, err, false);
 		sci->sc_flush_request = 0;
 	} else {
 		if (mode == SC_FLUSH_FILE)
@@ -2772,6 +2780,13 @@ static void nilfs_segctor_destroy(struct
 		|| sci->sc_seq_request != sci->sc_seq_done);
 	spin_unlock(&sci->sc_state_lock);
 
+	/*
+	 * Forcibly wake up tasks waiting in nilfs_segctor_sync(), which can
+	 * be called from delayed iput() via nilfs_evict_inode() and can race
+	 * with the above log writer thread termination.
+	 */
+	nilfs_segctor_wakeup(sci, 0, true);
+
 	if (flush_work(&sci->sc_iput_work))
 		flag = true;
 



