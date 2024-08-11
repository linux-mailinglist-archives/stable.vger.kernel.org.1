Return-Path: <stable+bounces-66378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2306994E20C
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 17:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D456D2815AF
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 15:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE4C14C59C;
	Sun, 11 Aug 2024 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xXEENv9D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC4213634C
	for <stable@vger.kernel.org>; Sun, 11 Aug 2024 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723391816; cv=none; b=ipxFFK04kNZyFOfD+jYYJAe41O7MWYST/Z7Kn1Egjc27bpbgO151byC39S8kZe0rK6Vd+8VznjlkJEFalDNYZqHzSohccjhY160aqozRiR/DA8dEb/9styRoAFfE+2SshfJ6/dOfpYq/Wnvil9JJZX8MCSB371ojVCvdY+HHANw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723391816; c=relaxed/simple;
	bh=J3DWYDbRwa+cOozxOrVtpYBpiEO1MKoOET1LQajdo/k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LNqCFTynw+w1gJqLSrKjVFFkOWRrtytN1IGp/dnBab2lr6/7KQ72AcsYUaohrlOv+ONMZRvQnQI/FH1DA3KnmzZ83FTRlHSMKkKserKUpMwBx0hVJ1OYz0+hWZvZWLyrnwTGJlBVKWOz3o4Wguu8x/lSg6bMbasUVwGBewB4wb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xXEENv9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F54C32786;
	Sun, 11 Aug 2024 15:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723391815;
	bh=J3DWYDbRwa+cOozxOrVtpYBpiEO1MKoOET1LQajdo/k=;
	h=Subject:To:Cc:From:Date:From;
	b=xXEENv9DPp6VEh9lFvoYKEhnblwmDvRXX23oABx5zfQ9BmmtijSrEyO819YFJmcbE
	 takSbtqqHyUPEUIpuSXyxQvG1yd0LLytmTdgzg4fTEhBsgQ8Lpn8vq6qXbgaAlEfoP
	 YgxDi6McwX6iK55lRJRPiOD1ooVFZ2igsf4PWGEQ=
Subject: FAILED: patch "[PATCH] clocksource: Fix brown-bag boolean thinko in" failed to apply to 4.19-stable tree
To: paulmck@kernel.org,bp@alien8.de,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 11 Aug 2024 17:56:41 +0200
Message-ID: <2024081141-tipoff-hurling-f5c9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x f2655ac2c06a15558e51ed6529de280e1553c86e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081141-tipoff-hurling-f5c9@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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
0a4bb5e5507a ("x86/fpu: Allow multiple bits in clearcpuid= parameter")
4185b3b92792 ("selftests/fpu: Add an FPU selftest")
b2ef9f5a5cb3 ("mm/hmm/test: add selftest driver for HMM")
30428ef5d1e8 ("lib/test_lockup: test module to generate lockups")
b95a8a27c300 ("x86/vdso: Use generic VDSO clock mode storage")

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


