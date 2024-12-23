Return-Path: <stable+bounces-105610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B9E9FAE0B
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 13:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D411884370
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 12:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456E8191478;
	Mon, 23 Dec 2024 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kUpTFaXJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C9C17BB6
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734955201; cv=none; b=sJ5zupgJQDP98wn5Gh0b7tVS0Et7DfP3zzSSLnYmHqPNq8vYBy7RcgGfYC+qgsLN8iS4m7dSuy1a2Y/QQ7z8bhflxmQBdlus2DFhL93T0yJ52fEocRJx5ZfAx6DQdFqhOoohPsGOWmcWhg++l9o+9p4PjZt4zm9U4xP6O1NlPXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734955201; c=relaxed/simple;
	bh=/EvxdFOeu9XIX9VXVT5NnUKGMIGEMTYeUgXaXY046Zw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tRyOuxbU0V+2ij6EEFupTLQU4x6aI8ZwDNPSU+iide5V7Cn26rUQPs8x3VI+wIkTskzOii6dwNc56NsWFznk5X+XUHpYY0C1BexlEW93IBLPZS8QEi0dp/x+CxROuQHcFymoHciilGktqElh+rfvrCTjtXIE52m2QwH+4RehsO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kUpTFaXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AB4C4CED3;
	Mon, 23 Dec 2024 12:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734955200;
	bh=/EvxdFOeu9XIX9VXVT5NnUKGMIGEMTYeUgXaXY046Zw=;
	h=Subject:To:Cc:From:Date:From;
	b=kUpTFaXJJXY9yuACEFhWxDr+9ITxP5F6mH5OI7ZqLeoc6KKHplH55WqUzXsoE+9OH
	 LtpzlX9cQGcyQoBkS+JmDJ8QQxwrNUIhxj8VEOm6hRq03Vra9FTI0aLZP9KWbBVEjR
	 H3Z3n70zfGrSXfXXN4LkJq6wCg+SFGhFcSjHjpEQ=
Subject: FAILED: patch "[PATCH] ceph: fix memory leak in ceph_direct_read_write()" failed to apply to 6.6-stable tree
To: idryomov@gmail.com,amarkuze@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Dec 2024 12:59:57 +0100
Message-ID: <2024122357-underuse-trousers-8f4d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 66e0c4f91461d17d48071695271c824620bed4ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122357-underuse-trousers-8f4d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 66e0c4f91461d17d48071695271c824620bed4ef Mon Sep 17 00:00:00 2001
From: Ilya Dryomov <idryomov@gmail.com>
Date: Fri, 6 Dec 2024 17:32:59 +0100
Subject: [PATCH] ceph: fix memory leak in ceph_direct_read_write()

The bvecs array which is allocated in iter_get_bvecs_alloc() is leaked
and pages remain pinned if ceph_alloc_sparse_ext_map() fails.

There is no need to delay the allocation of sparse_ext map until after
the bvecs array is set up, so fix this by moving sparse_ext allocation
a bit earlier.  Also, make a similar adjustment in __ceph_sync_read()
for consistency (a leak of the same kind in __ceph_sync_read() has been
addressed differently).

Cc: stable@vger.kernel.org
Fixes: 03bc06c7b0bd ("ceph: add new mount option to enable sparse reads")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 8e0400d461a2..67468d88f139 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1116,6 +1116,16 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 			len = read_off + read_len - off;
 		more = len < iov_iter_count(to);
 
+		op = &req->r_ops[0];
+		if (sparse) {
+			extent_cnt = __ceph_sparse_read_ext_count(inode, read_len);
+			ret = ceph_alloc_sparse_ext_map(op, extent_cnt);
+			if (ret) {
+				ceph_osdc_put_request(req);
+				break;
+			}
+		}
+
 		num_pages = calc_pages_for(read_off, read_len);
 		page_off = offset_in_page(off);
 		pages = ceph_alloc_page_vector(num_pages, GFP_KERNEL);
@@ -1129,16 +1139,6 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 						 offset_in_page(read_off),
 						 false, true);
 
-		op = &req->r_ops[0];
-		if (sparse) {
-			extent_cnt = __ceph_sparse_read_ext_count(inode, read_len);
-			ret = ceph_alloc_sparse_ext_map(op, extent_cnt);
-			if (ret) {
-				ceph_osdc_put_request(req);
-				break;
-			}
-		}
-
 		ceph_osdc_start_request(osdc, req);
 		ret = ceph_osdc_wait_request(osdc, req);
 
@@ -1551,6 +1551,16 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 			break;
 		}
 
+		op = &req->r_ops[0];
+		if (sparse) {
+			extent_cnt = __ceph_sparse_read_ext_count(inode, size);
+			ret = ceph_alloc_sparse_ext_map(op, extent_cnt);
+			if (ret) {
+				ceph_osdc_put_request(req);
+				break;
+			}
+		}
+
 		len = iter_get_bvecs_alloc(iter, size, &bvecs, &num_pages);
 		if (len < 0) {
 			ceph_osdc_put_request(req);
@@ -1560,6 +1570,8 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 		if (len != size)
 			osd_req_op_extent_update(req, 0, len);
 
+		osd_req_op_extent_osd_data_bvecs(req, 0, bvecs, num_pages, len);
+
 		/*
 		 * To simplify error handling, allow AIO when IO within i_size
 		 * or IO can be satisfied by single OSD request.
@@ -1591,17 +1603,6 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 			req->r_mtime = mtime;
 		}
 
-		osd_req_op_extent_osd_data_bvecs(req, 0, bvecs, num_pages, len);
-		op = &req->r_ops[0];
-		if (sparse) {
-			extent_cnt = __ceph_sparse_read_ext_count(inode, size);
-			ret = ceph_alloc_sparse_ext_map(op, extent_cnt);
-			if (ret) {
-				ceph_osdc_put_request(req);
-				break;
-			}
-		}
-
 		if (aio_req) {
 			aio_req->total_len += len;
 			aio_req->num_reqs++;


