Return-Path: <stable+bounces-98604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED419E48F7
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8C8281B40
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863FD20E023;
	Wed,  4 Dec 2024 23:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSv5zcff"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D80220E016;
	Wed,  4 Dec 2024 23:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354815; cv=none; b=XlSuwJE7UNKC1EwabKQ0AJh9Ndj78tVbcHy7IKBdN8ZPVeIjFKNKYzBWxChnfIHFjl0Gps/FNOjvTdQx/7BiN0ji0Fne5le2xJ+jBQLNi84VtQC3Cx5EUd+eDgwpZcQyjEtUd24Vhq187OY4FXLuxRq8I6bMuEaXWFmPcdk0N7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354815; c=relaxed/simple;
	bh=2YG1CF2q58HG6E9xqH4h2aveIrGJdp6i2yfxVFAXtxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIx+DusOipNh0Thf7/0eqNTNT0uCjd38keNgbmCL3TbFMLhPG/Vf7r5hpbZMYOqk1Eh2KRbuyYhflVoMuDFN/WFs2Peh0pO3CtSg1FsI45riooU8kZKNcaXu3Nx6xXTzgL7GEStcPbxTPXQ6dK5DIoMDCfMj7fdP9mF+HldSa6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSv5zcff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFAEC4CECD;
	Wed,  4 Dec 2024 23:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354815;
	bh=2YG1CF2q58HG6E9xqH4h2aveIrGJdp6i2yfxVFAXtxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mSv5zcffe1RgQc0on6uFsP7hedfdlYqPMQa+poZ24wtYNLbZYclOKlKAOaEHskpcV
	 BjO66VPm6KCPZkLcpcHExGL9Rd//42gU8X3unNeMoFTSWWAXCsSvVZJ1rqDW9Py+eO
	 zChtD/6VuEe046dASZ+7R2+TKpHkrsuAuWH4t46pIq0RnwLqHg5z2KR+a+DS2E4t8d
	 zQZybVvYGZUYOrnvLptmnFnqMJziIjtlJ/KoVxGQmVjjIZ+1RuTHJ9A0Z712oealXn
	 yyKBkMhOv2o1oZq/k5vtQ9RnzE3sQxbZhvhPDmgsJG31QJ5YoeXhwiC9+hvEHfcqdI
	 0om+Fry6yi56Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+7f3761b790fa41d0f3d5@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 2/3] fs/ntfs3: Fix case when unmarked clusters intersect with zone
Date: Wed,  4 Dec 2024 17:15:31 -0500
Message-ID: <20241204221534.2247369-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221534.2247369-1-sashal@kernel.org>
References: <20241204221534.2247369-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 58e988cd80490..48566dff0dc92 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -1055,8 +1055,8 @@ int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 {
 	int ret, err;
 	CLST next_vcn, lcn, len;
-	size_t index;
-	bool ok;
+	size_t index, done;
+	bool ok, zone;
 	struct wnd_bitmap *wnd;
 
 	ret = run_unpack(run, sbi, ino, svcn, evcn, vcn, run_buf, run_buf_size);
@@ -1087,8 +1087,9 @@ int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 			continue;
 
 		down_read_nested(&wnd->rw_lock, BITMAP_MUTEX_CLUSTERS);
+		zone = max(wnd->zone_bit, lcn) < min(wnd->zone_end, lcn + len);
 		/* Check for free blocks. */
-		ok = wnd_is_used(wnd, lcn, len);
+		ok = !zone && wnd_is_used(wnd, lcn, len);
 		up_read(&wnd->rw_lock);
 		if (ok)
 			continue;
@@ -1096,14 +1097,33 @@ int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
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


