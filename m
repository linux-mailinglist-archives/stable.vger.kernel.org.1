Return-Path: <stable+bounces-45089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265C28C5A2D
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 19:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA6D1F2279F
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 17:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481B417F38E;
	Tue, 14 May 2024 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="siZ/cXdP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mTq/VJCB"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E7D17EBB9
	for <stable@vger.kernel.org>; Tue, 14 May 2024 17:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715707113; cv=none; b=msGtYs+yD8FnkAISPBH7zSBUOBI+ZtCf3rbVcqdgc4DRAGgRg4BrLaZMlseNCN+JOk2arwgzFaxgJsa7MDarb80qDwA/DFBnHqFcd/vmu0vwJoFE5pJUnbOjCxI0iFRttReJA3/uIE6DnOGSy1ZidpaFe4oZeTR3hJTQxtM0NV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715707113; c=relaxed/simple;
	bh=NZR7d4Nv1tF+4i3RKyVUnvY440ZWNWes/tSBtMVIWmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aty+D+cF0XD+qwnLhdRT2djUkxYs72X+J5kkNNvzlx+FPBgWXdGBu5xfglN70tFex2ULcSX5fxxr5HqGCd24OMe0XBKD3nwA37Y3xPe7cyPKYHLwZp9hLixv/G3QXs2aaO5cJvE8d1L6z/7BRwcv1S8aheVzFQV7WQxJ7+uN9JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=siZ/cXdP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mTq/VJCB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF90B3368E;
	Tue, 14 May 2024 17:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715707109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HikSZtlXvphSCiXs/ksppv3uAIN2D5iXIy+9sDVjWNg=;
	b=siZ/cXdPzFYAOqxFtWM1I7TRoqUKn+bd6f6Xn2oQ7zho+DBcghUJXtidoNj0fGHOC/jbR7
	C+KOz2YFFYAZnaWQCz8obaRxnXAMzOi+JUbdLjg/MY0K71FU89TKB2WxfOP44P0BXxGZnO
	DmEogDmKvEfnkBoKNJvA+ibhX3cGSk4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715707107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HikSZtlXvphSCiXs/ksppv3uAIN2D5iXIy+9sDVjWNg=;
	b=mTq/VJCByTG7yr9hLbzkXq6nGboEI6WkYSkiXGDc9KXHBNveWrir11NfbryVXNsl7KEMlU
	j2boVTeBql9LOGjBoV+sJan5n1qFhrakK8OJc5GVzG3m0EBD5NGPnRcBJjkLN/DfIcxLxk
	JSpyM3EEeRttIELVRpuuZW3Hhs7mrrk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8EE5137C3;
	Tue, 14 May 2024 17:18:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ldXyNOOcQ2a4bgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 14 May 2024 17:18:27 +0000
From: David Sterba <dsterba@suse.com>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Julian Taylor <julian.taylor@1und1.de>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1.x] btrfs: do not wait for short bulk allocation
Date: Tue, 14 May 2024 19:10:52 +0200
Message-ID: <20240514171055.11285-1-dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.981];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1und1.de:email,dorminy.me:email,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]

From: Qu Wenruo <wqu@suse.com>

commit 1db7959aacd905e6487d0478ac01d89f86eb1e51 upstream.

[BUG]
There is a recent report that when memory pressure is high (including
cached pages), btrfs can spend most of its time on memory allocation in
btrfs_alloc_page_array() for compressed read/write.

[CAUSE]
For btrfs_alloc_page_array() we always go alloc_pages_bulk_array(), and
even if the bulk allocation failed (fell back to single page
allocation) we still retry but with extra memalloc_retry_wait().

If the bulk alloc only returned one page a time, we would spend a lot of
time on the retry wait.

The behavior was introduced in commit 395cb57e8560 ("btrfs: wait between
incomplete batch memory allocations").

[FIX]
Although the commit mentioned that other filesystems do the wait, it's
not the case at least nowadays.

All the mainlined filesystems only call memalloc_retry_wait() if they
failed to allocate any page (not only for bulk allocation).
If there is any progress, they won't call memalloc_retry_wait() at all.

For example, xfs_buf_alloc_pages() would only call memalloc_retry_wait()
if there is no allocation progress at all, and the call is not for
metadata readahead.

So I don't believe we should call memalloc_retry_wait() unconditionally
for short allocation.

Call memalloc_retry_wait() if it fails to allocate any page for tree
block allocation (which goes with __GFP_NOFAIL and may not need the
special handling anyway), and reduce the latency for
btrfs_alloc_page_array().

Reported-by: Julian Taylor <julian.taylor@1und1.de>
Tested-by: Julian Taylor <julian.taylor@1und1.de>
Link: https://lore.kernel.org/all/8966c095-cbe7-4d22-9784-a647d1bf27c3@1und1.de/
Fixes: 395cb57e8560 ("btrfs: wait between incomplete batch memory allocations")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 539bc9bdcb93..5f923c9b773e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1324,19 +1324,14 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array)
 		unsigned int last = allocated;
 
 		allocated = alloc_pages_bulk_array(GFP_NOFS, nr_pages, page_array);
-
-		if (allocated == nr_pages)
-			return 0;
-
-		/*
-		 * During this iteration, no page could be allocated, even
-		 * though alloc_pages_bulk_array() falls back to alloc_page()
-		 * if  it could not bulk-allocate. So we must be out of memory.
-		 */
-		if (allocated == last)
+		if (unlikely(allocated == last)) {
+			/* No progress, fail and do cleanup. */
+			for (int i = 0; i < allocated; i++) {
+				__free_page(page_array[i]);
+				page_array[i] = NULL;
+			}
 			return -ENOMEM;
-
-		memalloc_retry_wait(GFP_NOFS);
+		}
 	}
 	return 0;
 }
-- 
2.45.0


