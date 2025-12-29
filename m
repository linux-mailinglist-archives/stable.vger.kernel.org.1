Return-Path: <stable+bounces-203637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BA7CE718C
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6A78303E007
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897CF322C81;
	Mon, 29 Dec 2025 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k1zuvCgc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CFC32142E
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767019222; cv=none; b=SpYAUqRZ5iNpSUrEOy0hJvKs+bN7PkAUTxGR5IwJ6TK1utpkdMjSFblZESGNAHMWq376FOehIQKNEbMeTdvnA7RkvArHefAuJoZSBX1RqthWXyVc6f2GG2AmGRur398GtSoKTEYMNTm5ZAJRx2BJfqHDjzqiSkLp5QLIvhFbV4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767019222; c=relaxed/simple;
	bh=sfk3MAYrLdeA9HubAPG/9NoXr05HMDCR/OTYT9l2e8I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BMd6NQfsJVtzdoa7YD6Of9dIUBSqRADKPR8AOC+oYJUGD/8ledFUHEst98pF9ahRMqZW+XnT22t+i6dpNga4mMbasNKeL6q0rt8Xpat/Q4Q9hyouvVnpUaTjrRUVIB7kAr+p8yi6urcZZCDVkbR37ixspEtGhm/q4piV8HMJN7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k1zuvCgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C17C116C6;
	Mon, 29 Dec 2025 14:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767019222;
	bh=sfk3MAYrLdeA9HubAPG/9NoXr05HMDCR/OTYT9l2e8I=;
	h=Subject:To:Cc:From:Date:From;
	b=k1zuvCgcMPIfJmgyXmwaFxT/dMkqoU75I9Xltqd254OEfF755LjKwoZxV5VvrP2zd
	 3T0lv55XkIdcEdlVn/pKNPHiv8xb7OojuyTNIpFr+HwKk8jKkmJ2BFgmmW0oa99tBB
	 PvqnU4eKIQNX0ykUaHJfwfaqX2Hpi/cnV+9QG4nc=
Subject: FAILED: patch "[PATCH] svcrdma: bound check rq_pages index in inline path" failed to apply to 5.1-stable tree
To: linux@joshua.hu,chuck.lever@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 15:40:19 +0100
Message-ID: <2025122919-skirt-skittle-4fab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.1.y
git checkout FETCH_HEAD
git cherry-pick -x d1bea0ce35b6095544ee82bb54156fc62c067e58
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122919-skirt-skittle-4fab@gregkh' --subject-prefix 'PATCH 5.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d1bea0ce35b6095544ee82bb54156fc62c067e58 Mon Sep 17 00:00:00 2001
From: Joshua Rogers <linux@joshua.hu>
Date: Fri, 7 Nov 2025 10:09:49 -0500
Subject: [PATCH] svcrdma: bound check rq_pages index in inline path

svc_rdma_copy_inline_range indexed rqstp->rq_pages[rc_curpage] without
verifying rc_curpage stays within the allocated page array. Add guards
before the first use and after advancing to a new page.

Fixes: d7cc73972661 ("svcrdma: support multiple Read chunks per RPC")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index e813e5463352..310de7a80be5 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -841,6 +841,9 @@ static int svc_rdma_copy_inline_range(struct svc_rqst *rqstp,
 	for (page_no = 0; page_no < numpages; page_no++) {
 		unsigned int page_len;
 
+		if (head->rc_curpage >= rqstp->rq_maxpages)
+			return -EINVAL;
+
 		page_len = min_t(unsigned int, remaining,
 				 PAGE_SIZE - head->rc_pageoff);
 


