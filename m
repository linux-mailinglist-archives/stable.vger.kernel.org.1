Return-Path: <stable+bounces-172141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BD2B2FCF2
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2013EA069D3
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFD128505A;
	Thu, 21 Aug 2025 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IaymnUIr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48A72D481E
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786683; cv=none; b=ne5brStatczSxAKP8wAArhxvGc/KbJz5vNuHp8Xv/yd5oN9uda1y2ay/9F25P8ZcfdMxOCJC9uJS/sR8VruP8Y15wC3VzL38Oh5jVPHPw+L3OWrf/EaK9fdkKnHcXDJbpfQ5Bu09+d/xFAydBYpNbOHYeXB7brXdrN1195iwglw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786683; c=relaxed/simple;
	bh=tru1nQ5+PLlydWRzolHKhPXgjr62r+BbBU8Elo9kk9o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VV6MZqGcUwBMiGBXObDaoUfEZ47cRbTRv9Amkf/p1cpsy88Azaoy2MyvHieJW1VJIXX2jIYfHfSSl3Y0zEmJnDC/pI/q2Z+dB2cnJCQNBQfDSAPLJZgJgu1M2VrotYuNkEAvz/YnyX0PKrsS2Tv1ZMK6nmJlj9lttu0o8mZLRCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IaymnUIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA3BC2BCFA;
	Thu, 21 Aug 2025 14:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755786682;
	bh=tru1nQ5+PLlydWRzolHKhPXgjr62r+BbBU8Elo9kk9o=;
	h=Subject:To:Cc:From:Date:From;
	b=IaymnUIrtA2hdQR7zw+We/k4dGhRkPkyrmQhyAVoiCL8Cmc8qgFy6dqZ0o6qOgRVT
	 hmgW+ENH6vFTCricsebS7PviPB+KR8MP6OmH+oviWvQAJAQ4vzRVNU9kt5qPnhwWjx
	 KT8i+NkTmZqdRifszdgGZVsyjU19umzjGcNsyuuc=
Subject: FAILED: patch "[PATCH] drm/xe: Release runtime pm for error path of" failed to apply to 6.16-stable tree
To: shuicheng.lin@intel.com,matthew.brost@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 16:31:07 +0200
Message-ID: <2025082107-shortcut-trough-dbf3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
git checkout FETCH_HEAD
git cherry-pick -x 017ef1228d735965419ff118fe1b89089e772c42
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082107-shortcut-trough-dbf3@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 017ef1228d735965419ff118fe1b89089e772c42 Mon Sep 17 00:00:00 2001
From: Shuicheng Lin <shuicheng.lin@intel.com>
Date: Mon, 7 Jul 2025 00:49:14 +0000
Subject: [PATCH] drm/xe: Release runtime pm for error path of
 xe_devcoredump_read()

xe_pm_runtime_put() is missed to be called for the error path in
xe_devcoredump_read().
Add function description comments for xe_devcoredump_read() to help
understand it.

v2: more detail function comments and refine goto logic (Matt)

Fixes: c4a2e5f865b7 ("drm/xe: Add devcoredump chunking")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Link: https://lore.kernel.org/r/20250707004911.3502904-6-shuicheng.lin@intel.com

diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
index 94625010abc4..203e3038cc81 100644
--- a/drivers/gpu/drm/xe/xe_devcoredump.c
+++ b/drivers/gpu/drm/xe/xe_devcoredump.c
@@ -171,14 +171,32 @@ static void xe_devcoredump_snapshot_free(struct xe_devcoredump_snapshot *ss)
 
 #define XE_DEVCOREDUMP_CHUNK_MAX	(SZ_512M + SZ_1G)
 
+/**
+ * xe_devcoredump_read() - Read data from the Xe device coredump snapshot
+ * @buffer: Destination buffer to copy the coredump data into
+ * @offset: Offset in the coredump data to start reading from
+ * @count: Number of bytes to read
+ * @data: Pointer to the xe_devcoredump structure
+ * @datalen: Length of the data (unused)
+ *
+ * Reads a chunk of the coredump snapshot data into the provided buffer.
+ * If the devcoredump is smaller than 1.5 GB (XE_DEVCOREDUMP_CHUNK_MAX),
+ * it is read directly from a pre-written buffer. For larger devcoredumps,
+ * the pre-written buffer must be periodically repopulated from the snapshot
+ * state due to kmalloc size limitations.
+ *
+ * Return: Number of bytes copied on success, or a negative error code on failure.
+ */
 static ssize_t xe_devcoredump_read(char *buffer, loff_t offset,
 				   size_t count, void *data, size_t datalen)
 {
 	struct xe_devcoredump *coredump = data;
 	struct xe_devcoredump_snapshot *ss;
-	ssize_t byte_copied;
+	ssize_t byte_copied = 0;
 	u32 chunk_offset;
 	ssize_t new_chunk_position;
+	bool pm_needed = false;
+	int ret = 0;
 
 	if (!coredump)
 		return -ENODEV;
@@ -188,20 +206,19 @@ static ssize_t xe_devcoredump_read(char *buffer, loff_t offset,
 	/* Ensure delayed work is captured before continuing */
 	flush_work(&ss->work);
 
-	if (ss->read.size > XE_DEVCOREDUMP_CHUNK_MAX)
+	pm_needed = ss->read.size > XE_DEVCOREDUMP_CHUNK_MAX;
+	if (pm_needed)
 		xe_pm_runtime_get(gt_to_xe(ss->gt));
 
 	mutex_lock(&coredump->lock);
 
 	if (!ss->read.buffer) {
-		mutex_unlock(&coredump->lock);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto unlock;
 	}
 
-	if (offset >= ss->read.size) {
-		mutex_unlock(&coredump->lock);
-		return 0;
-	}
+	if (offset >= ss->read.size)
+		goto unlock;
 
 	new_chunk_position = div_u64_rem(offset,
 					 XE_DEVCOREDUMP_CHUNK_MAX,
@@ -221,12 +238,13 @@ static ssize_t xe_devcoredump_read(char *buffer, loff_t offset,
 		ss->read.size - offset;
 	memcpy(buffer, ss->read.buffer + chunk_offset, byte_copied);
 
+unlock:
 	mutex_unlock(&coredump->lock);
 
-	if (ss->read.size > XE_DEVCOREDUMP_CHUNK_MAX)
+	if (pm_needed)
 		xe_pm_runtime_put(gt_to_xe(ss->gt));
 
-	return byte_copied;
+	return byte_copied ? byte_copied : ret;
 }
 
 static void xe_devcoredump_free(void *data)


