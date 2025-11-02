Return-Path: <stable+bounces-192034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A950C28FA1
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 14:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D2BA4E68D1
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 13:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D8D1D63F3;
	Sun,  2 Nov 2025 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ydQECP2q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B004263CF
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762090977; cv=none; b=rcVCLbSIPg9w4ezyPeCb4YIlFKSD0R+jzXYRavZwSVgi1bafLdHBkrO2fDxVfqurOgrX7e1iaNITdF9YuBEcE1lAfJ7sNMIj6YU7ksM+UmU441+bFRhGO3utJdrhIBcaGLOSLxHkkQ2e36VL9tFznLqiQp9x9h3bFXccCbQ8oEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762090977; c=relaxed/simple;
	bh=2AgwIVgmGFAhEhfCH2T5kaVKB68KDMiuw5Wqsgtrlkw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nziryVyZWLAwVi4y4xRQWnndIkXWKW0oCLrcqiFxV0/tBS9uALu3fogy9JWK42v7rb8tG2G0MMdDHk7KFcOX8E5wdoJZ0xETMAoxowvNaz72gmyuwVMoucP/aHjQ6j0SHXMJNnuQXaeyPyWj0mFC3hxK7FDiJ9bcz1Y4AFE52Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ydQECP2q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43120C4CEF7;
	Sun,  2 Nov 2025 13:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762090977;
	bh=2AgwIVgmGFAhEhfCH2T5kaVKB68KDMiuw5Wqsgtrlkw=;
	h=Subject:To:Cc:From:Date:From;
	b=ydQECP2q5+mEUNiPms3SgU3P5s1dawJ5HTjr2++VRm1DpFapPAdGG6JEyKoOoMdd7
	 IULDOXf8VVNPZC82sj0v1A6HMwH0Pa19TgmkUANZk2Q1xk9gO+M5/thSU5XYHJxVyo
	 ZJb45agmfx6UcEWSLVWt2B0XwSXWYzK8DYm1+GZ4=
Subject: FAILED: patch "[PATCH] cpuidle: governors: menu: Select polling state in some more" failed to apply to 6.6-stable tree
To: rafael.j.wysocki@intel.com,christian.loehle@arm.com,dsmythies@telus.net,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 02 Nov 2025 22:42:45 +0900
Message-ID: <2025110245-mongoose-ravioli-e19d@gregkh>
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
git cherry-pick -x db86f55bf81a3a297be05ee8775ae9a8c6e3a599
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110245-mongoose-ravioli-e19d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From db86f55bf81a3a297be05ee8775ae9a8c6e3a599 Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Thu, 23 Oct 2025 19:12:57 +0200
Subject: [PATCH] cpuidle: governors: menu: Select polling state in some more
 cases

A throughput regression of 11% introduced by commit 779b1a1cb13a ("cpuidle:
governors: menu: Avoid selecting states with too much latency") has been
reported and it is related to the case when the menu governor checks if
selecting a proper idle state instead of a polling one makes sense.

In particular, it is questionable to do so if the exit latency of the
idle state in question exceeds the predicted idle duration, so add a
check for that, which is sufficient to make the reported regression go
away, and update the related code comment accordingly.

Fixes: 779b1a1cb13a ("cpuidle: governors: menu: Avoid selecting states with too much latency")
Closes: https://lore.kernel.org/linux-pm/004501dc43c9$ec8aa930$c59ffb90$@telus.net/
Reported-by: Doug Smythies <dsmythies@telus.net>
Tested-by: Doug Smythies <dsmythies@telus.net>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/12786727.O9o76ZdvQC@rafael.j.wysocki

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 7d21fb5a72f4..23239b0c04f9 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -318,10 +318,13 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 
 		/*
 		 * Use a physical idle state, not busy polling, unless a timer
-		 * is going to trigger soon enough.
+		 * is going to trigger soon enough or the exit latency of the
+		 * idle state in question is greater than the predicted idle
+		 * duration.
 		 */
 		if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
-		    s->target_residency_ns <= data->next_timer_ns) {
+		    s->target_residency_ns <= data->next_timer_ns &&
+		    s->exit_latency_ns <= predicted_ns) {
 			predicted_ns = s->target_residency_ns;
 			idx = i;
 			break;


