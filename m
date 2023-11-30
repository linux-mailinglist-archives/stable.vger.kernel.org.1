Return-Path: <stable+bounces-3231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C924A7FF1D6
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 15:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0586D1C20DA9
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 14:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7907A487AF;
	Thu, 30 Nov 2023 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OrMCa2pm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D67051001
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 14:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FCEC433C8;
	Thu, 30 Nov 2023 14:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701354700;
	bh=Mc3Q7Lqb6K00e9vYad1YKf9fMfL1wahq7acpMf2BTDg=;
	h=Subject:To:Cc:From:Date:From;
	b=OrMCa2pmFaPEsed2xjR/EVpDfCPR+39gYZ6RiZ8Jk0prJ93JDuNQ6dOGoJxTYVhB7
	 Gyrnporqu9MlAJpKkEZYFOMFliinnpXb9HX172Ix0p7fC5CUbiV7bu6GDdmb2Xqn6J
	 iqaNQ08IyXIV4VdYy5+KZcVYKBvTfu6r6JUkavx4=
Subject: FAILED: patch "[PATCH] io_uring: fix off-by one bvec index" failed to apply to 5.4-stable tree
To: kbusch@kernel.org,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 30 Nov 2023 14:31:26 +0000
Message-ID: <2023113025-eastbound-uninstall-c2e0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x d6fef34ee4d102be448146f24caf96d7b4a05401
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023113025-eastbound-uninstall-c2e0@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

d6fef34ee4d1 ("io_uring: fix off-by one bvec index")
57bebf807e2a ("io_uring/rsrc: optimise registered huge pages")
b000ae0ec2d7 ("io_uring/rsrc: optimise single entry advance")
c059f7858408 ("io_uring: move io_import_fixed()")
f337a84d3952 ("io_uring: opcode independent fixed buf import")
f3b44f92e59a ("io_uring: move read/write related opcodes to its own file")
c98817e6cd44 ("io_uring: move remaining file table manipulation to filetable.c")
735729844819 ("io_uring: move rsrc related data, core, and commands")
3b77495a9723 ("io_uring: split provided buffers handling into its own file")
7aaff708a768 ("io_uring: move cancelation into its own file")
329061d3e2f9 ("io_uring: move poll handling into its own file")
cfd22e6b3319 ("io_uring: add opcode name to io_op_defs")
92ac8beaea1f ("io_uring: include and forward-declaration sanitation")
c9f06aa7de15 ("io_uring: move io_uring_task (tctx) helpers into its own file")
a4ad4f748ea9 ("io_uring: move fdinfo helpers to its own file")
e5550a1447bf ("io_uring: use io_is_uring_fops() consistently")
17437f311490 ("io_uring: move SQPOLL related handling into its own file")
59915143e89f ("io_uring: move timeout opcodes and handling into its own file")
e418bbc97bff ("io_uring: move our reference counting into a header")
36404b09aa60 ("io_uring: move msg_ring into its own file")

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


