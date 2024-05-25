Return-Path: <stable+bounces-46163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDFC8CEFA7
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 17:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E290F1F214D4
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 15:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366F26518F;
	Sat, 25 May 2024 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qe638hks"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC317107A6
	for <stable@vger.kernel.org>; Sat, 25 May 2024 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716649564; cv=none; b=mk1j6tmVOCNWpC8HS8+qpYlFuJzSTZXm476A2gPeK0xvAT4JoRrt1jKVeczikKRphnVs3AwinBcCBAjQiJzMF+iUdm2ZHNx+wjD5PKXxQhM1mrRYvwvKP8nehOVLR9rOiXOfJ9QCMhY0/aF29bUJhCvF9uE5x8byvrbxCgizBmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716649564; c=relaxed/simple;
	bh=wL8bdn6xqcg36IbOcDdVmLyg1qfE3CRE33qHRFwdaQY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=q7wm5UNU1KOG6iBsWShShNKtPnF2aI+0jITvjwXGLnFRkXBHR7xbmoCRPKPsMuNazQIr2eAslswb5xLmODyZakgjOiXL83D7UDXZxzPFTCmO6FPLaIo2Rq+khtqtOtlppzIZW+hQaEYx85dmEZJxquMJf9GIcgow7wCgtwQPpFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qe638hks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26640C3277B;
	Sat, 25 May 2024 15:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716649562;
	bh=wL8bdn6xqcg36IbOcDdVmLyg1qfE3CRE33qHRFwdaQY=;
	h=Subject:To:Cc:From:Date:From;
	b=qe638hksyrthc0CXgY9jV7JcAU479pO8Glef9pkodKGGvZZMyD50v2y1bPkCf5TwQ
	 RnhK6/tikHpjUjvO6OEtOYUkNusTBJS3hSM/RT+4zOddPp17gGeGG7Rvdysbv25ie1
	 zkzw9/ph07Slp3GPPbP2mIPeJvw1CmeizjKqtJgU=
Subject: FAILED: patch "[PATCH] io_uring: fail NOP if non-zero op flags is passed in" failed to apply to 5.4-stable tree
To: ming.lei@redhat.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 25 May 2024 17:05:49 +0200
Message-ID: <2024052549-gyration-replica-129f@gregkh>
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
git cherry-pick -x 3d8f874bd620ce03f75a5512847586828ab86544
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024052549-gyration-replica-129f@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3d8f874bd620ce03f75a5512847586828ab86544 Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Fri, 10 May 2024 11:50:27 +0800
Subject: [PATCH] io_uring: fail NOP if non-zero op flags is passed in

The NOP op flags should have been checked from beginning like any other
opcode, otherwise NOP may not be extended with the op flags.

Given both liburing and Rust io-uring crate always zeros SQE op flags, just
ignore users which play raw NOP uring interface without zeroing SQE, because
NOP is just for test purpose. Then we can save one NOP2 opcode.

Suggested-by: Jens Axboe <axboe@kernel.dk>
Fixes: 2b188cc1bb85 ("Add io_uring IO interface")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20240510035031.78874-2-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/nop.c b/io_uring/nop.c
index d956599a3c1b..1a4e312dfe51 100644
--- a/io_uring/nop.c
+++ b/io_uring/nop.c
@@ -12,6 +12,8 @@
 
 int io_nop_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
+	if (READ_ONCE(sqe->rw_flags))
+		return -EINVAL;
 	return 0;
 }
 


