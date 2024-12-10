Return-Path: <stable+bounces-100353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FBD9EABBE
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF335283B34
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531FA13A41F;
	Tue, 10 Dec 2024 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hMrd0Awb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130A52AEE7
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822228; cv=none; b=vATZNKx7CV/7LfFaKdsaQiXsg9M3STzoXhIn00xc2fjk81YFbhgciSKe1TCtboG5D6xbcbzpyAdBU8QruPjpLOgyjFZziov133QF8CaOFeaQz26jyfWYpaHoG+qUNRXHel+9V/r1Y16w/+Q3zFWmuXOtIvuoMaV3wny9iYBl2U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822228; c=relaxed/simple;
	bh=7kn21MtGr9CyXdSs3GzhH/0IpumBAO5+4d89d6XTbDo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ssSjk7yR3ruijm1+LTjfeHQBoWk8wTbuApKLlXlqo0PYa7b/EsYiDzb35LHB7J15CqhW/RVdq1aMFf//MhEF3/67NRevrtH6305soB5Q8TTyZV++E8CYNxqEhktj7EzzN3Xao40SnYjTEaoov/MWsvd4yYXvqaQSAMzFgSfwq7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hMrd0Awb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F97DC4CED6;
	Tue, 10 Dec 2024 09:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733822228;
	bh=7kn21MtGr9CyXdSs3GzhH/0IpumBAO5+4d89d6XTbDo=;
	h=Subject:To:Cc:From:Date:From;
	b=hMrd0AwbVRP127PQodY03TsLJLgFIlwLF8spIKxNUQXQwDmTaGpZAK4SWXmyiXSyC
	 mxmh5ODFms3YqjOLbT2UPKBQujQpPmoIJY7M+tmlZCJwlWN7fTaQSQUyZZKV8jHgtP
	 pgEqjir4XrIpAw3d7+4boySqa9RLlmW28q8VLoh0=
Subject: FAILED: patch "[PATCH] io_uring: Change res2 parameter type in io_uring_cmd_done" failed to apply to 6.1-stable tree
To: bschubert@ddn.com,axboe@kernel.dk,joshi.k@samsung.com,lizetao1@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:16:23 +0100
Message-ID: <2024121023-scaling-reusable-1c2c@gregkh>
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
git cherry-pick -x a07d2d7930c75e6bf88683b376d09ab1f3fed2aa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121023-scaling-reusable-1c2c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a07d2d7930c75e6bf88683b376d09ab1f3fed2aa Mon Sep 17 00:00:00 2001
From: Bernd Schubert <bschubert@ddn.com>
Date: Tue, 3 Dec 2024 11:31:05 +0100
Subject: [PATCH] io_uring: Change res2 parameter type in io_uring_cmd_done

Change the type of the res2 parameter in io_uring_cmd_done from ssize_t
to u64. This aligns the parameter type with io_req_set_cqe32_extra,
which expects u64 arguments.
The change eliminates potential issues on 32-bit architectures where
ssize_t might be 32-bit.

Only user of passing res2 is drivers/nvme/host/ioctl.c and it actually
passes u64.

Fixes: ee692a21e9bf ("fs,io_uring: add infrastructure for uring-cmd")
Cc: stable@vger.kernel.org
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Tested-by: Li Zetao <lizetao1@huawei.com>
Reviewed-by: Li Zetao <lizetao1@huawei.com>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Link: https://lore.kernel.org/r/20241203-io_uring_cmd_done-res2-as-u64-v2-1-5e59ae617151@ddn.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 578a3fdf5c71..0d5448c0b86c 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -43,7 +43,7 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
  * Note: the caller should never hard code @issue_flags and is only allowed
  * to pass the mask provided by the core io_uring code.
  */
-void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret, ssize_t res2,
+void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret, u64 res2,
 			unsigned issue_flags);
 
 void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
@@ -67,7 +67,7 @@ static inline int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 	return -EOPNOTSUPP;
 }
 static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret,
-		ssize_t ret2, unsigned issue_flags)
+		u64 ret2, unsigned issue_flags)
 {
 }
 static inline void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index d9fb2143f56f..af842e9b4eb9 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -151,7 +151,7 @@ static inline void io_req_set_cqe32_extra(struct io_kiocb *req,
  * Called by consumers of io_uring_cmd, if they originally returned
  * -EIOCBQUEUED upon receiving the command.
  */
-void io_uring_cmd_done(struct io_uring_cmd *ioucmd, ssize_t ret, ssize_t res2,
+void io_uring_cmd_done(struct io_uring_cmd *ioucmd, ssize_t ret, u64 res2,
 		       unsigned issue_flags)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);


