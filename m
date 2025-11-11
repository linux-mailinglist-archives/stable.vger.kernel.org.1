Return-Path: <stable+bounces-193686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD12C4A9AB
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6891888030
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F5B3491E1;
	Tue, 11 Nov 2025 01:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rcxA1RbK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11C63491D0;
	Tue, 11 Nov 2025 01:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823772; cv=none; b=jCRa6axn0qb9gXr2gKub1iMRbsSQI0vppu9Nd4A5YN5iESoyiZNq0TFhb1jitnH3WAJe5i+JAXFS/wjsNgSPpJMK3Pdi+Ba8nqeLBZL1uxZiipzSnTDayYLvlrTcVJH+pGyKefUVDS2boVGrKoDxZAz3LkafrKIuwJsqNKqSDZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823772; c=relaxed/simple;
	bh=rbiWdiEQvavoRTWSS5Iwt6RFrPpO5seXLFZLs/QPFzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=reZnYqf12wkfeYOvgRxsgma5IcLvfAx+39njWrcbOEYxC6Ig0B5LUTatfFA+YD1qLD2ltRsVA2/iVs0hLEG715inQ0iqiJSPMi7d4868k9GzB+zVGBmVv5X0KK7tzbsFxKQ7yM74LSFom4nQdLdEY3kPyGkC3iahY5o1UVO+I9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rcxA1RbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D708C2BC86;
	Tue, 11 Nov 2025 01:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762823772;
	bh=rbiWdiEQvavoRTWSS5Iwt6RFrPpO5seXLFZLs/QPFzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rcxA1RbKO61mkdhG+SCM/qKTHcWNEwpLThw5xeq8a6KenE/TGgkEqAdMv5YtNpu4/
	 QcstLLbYcabwtt4XBvIr2mVU7g20wz3+QPIQRr5Q4FaA+yTl4uX+fcKuygHyh70Q62
	 qKI0GAzmAblvno4eVJP/4e+ck+APb3VM4+lsB5Pw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chunsheng Luo <luochunsheng@ustc.edu>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 366/849] fuse: zero initialize inode private data
Date: Tue, 11 Nov 2025 09:38:56 +0900
Message-ID: <20251111004545.269806099@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit 3ca1b311181072415b6432a169de765ac2034e5a ]

This is slightly tricky, since the VFS uses non-zeroing allocation to
preserve some fields that are left in a consistent state.

Reported-by: Chunsheng Luo <luochunsheng@ustc.edu>
Closes: https://lore.kernel.org/all/20250818083224.229-1-luochunsheng@ustc.edu/
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/inode.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 7ddfd2b3cc9c4..7c0403a002e75 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -101,14 +101,11 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	if (!fi)
 		return NULL;
 
-	fi->i_time = 0;
+	/* Initialize private data (i.e. everything except fi->inode) */
+	BUILD_BUG_ON(offsetof(struct fuse_inode, inode) != 0);
+	memset((void *) fi + sizeof(fi->inode), 0, sizeof(*fi) - sizeof(fi->inode));
+
 	fi->inval_mask = ~0;
-	fi->nodeid = 0;
-	fi->nlookup = 0;
-	fi->attr_version = 0;
-	fi->orig_ino = 0;
-	fi->state = 0;
-	fi->submount_lookup = NULL;
 	mutex_init(&fi->mutex);
 	spin_lock_init(&fi->lock);
 	fi->forget = fuse_alloc_forget();
-- 
2.51.0




