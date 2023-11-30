Return-Path: <stable+bounces-3228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B4B7FF1CC
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 15:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61031281F46
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 14:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34BC487AF;
	Thu, 30 Nov 2023 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PXii2TuX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964FC51C33
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 14:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D99C433C8;
	Thu, 30 Nov 2023 14:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701354686;
	bh=vmcKCeyHsc9zN1g20uYhbEB194HdoxYMvBMfRNWrST4=;
	h=Subject:To:Cc:From:Date:From;
	b=PXii2TuX6d97pVT3Qw9mgcgnj4ns7CnKhPw58LiQxxBgZVipfkLp0wkf9/5bz5uNE
	 1P7BGFNbiGHs9Cmv937phP+0B7puOrDvTYbnFuf+viXo+oS6sVhTyiWJUAj0ZGsQZc
	 N6E4mhNH7TCApnv4V1InfwLDbnGCzmEuaZV7p+3w=
Subject: FAILED: patch "[PATCH] io_uring: fix off-by one bvec index" failed to apply to 6.1-stable tree
To: kbusch@kernel.org,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 30 Nov 2023 14:31:23 +0000
Message-ID: <2023113023-heaviness-easel-554e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d6fef34ee4d102be448146f24caf96d7b4a05401
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023113023-heaviness-easel-554e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

d6fef34ee4d1 ("io_uring: fix off-by one bvec index")
57bebf807e2a ("io_uring/rsrc: optimise registered huge pages")
b000ae0ec2d7 ("io_uring/rsrc: optimise single entry advance")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d6fef34ee4d102be448146f24caf96d7b4a05401 Mon Sep 17 00:00:00 2001
From: Keith Busch <kbusch@kernel.org>
Date: Mon, 20 Nov 2023 14:18:31 -0800
Subject: [PATCH] io_uring: fix off-by one bvec index

If the offset equals the bv_len of the first registered bvec, then the
request does not include any of that first bvec. Skip it so that drivers
don't have to deal with a zero length bvec, which was observed to break
NVMe's PRP list creation.

Cc: stable@vger.kernel.org
Fixes: bd11b3a391e3 ("io_uring: don't use iov_iter_advance() for fixed buffers")
Signed-off-by: Keith Busch <kbusch@kernel.org>
Link: https://lore.kernel.org/r/20231120221831.2646460-1-kbusch@meta.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 7034be555334..f521c5965a93 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1258,7 +1258,7 @@ int io_import_fixed(int ddir, struct iov_iter *iter,
 		 */
 		const struct bio_vec *bvec = imu->bvec;
 
-		if (offset <= bvec->bv_len) {
+		if (offset < bvec->bv_len) {
 			/*
 			 * Note, huge pages buffers consists of one large
 			 * bvec entry and should always go this way. The other


