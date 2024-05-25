Return-Path: <stable+bounces-46162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE55C8CEFA6
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 17:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B4322814A4
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 15:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696A9634E2;
	Sat, 25 May 2024 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jDAvFsuA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A82A107A6
	for <stable@vger.kernel.org>; Sat, 25 May 2024 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716649560; cv=none; b=WFTfIUs9TjxiMixUz0ofKhyRInam10MBR+hXvnOYCQaTK+7Ezwln1OWPwMBw0CkS/dmerbV0k7ayO5sBN0d2VYlao6ScZZn3hg/zU2kQkYYSUBC3kfeU/09QxKM6EhYNCxyiyRx/Dw2tFxY/asuKl+miUxckdFcqxJuOwUAVo+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716649560; c=relaxed/simple;
	bh=sMcqgGXNPrUf01OSejkPN91lbjb+pod529DR7L7XDL0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RAs1738PFx9/KAtk4FXruyDxmeQp6kGAGn7zOapL13vgqQTiitP8T8G+LDOT3pkR/M6Ku8pvssRfsXBP7nIRNSVJSUl+a8pDsFyDrrVGSyu2oOqkfpF8Q7+5D27BCL0LY9/X3/q99yGorwCefV5dcV1CRA4NfKJuV2x791F2LDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jDAvFsuA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41770C2BD11;
	Sat, 25 May 2024 15:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716649559;
	bh=sMcqgGXNPrUf01OSejkPN91lbjb+pod529DR7L7XDL0=;
	h=Subject:To:Cc:From:Date:From;
	b=jDAvFsuAzhzN59suBu573ob5NCXIZs6kcdO07MzNWcSJjSJ82xIonBJGMcIL5m7Hd
	 JAmGU1aURkR1k+q7DtSlT4bTIlat834TztkKbiB2B1IlHqAtoPWHICns/f/JILYTZN
	 xUJfu62Rc7hNMmoU7HrQGBF41FvXT0lOYBqzqxUQ=
Subject: FAILED: patch "[PATCH] io_uring: fail NOP if non-zero op flags is passed in" failed to apply to 5.10-stable tree
To: ming.lei@redhat.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 25 May 2024 17:05:48 +0200
Message-ID: <2024052548-prance-gliding-4f31@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 3d8f874bd620ce03f75a5512847586828ab86544
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024052548-prance-gliding-4f31@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
 


