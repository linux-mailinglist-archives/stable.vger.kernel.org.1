Return-Path: <stable+bounces-66376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A820594E20A
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 17:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6410C2815C9
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 15:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EA513634C;
	Sun, 11 Aug 2024 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ez69ODhY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7474B7F6
	for <stable@vger.kernel.org>; Sun, 11 Aug 2024 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723391809; cv=none; b=YnY3MI5e3bOX1akXXnat1ymDpX3uMu6UgH84kAbamEBwVeLVjle0RXGZbg7C3cDnh89ZMZbHPup+GCmInhsPE4YRO/EB4C+RZ2IVKGhCs8Jz+556hp3ceNWheJPGVIgC0iA4HV97ObuBF+yEpaAEfYBnqcZmFSot5EeFnYQH3YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723391809; c=relaxed/simple;
	bh=HiYzwTpNkOK2OM9Gw9v9eVMJXQpcYuibjuOVLiRehLo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rIQPqmMJTZQ+czK1ImisqDF1rTjqXvuSM5gCjX3PG363H2nMCe7xjEjwT9LsN0Ft84OhmA+yBGPSWqG3AJmf4p37tPFbC7Fe1uFT51FxiKmluONChquZyduaRHKMKegpKNouuz5vF/Pb0yR5IAcVHEC/Ytu6Et0SE0N5uB5CsVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ez69ODhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71084C32786;
	Sun, 11 Aug 2024 15:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723391808;
	bh=HiYzwTpNkOK2OM9Gw9v9eVMJXQpcYuibjuOVLiRehLo=;
	h=Subject:To:Cc:From:Date:From;
	b=Ez69ODhYcCkMQ0bXA8ermEjBFy51IzI4oWTrdjD3DDk1heJqCeALfreYnvJ6xwYkX
	 yxxEnaO3ADtXFDzXeVpnEBmhShrpX9XWELlWcSZiCDLDt8vFGfyirua5uABjz8vHcz
	 9yB3J5nO+bJQR5dU62Y8zi7jkqhgqxJn7cIxPjaY=
Subject: FAILED: patch "[PATCH] clocksource: Fix brown-bag boolean thinko in" failed to apply to 5.10-stable tree
To: paulmck@kernel.org,bp@alien8.de,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 11 Aug 2024 17:56:37 +0200
Message-ID: <2024081137-departed-drop-down-937e@gregkh>
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
git cherry-pick -x f2655ac2c06a15558e51ed6529de280e1553c86e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081137-departed-drop-down-937e@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

f2655ac2c06a ("clocksource: Fix brown-bag boolean thinko in cs_watchdog_read()")
2ed08e4bc532 ("clocksource: Scale the watchdog read retries automatically")
877a0e83c57f ("torture: Enable clocksource watchdog with "tsc=watchdog"")
1a5620671a1b ("clocksource: Reduce the default clocksource_watchdog() retries to 2")
c86ff8c55b8a ("clocksource: Avoid accidental unstable marking of clocksources")
ef4dac7dbde7 ("torture: Add clocksource-watchdog testing to torture.sh")
1253b9b87e42 ("clocksource: Provide kernel module to test clocksource watchdog")
2e27e793e280 ("clocksource: Reduce clocksource-skew threshold")
fa218f1cce6b ("clocksource: Limit number of CPUs checked for clock synchronization")
7560c02bdffb ("clocksource: Check per-CPU clock synchronization when marked unstable")
db3a34e17433 ("clocksource: Retry clock read if long delays detected")
a115a775a8d5 ("torture: Add "make allmodconfig" to torture.sh")
197220d4a334 ("torture: Remove use of "eval" in torture.sh")
1adb5d6b5225 ("torture: Make torture.sh use common time-duration bash functions")
bfc19c13d24c ("torture: Add torture.sh torture-everything script")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f2655ac2c06a15558e51ed6529de280e1553c86e Mon Sep 17 00:00:00 2001
From: "Paul E. McKenney" <paulmck@kernel.org>
Date: Fri, 2 Aug 2024 08:46:15 -0700
Subject: [PATCH] clocksource: Fix brown-bag boolean thinko in
 cs_watchdog_read()

The current "nretries > 1 || nretries >= max_retries" check in
cs_watchdog_read() will always evaluate to true, and thus pr_warn(), if
nretries is greater than 1.  The intent is instead to never warn on the
first try, but otherwise warn if the successful retry was the last retry.

Therefore, change that "||" to "&&".

Fixes: db3a34e17433 ("clocksource: Retry clock read if long delays detected")
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240802154618.4149953-2-paulmck@kernel.org

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index d25ba49e313c..d0538a75f4c6 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -246,7 +246,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 
 		wd_delay = cycles_to_nsec_safe(watchdog, *wdnow, wd_end);
 		if (wd_delay <= WATCHDOG_MAX_SKEW) {
-			if (nretries > 1 || nretries >= max_retries) {
+			if (nretries > 1 && nretries >= max_retries) {
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
 					smp_processor_id(), watchdog->name, nretries);
 			}


