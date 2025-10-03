Return-Path: <stable+bounces-183216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 174E0BB6F34
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 15:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53DCD4EC1DD
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 13:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A21D2F25EC;
	Fri,  3 Oct 2025 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f+tGh2I6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC61B2F25E4
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759497174; cv=none; b=a+vsGZdgvXvuidx8zyIM9RIlq+t553u5q5uvSFWQBUiX6RVefisR3WsxiSjZpNM8PEamTJ/CRpqojmC2BwLRVUgtM80vGmT4BP+dkr2mKkrJHKStJbjitHs+htzqG5s4akUZxk9h3Qhni/c+DVt6BkL+YJA4R+RpyzJ/B84SMQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759497174; c=relaxed/simple;
	bh=RmfnfVp14Rfdt85nxH0jLi3aMfWii+B0AI32Y6tJtSc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=i+h/C+t64wAts+ksRdgLVz5f/pWr/bom7jivJOBxbR1qIPWzyqn2Vcgkxs7yD3a3xZBYDgMNZTQAN++UfV8FXZwYhTQBozAS99PyvF4PdusfnglqoOVRx53b6QxTN4E3TILINRlHH7kM6nBV4M6VqHCRwKoEsDw8ArjZoO1hbZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f+tGh2I6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1756BC4CEF5;
	Fri,  3 Oct 2025 13:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759497174;
	bh=RmfnfVp14Rfdt85nxH0jLi3aMfWii+B0AI32Y6tJtSc=;
	h=Subject:To:Cc:From:Date:From;
	b=f+tGh2I6ZyRWlbIxGdPX/URYSKh89RFpEaL2yUIfNt5jameVkRNRihQBsfIMUTZ9m
	 s/Lw9bAoP5QTp6bhoVkboQjXHgY9Obj2oxQzstLwIoZKpFF/dtsScvSaBuE2KklJzk
	 lWOKy/gUd4SPCMHHwpVqpalX7fEBX9zJnK3Dtodg=
Subject: FAILED: patch "[PATCH] media: tuner: xc5000: Fix use-after-free in xc5000_release
[hverkuil: fix typo in tunner -> tuner]" failed to apply to 6.6-stable tree
To: duoming@zju.edu.cn,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 03 Oct 2025 15:12:39 +0200
Message-ID: <2025100338-ambulance-swaddling-4b2b@gregkh>
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
git cherry-pick -x 40b7a19f321e65789612ebaca966472055dab48c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025100338-ambulance-swaddling-4b2b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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
 


