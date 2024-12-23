Return-Path: <stable+bounces-105799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF369FB1BF
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 17:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3391F7A1185
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0ED188006;
	Mon, 23 Dec 2024 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SK8k0vb/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E7B19E971;
	Mon, 23 Dec 2024 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734970176; cv=none; b=Qo2qzY3JiU58A6wOnThYRsGF4sCR6aFzQZ1qMlWZcuc6xfb10b+HUSjS+aQj+GGIwKixSgCA1BTOeHTe9Eo9OLvm1zYrXs7tPslT5y+aEOIxwDkxYMV/maQnJurqNr6pfY8TNta86gdP5Up7sCjHauc+nla8/IvbgdRh5Sc6sgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734970176; c=relaxed/simple;
	bh=6nytv55gEgzgeFhznbnEEVuuZHhmKQMf0xK/XozFAkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6YiPnVa621a6isAnmjL0LZHwMMsgSiabmAuBqZfMMc48TGyzMHpUyOXLSUunJ8C+cpxmmsyWoUxRCtsougvKUT5qmanNxOMuEvGfsd+T9sG1LbSgrm1PXvG8vGjsnM163qkhcaNJlt20Rp9ekKDwwffzliBNiAG3T7PDUt7YuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SK8k0vb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAC9C4CED3;
	Mon, 23 Dec 2024 16:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734970176;
	bh=6nytv55gEgzgeFhznbnEEVuuZHhmKQMf0xK/XozFAkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SK8k0vb/iMJLsXpRsTqUrhHcSm/AVmjpM2y+hT7cdLHaEFhalyxR/GOide681r3eG
	 uElrWlw8lRRBa2sEb+7F52wJozBM65JpuGsxnB3ueHBoaGOXJGQde7J7Z6C6a7k70R
	 fS8PhBAcavPHw5QEPw+MKrwLRthucHHfN0ouRwgo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 6.12 153/160] ceph: improve error handling and short/overflow-read logic in __ceph_sync_read()
Date: Mon, 23 Dec 2024 16:59:24 +0100
Message-ID: <20241223155414.726767191@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223155408.598780301@linuxfoundation.org>
References: <20241223155408.598780301@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Markuze <amarkuze@redhat.com>

commit 9abee475803fab6ad59d4f4fc59c6a75374a7d9d upstream.

This patch refines the read logic in __ceph_sync_read() to ensure more
predictable and efficient behavior in various edge cases.

- Return early if the requested read length is zero or if the file size
  (`i_size`) is zero.
- Initialize the index variable (`idx`) where needed and reorder some
  code to ensure it is always set before use.
- Improve error handling by checking for negative return values earlier.
- Remove redundant encrypted file checks after failures. Only attempt
  filesystem-level decryption if the read succeeded.
- Simplify leftover calculations to correctly handle cases where the
  read extends beyond the end of the file or stops short.  This can be
  hit by continuously reading a file while, on another client, we keep
  truncating and writing new data into it.
- This resolves multiple issues caused by integer and consequent buffer
  overflow (`pages` array being accessed beyond `num_pages`):
  - https://tracker.ceph.com/issues/67524
  - https://tracker.ceph.com/issues/68980
  - https://tracker.ceph.com/issues/68981

Cc: stable@vger.kernel.org
Fixes: 1065da21e5df ("ceph: stop copying to iter at EOF on sync reads")
Reported-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ceph/file.c |   29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1066,7 +1066,7 @@ ssize_t __ceph_sync_read(struct inode *i
 	if (ceph_inode_is_shutdown(inode))
 		return -EIO;
 
-	if (!len)
+	if (!len || !i_size)
 		return 0;
 	/*
 	 * flush any page cache pages in this range.  this
@@ -1086,7 +1086,7 @@ ssize_t __ceph_sync_read(struct inode *i
 		int num_pages;
 		size_t page_off;
 		bool more;
-		int idx;
+		int idx = 0;
 		size_t left;
 		struct ceph_osd_req_op *op;
 		u64 read_off = off;
@@ -1160,7 +1160,14 @@ ssize_t __ceph_sync_read(struct inode *i
 		else if (ret == -ENOENT)
 			ret = 0;
 
-		if (ret > 0 && IS_ENCRYPTED(inode)) {
+		if (ret < 0) {
+			ceph_osdc_put_request(req);
+			if (ret == -EBLOCKLISTED)
+				fsc->blocklisted = true;
+			break;
+		}
+
+		if (IS_ENCRYPTED(inode)) {
 			int fret;
 
 			fret = ceph_fscrypt_decrypt_extents(inode, pages,
@@ -1189,7 +1196,7 @@ ssize_t __ceph_sync_read(struct inode *i
 		ceph_osdc_put_request(req);
 
 		/* Short read but not EOF? Zero out the remainder. */
-		if (ret >= 0 && ret < len && (off + ret < i_size)) {
+		if (ret < len && (off + ret < i_size)) {
 			int zlen = min(len - ret, i_size - off - ret);
 			int zoff = page_off + ret;
 
@@ -1199,13 +1206,11 @@ ssize_t __ceph_sync_read(struct inode *i
 			ret += zlen;
 		}
 
-		idx = 0;
-		if (ret <= 0)
-			left = 0;
-		else if (off + ret > i_size)
-			left = i_size - off;
+		if (off + ret > i_size)
+			left = (i_size > off) ? i_size - off : 0;
 		else
 			left = ret;
+
 		while (left > 0) {
 			size_t plen, copied;
 
@@ -1223,12 +1228,6 @@ ssize_t __ceph_sync_read(struct inode *i
 		}
 		ceph_release_page_vector(pages, num_pages);
 
-		if (ret < 0) {
-			if (ret == -EBLOCKLISTED)
-				fsc->blocklisted = true;
-			break;
-		}
-
 		if (off >= i_size || !more)
 			break;
 	}



