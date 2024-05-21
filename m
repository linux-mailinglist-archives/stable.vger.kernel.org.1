Return-Path: <stable+bounces-45477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F6C8CA824
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 08:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB231F2238A
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 06:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95CD4B5A6;
	Tue, 21 May 2024 06:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cLB2wVU7"
X-Original-To: stable@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439F9481B9;
	Tue, 21 May 2024 06:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716274252; cv=none; b=d1UOX0Lr3yCKyERQL7/SaZFN4AdbXeRqbpN9yA0zu4GWfGEY6TSjm4b5U+PkwP8AMrmRTWfW1RyKhBljHOYKMo9HON34Gayp3NGhRIV9oXwJqdshdmJbt7DI5ELE8/H6BMbMrmETU9L/hVUCnI5454A7wBHYGJLkCUvlBj7lALE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716274252; c=relaxed/simple;
	bh=Hizn4Dnh13RQ06Vwkn9Ezw8vptYpnecvk5Jv8JF9xiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D+KoY4ES4oAUgJZ7SDdOwezuR+Z5JAuZm0ivJRkpGLVshnjd9JLLzUvInhrSNAIkNauHYbhKkysqfqeAmCKrM8+XywjsOPqlg/mYRzPX0rkXEqRtojxpS1d3GpkZXW2GrNEcXHDeI/BgcRjamvLaBIxFCZsXn2FjVbbCa6Hsb1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cLB2wVU7; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716274241; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=JCING5sZygVmTb4vCd81GBYFm+lfeEpLIKLRnHa1e1E=;
	b=cLB2wVU7RnymesKk+XihtZDxVpJgLh2DKV0G+1v+DTU79Vn20KcAiOOLANJqvvYVs8XcpI4T/VRO8z7/aZipf4eti1Spiv3uG0joqIl0yjA9LSB1ADWpxVG0LsqxzTbUtjaiBZHAWIfngzA9m9MCDJliOVuYpl5OHHK/RoNz7N8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W6wiTg-_1716274239;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W6wiTg-_1716274239)
          by smtp.aliyun-inc.com;
          Tue, 21 May 2024 14:50:40 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org,
	Baokun Li <libaokun1@huawei.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 6.8.y 2/2] erofs: reliably distinguish block based and fscache mode
Date: Tue, 21 May 2024 14:50:32 +0800
Message-Id: <20240521065032.4192363-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240521065032.4192363-1-hsiangkao@linux.alibaba.com>
References: <20240521065032.4192363-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

commit 7af2ae1b1531feab5d38ec9c8f472dc6cceb4606 upstream.

When erofs_kill_sb() is called in block dev based mode, s_bdev may not
have been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled,
it will be mistaken for fscache mode, and then attempt to free an anon_dev
that has never been allocated, triggering the following warning:

============================================
ida_free called for id=0 which is not allocated.
WARNING: CPU: 14 PID: 926 at lib/idr.c:525 ida_free+0x134/0x140
Modules linked in:
CPU: 14 PID: 926 Comm: mount Not tainted 6.9.0-rc3-dirty #630
RIP: 0010:ida_free+0x134/0x140
Call Trace:
 <TASK>
 erofs_kill_sb+0x81/0x90
 deactivate_locked_super+0x35/0x80
 get_tree_bdev+0x136/0x1e0
 vfs_get_tree+0x2c/0xf0
 do_new_mount+0x190/0x2f0
 [...]
============================================

Now when erofs_kill_sb() is called, erofs_sb_info must have been
initialised, so use sbi->fsid to distinguish between the two modes.

Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20240419123611.947084-3-libaokun1@huawei.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 8d7a3abb9c1b..a2fa74558570 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -790,17 +790,13 @@ static int erofs_init_fs_context(struct fs_context *fc)
 
 static void erofs_kill_sb(struct super_block *sb)
 {
-	struct erofs_sb_info *sbi;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (erofs_is_fscache_mode(sb))
+	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
 		kill_anon_super(sb);
 	else
 		kill_block_super(sb);
 
-	sbi = EROFS_SB(sb);
-	if (!sbi)
-		return;
-
 	erofs_free_dev_context(sbi->devs);
 	fs_put_dax(sbi->dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
-- 
2.39.3


