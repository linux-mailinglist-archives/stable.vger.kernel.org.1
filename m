Return-Path: <stable+bounces-192033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 885CDC28F9E
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 14:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A3A64E653C
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 13:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DEA1B87EB;
	Sun,  2 Nov 2025 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v9bu1Kmh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851BA63CF
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762090975; cv=none; b=CJYsQ9EjrBQ7vTU7ULU3q2/cwBkGLgh53zd78OGSpyvoSVZ/z9+tU9eOdFmgqDsQ6b+BR1XMce/WvQWN47gHw4HyAQ5cKLvF63OpbteHC0/Zj9nXwL0IQ56vMe/Yqf2N32tE7JR2LF3VbzvSye5TNT1gNY5AG0wUKSMYD5yqJdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762090975; c=relaxed/simple;
	bh=pxKUdWGMvpkililjBNHR+vXx1GAhi0KgxN6OyMoHl+8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MojCgsUTheMQ8r3KNNtTI5PE/aBmbVHMJuulXig9F204Z+bIvAc0IjKH3f1+Yyg5QAbBcs0O3PGykHp/rzK49eYWT/WsLXB+3rnH55GSPOcnPAHIHgXh2BQh62ysMy8Estv0zUmFvx8ZMx83viHvbR12Qvi6JQ/03ieFzv7/n8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v9bu1Kmh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC9EC4CEF7;
	Sun,  2 Nov 2025 13:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762090975;
	bh=pxKUdWGMvpkililjBNHR+vXx1GAhi0KgxN6OyMoHl+8=;
	h=Subject:To:Cc:From:Date:From;
	b=v9bu1KmhrP4S8ozGXqtV51qEwNTx4MYKAVyDKNHElkblBLUnVR0LSC7JKUITEF0rG
	 z6J9C21Ky8CtPVGYLUi9tKVNjH7hOWNKvOgf7Ci5zpslb5nNIASEaCUUVjWKTH00rx
	 ktf95S+2CI5h/DU2vqXVreszsxqm6GBxh92cvQ7c=
Subject: FAILED: patch "[PATCH] cpuidle: governors: menu: Select polling state in some more" failed to apply to 6.12-stable tree
To: rafael.j.wysocki@intel.com,christian.loehle@arm.com,dsmythies@telus.net,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 02 Nov 2025 22:42:44 +0900
Message-ID: <2025110244-overstuff-scallop-d38a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x db86f55bf81a3a297be05ee8775ae9a8c6e3a599
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110244-overstuff-scallop-d38a@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


