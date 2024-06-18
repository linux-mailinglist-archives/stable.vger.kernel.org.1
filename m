Return-Path: <stable+bounces-53628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E9690D330
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFBC41C235A7
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF6F145B37;
	Tue, 18 Jun 2024 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kBSX8feh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407D312CDB5
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717806; cv=none; b=FZPyfq6VUPtGpDGXuPgjxmKL9rgbSPTjWGxd5+Mql8FvG1nHYjaQlLnXFoE+oCvFBnMRZAFRKLVVtC9kE5E6qedOelz4OivTMSTCRzjEUkN6jbAxUgtnzKdWokxjBV42/xsQtG3A/Onr8jqfRpn3kKNu7DKfbY738Oz2THn2JiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717806; c=relaxed/simple;
	bh=ckRyngj7qiLoarkDOZexB5meNFnbO0JAmGZ3ZhOrq9I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=U6hGbQnQrpvJ+iJZ/aiR54iKZJeCUvfks7zKP9cY+s3z5uRXPRDEArV6DK7Onsw6LEYMLT9T67o7xbJ3zR56Ij0nxaBrwdwuJWSOqBS1J6JqT8HuBQjq/I/k8jHzHkw6KGLXklEehOHJjw4tWTY0IRwpnvnk29KD5fKbEX//rso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kBSX8feh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFF9C32786;
	Tue, 18 Jun 2024 13:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718717805;
	bh=ckRyngj7qiLoarkDOZexB5meNFnbO0JAmGZ3ZhOrq9I=;
	h=Subject:To:Cc:From:Date:From;
	b=kBSX8fehXDIm6ESz6ZbKT4/Ezxs7k5nheYFHN9r7RC7nqDa0PkFM3wcfhSfLIOtJi
	 pTw7S9JhNZS3Zmg1zYt+QqZv8H+lSRfVnuzo/jNtwCLSsBRzU+zdFp2R3S9W5blHyO
	 RAQMYH90sPUI78mdS22+0DbbQuesq826AGnlMD4s=
Subject: FAILED: patch "[PATCH] dma-buf: handle testing kthreads creation failure" failed to apply to 6.1-stable tree
To: pchelkin@ispras.ru,christian.koenig@amd.com,tjmercier@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Jun 2024 15:35:37 +0200
Message-ID: <2024061836-game-handstand-9498@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6cb05d89fd62a76a9b74bd16211fb0930e89fea8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061836-game-handstand-9498@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 


