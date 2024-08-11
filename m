Return-Path: <stable+bounces-66374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE0194E208
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 17:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C31A1C20C4E
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 15:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160B314C5A9;
	Sun, 11 Aug 2024 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="usosCh6M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F1C7F6
	for <stable@vger.kernel.org>; Sun, 11 Aug 2024 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723391800; cv=none; b=guhSyem6rlsopS6v7nwKoIKXhRAMEdNrVEnipDAo+u7HcarK7laGkOFfiAu2Y6dESJu2ax/Zg9+HDqaaK0aTpG7JS5jBKeiPpK83QHEJnrshcTzYF9F71Wie6wyPR8fXj7wZeHAmaF1a4nMewhOnnzWHZahFEu1kanvNP8coDeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723391800; c=relaxed/simple;
	bh=EM4wDjfsFcquvmKNrEm1yr+UXs4SB07Zr0APMPifimc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XDQStCAIVWg1gVA2b/B3pHH2wK/HpBeUPB6FQ8cheZswFm0juigLhUi3Mw/leZTx4a+rhW5KgZ89ha09o6QqqZl1SaTx9Hcqpud3I1lQHyz4hzCihGLK3UHsiUbAk+Mkf5rkNVAJeTY6PVGFAl5+gRJiv1NJBKu/vtqpdsxj0lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=usosCh6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12540C32786;
	Sun, 11 Aug 2024 15:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723391800;
	bh=EM4wDjfsFcquvmKNrEm1yr+UXs4SB07Zr0APMPifimc=;
	h=Subject:To:Cc:From:Date:From;
	b=usosCh6MLB8m/x1INzMHOI2d+gb6YxpZ1P4vOCwoarPviyDl0ec25BuNqm5/ygCB6
	 OehIhmSJ/IpUgPpPzi0wf6CsA/Bdes/1D0D+qDT/o4SuIt4wmtmfzcNPGWMUZtGjqL
	 wZngGNWRAQFPNnrUx8TQLb7XeA7iBf/G7NYY1LBM=
Subject: FAILED: patch "[PATCH] clocksource: Fix brown-bag boolean thinko in" failed to apply to 6.1-stable tree
To: paulmck@kernel.org,bp@alien8.de,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 11 Aug 2024 17:56:31 +0200
Message-ID: <2024081131-chewable-convent-91a9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f2655ac2c06a15558e51ed6529de280e1553c86e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081131-chewable-convent-91a9@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

f2655ac2c06a ("clocksource: Fix brown-bag boolean thinko in cs_watchdog_read()")
2ed08e4bc532 ("clocksource: Scale the watchdog read retries automatically")
877a0e83c57f ("torture: Enable clocksource watchdog with "tsc=watchdog"")

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


