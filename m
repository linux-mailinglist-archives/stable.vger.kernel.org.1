Return-Path: <stable+bounces-8732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36522820477
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D0D2821B5
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 11:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA4E2104;
	Sat, 30 Dec 2023 11:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vwh3WOVc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461931FCF
	for <stable@vger.kernel.org>; Sat, 30 Dec 2023 11:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF26CC433C8;
	Sat, 30 Dec 2023 11:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703934065;
	bh=507Y6pUIgz4D/9SyxvMGtoTT8mlI+BqhAStZqrnbQm8=;
	h=Subject:To:Cc:From:Date:From;
	b=vwh3WOVc84ck8CYc20yV4IJw0BGZFhvErqAomPBZYjXFLZXCN4PgKYTde/jGi8eTC
	 A0NzdBIUG8LsFD9d1ztsZyasvU2iNR8LXPR9a1BO7m+J82XRAcAUMLt7tavrFrQ5N7
	 +pv41IsuAHX9S8sCmlgGAk6blfpQUU0IUr2r2YMU=
Subject: FAILED: patch "[PATCH] bus: ti-sysc: Flush posted write only after srst_udelay" failed to apply to 5.4-stable tree
To: tony@atomide.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 30 Dec 2023 11:01:02 +0000
Message-ID: <2023123002-partridge-speech-5e07@gregkh>
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
git cherry-pick -x f71f6ff8c1f682a1cae4e8d7bdeed9d7f76b8f75
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023123002-partridge-speech-5e07@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

f71f6ff8c1f6 ("bus: ti-sysc: Flush posted write only after srst_udelay")
d929b2b7464f ("bus: ti-sysc: Use fsleep() instead of usleep_range() in sysc_reset()")
34539b442b3b ("bus: ti-sysc: Flush posted write on enable before reset")
ab4d309d8708 ("bus: ti-sysc: Improve reset to work with modules with no sysconfig")
e64c021fd924 ("bus: ti-sysc: Rename clk related quirks to pre_reset and post_reset quirks")
aec551c7a00f ("bus: ti-sysc: Fix 1-wire reset quirk")
e709ed70d122 ("bus: ti-sysc: Fix missing reset delay handling")
020003f763e2 ("bus: ti-sysc: Add module enable quirk for audio AESS")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f71f6ff8c1f682a1cae4e8d7bdeed9d7f76b8f75 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 24 Nov 2023 10:50:56 +0200
Subject: [PATCH] bus: ti-sysc: Flush posted write only after srst_udelay

Commit 34539b442b3b ("bus: ti-sysc: Flush posted write on enable before
reset") caused a regression reproducable on omap4 duovero where the ISS
target module can produce interconnect errors on boot. Turns out the
registers are not accessible until after a delay for devices needing
a ti,sysc-delay-us value.

Let's fix this by flushing the posted write only after the reset delay.
We do flushing also for ti,sysc-delay-us using devices as that should
trigger an interconnect error if the delay is not properly configured.

Let's also add some comments while at it.

Fixes: 34539b442b3b ("bus: ti-sysc: Flush posted write on enable before reset")
Cc: stable@vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index d57bc066dce6..9ed9239b1228 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -2158,13 +2158,23 @@ static int sysc_reset(struct sysc *ddata)
 		sysc_val = sysc_read_sysconfig(ddata);
 		sysc_val |= sysc_mask;
 		sysc_write(ddata, sysc_offset, sysc_val);
-		/* Flush posted write */
+
+		/*
+		 * Some devices need a delay before reading registers
+		 * after reset. Presumably a srst_udelay is not needed
+		 * for devices that use a rstctrl register reset.
+		 */
+		if (ddata->cfg.srst_udelay)
+			fsleep(ddata->cfg.srst_udelay);
+
+		/*
+		 * Flush posted write. For devices needing srst_udelay
+		 * this should trigger an interconnect error if the
+		 * srst_udelay value is needed but not configured.
+		 */
 		sysc_val = sysc_read_sysconfig(ddata);
 	}
 
-	if (ddata->cfg.srst_udelay)
-		fsleep(ddata->cfg.srst_udelay);
-
 	if (ddata->post_reset_quirk)
 		ddata->post_reset_quirk(ddata);
 


