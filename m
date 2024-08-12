Return-Path: <stable+bounces-66423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0317494E9C2
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 11:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B751C215A4
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 09:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575C416CD19;
	Mon, 12 Aug 2024 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c8CgsBsv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F7620323
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723454875; cv=none; b=KgJCwFY7P3oaVsRh++U8iHxBC5juA2//Ot8jOkv41Cd3IW8eFu1oiWMnZn6YDlQtKH3t+O/2QPv/VwyZRtrOTul0S6TbnfSI9FhIn1pfGDYLDaRCWHbwg1XPnyp+qwA+ggUhgCnyJ/YmlNE11+cy+14rsR8q8DKZP44a8O26NaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723454875; c=relaxed/simple;
	bh=jKcxXpFHqeXVAm80BWkpkHdwbwKRgW7ztQv5k8zbYk8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eULCTVahJkMqM/VxnwmdUhFosXE7gd3bTMPw0Yh9m6ToIfXrRywglIpriW3IYQv+i0iV5r5JDlogCI8bR+m1zmUNauEgGzoAcrQ527aDrvG5jGGdpHs5DdZFd4k4V50zw5wSmHQ/JKAUzO2Xwd4TEeNkhnwC62gB/yZyk4Rcdfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c8CgsBsv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E549C32782;
	Mon, 12 Aug 2024 09:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723454875;
	bh=jKcxXpFHqeXVAm80BWkpkHdwbwKRgW7ztQv5k8zbYk8=;
	h=Subject:To:Cc:From:Date:From;
	b=c8CgsBsv8FeT2HYfxPoAKCB6ff7+H7sC8/Ced3fDZ3KTvJEhYt6j5LURiXQRip69/
	 JK7HeME5J+HHIAunc+HCYxsbU5XmfkCUUzX45WOxVuiMjQLTqbWKWmubzNMeisRkwu
	 iGKnlqX14+Np9YwVW8eYELJ8QHadxoCufvlH09gc=
Subject: FAILED: patch "[PATCH] drm/xe: Fix NULL ptr dereference in devcoredump" failed to apply to 6.10-stable tree
To: matthew.brost@intel.com,jose.souza@intel.com,rodrigo.vivi@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 11:27:51 +0200
Message-ID: <2024081251-washhouse-liftoff-22e6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x f2bf9e95989c0163650dbeaede658d0fcf929063
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081251-washhouse-liftoff-22e6@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

f2bf9e95989c ("drm/xe: Fix NULL ptr dereference in devcoredump")
b10d0c5e9df7 ("drm/xe: Add process name to devcoredump")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f2bf9e95989c0163650dbeaede658d0fcf929063 Mon Sep 17 00:00:00 2001
From: Matthew Brost <matthew.brost@intel.com>
Date: Thu, 30 May 2024 13:33:41 -0700
Subject: [PATCH] drm/xe: Fix NULL ptr dereference in devcoredump
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Kernel VM do not have an Xe file. Include a check for Xe file in the VM
before trying to get pid from VM's Xe file when taking a devcoredump.

Fixes: b10d0c5e9df7 ("drm/xe: Add process name to devcoredump")
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: José Roberto de Souza <jose.souza@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: José Roberto de Souza <jose.souza@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240530203341.1795181-1-matthew.brost@intel.com

diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
index 1973bfaece40..d7f2d19a77c1 100644
--- a/drivers/gpu/drm/xe/xe_devcoredump.c
+++ b/drivers/gpu/drm/xe/xe_devcoredump.c
@@ -176,7 +176,7 @@ static void devcoredump_snapshot(struct xe_devcoredump *coredump,
 	ss->snapshot_time = ktime_get_real();
 	ss->boot_time = ktime_get_boottime();
 
-	if (q->vm) {
+	if (q->vm && q->vm->xef) {
 		task = get_pid_task(q->vm->xef->drm->pid, PIDTYPE_PID);
 		if (task)
 			process_name = task->comm;


