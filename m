Return-Path: <stable+bounces-133009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0E0A9199C
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA78E461701
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06B91E521A;
	Thu, 17 Apr 2025 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yvuSWivG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814252AE90
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744886776; cv=none; b=H3DWm4zSycxBXeHH1WBqVqvT/Ti3Zi4tkpWWqDSzWhvDSNK3OH0j7PS9jAXuMTwVBrC6ey0zxdmc/VeUSqS+yHKD2Zwwi2UlNGejroM2eIoPXt+Xka4LOplaXq68C1pEN2JB9MtS63glYrYFuoGghwxHEXmPovHBup5aV9qc+j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744886776; c=relaxed/simple;
	bh=8vxZkukKSqIFD8DyKOvTqjj4F5EGzQUswWKvV/nUSHw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qyLF6f7V0bNOBAzQfRotEH0EkW/8RpVp1M8Ro735OLQ96ip82psjn7EAHpomKCbkG46K129xP6lR6GzE+iIxPCpXipwSG/v0A99qsIectAFaMQdk6m42vL36c4xYU9IHmKQVHZ3FAoAXbCSPzbRZidJdFVSPtAtQak2vJGDpMHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yvuSWivG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EE1C4CEE7;
	Thu, 17 Apr 2025 10:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744886774;
	bh=8vxZkukKSqIFD8DyKOvTqjj4F5EGzQUswWKvV/nUSHw=;
	h=Subject:To:Cc:From:Date:From;
	b=yvuSWivG8d+uhLx1Eqjil+EbAlNsGmU4z+BwmlbKj+FH7LzXYa34lNdHTVPFEqgBk
	 jro1FtmG1DPDO8ugJMpRBxZ8donzgjMcHrCCJwZHccuAFgqYVO8CSHtPTJcMKqg1hg
	 di7V/UFUkdtK2tqQ8/IRtFCOQrS9oCQzCYgNJ/j4=
Subject: FAILED: patch "[PATCH] io_uring/net: fix accept multishot handling" failed to apply to 6.6-stable tree
To: asml.silence@gmail.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:46:11 +0200
Message-ID: <2025041711-juniper-slapstick-265c@gregkh>
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
git cherry-pick -x f6a89bf5278d6e15016a736db67043560d1b50d5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041711-juniper-slapstick-265c@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f6a89bf5278d6e15016a736db67043560d1b50d5 Mon Sep 17 00:00:00 2001
From: Pavel Begunkov <asml.silence@gmail.com>
Date: Sun, 23 Feb 2025 17:22:29 +0000
Subject: [PATCH] io_uring/net: fix accept multishot handling

REQ_F_APOLL_MULTISHOT doesn't guarantee it's executed from the multishot
context, so a multishot accept may get executed inline, fail
io_req_post_cqe(), and ask the core code to kill the request with
-ECANCELED by returning IOU_STOP_MULTISHOT even when a socket has been
accepted and installed.

Cc: stable@vger.kernel.org
Fixes: 390ed29b5e425 ("io_uring: add IORING_ACCEPT_MULTISHOT for accept")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/51c6deb01feaa78b08565ca8f24843c017f5bc80.1740331076.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/net.c b/io_uring/net.c
index 1d1107fd5beb..926cdb8d3350 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1641,6 +1641,8 @@ int io_accept(struct io_kiocb *req, unsigned int issue_flags)
 	}
 
 	io_req_set_res(req, ret, cflags);
+	if (!(issue_flags & IO_URING_F_MULTISHOT))
+		return IOU_OK;
 	return IOU_STOP_MULTISHOT;
 }
 


