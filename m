Return-Path: <stable+bounces-99036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF2D9E6E00
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D080C18835FF
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 12:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF30D1E1A05;
	Fri,  6 Dec 2024 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tXI6JzB3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03791D63DF
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487661; cv=none; b=DZJ+tO5JJPldy10RL4oZBgCnt07XN5dY+yhLw1d+aE+PlPPevPL1kizg3wvmZ7jFhRM1IptoEYSqiLBVlK94VBXIZo+xR7/8y9qRResFRW+aMkN4+mzPOHIEzK5X34lz7r4InnaDB0EsjlvdIQSFgfkoAqy3tMlyWjLdfCRI9V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487661; c=relaxed/simple;
	bh=K7Gvs/nKPKJzqmT83ymetu5204raXmFlrYm//4Dxcqg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qPbXv5bkIasgZcG1ulH/AkodB6xofQJdOhccL3ENRAh15TAbA1isGTTRsXbWrfj1hRrM8MMQHe6cTWwl35JOubmm/YoA48C2zLUyC98qP6C9APa0IdJqrK9cgIdTwbgeGV0yOFbbpptMv8DCglTXLFgpdWQeHhmfkv77xC6JsiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tXI6JzB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FD0C4CED1;
	Fri,  6 Dec 2024 12:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733487661;
	bh=K7Gvs/nKPKJzqmT83ymetu5204raXmFlrYm//4Dxcqg=;
	h=Subject:To:Cc:From:Date:From;
	b=tXI6JzB3+79dJm/0WEm29gzCvzcLKCuzcnIEpE1IB4xvigRUDasVmTfIGMn2RTpZn
	 Enrfo4Rp3DDaWYEZVGboJsI/riOL0dUS0yHu0EYIQbNnL4IBQ/btrEtgnPxylw7GxB
	 FpXKl6lzl2tJSqHygCsBItydCz4eVsfxTTaRQCJs=
Subject: FAILED: patch "[PATCH] i3c: master: svc: Modify enabled_events bit 7:0 to act as IBI" failed to apply to 5.15-stable tree
To: Frank.Li@nxp.com,alexandre.belloni@bootlin.com,miquel.raynal@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 13:20:44 +0100
Message-ID: <2024120644-desolate-caterer-afb9@gregkh>
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
git cherry-pick -x 25bc99be5fe53853053ceeaa328068c49dc1e799
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120644-desolate-caterer-afb9@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 25bc99be5fe53853053ceeaa328068c49dc1e799 Mon Sep 17 00:00:00 2001
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 1 Nov 2024 12:50:02 -0400
Subject: [PATCH] i3c: master: svc: Modify enabled_events bit 7:0 to act as IBI
 enable counter

Fix issue where disabling IBI on one device disables the entire IBI
interrupt. Modify bit 7:0 of enabled_events to serve as an IBI enable
counter, ensuring that the system IBI interrupt is disabled only when all
I3C devices have IBI disabled.

Cc: stable@kernel.org
Fixes: 7ff730ca458e ("i3c: master: svc: enable the interrupt in the enable ibi function")
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20241101165002.2479794-1-Frank.Li@nxp.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index c53f2b27662f..c1ee3828e7ee 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -130,8 +130,8 @@
 #define SVC_I3C_PPBAUD_MAX 15
 #define SVC_I3C_QUICK_I2C_CLK 4170000
 
-#define SVC_I3C_EVENT_IBI	BIT(0)
-#define SVC_I3C_EVENT_HOTJOIN	BIT(1)
+#define SVC_I3C_EVENT_IBI	GENMASK(7, 0)
+#define SVC_I3C_EVENT_HOTJOIN	BIT(31)
 
 struct svc_i3c_cmd {
 	u8 addr;
@@ -214,7 +214,7 @@ struct svc_i3c_master {
 		spinlock_t lock;
 	} ibi;
 	struct mutex lock;
-	int enabled_events;
+	u32 enabled_events;
 	u32 mctrl_config;
 };
 
@@ -1688,7 +1688,7 @@ static int svc_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
 		return ret;
 	}
 
-	master->enabled_events |= SVC_I3C_EVENT_IBI;
+	master->enabled_events++;
 	svc_i3c_master_enable_interrupts(master, SVC_I3C_MINT_SLVSTART);
 
 	return i3c_master_enec_locked(m, dev->info.dyn_addr, I3C_CCC_EVENT_SIR);
@@ -1700,7 +1700,7 @@ static int svc_i3c_master_disable_ibi(struct i3c_dev_desc *dev)
 	struct svc_i3c_master *master = to_svc_i3c_master(m);
 	int ret;
 
-	master->enabled_events &= ~SVC_I3C_EVENT_IBI;
+	master->enabled_events--;
 	if (!master->enabled_events)
 		svc_i3c_master_disable_interrupts(master);
 


