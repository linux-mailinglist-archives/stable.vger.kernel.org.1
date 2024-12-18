Return-Path: <stable+bounces-105130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7DA9F5F6E
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 08:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A276818919A9
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 07:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BAA15625A;
	Wed, 18 Dec 2024 07:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HKa/XDgL"
X-Original-To: stable@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22CA8488
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 07:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734507593; cv=none; b=VYIVISwBKVOVrKCuPKLcXK/uR8CrY1q2nxAHLg6I8q+Ao/MTbgPbzoQmAJRY4R4m5oHa02WjHtw+RXgB9QoQscSh1SCVkn5+xtKAJDcnVnDYDYHO0c9h656I+gQwI4AHFp0EkB5K+NhwgWBdYTS9Usd30Jhljo5LamXZ84rX6bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734507593; c=relaxed/simple;
	bh=3oOrOWAI5yzLn1ZGumblyV5NHYRVSuKtrkeEgqAyEEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KYj2YAanLeZ9Zb92cjT2jPWyQOBSMQvm/AwyAxdCvNcxaB2CB1sdGcTMSHy29zYlS7Pi48mUwUxNd90HOGth7hHQXmZwJPDuaS2wDMBC8wZH56T7rhkExsKaNbG+JL3UuSgxUemVJYWTL3oEYflHGXbnEHkdpRaRUvLoRB7yXEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HKa/XDgL; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734507581; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4/fbYoMW4Mgk8ctWCbpE50BBypITO2RQ4q5chnEAJ4E=;
	b=HKa/XDgLeVAP7IWn0arsumuedOu3Ks2jYkLjhrF6aceeR94VDsarkIsACqjVsfCMNBTwOcEvzamffhej0AE7KnAwsVbFcR2KtnNrRD6xVaMmu7L55NiDBO8rmXBdHty84DAn/1MMJJeszq5nCnPoRiYH92fcjJTOkktlvRjpd7s=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLlkMIV_1734507580 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Dec 2024 15:39:41 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: allison.karlitskaya@redhat.com,
	linux-erofs@lists.ozlabs.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	syzbot+f966c13b1b4fc0403b19@syzkaller.appspotmail.com,
	Yue Hu <huyue2@coolpad.com>
Subject: [PATCH 5.4.y 1/2] erofs: fix order >= MAX_ORDER warning due to crafted negative i_size
Date: Wed, 18 Dec 2024 15:39:37 +0800
Message-ID: <20241218073938.459812-1-hsiangkao@linux.alibaba.com>
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
index 0dbeaf68e1d6..ba981076d6f2 100644
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


