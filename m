Return-Path: <stable+bounces-98606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D46759E4901
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94AC4281F8A
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4F720E334;
	Wed,  4 Dec 2024 23:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h81yAb37"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2555220E32D;
	Wed,  4 Dec 2024 23:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354820; cv=none; b=YPfniYaKwylC2wslZjAPL0KTTDRJC4WtySN84pEig0uTtVtlUUVbYk5Kne+oD05WJp9it8BliLEiKH1L0SSqf4Nr7lwdQ9cPWuwjDDX9/OyjMyou974Sqzvy8g3TLTd15AIwPYRv/sDrUzv36wvtUwk5bu82cGQEvkLJoLG3JCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354820; c=relaxed/simple;
	bh=Y9JKejcSL4uFEb7Pawul7nYeququsEJt7FV7B5uTBZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KcjBYt64oRCEw9c1OYS4guEDwNh4nI+d0XBAKIXoPIoApvK7DJxYGZQQDrZ8VHeGI4HM8I9oKTUhvJe+SXIKxNQaYUA7mHO5p9MAHSywf5vjZt2cY+klErlHPZTh7v8JrdX1Ux8nmPk733Iys2E1uNXJ4byMFnVFmz+78qV1Eoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h81yAb37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62BEC4CECD;
	Wed,  4 Dec 2024 23:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354819;
	bh=Y9JKejcSL4uFEb7Pawul7nYeququsEJt7FV7B5uTBZg=;
	h=From:To:Cc:Subject:Date:From;
	b=h81yAb37AIyrM0YTmWvaypfts0xhZXm0ajZQVV0CxWWXmQWLYlbbnsw16K/d3uo9k
	 bBVsQQBfMqDIXb83TWTydluWhmZ7fDmIICNqkLTYazsWhCgjde0JD0L11Hdcrnh6hz
	 iKBhlIOF/yiUdv1g4xl6pL+oJN3XCm3vP9j1IbG+yUeK1AuaEbxxILbQ+PICVool95
	 N/dgBwfRn96VOUzPURu9fz+7l4lAUhdUYxylvOU2a3MhzCnBvMRA7yHH4D/VZh7n3P
	 KZV1xK0gPlrcgqwgE6KEzsrcpusJP1D/zE+namofDbORJkJMGnfRpAuxP5bT4Pssa2
	 lG5hGEz+FFVRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+7f3761b790fa41d0f3d5@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 1/2] fs/ntfs3: Fix case when unmarked clusters intersect with zone
Date: Wed,  4 Dec 2024 17:15:38 -0500
Message-ID: <20241204221539.2247447-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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


