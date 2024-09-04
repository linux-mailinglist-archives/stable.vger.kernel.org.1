Return-Path: <stable+bounces-72958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D579296AF29
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 05:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C131C21013
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 03:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A0461674;
	Wed,  4 Sep 2024 03:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSUNarub"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA464F602;
	Wed,  4 Sep 2024 03:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725420074; cv=none; b=i7GgSQcgHz4RzPKBNC53D4DMeJAeJQMyCXYG5HxyGaO8504mCzaM0G5T0QlFZ9TY8GYJZylpbT8f3TOQNOXN1/irlj8c8KJRp4uBkg7pxyO/IoM1OWCj/nc0kM+G1f5c4lXb3tJUnttSKteAPj7owJ1YYtHUiIV5x6rZbUbkSq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725420074; c=relaxed/simple;
	bh=7W7hSFh6fbzMu1DJBOBbHsI5RIQMTJ2hInRBKWxu5IA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oDiR34kRBG6ygYcIUBoGPKtmxlCckcRm4UJcuSKrB/MtExdpPkJc3ZKIRZbd+KxhL4gWaHTJPD2/hdZLokt9RzZNHKza+iAV+L8tk1oesHqh4AY9u6pRY2TVeY7jA3P2R3fmRn45Uv0qtENmAPD9BhGTU9etv1MMyat9lNXzTzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSUNarub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590B1C4CEC4;
	Wed,  4 Sep 2024 03:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725420073;
	bh=7W7hSFh6fbzMu1DJBOBbHsI5RIQMTJ2hInRBKWxu5IA=;
	h=From:To:Cc:Subject:Date:From;
	b=QSUNarubdzImUCws3SMfJfYvb7vpJ3+zEAqxD8MTeRnEt484c/BSAx6jJzzsHqsLj
	 o+ClAQ/NVA7gIpQGNqmzcC15bSCQ8EpzyTlJKyRXzuAQ99RSZqU/7nopUuX6k4cC2V
	 8yXAbSg4cnXX5Hn+S14ywgiOp5nwLssmfBik9qtFxasjy+yLA06/NFsw7to/IIAox7
	 GU1mAhc2wKJGJIWPJSDfpLxywKo2hCoJqfgfJpKESNj8JqR8MBFfbbSBcd1TrHsZpp
	 3U8ZDAy1a25HNeNgRjxl5ylCO46x62MStPbvAw7s0HDBGaZ/FLvUNPrveBLlEyEu1S
	 ZGeS2qyi3e/jg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: fix to check atomic_file in f2fs ioctl interfaces
Date: Wed,  4 Sep 2024 11:20:47 +0800
Message-Id: <20240904032047.1264706-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some f2fs ioctl interfaces like f2fs_ioc_set_pin_file(),
f2fs_move_file_range(), and f2fs_defragment_range() missed to
check atomic_write status, which may cause potential race issue,
fix it.

Cc: stable@vger.kernel.org
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a8d153eb0a95..99903eafa7fe 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2710,7 +2710,8 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 				(range->start + range->len) >> PAGE_SHIFT,
 				DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE));
 
-	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED) ||
+		f2fs_is_atomic_file(inode)) {
 		err = -EINVAL;
 		goto unlock_out;
 	}
@@ -2943,6 +2944,11 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 		goto out_unlock;
 	}
 
+	if (f2fs_is_atomic_file(src) || f2fs_is_atomic_file(dst)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	ret = -EINVAL;
 	if (pos_in + len > src->i_size || pos_in + len < pos_in)
 		goto out_unlock;
@@ -3326,6 +3332,11 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 
 	inode_lock(inode);
 
+	if (f2fs_is_atomic_file(inode)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (!pin) {
 		clear_inode_flag(inode, FI_PIN_FILE);
 		f2fs_i_gc_failures_write(inode, 0);
-- 
2.40.1


