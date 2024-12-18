Return-Path: <stable+bounces-105128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE9A9F5F67
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 08:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B44188DB54
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 07:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD6C156F30;
	Wed, 18 Dec 2024 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="c8+UfAFt"
X-Original-To: stable@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F20D481D1
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 07:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734507406; cv=none; b=QZOi6iCpiiC3s6ScFCDpGcit+6myGXTR21usphI7w2UHCuy/eLmnpaXH3Rwg6n4E7uNYgCnG1SPWAXBHmuwji1xrgowC/GPUVlhYa6CGIo4shrjfItCWHgxgNGqcYNO8H3v9oTyOL2JGZ8x++5lToRotrODqJya6b54pH8WFvKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734507406; c=relaxed/simple;
	bh=geHqZm8cv4pUQgbfFNWyDyA3b3WFcCgs/+c7nJdNxCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MIfbnOYasaly6tehIEQo+4gkorOq0GuCt7gr8A/zk4ilY0KojXGsc+Gnmvgx/xivihau40sjB5IkiCmgY/a1yWphkO3gEWZNpTLTu+x6ZfbTIHQiCcfQHRx3HR144S4R21xvFEuywJGNlIIP8BzdTZ0dsBZFk5HMB8EdSZA1/Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=c8+UfAFt; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734507395; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=p0vvWWrMMbw7/s7hWg0TDba/m+Ylu1H14UrtBMjU/Ow=;
	b=c8+UfAFtbgWGkoySXKQJROXcWMZK8bX/2MEnckrcyBO1Tr+uxbkhpnHatTksYghBzVGtlKmupXycOHOrBQqLsKt/Coj5Vop8YLZV/mITk6ovjxtuXvsSYmr14ZxFcWNH8Fw4Pb9E4jztuHbXJ3/P3XeDFTcq3glgb13CtCO9f14=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLlonKC_1734507394 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Dec 2024 15:36:35 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: allison.karlitskaya@redhat.com,
	linux-erofs@lists.ozlabs.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	syzbot+f966c13b1b4fc0403b19@syzkaller.appspotmail.com,
	Yue Hu <huyue2@coolpad.com>
Subject: [PATCH 5.10.y 1/2] erofs: fix order >= MAX_ORDER warning due to crafted negative i_size
Date: Wed, 18 Dec 2024 15:36:25 +0800
Message-ID: <20241218073626.454638-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 1dd73601a1cba37a0ed5f89a8662c90191df5873 upstream.

As syzbot reported [1], the root cause is that i_size field is a
signed type, and negative i_size is also less than EROFS_BLKSIZ.
As a consequence, it's handled as fast symlink unexpectedly.

Let's fall back to the generic path to deal with such unusual i_size.

[1] https://lore.kernel.org/r/000000000000ac8efa05e7feaa1f@google.com

Reported-by: syzbot+f966c13b1b4fc0403b19@syzkaller.appspotmail.com
Fixes: 431339ba9042 ("staging: erofs: add inode operations")
Reviewed-by: Yue Hu <huyue2@coolpad.com>
Link: https://lore.kernel.org/r/20220909023948.28925-1-hsiangkao@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 0a94a52a119f..93a4ed665d93 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -202,7 +202,7 @@ static int erofs_fill_symlink(struct inode *inode, void *data,
 
 	/* if it cannot be handled with fast symlink scheme */
 	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
-	    inode->i_size >= PAGE_SIZE) {
+	    inode->i_size >= PAGE_SIZE || inode->i_size < 0) {
 		inode->i_op = &erofs_symlink_iops;
 		return 0;
 	}
-- 
2.43.5


