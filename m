Return-Path: <stable+bounces-69497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5917F956728
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706681C217D8
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C2F15E5D0;
	Mon, 19 Aug 2024 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ct/Frev3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CCF15D5C8
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060022; cv=none; b=ouzobV8y7FH8xaAKvd8anVmBdQVa0eCLSkST3G1FUr2w6MMXtHeGEnN/It2S+DL5VKVynhC8J7lMQ1QYRYKumLQ2uzb8IOK3yg59cQ44W6Z6HxXMAASVB5B4ZGpKqK4PwriPyVJWzCzXIcI0lXqb6Z5aTL/bzaBHqJ4QCl6aLSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060022; c=relaxed/simple;
	bh=popoXJabUv7Q3hQ+Hhk7Hv68rNXQm5Qat0qW7P5+wXU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IOhOAszt8qJIC73+CAECWEcZz0F12v2AO9nw1YTaF6OqXPqGEIV4jjzK+dntWHcIuR8j36oFWRZhCENyOM0Ons+rj9CfMvductF1ua68XYZx9OKdeOMYbm9CsVDQ06Zoe1qOAh71LQCh7VYy0h7MoKGYMXEnsTPSp9swkXO3oLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ct/Frev3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD76C32782;
	Mon, 19 Aug 2024 09:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724060021;
	bh=popoXJabUv7Q3hQ+Hhk7Hv68rNXQm5Qat0qW7P5+wXU=;
	h=Subject:To:Cc:From:Date:From;
	b=ct/Frev3fJih8ffbBJqeFAEM6/1ndA/UKmqKqUSfjWMTuHsd3Sg+gIqgJthHaTz31
	 aplxQlp/stDdg5wtwdhg0n7+R8Bm5qDr5H6ysmzkarYSvkkb3EcAXP4HQSZbF2dlv7
	 NoU5vmNPZ0d6MhK4EZe66PlCohkuTX2MK5c1sQro=
Subject: FAILED: patch "[PATCH] dm suspend: return -ERESTARTSYS instead of -EINTR" failed to apply to 5.4-stable tree
To: mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:33:27 +0200
Message-ID: <2024081927-lapping-sedation-f06f@gregkh>
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
git cherry-pick -x 1e1fd567d32fcf7544c6e09e0e5bc6c650da6e23
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081927-lapping-sedation-f06f@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

1e1fd567d32f ("dm suspend: return -ERESTARTSYS instead of -EINTR")
85067747cf98 ("dm: do not use waitqueue for request-based DM")
087615bf3acd ("dm mpath: pass IO start time to path selector")

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
 


