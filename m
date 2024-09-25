Return-Path: <stable+bounces-77647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 767E5985F79
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E10A1F25DCA
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3A919047C;
	Wed, 25 Sep 2024 12:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITDWyRdn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3FE19046E;
	Wed, 25 Sep 2024 12:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266573; cv=none; b=WxOhKxvoBjVD1DLzHaGLdIxdWshBL8B80uPvsLcbUookMn2fmwSSNZ72xJWW/KNonUbSXqEBZhOdIDfsx4MdmI8xoRTPWDc3NmmVHhgWmSK3BIRTONL5bkyYB3aBVuH58EgABp/OCMfdU4NRzTel1SKzYxn1s45aDUh9TA79oMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266573; c=relaxed/simple;
	bh=ir94CT1QTSuooMup0r0duChiV29jlBrQQC8uBWMKd9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qY46i9HsWtGqukevcPm64b7wIA1vlAykW61txEng2lAumhYYKnU5H8YzBTg1sXtuRGn0lQ08Tr494Ez2WfSDJlhvNC/Mv8NTxtuOmlTokJQX47486gfd2nynmYq7vJmkqPie0b0tQ5OdS2jc5h424FXCE3ne4TE/lbVsxbI0hHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITDWyRdn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0750C4CEC3;
	Wed, 25 Sep 2024 12:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266573;
	bh=ir94CT1QTSuooMup0r0duChiV29jlBrQQC8uBWMKd9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ITDWyRdnllw/SRbjl+WgL9AxCLYjtwwyMmRxDzddKloS/EbTERMfI2iJUgWmg9BIA
	 pIbspIkuNY/t7ds1xtp8yZcJfYiXYecA6nFluMypaMYNRN1HDqTsZfMQ9id7DhDClJ
	 sdduu036l2DwLzri+QdN5NBs6Olc+6TK+0sCis1O5CLpzlauh9DSZ62iRaI0nAtxpp
	 ucHMfpRpyo7T+JPmha0kwUKd2/F+S9MkXibkLCFkvI4L6Skh0g8Vzb8MArcmvEcxHT
	 QPBXcwgx4rtFUekBzybzGJQiR5zg/vYXIROQNSYU64P3s3DSI/gfyEDgsfaFGN+7Cl
	 bt2y2EwP2zlhg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhao Mengmeng <zhaomengmeng@kylinos.cn>,
	syzbot+02341e0daa42a15ce130@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	llfamsec@gmail.com,
	walmeida@microsoft.com,
	brauner@kernel.org,
	gregkh@linuxfoundation.org,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.6 100/139] jfs: Fix uninit-value access of new_ea in ea_buffer
Date: Wed, 25 Sep 2024 08:08:40 -0400
Message-ID: <20240925121137.1307574-100-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

[ Upstream commit 2b59ffad47db1c46af25ccad157bb3b25147c35c ]

syzbot reports that lzo1x_1_do_compress is using uninit-value:

=====================================================
BUG: KMSAN: uninit-value in lzo1x_1_do_compress+0x19f9/0x2510 lib/lzo/lzo1x_compress.c:178

...

Uninit was stored to memory at:
 ea_put fs/jfs/xattr.c:639 [inline]

...

Local variable ea_buf created at:
 __jfs_setxattr+0x5d/0x1ae0 fs/jfs/xattr.c:662
 __jfs_xattr_set+0xe6/0x1f0 fs/jfs/xattr.c:934

=====================================================

The reason is ea_buf->new_ea is not initialized properly.

Fix this by using memset to empty its content at the beginning
in ea_get().

Reported-by: syzbot+02341e0daa42a15ce130@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=02341e0daa42a15ce130
Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/xattr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index 17faf8d355290..49e064c1f5517 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -434,6 +434,8 @@ static int ea_get(struct inode *inode, struct ea_buffer *ea_buf, int min_size)
 	int rc;
 	int quota_allocation = 0;
 
+	memset(&ea_buf->new_ea, 0, sizeof(ea_buf->new_ea));
+
 	/* When fsck.jfs clears a bad ea, it doesn't clear the size */
 	if (ji->ea.flag == 0)
 		ea_size = 0;
-- 
2.43.0


