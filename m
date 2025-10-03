Return-Path: <stable+bounces-183218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EBBBB6F65
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 15:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CDF2188E977
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 13:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00152F0C55;
	Fri,  3 Oct 2025 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mkrFUXyi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04919D8A3
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759497181; cv=none; b=WFzaPOlb0SwLWsR4fOmy4s9E5u7luv3FPJr18MvqdoYN68MYVExmypRkcvsbY42v5FPuZz4C8NNOKKNJ/gfJFbKzlZhr0k7vOyblxaeM0lMUuW4lg/F0TbuXeOtkrlBW8MzL0a4rClj6LgMR6rJQ7zHbBQD4Ae1DOG9pAr96W2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759497181; c=relaxed/simple;
	bh=gBDagRjjXx1W7tSYNxk8a7rTy7A07zg+MOvbvPN78ac=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CaCS7YZSfN+Vv9AlhDpsW4NNWVQrKz6yarhvtzZVbWClV94/znlWOLP6uGJUgLBfurAgAa5hHZbcd+mplQe+vaDkrrCOYscjgIySWa0a3NpxYX6WfE7upeItby3Fm5NK9GO+6r7iK+lnuT2Bmn86aPaNN8e7a0JiuPbYbkm5yn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mkrFUXyi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AA2C4CEF5;
	Fri,  3 Oct 2025 13:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759497181;
	bh=gBDagRjjXx1W7tSYNxk8a7rTy7A07zg+MOvbvPN78ac=;
	h=Subject:To:Cc:From:Date:From;
	b=mkrFUXyiMWcJVhIlR4gVlv6EcTfQzhB244Ow4KX98Lb8ffjXPjxy2czsFRFlYHC6I
	 fhmQGo04XE39Jy9m8tHmbho49llpubX3tbe32bU3QHNKkVrb3amAsxPIlnuz3i5Vnv
	 Oz4dzZjI2zWccePI9vryDWclEMQj1Y/5Yslc7uI0=
Subject: FAILED: patch "[PATCH] media: tuner: xc5000: Fix use-after-free in xc5000_release
[hverkuil: fix typo in tunner -> tuner]" failed to apply to 5.10-stable tree
To: duoming@zju.edu.cn,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 03 Oct 2025 15:12:41 +0200
Message-ID: <2025100341-cobbler-alabaster-748a@gregkh>
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
git cherry-pick -x 40b7a19f321e65789612ebaca966472055dab48c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025100341-cobbler-alabaster-748a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 40b7a19f321e65789612ebaca966472055dab48c Mon Sep 17 00:00:00 2001
From: Duoming Zhou <duoming@zju.edu.cn>
Date: Wed, 17 Sep 2025 17:56:08 +0800
Subject: [PATCH] media: tuner: xc5000: Fix use-after-free in xc5000_release

The original code uses cancel_delayed_work() in xc5000_release(), which
does not guarantee that the delayed work item timer_sleep has fully
completed if it was already running. This leads to use-after-free scenarios
where xc5000_release() may free the xc5000_priv while timer_sleep is still
active and attempts to dereference the xc5000_priv.

A typical race condition is illustrated below:

CPU 0 (release thread)                 | CPU 1 (delayed work callback)
xc5000_release()                       | xc5000_do_timer_sleep()
  cancel_delayed_work()                |
  hybrid_tuner_release_state(priv)     |
    kfree(priv)                        |
                                       |   priv = container_of() // UAF

Replace cancel_delayed_work() with cancel_delayed_work_sync() to ensure
that the timer_sleep is properly canceled before the xc5000_priv memory
is deallocated.

A deadlock concern was considered: xc5000_release() is called in a process
context and is not holding any locks that the timer_sleep work item might
also need. Therefore, the use of the _sync() variant is safe here.

This bug was initially identified through static analysis.

Fixes: f7a27ff1fb77 ("[media] xc5000: delay tuner sleep to 5 seconds")
Cc: stable@vger.kernel.org
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[hverkuil: fix typo in Subject: tunner -> tuner]

diff --git a/drivers/media/tuners/xc5000.c b/drivers/media/tuners/xc5000.c
index bf4ff461e082..a28481edd22e 100644
--- a/drivers/media/tuners/xc5000.c
+++ b/drivers/media/tuners/xc5000.c
@@ -1304,7 +1304,7 @@ static void xc5000_release(struct dvb_frontend *fe)
 	mutex_lock(&xc5000_list_mutex);
 
 	if (priv) {
-		cancel_delayed_work(&priv->timer_sleep);
+		cancel_delayed_work_sync(&priv->timer_sleep);
 		hybrid_tuner_release_state(priv);
 	}
 


