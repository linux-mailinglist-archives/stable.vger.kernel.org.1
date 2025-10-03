Return-Path: <stable+bounces-183219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 297FEBB6F68
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 15:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB1E1AE1C89
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 13:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D0D2F2D;
	Fri,  3 Oct 2025 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wKjmUvxb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB8B1C2334
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759497190; cv=none; b=VH7uO3rw+Mr/a5j81tSisBMuJgGhwG+zRIlX4gFYQDoumXsbP0c7s4vFew613uLGhu3Ti8TYDJdKsXMFonvxmFju+S+aBRejTrERpc8gtl/JV+tROPQOTSmJiSXoKHWQ7VgPbkgDCzLGszrtNMgAZzH6qr30RMpm3ppcge1jpDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759497190; c=relaxed/simple;
	bh=a+MTtxeoagXguXl5hnSQni8/dsfGpF3bkJQvgCil0Nw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=I0mSoew6y0IvuN8+ahvn/bycucCI96Bzpcmy3P+Ror7ZNa8hSy8gsb0eXp8LPhevooqePxPgZFuAxGaH9oqtHxmo6OdkWZjSBwLyUbsiMQ/V85BOnXjiZowg2XmoFEnaWlOVFtAWAfVLI/KrNcAwkatvBqgF3ku7DreQnB6dPHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wKjmUvxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA8FC4CEF5;
	Fri,  3 Oct 2025 13:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759497185;
	bh=a+MTtxeoagXguXl5hnSQni8/dsfGpF3bkJQvgCil0Nw=;
	h=Subject:To:Cc:From:Date:From;
	b=wKjmUvxbUoR1yAGa6T1Llm9nDgGfeAAOs52QMSBxQlPkejQiGEGdor8sj1dCi6K32
	 zwxM2Rqk36B9OJmavg+/RfHnESHz+H1XRdcr+oca3OG1pvO3VMnLxHcutCPGShb+c9
	 tZnHJGQsxlan4FGj5WBTZ3TVUqq857+y0i98QIa0=
Subject: FAILED: patch "[PATCH] media: tuner: xc5000: Fix use-after-free in xc5000_release
[hverkuil: fix typo in tunner -> tuner]" failed to apply to 5.4-stable tree
To: duoming@zju.edu.cn,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 03 Oct 2025 15:12:41 +0200
Message-ID: <2025100341-dime-left-e15f@gregkh>
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
git cherry-pick -x 40b7a19f321e65789612ebaca966472055dab48c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025100341-dime-left-e15f@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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
 


