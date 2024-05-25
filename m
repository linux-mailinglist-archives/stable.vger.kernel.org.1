Return-Path: <stable+bounces-46161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D845D8CEFA5
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 17:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A96D1C20991
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 15:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFBD634E2;
	Sat, 25 May 2024 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EBNx1Rfo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5232A107A6
	for <stable@vger.kernel.org>; Sat, 25 May 2024 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716649551; cv=none; b=SqdiTH4EBE/UwbkygVXGkdySgaZR59+CWqK82YZJm+uVoy9Z1HEDJh6keFhA8XfOqK8QyorRCHr530DwBqV6dZTQXLc7ZXdz/5uWbrmv8KI4veLJ1mDXo8DtI4oWiLfFJko5hFKfUZqBJoS/nOE64Pnddc4SrEtrnRjpy5ddTqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716649551; c=relaxed/simple;
	bh=TXXIwhETfNNK2NCaMBEakKO9cVVJms9+Bq/KoFX9FfU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=W49IpXOPbX7YmHnm0u2P5hiqdKxXwC5Fpq3USZM2e8Hstm3WehOFgvwx1RL+PELqgUPlXXsO7togFrcHPTPNcq50w5/OWa98lL0tEtlObKSb57GCwIximWZ6QwHxSuyqkRyDWqEOlh1tli5xyx4GPjs/ybsg6bUessDdmFu843U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EBNx1Rfo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791B3C2BD11;
	Sat, 25 May 2024 15:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716649550;
	bh=TXXIwhETfNNK2NCaMBEakKO9cVVJms9+Bq/KoFX9FfU=;
	h=Subject:To:Cc:From:Date:From;
	b=EBNx1RfoTg4BUZadNEGSDZqY1SB+q3Oo+EvmFt1/X78uYlylcSsVAD19grAQvDUAG
	 F2fSFOEvxdCDDoAUVz0+0RIIflWlJpa4duRSINWD2wc+S+/aPAJB7AVDgNLT74AoBG
	 mx5n70xUOnm0N7BTGFw0weD18XULRiSGaZlVHwzM=
Subject: FAILED: patch "[PATCH] io_uring: fail NOP if non-zero op flags is passed in" failed to apply to 5.15-stable tree
To: ming.lei@redhat.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 25 May 2024 17:05:48 +0200
Message-ID: <2024052547-overdraft-murmuring-02fd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 3d8f874bd620ce03f75a5512847586828ab86544
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024052547-overdraft-murmuring-02fd@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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
 


