Return-Path: <stable+bounces-151441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D171FACE126
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 17:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5AC3A85AC
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 15:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2977187554;
	Wed,  4 Jun 2025 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2h7Qgzm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6213E2F56
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749050703; cv=none; b=jpo4S19eW4npIr8CDJNlmuu5IF9zgQ4whqCYuoGRQN8KUS4kzqQ1SMCeeBYCL1oWdjuUT75f03dSk3umtw5Md31HZ4gRN/O0GdCy4p2v5a/kG7w57E1c45jPQ7VPAet8GWILtTHvZiM8xKXq5+GPoT30tqXGNmxU+mL0M4fyPWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749050703; c=relaxed/simple;
	bh=2NlaTvSGKfhcmdxqioGrjRwphnKIaBSOxtglufyzHDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HB3B+LcbDPM2y2jR3b9mS2U+G8ptg8Ku+LDpJOBRZA8REJZuK5V5q43yiLqsImuSzfmFf1MYfWzpPGH/8jJ5v0dgv2icm0I4q0opWqkQhZihacGUBswMxk+MUcfYv25OJnZYFiYxEP2cR7+zl4dJpHWQE1ePoDBs5RIpBKoowBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2h7Qgzm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0420FC4CEE4;
	Wed,  4 Jun 2025 15:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749050702;
	bh=2NlaTvSGKfhcmdxqioGrjRwphnKIaBSOxtglufyzHDo=;
	h=From:To:Cc:Subject:Date:From;
	b=N2h7QgzmPlvbbuR5tv2ITRJ2vk/HJ6OiOSjVJDS2vT8JShKqmSDKtXKl2fVoEODx1
	 wpTrdcFd5/VoK91YCuL6fLtCBsIXhfDRla1lUQDuhNRBpfw0uwFzUy3dkSDROloU5+
	 6wG666HEMz07mo93Yl3iz1MFTtBhTh5Nn2tKuuV8WG52WcT7vnKKowJ3WfXgQwF6NN
	 LNZhNVBfI4idnZ0d0TlfCluphOFwgd5vaj4AMbc7sXvXdieRFSz7Gz/57WsbLv6XRV
	 I16iUBWww2oNHbw91Imt2808+ZFu1eiTVz8Tg5580A9KW9sd4EpBb1qbc7N1uEQI0W
	 0wIN4c3su751g==
From: hubcap@kernel.org
To: stable@vger.kernel.org
Cc: Mike Marshall <hubcap@omnibond.com>,
	hubcapsc@gmail.com
Subject: [PATCH 6.14] orangefs: adjust counting code to recover from 665575cf
Date: Wed,  4 Jun 2025 11:23:02 -0400
Message-ID: <20250604152308.216963-2-hubcap@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Marshall <hubcap@omnibond.com>

A late commit to 6.14-rc7 (665575cf) broke orangefs. This is a several line
adjustment to some counters needed to keep orangefs from deadlocking
when writing page cache data out to the filesystem. 

Signed-off-by: Mike Marshall <hubcap@omnibond.com>
---
 fs/orangefs/inode.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index aae6d2b8767d..3e8ce0fea4d7 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -32,12 +32,13 @@ static int orangefs_writepage_locked(struct page *page,
 	len = i_size_read(inode);
 	if (PagePrivate(page)) {
 		wr = (struct orangefs_write_range *)page_private(page);
-		WARN_ON(wr->pos >= len);
 		off = wr->pos;
-		if (off + wr->len > len)
+		if ((off + wr->len > len) && (off <= len))
 			wlen = len - off;
 		else
 			wlen = wr->len;
+		if (wlen == 0)
+			wlen = wr->len;
 	} else {
 		WARN_ON(1);
 		off = page_offset(page);
@@ -46,8 +47,6 @@ static int orangefs_writepage_locked(struct page *page,
 		else
 			wlen = PAGE_SIZE;
 	}
-	/* Should've been handled in orangefs_invalidate_folio. */
-	WARN_ON(off == len || off + wlen > len);
 
 	WARN_ON(wlen == 0);
 	bvec_set_page(&bv, page, wlen, off % PAGE_SIZE);
@@ -341,6 +340,8 @@ static int orangefs_write_begin(struct file *file,
 			wr->len += len;
 			goto okay;
 		} else {
+			wr->pos = pos;
+			wr->len = len;
 			ret = orangefs_launder_folio(folio);
 			if (ret)
 				return ret;
-- 
2.49.0


