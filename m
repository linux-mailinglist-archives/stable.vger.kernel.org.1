Return-Path: <stable+bounces-190526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE52C106AB
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 20:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 92EDD34F4C5
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF513314C3;
	Mon, 27 Oct 2025 18:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cXNW0Jm4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB72330B20;
	Mon, 27 Oct 2025 18:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591521; cv=none; b=GURT7Kn7Yz6Z8YO32fNgCnzDFNGpaMJdJ27QhbsFbuotVkulB3ASiM9cveUcStzvTuKw5sbrLkPJ2RyUK+ha9liQSZDJW8wMvmxhligU/fs5+ptVlkMUSKi6rJSX9zmIqMIqpVj5VNREc/bs9/A1jnrSfJWb/EetEAz1AEGZ64I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591521; c=relaxed/simple;
	bh=QWKxX6lCn2FPjGEjd1yuRT2dSQKrtVsbd5PlrOodIho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMVXpoPQydc+N4ddu5A7KWBCyXYaDVQrzDMWDtvTHdBpH6EYuIuStxyxuGBTgSTtKom4rrnrdXNmDCPAI68jOztSQCEijbgHeibpQpX3Ejw8qvWxEUTyInlNajv8jLaDoqExFg7vHIz5oP0ekSu067f6/cmkeBQCDKBmkqaNap4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cXNW0Jm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2327AC4CEF1;
	Mon, 27 Oct 2025 18:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761591520;
	bh=QWKxX6lCn2FPjGEjd1yuRT2dSQKrtVsbd5PlrOodIho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cXNW0Jm416cRlTLzcKhEgKeKOCYx7RKCGTQ0z5Q4swUCcIv8Z48VLMBKPVX23rqIY
	 8NXI8tb9Na5l5efeQBWouSiEgAR8r3yDI45Hqwn2UxSOisb145qbtYlFpQq86lGFlA
	 QZVAqGxyXZHWh3ddmUqxLD7JQ1Knwf3b0WhBJ62w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Pitre <nico@fluxnic.net>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 190/332] cramfs: Verify inode mode when loading from disk
Date: Mon, 27 Oct 2025 19:34:03 +0100
Message-ID: <20251027183529.699895990@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183524.611456697@linuxfoundation.org>
References: <20251027183524.611456697@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 4b90cfd1ec360..fda92e56ccd69 100644
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




