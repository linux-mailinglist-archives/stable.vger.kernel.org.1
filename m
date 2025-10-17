Return-Path: <stable+bounces-187638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02F8BEA9B6
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE3B7C4528
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B1E231C9F;
	Fri, 17 Oct 2025 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LIGd6Vbq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9F121C9EA;
	Fri, 17 Oct 2025 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716649; cv=none; b=qRfzpZ07u0a9HPzQQB9srveBJ7hkKP83Sn3oSlnzONnb2AtPDfFkX+azHQGlcVFAKtOoYCsHGQ3q/60Vz39oqcWstMWNWAkz/kkTd3YCGpWzYwxhxx80JZu/LXcbLurHy0ipHidIGarjSlu6J6hV8BE7OxOwNdsei4M1OwzOIXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716649; c=relaxed/simple;
	bh=+L08JIUTUPZkDvgIEczCGeb0NhUqaxzima7JcAYHlMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E46N0cXtKHUJuttrR5GgD826xLVIk/VB3uPceq1ntcCTVwKad0Jz1I7WHdv6PQTi/ehKqcO95or71MrTM0NwD7H83rw9Ypfu9yUKzw2qR3FjY9FJV3FVMT4fRUDXd9XD7V88EDWA/Sk8H6CPf1zJPnLKZPxzeUVo6t02tjY+R+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LIGd6Vbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D0BC4CEE7;
	Fri, 17 Oct 2025 15:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760716649;
	bh=+L08JIUTUPZkDvgIEczCGeb0NhUqaxzima7JcAYHlMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LIGd6VbqAGr/1hxFs6D0r+2uHHBi3uRF3y3mNyLpH5dfcSQ1ht89eWqEDuGmxv+wB
	 wilcfbol2UNL/RTxbYIu/BIgzK57kkaLp60JPSY5GAUeOoqjmsJkbbavXVP4hyic6v
	 CRLj9tvBlhlX49Yr0jnLKLfBzv4a9EN9eONWFqhI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Pitre <nico@fluxnic.net>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 264/276] cramfs: Verify inode mode when loading from disk
Date: Fri, 17 Oct 2025 16:55:57 +0200
Message-ID: <20251017145152.122609277@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
References: <20251017145142.382145055@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 7f9d34b0a7cb93d678ee7207f0634dbf79e47fe5 ]

The inode mode loaded from corrupted disk can be invalid. Do like what
commit 0a9e74051313 ("isofs: Verify inode mode when loading from disk")
does.

Reported-by: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Link: https://lore.kernel.org/429b3ef1-13de-4310-9a8e-c2dc9a36234a@I-love.SAKURA.ne.jp
Acked-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cramfs/inode.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 2be65269a987c..c893066e77ab4 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -117,9 +117,18 @@ static struct inode *get_cramfs_inode(struct super_block *sb,
 		inode_nohighmem(inode);
 		inode->i_data.a_ops = &cramfs_aops;
 		break;
-	default:
+	case S_IFCHR:
+	case S_IFBLK:
+	case S_IFIFO:
+	case S_IFSOCK:
 		init_special_inode(inode, cramfs_inode->mode,
 				old_decode_dev(cramfs_inode->size));
+		break;
+	default:
+		printk(KERN_DEBUG "CRAMFS: Invalid file type 0%04o for inode %lu.\n",
+		       inode->i_mode, inode->i_ino);
+		iget_failed(inode);
+		return ERR_PTR(-EIO);
 	}
 
 	inode->i_mode = cramfs_inode->mode;
-- 
2.51.0




