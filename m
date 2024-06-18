Return-Path: <stable+bounces-53627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91A190D32F
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD9528142A
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5263513BC3F;
	Tue, 18 Jun 2024 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T9ylRmDH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D3A12CDB5
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717803; cv=none; b=AEKAobVC15zEbwGFvIoUDQF6vyb9bE2kq0OnsNIRo/1bq2U25p2d9NJatUY1xavx3f9JlJ8hSjpArhNvLLecJ5mo+U5qiZVqKRzDPGZncSnLHy/juLjeaTlae+NwG3P5x2/R761IJlvjiDBIx2YDTXdSuVXua+5f17cGBv8NR6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717803; c=relaxed/simple;
	bh=W1S+j+Cdi3Xl5X2uzMkVyG03Z8MIFUEpV0sjRkG5k80=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Qc8ARKBP6etKTEv/rnQRcATBoR0ahuifopoRKXihZHVFXiX04fMTKiLRw7p9qaBNlnBFyMrWwPFX2cxw77qN7e28ocbOGkbPwnQpjNCMMGlo0Jg5YoUSgRoHdp3XYnrp1643tiUrMa7YieLUtULOlg3Sh6BdOjok+FqE/6vPwUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T9ylRmDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABFEC3277B;
	Tue, 18 Jun 2024 13:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718717802;
	bh=W1S+j+Cdi3Xl5X2uzMkVyG03Z8MIFUEpV0sjRkG5k80=;
	h=Subject:To:Cc:From:Date:From;
	b=T9ylRmDHVX6Vhdllrw6sPKilkniQAsKA1q+30ePpyV817yCi+dnTbUni73jIAo2QE
	 G6B7v6kyZY3LK8+0ZLA+Z/Cd+cOgFSoQHCH4EVaIvxKwBbWopu55+aM/RAjdICzOA4
	 kXk00jFJv8iXSTK52c8zN1Xf1rLfjpUvPeQ6xmaA=
Subject: FAILED: patch "[PATCH] dma-buf: handle testing kthreads creation failure" failed to apply to 5.15-stable tree
To: pchelkin@ispras.ru,christian.koenig@amd.com,tjmercier@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Jun 2024 15:35:37 +0200
Message-ID: <2024061837-unclothed-composed-8a87@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6cb05d89fd62a76a9b74bd16211fb0930e89fea8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061837-unclothed-composed-8a87@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

6cb05d89fd62 ("dma-buf: handle testing kthreads creation failure")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6cb05d89fd62a76a9b74bd16211fb0930e89fea8 Mon Sep 17 00:00:00 2001
From: Fedor Pchelkin <pchelkin@ispras.ru>
Date: Wed, 22 May 2024 21:13:08 +0300
Subject: [PATCH] dma-buf: handle testing kthreads creation failure
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

kthread creation may possibly fail inside race_signal_callback(). In
such a case stop the already started threads, put the already taken
references to them and return with error code.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 2989f6451084 ("dma-buf: Add selftests for dma-fence")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Reviewed-by: T.J. Mercier <tjmercier@google.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240522181308.841686-1-pchelkin@ispras.ru
Signed-off-by: Christian König <christian.koenig@amd.com>

diff --git a/drivers/dma-buf/st-dma-fence.c b/drivers/dma-buf/st-dma-fence.c
index b7c6f7ea9e0c..6a1bfcd0cc21 100644
--- a/drivers/dma-buf/st-dma-fence.c
+++ b/drivers/dma-buf/st-dma-fence.c
@@ -540,6 +540,12 @@ static int race_signal_callback(void *arg)
 			t[i].before = pass;
 			t[i].task = kthread_run(thread_signal_callback, &t[i],
 						"dma-fence:%d", i);
+			if (IS_ERR(t[i].task)) {
+				ret = PTR_ERR(t[i].task);
+				while (--i >= 0)
+					kthread_stop_put(t[i].task);
+				return ret;
+			}
 			get_task_struct(t[i].task);
 		}
 


