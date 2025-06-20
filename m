Return-Path: <stable+bounces-154891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A99AE131B
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4FA97ABBFC
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554ED1F09BF;
	Fri, 20 Jun 2025 05:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T1PvJG7D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AFE1DED53
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 05:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398047; cv=none; b=cUKzN+emFNSOWh4JZ/oT6fW8nl1g5Ndc+BWGi3LW+ivh11q/3nF7yG77zlMvg1i4z8Nz1rdadRHQpWshD5CtHU+qiYpubK3Ak02Bw1NnZQs8IS3ORRtULUeisM/HsBgeFrDfecLkkX+0PUiBgjw+vUC9XX/HlAZf4rh1ZOgS97k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398047; c=relaxed/simple;
	bh=ZNI9E1ag8n84rJfhMzZzfkXqISB8xJ13AT714ZhlMeY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RRSdj/GXy2Wsr/7Jf0m2B7M8tOPw4IDMaOVnE1vuTvlilEVs1mdwTp6mGmv7+aoqXNq1RCCBrQDsXQpX55oAhQSbMTKXS8EO0hVHwuFYEk214FpoUg3SJc7MTXZ7WbHjMhkfXNhBj459NTL6TjTLrwz5Zsem8qye6+GTJnxgb2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T1PvJG7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FB0C4CEED;
	Fri, 20 Jun 2025 05:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750398046;
	bh=ZNI9E1ag8n84rJfhMzZzfkXqISB8xJ13AT714ZhlMeY=;
	h=Subject:To:Cc:From:Date:From;
	b=T1PvJG7DYUs1QGM1MFa2MLElBl3ebvWO16IG3uBMu9oSlbuaUukf9H7zoWODQa/US
	 2DKwTyArIRK7mk9IiaiqZ5GV8iGtBjwhurEQel6nCQKh7nBULslCQw6fzf/Pn+awNM
	 HqAued8bbs/4GvtoYacpY6+en7aJOr1/P6TLUdWA=
Subject: FAILED: patch "[PATCH] io_uring/kbuf: account ring io_buffer_list memory" failed to apply to 6.1-stable tree
To: asml.silence@gmail.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 07:40:44 +0200
Message-ID: <2025062043-header-audio-50d2@gregkh>
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
git cherry-pick -x 475a8d30371604a6363da8e304a608a5959afc40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062043-header-audio-50d2@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 475a8d30371604a6363da8e304a608a5959afc40 Mon Sep 17 00:00:00 2001
From: Pavel Begunkov <asml.silence@gmail.com>
Date: Tue, 13 May 2025 18:26:46 +0100
Subject: [PATCH] io_uring/kbuf: account ring io_buffer_list memory

Follow the non-ringed pbuf struct io_buffer_list allocations and account
it against the memcg. There is low chance of that being an actual
problem as ring provided buffer should either pin user memory or
allocate it, which is already accounted.

Cc: stable@vger.kernel.org # 6.1
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/3985218b50d341273cafff7234e1a7e6d0db9808.1747150490.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 1cf0d2c01287..446207db1edf 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -621,7 +621,7 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 		io_destroy_bl(ctx, bl);
 	}
 
-	free_bl = bl = kzalloc(sizeof(*bl), GFP_KERNEL);
+	free_bl = bl = kzalloc(sizeof(*bl), GFP_KERNEL_ACCOUNT);
 	if (!bl)
 		return -ENOMEM;
 


