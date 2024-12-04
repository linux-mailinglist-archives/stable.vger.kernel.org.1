Return-Path: <stable+bounces-98608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9989E491D
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057A716B35C
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E2A2066EB;
	Wed,  4 Dec 2024 23:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brvyr9xh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D040E20E70F;
	Wed,  4 Dec 2024 23:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354823; cv=none; b=NhF2+kxIYqlNzMH/mDl661Brn/bN1V3esukJSqzInZaUzQZJmt7RdS1qb+bB4fgjtleO5tLNiqd0ykfjcdW40kfnDYHNQxHppTrLBTht048ScS5jB833OP1KblkUabQT9CDYKTFfRLfDdJjFlP5y/RwsvlkZdBBlvAqBJlJrNZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354823; c=relaxed/simple;
	bh=Y9JKejcSL4uFEb7Pawul7nYeququsEJt7FV7B5uTBZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pAyrWs8kW6ybS2usQIkA++nLqKTn0kIsFgApByXiu674nmhnjziZdwanHAbYtIuZc8ET1G5p3bG89nRnMdEKnAe2xJ83Ye7qjX7Qzq3dBGRbZeWHxs8RzNnVFINeKmi2g2/8ugafqznS46zR8E67nbjzVZuG+LNUccvpX/AryaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brvyr9xh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00146C4CECD;
	Wed,  4 Dec 2024 23:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354823;
	bh=Y9JKejcSL4uFEb7Pawul7nYeququsEJt7FV7B5uTBZg=;
	h=From:To:Cc:Subject:Date:From;
	b=brvyr9xhB3c9dPQSSGeQLyQlQjxjkHhS/jKWkBNgfGmJMETFE3K293u805XllaxP2
	 Jfu57J/RNx/auygbu/iw4cLDw+KrcpKz28bYaPbi8bpUuyMbw63WWqVS+f4oh62GIN
	 xG117orH8xRUwQ6Uq2NceWPbfTFEHVdxXWz845Ywu7GX0jJN/A0A1BhCr1bpk+g1pv
	 q/A5uFimsjnAMeOdyIvOvAaH0B+a2x+wtZoYqGq5ZGHJj8g40GONZZq9o/NODdIIXW
	 rMdlxxP4dupBh3gsyLLHsHb5QGueYQwg7pM/kGNKUHjr4dpLOcA0mLg2qBvzx9XdYC
	 DrSxViS2rVa2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+7f3761b790fa41d0f3d5@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6] fs/ntfs3: Fix case when unmarked clusters intersect with zone
Date: Wed,  4 Dec 2024 17:15:43 -0500
Message-ID: <20241204221543.2247503-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 5fc982fe7eca9d0cf7b25832450ebd4f7c8e1c36 ]

Reported-by: syzbot+7f3761b790fa41d0f3d5@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/run.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index cb8cf0161177b..44e93ad491ba7 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -1053,8 +1053,8 @@ int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 {
 	int ret, err;
 	CLST next_vcn, lcn, len;
-	size_t index;
-	bool ok;
+	size_t index, done;
+	bool ok, zone;
 	struct wnd_bitmap *wnd;
 
 	ret = run_unpack(run, sbi, ino, svcn, evcn, vcn, run_buf, run_buf_size);
@@ -1085,8 +1085,9 @@ int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 			continue;
 
 		down_read_nested(&wnd->rw_lock, BITMAP_MUTEX_CLUSTERS);
+		zone = max(wnd->zone_bit, lcn) < min(wnd->zone_end, lcn + len);
 		/* Check for free blocks. */
-		ok = wnd_is_used(wnd, lcn, len);
+		ok = !zone && wnd_is_used(wnd, lcn, len);
 		up_read(&wnd->rw_lock);
 		if (ok)
 			continue;
@@ -1094,14 +1095,33 @@ int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 		/* Looks like volume is corrupted. */
 		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
 
-		if (down_write_trylock(&wnd->rw_lock)) {
-			/* Mark all zero bits as used in range [lcn, lcn+len). */
-			size_t done;
-			err = wnd_set_used_safe(wnd, lcn, len, &done);
-			up_write(&wnd->rw_lock);
-			if (err)
-				return err;
+		if (!down_write_trylock(&wnd->rw_lock))
+			continue;
+
+		if (zone) {
+			/*
+			 * Range [lcn, lcn + len) intersects with zone.
+			 * To avoid complex with zone just turn it off.
+			 */
+			wnd_zone_set(wnd, 0, 0);
+		}
+
+		/* Mark all zero bits as used in range [lcn, lcn+len). */
+		err = wnd_set_used_safe(wnd, lcn, len, &done);
+		if (zone) {
+			/* Restore zone. Lock mft run. */
+			struct rw_semaphore *lock;
+			lock = is_mounted(sbi) ? &sbi->mft.ni->file.run_lock :
+						 NULL;
+			if (lock)
+				down_read(lock);
+			ntfs_refresh_zone(sbi);
+			if (lock)
+				up_read(lock);
 		}
+		up_write(&wnd->rw_lock);
+		if (err)
+			return err;
 	}
 
 	return ret;
-- 
2.43.0


