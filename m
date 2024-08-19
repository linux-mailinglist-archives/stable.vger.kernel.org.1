Return-Path: <stable+bounces-69469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA07B956669
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 756D9B21BB0
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9B015B98D;
	Mon, 19 Aug 2024 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vWj+qr1v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A38C15B984
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058641; cv=none; b=IntSjsVoVNUUS9fly98YP04I36R/C1gdv/6tyTNSlsDhaisINPAJfUN9K8plOmH1jc4HVn3CYHGbKsIyahSzN9XY0ZJdvfciNWhvLFSxh0srU/NcZ3diWBtGQapuOMEVXX0NlbS2cdQbyE/xWyZVFepo0gJBvnDs+GCKPob2pK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058641; c=relaxed/simple;
	bh=DWPUi/7YSFwMuIgw/IzBssePckUd27OlCV0rY+kxP7I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=B61fMUfXpnEmmXd+Y3vcAnmFAbJRS0na+3XnnYmmVCM1QJ5sELMBQ/KS9xP9ZUeCKoQO+NIv2ZuY72xjwU1j2ouxfJr2VTqgmkpJgAjD0cTGVBMGAdw+Y9zce2ctHuNLZ5OElKRHXFvKK2Hn0EqQVhX8eKc0ydQdVLxXiTWxSOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vWj+qr1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4EEC32782;
	Mon, 19 Aug 2024 09:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724058641;
	bh=DWPUi/7YSFwMuIgw/IzBssePckUd27OlCV0rY+kxP7I=;
	h=Subject:To:Cc:From:Date:From;
	b=vWj+qr1vXFpOqDFRrFCiBVnE8ekKQMXTH9QN9WBB3AoiWBtrCu9TI3kq2GrqMErc+
	 ZeIpj07Y4Hu4qtgZ7zLRnh9Tx0BDqq2JIpGnvgXD1T2oCSyMRPnVRXej24APQNcRG5
	 G7CKCAFTeYHrxobASnRon/ZsJ60lk0LDv/KwCYHc=
Subject: FAILED: patch "[PATCH] ALSA: timer: Relax start tick time check for slave timer" failed to apply to 5.10-stable tree
To: tiwai@suse.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:10:30 +0200
Message-ID: <2024081930-commuting-makeover-de1c@gregkh>
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
git cherry-pick -x ccbfcac05866ebe6eb3bc6d07b51d4ed4fcde436
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081930-commuting-makeover-de1c@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


