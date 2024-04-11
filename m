Return-Path: <stable+bounces-38783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA1C8A1061
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5641C21C21
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C1E1474BA;
	Thu, 11 Apr 2024 10:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VP9jiEog"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182C464CC0;
	Thu, 11 Apr 2024 10:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831577; cv=none; b=pDlXdKw+SuKinEKonWkwkAudmiMm/KcKGbAMbnpTPT9+0phc485DJnQvyUnJ6g2PcNf8fLjV59QDyr5Z/AbMywa51pj5olz1tAPJbl/DR/dD1Gw8ba+CJnBsKn6WBSrNZsGV5iSje8WbKl3qkcyonNSh9b+focJho9ngX6eIBDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831577; c=relaxed/simple;
	bh=FsPtQw5PWUvTiXfiaqWwk8k+pd46SAX0jW2HnzHtXCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwnFbpcdzdPC1Js97QbBz7r6qxFn7TMmoJQobmSVhn4MGKylHSE9HCE3609a5nNwx/RRok42K1wIF6TLMIvlp3lG50YSwWt3pK18n6JWOZLo3N1Iin9ns+FrLeqvv3uuClvrNdd8Ds2b2utnjhMcCj9cHeq5JvpiGHrgtNwaY20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VP9jiEog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9106FC433C7;
	Thu, 11 Apr 2024 10:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831577;
	bh=FsPtQw5PWUvTiXfiaqWwk8k+pd46SAX0jW2HnzHtXCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VP9jiEogXz39joqjbUU3MxNFftrcRa5w0tOCAlrveEk7NbuHU7kFOwH/HP9U0N7yX
	 KTRnPvcpGyyiTvLmzt9OMZhbxTqKZnaDYrQJLIt4Ab2sftFCaRxW21QnpyhPcRKzql
	 A4bY+pKkdAH/DxzC/+eLG/14gofMVSVMhNElZVyQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 054/294] fuse: dont unhash root
Date: Thu, 11 Apr 2024 11:53:37 +0200
Message-ID: <20240411095437.268156905@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>
References: <20240411095435.633465671@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit b1fe686a765e6c0d71811d825b5a1585a202b777 ]

The root inode is assumed to be always hashed.  Do not unhash the root
inode even if it is marked BAD.

Fixes: 5d069dbe8aaf ("fuse: fix bad inode")
Cc: <stable@vger.kernel.org> # v5.11
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/fuse_i.h | 1 -
 fs/fuse/inode.c  | 7 +++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ceaa6868386e6..33eb5fefc06b4 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -873,7 +873,6 @@ static inline bool fuse_stale_inode(const struct inode *inode, int generation,
 
 static inline void fuse_make_bad(struct inode *inode)
 {
-	remove_inode_hash(inode);
 	set_bit(FUSE_I_BAD, &get_fuse_inode(inode)->state);
 }
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 9ea175ff9c8e6..4a7ebccd359ee 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -352,8 +352,11 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	} else if (fuse_stale_inode(inode, generation, attr)) {
 		/* nodeid was reused, any I/O on the old inode should fail */
 		fuse_make_bad(inode);
-		iput(inode);
-		goto retry;
+		if (inode != d_inode(sb->s_root)) {
+			remove_inode_hash(inode);
+			iput(inode);
+			goto retry;
+		}
 	}
 done:
 	fi = get_fuse_inode(inode);
-- 
2.43.0




