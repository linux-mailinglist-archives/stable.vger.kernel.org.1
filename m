Return-Path: <stable+bounces-124380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24036A6029E
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6473BE953
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F011F4621;
	Thu, 13 Mar 2025 20:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aauYFGpV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CAC1F4604
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897589; cv=none; b=NjpvWw31lE3JuPzQejSpQJz3AFbiJe4rKuNoEq378xNRkYbZyw5mDu8BIEHKYV9wdDtGsxlUEejFIq7ywyFwFe0BHYmFILC70HQjKsUcunXn8iVHdZovoKlHAWvUux42dl7fvYQ64r35wpsqCe5te4IxQ2myjWkKW+viZbtQo2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897589; c=relaxed/simple;
	bh=x2zMxwa4P4O0M75+D3/Y9UTiLpTqM5bt0qWwpEnHzVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tb4BrfZoqAXyp4/4HdYC1Ygs9ClxvO0updd6mgb3do9OcBwTiHKn7x0mBx6fOGy6QvwRUwYT4uUEGabaEaxRmz1HgtkqyesOzMk0eDNpiDiyZLfP4EKpp6zC54JLSY4ZfTiaVXxPnQGq/ZWsPjcNBFBvxfgV+ImHyvurJuxL2jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aauYFGpV; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-225df540edcso1391595ad.0
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897585; x=1742502385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=womBR5ENlT36CNxCREhlYCft4/Eol3h8MUOUzleO6/A=;
        b=aauYFGpV9ZPLvR82Jy63Fpmq+TTbE4syvWTgAg15xDJK4UWe6uL0TpL9bsU0ec2g3l
         Ho39hzUj3jFmbBURuYV6UJP8w83JtTmPm1cIa3nZzaSEqd/u4IcvOXVzdE07VwoA78Im
         9GM75UpR+cAiuOTVuxfF+lOfNBDbtv9nO1nsbp1s9fXv01UbZBjCYNJS78AhFVGUhl7n
         sdkbFjbF3ixg4dee3nVSKA/ta2njuBbOG5rXLUCGYD9UQZVs/5/0VUPjaf+rfSpihPqm
         XXzCTwl2VXQU9Ty32I35ZjHcwz1r7qmLVKJZ6yHCE0Ze5L7H8y+Vj0WB7aS+7x1lC6yn
         MW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897585; x=1742502385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=womBR5ENlT36CNxCREhlYCft4/Eol3h8MUOUzleO6/A=;
        b=ZG5y07VB+LJATxi7gqx4PeJMX5W6uwO4BR/0VNaxO0xWQ0VTPV3Us5TCYqDTiaSIjb
         NIqCCnX2PHBbKJuuIOH9pPYkTpLFA7qwH5bDPAlbPknlk5yJw02nqylOkwaIq8fue1sw
         T4ruvSLx4oYuhnM13aDzTV4tERa/4T0ZiD96Iu3iS4gAEa7fC5HvAKXYQOiK3fM5EMqc
         DX4rPOlKUxWtl+Mg3eAayApoX+A19CWmQHE1Xr7dvFmuctKTIW9SA0LcwY7Dmo3AAcr1
         TBmDpMbhp40tl4eundydN8fWRU0mSYwTkaIAydivi3qWj8wsSd0y8GBAZc0d5AFK3w1A
         V/8A==
X-Gm-Message-State: AOJu0YxOIosqh2BusOURB+UPxsXI3qJz9XhCIwu55qQ9/RFHRZ49eXHM
	vyI2BGiHiFbhaZYpLTlgiDSc7XWlHf/TzaCAGJv7PqwcCTLYUK9o+6WgEuZr
X-Gm-Gg: ASbGncvu03GIrNxiYD/VE9a/ghDNUQYiQRpLvAuaW+m5gd4xPD3sEdGzIlFZYueXVEq
	PGLCr+o7J1KVTrDyBorsiy92fMFZpyMmicdMwHOwx528Jxo84hPTmEbf+UzofJRi+UzFlwD67X6
	Oq2LKECbFOo30ebLg7MnsdR5XIlMP13iSOL3QUf+a/C18a8mFmApNNTUQgcXIkR04fKx6dZ9KTo
	RN7T/6WX8tzDYg1XGenZ4XBJXYGSQ3n2Y8BOYfJF4G9Nl/8O44nJ3Nw5LHOua/uQNkJ3VhwvaKC
	OHEx0jTaNkqQm9C3UipI8e+5DsvUHA6GX6j5T1vd57DlSYqc3XCsI51ksrE3P35YGxtvV/c=
X-Google-Smtp-Source: AGHT+IHi6zo54LxCPMo8ewfP41GPSeKLkl2hrXHOs+yxrXYGY1wWZ1kYdmSlAVQcgZ23mgJNh2zkWQ==
X-Received: by 2002:a05:6a20:12c8:b0:1f3:2968:5ac5 with SMTP id adf61e73a8af0-1f5b095d100mr6021889637.20.1741897585527;
        Thu, 13 Mar 2025 13:26:25 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:25 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 22/29] xfs: force all buffers to be written during btree bulk load
Date: Thu, 13 Mar 2025 13:25:42 -0700
Message-ID: <20250313202550.2257219-23-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
In-Reply-To: <20250313202550.2257219-1-leah.rumancik@gmail.com>
References: <20250313202550.2257219-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 13ae04d8d45227c2ba51e188daf9fc13d08a1b12 ]

While stress-testing online repair of btrees, I noticed periodic
assertion failures from the buffer cache about buffers with incorrect
DELWRI_Q state.  Looking further, I observed this race between the AIL
trying to write out a btree block and repair zapping a btree block after
the fact:

AIL:    Repair0:

pin buffer X
delwri_queue:
set DELWRI_Q
add to delwri list

        stale buf X:
        clear DELWRI_Q
        does not clear b_list
        free space X
        commit

delwri_submit   # oops

Worse yet, I discovered that running the same repair over and over in a
tight loop can result in a second race that cause data integrity
problems with the repair:

AIL:    Repair0:        Repair1:

pin buffer X
delwri_queue:
set DELWRI_Q
add to delwri list

        stale buf X:
        clear DELWRI_Q
        does not clear b_list
        free space X
        commit

                        find free space X
                        get buffer
                        rewrite buffer
                        delwri_queue:
                        set DELWRI_Q
                        already on a list, do not add
                        commit

                        BAD: committed tree root before all blocks written

delwri_submit   # too late now

I traced this to my own misunderstanding of how the delwri lists work,
particularly with regards to the AIL's buffer list.  If a buffer is
logged and committed, the buffer can end up on that AIL buffer list.  If
btree repairs are run twice in rapid succession, it's possible that the
first repair will invalidate the buffer and free it before the next time
the AIL wakes up.  Marking the buffer stale clears DELWRI_Q from the
buffer state without removing the buffer from its delwri list.  The
buffer doesn't know which list it's on, so it cannot know which lock to
take to protect the list for a removal.

If the second repair allocates the same block, it will then recycle the
buffer to start writing the new btree block.  Meanwhile, if the AIL
wakes up and walks the buffer list, it will ignore the buffer because it
can't lock it, and go back to sleep.

When the second repair calls delwri_queue to put the buffer on the
list of buffers to write before committing the new btree, it will set
DELWRI_Q again, but since the buffer hasn't been removed from the AIL's
buffer list, it won't add it to the bulkload buffer's list.

This is incorrect, because the bulkload caller relies on delwri_submit
to ensure that all the buffers have been sent to disk /before/
committing the new btree root pointer.  This ordering requirement is
required for data consistency.

Worse, the AIL won't clear DELWRI_Q from the buffer when it does finally
drop it, so the next thread to walk through the btree will trip over a
debug assertion on that flag.

To fix this, create a new function that waits for the buffer to be
removed from any other delwri lists before adding the buffer to the
caller's delwri list.  By waiting for the buffer to clear both the
delwri list and any potential delwri wait list, we can be sure that
repair will initiate writes of all buffers and report all write errors
back to userspace instead of committing the new structure.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_btree_staging.c |  4 +--
 fs/xfs/xfs_buf.c                  | 44 ++++++++++++++++++++++++++++---
 fs/xfs/xfs_buf.h                  |  1 +
 3 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_btree_staging.c b/fs/xfs/libxfs/xfs_btree_staging.c
index dd75e208b543..29e3f8ccb185 100644
--- a/fs/xfs/libxfs/xfs_btree_staging.c
+++ b/fs/xfs/libxfs/xfs_btree_staging.c
@@ -340,13 +340,11 @@ xfs_btree_bload_drop_buf(
 	struct xfs_buf		**bpp)
 {
 	if (*bpp == NULL)
 		return;
 
-	if (!xfs_buf_delwri_queue(*bpp, buffers_list))
-		ASSERT(0);
-
+	xfs_buf_delwri_queue_here(*bpp, buffers_list);
 	xfs_buf_relse(*bpp);
 	*bpp = NULL;
 }
 
 /*
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 54c774af6e1c..257945cdf63b 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -2038,28 +2038,36 @@ xfs_alloc_buftarg(
 error_free:
 	kmem_free(btp);
 	return NULL;
 }
 
+static inline void
+xfs_buf_list_del(
+	struct xfs_buf		*bp)
+{
+	list_del_init(&bp->b_list);
+	wake_up_var(&bp->b_list);
+}
+
 /*
  * Cancel a delayed write list.
  *
  * Remove each buffer from the list, clear the delwri queue flag and drop the
  * associated buffer reference.
  */
 void
 xfs_buf_delwri_cancel(
 	struct list_head	*list)
 {
 	struct xfs_buf		*bp;
 
 	while (!list_empty(list)) {
 		bp = list_first_entry(list, struct xfs_buf, b_list);
 
 		xfs_buf_lock(bp);
 		bp->b_flags &= ~_XBF_DELWRI_Q;
-		list_del_init(&bp->b_list);
+		xfs_buf_list_del(bp);
 		xfs_buf_relse(bp);
 	}
 }
 
 /*
@@ -2108,10 +2116,38 @@ xfs_buf_delwri_queue(
 	}
 
 	return true;
 }
 
+/*
+ * Queue a buffer to this delwri list as part of a data integrity operation.
+ * If the buffer is on any other delwri list, we'll wait for that to clear
+ * so that the caller can submit the buffer for IO and wait for the result.
+ * Callers must ensure the buffer is not already on the list.
+ */
+void
+xfs_buf_delwri_queue_here(
+	struct xfs_buf		*bp,
+	struct list_head	*buffer_list)
+{
+	/*
+	 * We need this buffer to end up on the /caller's/ delwri list, not any
+	 * old list.  This can happen if the buffer is marked stale (which
+	 * clears DELWRI_Q) after the AIL queues the buffer to its list but
+	 * before the AIL has a chance to submit the list.
+	 */
+	while (!list_empty(&bp->b_list)) {
+		xfs_buf_unlock(bp);
+		wait_var_event(&bp->b_list, list_empty(&bp->b_list));
+		xfs_buf_lock(bp);
+	}
+
+	ASSERT(!(bp->b_flags & _XBF_DELWRI_Q));
+
+	xfs_buf_delwri_queue(bp, buffer_list);
+}
+
 /*
  * Compare function is more complex than it needs to be because
  * the return value is only 32 bits and we are doing comparisons
  * on 64 bit values
  */
@@ -2170,31 +2206,31 @@ xfs_buf_delwri_submit_buffers(
 		 * marked it stale in the meantime.  In that case only the
 		 * _XBF_DELWRI_Q flag got cleared, and we have to drop the
 		 * reference and remove it from the list here.
 		 */
 		if (!(bp->b_flags & _XBF_DELWRI_Q)) {
-			list_del_init(&bp->b_list);
+			xfs_buf_list_del(bp);
 			xfs_buf_relse(bp);
 			continue;
 		}
 
 		trace_xfs_buf_delwri_split(bp, _RET_IP_);
 
 		/*
 		 * If we have a wait list, each buffer (and associated delwri
 		 * queue reference) transfers to it and is submitted
 		 * synchronously. Otherwise, drop the buffer from the delwri
 		 * queue and submit async.
 		 */
 		bp->b_flags &= ~_XBF_DELWRI_Q;
 		bp->b_flags |= XBF_WRITE;
 		if (wait_list) {
 			bp->b_flags &= ~XBF_ASYNC;
 			list_move_tail(&bp->b_list, wait_list);
 		} else {
 			bp->b_flags |= XBF_ASYNC;
-			list_del_init(&bp->b_list);
+			xfs_buf_list_del(bp);
 		}
 		__xfs_buf_submit(bp, false);
 	}
 	blk_finish_plug(&plug);
 
@@ -2244,11 +2280,11 @@ xfs_buf_delwri_submit(
 
 	/* Wait for IO to complete. */
 	while (!list_empty(&wait_list)) {
 		bp = list_first_entry(&wait_list, struct xfs_buf, b_list);
 
-		list_del_init(&bp->b_list);
+		xfs_buf_list_del(bp);
 
 		/*
 		 * Wait on the locked buffer, check for errors and unlock and
 		 * release the delwri queue reference.
 		 */
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 549c60942208..6cf0332ba62c 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -303,10 +303,11 @@ extern void *xfs_buf_offset(struct xfs_buf *, size_t);
 extern void xfs_buf_stale(struct xfs_buf *bp);
 
 /* Delayed Write Buffer Routines */
 extern void xfs_buf_delwri_cancel(struct list_head *);
 extern bool xfs_buf_delwri_queue(struct xfs_buf *, struct list_head *);
+void xfs_buf_delwri_queue_here(struct xfs_buf *bp, struct list_head *bl);
 extern int xfs_buf_delwri_submit(struct list_head *);
 extern int xfs_buf_delwri_submit_nowait(struct list_head *);
 extern int xfs_buf_delwri_pushbuf(struct xfs_buf *, struct list_head *);
 
 static inline xfs_daddr_t xfs_buf_daddr(struct xfs_buf *bp)
-- 
2.49.0.rc1.451.g8f38331e32-goog


