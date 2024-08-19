Return-Path: <stable+bounces-69468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC3B956667
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92E01F227B2
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9EF15B97E;
	Mon, 19 Aug 2024 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tq97hszD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C6F15B11F
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058638; cv=none; b=rLOBDkkYu9RkiWA1yJBPagBvJ+flCqP29InpfiYaf/20kDVjCLSzXBgEJztp5PTBn14jVc+L7dPrZaqkqYTrUJtMpPn4DPXrIiw2fEEb7z2IJ3TG6w9wPXrl9nCM9i0ONPyoliSbj0u6UJnRa0hs+SJqFrREAp8fL/gFHxFqEBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058638; c=relaxed/simple;
	bh=NtGibkkkXfWgqksxfge7yfsLgyFlE1LYNLP+hsoFNtM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aYURUzHsavzbguytl/3YkekNESOw2yvRejoWyoiFlE6WP2aPhMwX65SDJp8MhY7mAaNd37EOBD281NvCYFEsi/dODNWqC3FP8OqwiTvoC/RGrwNPH7gYQVlmvDl7BP5ZCAlePyMZ7IdhBHoze/fdfU7muacCdiMr+KN83mw1P6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tq97hszD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AA2C32782;
	Mon, 19 Aug 2024 09:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724058638;
	bh=NtGibkkkXfWgqksxfge7yfsLgyFlE1LYNLP+hsoFNtM=;
	h=Subject:To:Cc:From:Date:From;
	b=tq97hszDUGl4T98x9SzFIhXpTZAmDOofMxi4ZClCZ3R+PVSeXzShWqtIzNl2VM/Lc
	 jLieO5e+30B5/TvTUGUp4cRNgADUDrwv/c5MbzTdvdi5uZWQp6I4JEF353+hLkjGt7
	 Fk01Xvzsbc3xjLYJevV8Z1bi8BthhobqJ2jDTdLM=
Subject: FAILED: patch "[PATCH] ALSA: timer: Relax start tick time check for slave timer" failed to apply to 5.15-stable tree
To: tiwai@suse.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:10:29 +0200
Message-ID: <2024081929-kangaroo-abstract-f5d8@gregkh>
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
git cherry-pick -x ccbfcac05866ebe6eb3bc6d07b51d4ed4fcde436
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081929-kangaroo-abstract-f5d8@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

ccbfcac05866 ("ALSA: timer: Relax start tick time check for slave timer elements")
4a63bd179fa8 ("ALSA: timer: Set lower bound of start tick time")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ccbfcac05866ebe6eb3bc6d07b51d4ed4fcde436 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Sat, 10 Aug 2024 10:48:32 +0200
Subject: [PATCH] ALSA: timer: Relax start tick time check for slave timer
 elements

The recent addition of a sanity check for a too low start tick time
seems breaking some applications that uses aloop with a certain slave
timer setup.  They may have the initial resolution 0, hence it's
treated as if it were a too low value.

Relax and skip the check for the slave timer instance for addressing
the regression.

Fixes: 4a63bd179fa8 ("ALSA: timer: Set lower bound of start tick time")
Cc: <stable@vger.kernel.org>
Link: https://github.com/raspberrypi/linux/issues/6294
Link: https://patch.msgid.link/20240810084833.10939-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/core/timer.c b/sound/core/timer.c
index d104adc75a8b..71a07c1662f5 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -547,7 +547,7 @@ static int snd_timer_start1(struct snd_timer_instance *timeri,
 	/* check the actual time for the start tick;
 	 * bail out as error if it's way too low (< 100us)
 	 */
-	if (start) {
+	if (start && !(timer->hw.flags & SNDRV_TIMER_HW_SLAVE)) {
 		if ((u64)snd_timer_hw_resolution(timer) * ticks < 100000)
 			return -EINVAL;
 	}


