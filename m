Return-Path: <stable+bounces-74403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A5D972F24
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76038B27610
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D6618E773;
	Tue, 10 Sep 2024 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zd5EB+Ad"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC07186E4B;
	Tue, 10 Sep 2024 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961702; cv=none; b=P0fexCFcTbhJJHy1+MyK7O+9IIf7gkZqojj+HPIg8sceVwOnC5Yxn8QVErCQ6eysOPbAxJOrqnT1TqhS0al+bFk5i/2L71Wv/xq2nYK/Dz81pnUSyhNKuXvcqEzZw5fFH9TsiKr7b48NN+/lRTm3AaqrnEX6edzCspwSdE65GIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961702; c=relaxed/simple;
	bh=lE1oT+5iF23iWkrP70v4jhMMFk1xlq9XOb4tqwTficM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+P+EEGPpW2stM7vPkWqOFNkE3pVhmwDurxy13wlclEmnpdJAZ+3xVmGI+EkGVr9kj/RWOleC1xTRIrxeB0qSmG7konZcQmonKDdgsOkNZIBDCvJN835ZbsZmdn0ZZkX7rqjxCZGSvRzkCitB4rzcqBYto0U7VIH0e+ykmCE1kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zd5EB+Ad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D3AC4CEC3;
	Tue, 10 Sep 2024 09:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961702;
	bh=lE1oT+5iF23iWkrP70v4jhMMFk1xlq9XOb4tqwTficM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zd5EB+AdnwX73g+zjq0CRV+4Pc2/EeMXqioocaSUyuO0ziV9ftFPF/xH3VUcV2vzW
	 P8I6N/96YH/vKjusl3gkFlr1LqfUzuIvzn5UNL+Yyux2AQ/gxCR5ItB7ivgc9pW7xm
	 DmQqA7eZGZy4vAnny66fBb+Pg9+U6epVeuXDLu6I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Steve French <stfrench@microsoft.com>,
	Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
	Pavel Shilovsky <pshilov@microsoft.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-cifs@vger.kernel.org,
	linux-mm@kvack.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 159/375] cifs: Fix FALLOC_FL_ZERO_RANGE to preflush buffered part of target region
Date: Tue, 10 Sep 2024 11:29:16 +0200
Message-ID: <20240910092627.818785133@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 91d1dfae464987aaf6c79ff51d8674880fb3be77 ]

Under certain conditions, the range to be cleared by FALLOC_FL_ZERO_RANGE
may only be buffered locally and not yet have been flushed to the server.
For example:

	xfs_io -f -t -c "pwrite -S 0x41 0 4k" \
		     -c "pwrite -S 0x42 4k 4k" \
		     -c "fzero 0 4k" \
		     -c "pread -v 0 8k" /xfstest.test/foo

will write two 4KiB blocks of data, which get buffered in the pagecache,
and then fallocate() is used to clear the first 4KiB block on the server -
but we don't flush the data first, which means the EOF position on the
server is wrong, and so the FSCTL_SET_ZERO_DATA RPC fails (and xfs_io
ignores the error), but then when we try to read it, we see the old data.

Fix this by preflushing any part of the target region that above the
server's idea of the EOF position to force the server to update its EOF
position.

Note, however, that we don't want to simply expand the file by moving the
EOF before doing the FSCTL_SET_ZERO_DATA[*] because someone else might see
the zeroed region or if the RPC fails we then have to try to clean it up or
risk getting corruption.

[*] And we have to move the EOF first otherwise FSCTL_SET_ZERO_DATA won't
do what we want.

This fixes the generic/008 xfstest.

[!] Note: A better way to do this might be to split the operation into two
parts: we only do FSCTL_SET_ZERO_DATA for the part of the range below the
server's EOF and then, if that worked, invalidate the buffered pages for the
part above the range.

Fixes: 6b69040247e1 ("cifs/smb3: Fix data inconsistent when zero file range")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <stfrench@microsoft.com>
cc: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
cc: Pavel Shilovsky <pshilov@microsoft.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-mm@kvack.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2ops.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 42352f70b01c..1d6e8eacdd74 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3219,13 +3219,15 @@ static long smb3_zero_data(struct file *file, struct cifs_tcon *tcon,
 }
 
 static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
-			    loff_t offset, loff_t len, bool keep_size)
+			    unsigned long long offset, unsigned long long len,
+			    bool keep_size)
 {
 	struct cifs_ses *ses = tcon->ses;
 	struct inode *inode = file_inode(file);
 	struct cifsInodeInfo *cifsi = CIFS_I(inode);
 	struct cifsFileInfo *cfile = file->private_data;
-	unsigned long long new_size;
+	struct netfs_inode *ictx = netfs_inode(inode);
+	unsigned long long i_size, new_size, remote_size;
 	long rc;
 	unsigned int xid;
 
@@ -3237,6 +3239,16 @@ static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
 	inode_lock(inode);
 	filemap_invalidate_lock(inode->i_mapping);
 
+	i_size = i_size_read(inode);
+	remote_size = ictx->remote_i_size;
+	if (offset + len >= remote_size && offset < i_size) {
+		unsigned long long top = umin(offset + len, i_size);
+
+		rc = filemap_write_and_wait_range(inode->i_mapping, offset, top - 1);
+		if (rc < 0)
+			goto zero_range_exit;
+	}
+
 	/*
 	 * We zero the range through ioctl, so we need remove the page caches
 	 * first, otherwise the data may be inconsistent with the server.
-- 
2.43.0




