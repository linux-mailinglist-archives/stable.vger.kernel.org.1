Return-Path: <stable+bounces-202442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9675CC2B0A
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF3B030210F7
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45C8363C61;
	Tue, 16 Dec 2025 12:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D8bRKIZS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551033644A2;
	Tue, 16 Dec 2025 12:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887912; cv=none; b=XgwwVXox2CZ578M3Q9o+9fUnQUDzR/1FS1+sA+uWCvONOnNHsVgLI5SszZOxQ51f0vlaLYYrQxlGdZ9di3HAiQXT+u7VBVU6e4q6Ztc4xpZ2SU1vikAlHw2SfDAZcaCJp6rL567Y0pQf6jIT5fi0UJ4JVf96G3RRFpAVG/WJLBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887912; c=relaxed/simple;
	bh=stAIuhkqMuovDW3Ssl0rZR6N7wxnyflu0TdxyCyetBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsW7jEjzwnIs/Qvt/QpiHsMW6lFjtR6QwFe6Ad2ck7jcJzifqnDJy3g33GZ4AdzgqmacQfMKRAknbfLc1M11ZwGhLoJJLsqsQG/cNjjvG8fFClD8wHMUDvfL/kZHGBUXL10Exs6+NQPu40kdrwNOldcC/SedUc01nz+o03MFNl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D8bRKIZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0484C4CEF5;
	Tue, 16 Dec 2025 12:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765887912;
	bh=stAIuhkqMuovDW3Ssl0rZR6N7wxnyflu0TdxyCyetBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D8bRKIZSIq5GTJKp0A8pi8q8ZAgsNY4pGjJKnyy4nfVNY3vu1LC+fAX+VA8Fgd/4I
	 nZZUL3U8LNfEcP+SiD4fcMk9WMRPtUc+IYELCMc34I/nbyuLXLjn/DoRzkrWbv9UY6
	 sEF1FV1ksPKPnNZu2UVr+yQpHovqQ9uQQdwj4QBs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Chao Yu <chao@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>,
	syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com
Subject: [PATCH 6.18 375/614] erofs: correct FSDAX detection
Date: Tue, 16 Dec 2025 12:12:22 +0100
Message-ID: <20251216111414.948573232@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
References: <20251216111401.280873349@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit ebe4f3f6eb0c10f87c58e52a8912694c14fdeda6 ]

The detection of the primary device is skipped incorrectly
if the multiple or flattened feature is enabled.

It also fixes the FSDAX misdetection for non-block extra blobs.

Fixes: c6993c4cb918 ("erofs: Fallback to normal access if DAX is not supported on extra device")
Reported-and-tested-by: syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/691af9f6.a70a0220.3124cb.0097.GAE@google.com
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/super.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index f3f8d8c066e4e..cd8ff98c29384 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -174,15 +174,15 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 		if (!erofs_is_fileio_mode(sbi)) {
 			dif->dax_dev = fs_dax_get_by_bdev(file_bdev(file),
 					&dif->dax_part_off, NULL, NULL);
-			if (!dif->dax_dev && test_opt(&sbi->opt, DAX_ALWAYS)) {
-				erofs_info(sb, "DAX unsupported by %s. Turning off DAX.",
-					   dif->path);
-				clear_opt(&sbi->opt, DAX_ALWAYS);
-			}
 		} else if (!S_ISREG(file_inode(file)->i_mode)) {
 			fput(file);
 			return -EINVAL;
 		}
+		if (!dif->dax_dev && test_opt(&sbi->opt, DAX_ALWAYS)) {
+			erofs_info(sb, "DAX unsupported by %s. Turning off DAX.",
+				   dif->path);
+			clear_opt(&sbi->opt, DAX_ALWAYS);
+		}
 		dif->file = file;
 	}
 
@@ -215,13 +215,13 @@ static int erofs_scan_devices(struct super_block *sb,
 			  ondisk_extradevs, sbi->devs->extra_devices);
 		return -EINVAL;
 	}
-	if (!ondisk_extradevs) {
-		if (test_opt(&sbi->opt, DAX_ALWAYS) && !sbi->dif0.dax_dev) {
-			erofs_info(sb, "DAX unsupported by block device. Turning off DAX.");
-			clear_opt(&sbi->opt, DAX_ALWAYS);
-		}
-		return 0;
+
+	if (test_opt(&sbi->opt, DAX_ALWAYS) && !sbi->dif0.dax_dev) {
+		erofs_info(sb, "DAX unsupported by block device. Turning off DAX.");
+		clear_opt(&sbi->opt, DAX_ALWAYS);
 	}
+	if (!ondisk_extradevs)
+		return 0;
 
 	if (!sbi->devs->extra_devices && !erofs_is_fscache_mode(sb))
 		sbi->devs->flatdev = true;
-- 
2.51.0




