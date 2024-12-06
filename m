Return-Path: <stable+bounces-99951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEB99E7509
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA27A1885B5C
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1542066F0;
	Fri,  6 Dec 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mBLPuOSh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mBLPuOSh"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA022066C5
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733500912; cv=none; b=LpoZ4Iw11RaoEagr1ndHf9W8PqGJB4AJeQIqg8unUWmnOqYrA9qEerjqBqXHS224e+nJ9fYCzNoF/shi2SZ/t1/w5wZv7c7PX+QrQcExIsWXXmXD9ch2m5mJLeB0KPNTOfUKzkVZPvRUmE8sFGZK7xyHhSNqKWg1LTYpRHJDr/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733500912; c=relaxed/simple;
	bh=kuA9NT8P+lqihAK4QJvZEbpZvfDIwb72rg5daPgMBa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LCe424SN/5Ho0K2Q6Aq8Z/hMyqQjWaf396osrV5MNyAAkDk/9zuQjUVPHFqbjOSCh/jIyS7z4DTD2Gf5H03m6DibUBmKMsraHHwyzuMhkk01RJRO44NQ1rvgbYsTLPLLTh6s/sI6XrYlDRHsh1zVlole9C3yv8JtBMJeYNzuvLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mBLPuOSh; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mBLPuOSh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 323501F37E;
	Fri,  6 Dec 2024 16:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733500908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W5XvePpQBPvCDxqrxzCKVs5ihvT+xU89EPkS5kuP1iU=;
	b=mBLPuOShxiihEhyCJctkVK/74EatyT1kfxsnRtG7ossn46kY/lEu2SuoFq/Qfbb5UZcQfD
	/9eGbmN5n5tvQzHFn+WUDv444mrQ3Oza8cpc1bl0/u4345Ce/jhiUZ1tBJt09tYX9LmZsL
	7xGtZE3z+BT+lZmSIOJRBlg9QhfJysU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733500908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W5XvePpQBPvCDxqrxzCKVs5ihvT+xU89EPkS5kuP1iU=;
	b=mBLPuOShxiihEhyCJctkVK/74EatyT1kfxsnRtG7ossn46kY/lEu2SuoFq/Qfbb5UZcQfD
	/9eGbmN5n5tvQzHFn+WUDv444mrQ3Oza8cpc1bl0/u4345Ce/jhiUZ1tBJt09tYX9LmZsL
	7xGtZE3z+BT+lZmSIOJRBlg9QhfJysU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C33A138A7;
	Fri,  6 Dec 2024 16:01:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ygOcBuwfU2cuBgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 06 Dec 2024 16:01:48 +0000
From: David Sterba <dsterba@suse.com>
To: stable@vger.kernel.org
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.6.x] btrfs: add cancellation points to trim loops
Date: Fri,  6 Dec 2024 17:01:34 +0100
Message-ID: <20241206160134.17747-1-dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,suse.com];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -2.80
X-Spam-Flag: NO

From: Luca Stefani <luca.stefani.ge1@gmail.com>

commit 69313850dce33ce8c24b38576a279421f4c60996 upstream.

There are reports that system cannot suspend due to running trim because
the task responsible for trimming the device isn't able to finish in
time, especially since we have a free extent discarding phase, which can
trim a lot of unallocated space. There are no limits on the trim size
(unlike the block group part).

Since trime isn't a critical call it can be interrupted at any time,
in such cases we stop the trim, report the amount of discarded bytes and
return an error.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219180
Link: https://bugzilla.suse.com/show_bug.cgi?id=1229737
CC: stable@vger.kernel.org # 5.15+
Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c      | 7 ++++++-
 fs/btrfs/free-space-cache.c | 4 ++--
 fs/btrfs/free-space-cache.h | 7 +++++++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index b3680e1c7054..599407120513 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1319,6 +1319,11 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 		start += bytes_to_discard;
 		bytes_left -= bytes_to_discard;
 		*discarded_bytes += bytes_to_discard;
+
+		if (btrfs_trim_interrupted()) {
+			ret = -ERESTARTSYS;
+			break;
+		}
 	}
 
 	return ret;
@@ -6094,7 +6099,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 		start += len;
 		*trimmed += bytes;
 
-		if (fatal_signal_pending(current)) {
+		if (btrfs_trim_interrupted()) {
 			ret = -ERESTARTSYS;
 			break;
 		}
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 3bcf4a30cad7..9a6ec9344c3e 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3808,7 +3808,7 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 		if (async && *total_trimmed)
 			break;
 
-		if (fatal_signal_pending(current)) {
+		if (btrfs_trim_interrupted()) {
 			ret = -ERESTARTSYS;
 			break;
 		}
@@ -3999,7 +3999,7 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 		}
 		block_group->discard_cursor = start;
 
-		if (fatal_signal_pending(current)) {
+		if (btrfs_trim_interrupted()) {
 			if (start != offset)
 				reset_trimming_bitmap(ctl, offset);
 			ret = -ERESTARTSYS;
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 33b4da3271b1..bd80c7b2af96 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -6,6 +6,8 @@
 #ifndef BTRFS_FREE_SPACE_CACHE_H
 #define BTRFS_FREE_SPACE_CACHE_H
 
+#include <linux/freezer.h>
+
 /*
  * This is the trim state of an extent or bitmap.
  *
@@ -43,6 +45,11 @@ static inline bool btrfs_free_space_trimming_bitmap(
 	return (info->trim_state == BTRFS_TRIM_STATE_TRIMMING);
 }
 
+static inline bool btrfs_trim_interrupted(void)
+{
+	return fatal_signal_pending(current) || freezing(current);
+}
+
 /*
  * Deltas are an effective way to populate global statistics.  Give macro names
  * to make it clear what we're doing.  An example is discard_extents in
-- 
2.45.0


