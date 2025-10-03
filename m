Return-Path: <stable+bounces-183217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC24BB6FE5
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 15:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1984A6608
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 13:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2902F25E1;
	Fri,  3 Oct 2025 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tq+//4R7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3F22F0C55
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759497178; cv=none; b=daE3jAh91lzcfo4J4rHkdVMFCRqMpa2ncSXOu2LGSgkmAQmG2pZbbsFhwSFsl5EDYbeZiBHYI2aoibASqmGDWZful53bSg0SESJv2WGhHts0BMSt1mFEUDe5eBYsteRgD0fP2fqImpzqE9QdgVYSqLUWF/nadHvHQyBnStXxRkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759497178; c=relaxed/simple;
	bh=AMOYeCLNYiwOBK33MDC+VGp7ejDS12kjq6f3FTTup9Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BwB+sw5X9j0TBbjS155wsTNLb7IxcUgebxjnJpmRLfJ6RryA+piHOmqjFdIKp91UCXMl9yomvm+AVr/4hvx1K4Z0rezi309xpxCTWULOiFoQfFPac9f2t2sYSJIvqclbEUnpntSGqdbhvJOHYMXkAQV8t+TKh92It7QkRsinMbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tq+//4R7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F73BC4CEF5;
	Fri,  3 Oct 2025 13:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759497177;
	bh=AMOYeCLNYiwOBK33MDC+VGp7ejDS12kjq6f3FTTup9Q=;
	h=Subject:To:Cc:From:Date:From;
	b=Tq+//4R77wuVSWR92OqSvXkO20kL7BCCoTuHI6Z1NRgJwH2pk4Gblsrm46J69ji9U
	 ailjeJoLm6GJHd1IVf++/QDshiXv9ftjYtbX4a74fZ8BkJXrBP382CD/Fi3ihmAqwR
	 edVkSpn1o+31lQ3f9oQla+9PGD+7Sl4n5wpFlLrs=
Subject: FAILED: patch "[PATCH] media: tuner: xc5000: Fix use-after-free in xc5000_release
[hverkuil: fix typo in tunner -> tuner]" failed to apply to 5.15-stable tree
To: duoming@zju.edu.cn,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 03 Oct 2025 15:12:40 +0200
Message-ID: <2025100340-pleat-amusable-e5dc@gregkh>
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
git cherry-pick -x 40b7a19f321e65789612ebaca966472055dab48c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025100340-pleat-amusable-e5dc@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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
 


