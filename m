Return-Path: <stable+bounces-167677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B85EB23156
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3512167223
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EED2FFDC3;
	Tue, 12 Aug 2025 18:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mWpXPZ4r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BDA2FF179;
	Tue, 12 Aug 2025 18:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021625; cv=none; b=RmwVyFu03gZkxkQjGQxgvr1oNZqzYGCUrE+WnmaaXVUHqOnBMhc2ZRA+sCGShtYEkxpGYn4jsKNYJWTPu5NQzMkg5vH3NnrMSgbfPOa8pYspDKOi8pTUuKVwlk3t4g233SvQpR81X/9/6gE2OcWMaDjshrr7pUPH8foo3RnZ4zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021625; c=relaxed/simple;
	bh=9OZntMC6Ke1nETrzQ84uQ7dMCUiAqnk4KCMMi2Z9lA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AenRMzMr4enrURpJPs0HdCCblIAPOi+XNL+px4WWJ1gwCB/HNz4MYwjC8qjCw0U1aioxK+Y1C0PlKMzOlxzKVG8moVjGhODTerVTCwrKW9/e2ZDLSfQ4IUzeyi/yVZJwLZFx4lkPrO2204ip3ZYRHg+n5vowN2bbA+Uglf8Gi0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mWpXPZ4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EE3C4CEF0;
	Tue, 12 Aug 2025 18:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755021624;
	bh=9OZntMC6Ke1nETrzQ84uQ7dMCUiAqnk4KCMMi2Z9lA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mWpXPZ4rYzroZmK0rrR6ZyDzkLfyQAFdn5ArSBQm5oejP9EDe9OGynPSzWH0iGi7P
	 MurvgkO5wZ7fT07iVP71b+mMlx20gAa+4NO3HONUhdn/zok/9DW2eLNxw8dJWIZiQJ
	 9HAeuouJJSQ03IUFkTtaqYj+iI4/QYW4+AtXQ0Vs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 176/262] f2fs: fix to avoid out-of-boundary access in devs.path
Date: Tue, 12 Aug 2025 19:29:24 +0200
Message-ID: <20250812173000.609932632@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172952.959106058@linuxfoundation.org>
References: <20250812172952.959106058@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao@kernel.org>

[ Upstream commit 5661998536af52848cc4d52a377e90368196edea ]

- touch /mnt/f2fs/012345678901234567890123456789012345678901234567890123
- truncate -s $((1024*1024*1024)) \
  /mnt/f2fs/012345678901234567890123456789012345678901234567890123
- touch /mnt/f2fs/file
- truncate -s $((1024*1024*1024)) /mnt/f2fs/file
- mkfs.f2fs /mnt/f2fs/012345678901234567890123456789012345678901234567890123 \
  -c /mnt/f2fs/file
- mount /mnt/f2fs/012345678901234567890123456789012345678901234567890123 \
  /mnt/f2fs/loop

[16937.192225] F2FS-fs (loop0): Mount Device [ 0]: /mnt/f2fs/012345678901234567890123456789012345678901234567890123\xff\x01,      511,        0 -    3ffff
[16937.192268] F2FS-fs (loop0): Failed to find devices

If device path length equals to MAX_PATH_LEN, sbi->devs.path[] may
not end up w/ null character due to path array is fully filled, So
accidently, fields locate after path[] may be treated as part of
device path, result in parsing wrong device path.

struct f2fs_dev_info {
...
	char path[MAX_PATH_LEN];
...
};

Let's add one byte space for sbi->devs.path[] to store null
character of device path string.

Fixes: 3c62be17d4f5 ("f2fs: support multiple devices")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2d9a86129bd8..7329f706da83 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1245,7 +1245,7 @@ struct f2fs_bio_info {
 #define RDEV(i)				(raw_super->devs[i])
 struct f2fs_dev_info {
 	struct block_device *bdev;
-	char path[MAX_PATH_LEN];
+	char path[MAX_PATH_LEN + 1];
 	unsigned int total_segments;
 	block_t start_blk;
 	block_t end_blk;
-- 
2.39.5




