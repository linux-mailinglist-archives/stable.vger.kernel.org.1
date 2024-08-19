Return-Path: <stable+bounces-69492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D867956722
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411C61C2159F
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A8B15ECD9;
	Mon, 19 Aug 2024 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yh0U4jBV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5894615ECE2
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060007; cv=none; b=F26R0jmm1TrVquSUhsWDn7y55Q3voCpLe9CauCdrdAo0VOgRqu8Vim4dIBH4zDYCAJN2XLAZvxKVzkhkpFUzVSV3iw33uja3sAOcpZ9lkXY1ISKbPHYfxJsRoDVyG9aquXtCLAci4cm9ggMvAY9OsIeJFaJdjFhBw0/j52QZmqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060007; c=relaxed/simple;
	bh=kwwofSyUwNGfrN7qmnzZSPG7Y+YMsMJ1JBz7UpEG3M4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QeILP4jzzKvfOdIoYLRGEvczEQT3nUPjcH54WQPC0mc51jMzPpa4BKNficwfTLqbCv6yyLTnkr4fK5vqFjOssN2ndUr6IpTlBHYI9idUHmjigB6s99F4bZxniFQoX1ZEz+hc7VdVpBx/LV7ufNco5q41CQxlVdgxkLDEZPr9RRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yh0U4jBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F146C4AF0E;
	Mon, 19 Aug 2024 09:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724060006;
	bh=kwwofSyUwNGfrN7qmnzZSPG7Y+YMsMJ1JBz7UpEG3M4=;
	h=Subject:To:Cc:From:Date:From;
	b=yh0U4jBVlcttoE7aj/lqSzc4RRRiCQFK14mJ1QoJx8+dnVmV9qXpO8PDDw9BQstLB
	 U6E11Y5I0RtFbID/jqNLzloT5fFXL7N3I9FFC05G8teOCx/TQmre8w5X9l2De0Hyx6
	 ke5G23ZXtQXmGab43szl5pVMkdbZB9huhtG4Ne1A=
Subject: FAILED: patch "[PATCH] dm suspend: return -ERESTARTSYS instead of -EINTR" failed to apply to 6.10-stable tree
To: mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:33:24 +0200
Message-ID: <2024081923-move-improving-38ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1e1fd567d32fcf7544c6e09e0e5bc6c650da6e23
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081923-move-improving-38ad@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

1e1fd567d32f ("dm suspend: return -ERESTARTSYS instead of -EINTR")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1e1fd567d32fcf7544c6e09e0e5bc6c650da6e23 Mon Sep 17 00:00:00 2001
From: Mikulas Patocka <mpatocka@redhat.com>
Date: Tue, 13 Aug 2024 12:38:51 +0200
Subject: [PATCH] dm suspend: return -ERESTARTSYS instead of -EINTR

This commit changes device mapper, so that it returns -ERESTARTSYS
instead of -EINTR when it is interrupted by a signal (so that the ioctl
can be restarted).

The manpage signal(7) says that the ioctl function should be restarted if
the signal was handled with SA_RESTART.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 97fab2087df8..87bb90303435 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2737,7 +2737,7 @@ static int dm_wait_for_bios_completion(struct mapped_device *md, unsigned int ta
 			break;
 
 		if (signal_pending_state(task_state, current)) {
-			r = -EINTR;
+			r = -ERESTARTSYS;
 			break;
 		}
 
@@ -2762,7 +2762,7 @@ static int dm_wait_for_completion(struct mapped_device *md, unsigned int task_st
 			break;
 
 		if (signal_pending_state(task_state, current)) {
-			r = -EINTR;
+			r = -ERESTARTSYS;
 			break;
 		}
 


