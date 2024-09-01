Return-Path: <stable+bounces-71769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A35589677AA
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D388C1C20E4F
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE321836E2;
	Sun,  1 Sep 2024 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WhMQQkv/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1DD17F394;
	Sun,  1 Sep 2024 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725207754; cv=none; b=bpyhsrVp8LmrfgDAetmkSITrhrLpTnzarT93RMjgYCWZMFBo8KSv5OT7UB/e4XUvsULd7M1P+fl93Vb9UD16F7dUvdpCc0yuecalj2I+MHw7x9lifTalszD4+0wNqZSy4vj73X2rdfhs5l2ueg8zIsaJlisGrQ0qPIZq+MAJpd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725207754; c=relaxed/simple;
	bh=cNov5Dzmz/0IjlovJ2rPA5BTo1A2Qx/m55kTOCV5MOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCjn4FySRiqLEBD2DvAHj9VHicLtx+MxuE9SpOfyDj8vFbXcATJMDbMts3UI62WH462AUs3r7HoDMcRSXgeqNW4wEl9Qu47VuXetF2Y1yGtfajmUUGwhSTChLGW/Gq8scK49QbCFr03DgYssegbUOipkAAVgaZfHdus1vhUbAlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WhMQQkv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDF8C4CEC3;
	Sun,  1 Sep 2024 16:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725207754;
	bh=cNov5Dzmz/0IjlovJ2rPA5BTo1A2Qx/m55kTOCV5MOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WhMQQkv/R/07Jy0dTKMd0sYJrdR5mJRAyr4vxvj/WK26RpND0Wrh6JA8o4/nS+TcM
	 bqRsIzKJf+st+5aW4QXT7UIVsWyfMRotwc1m6UE2GBYJcOgpn1Xc4YzW0qN33ol0Lo
	 TmMxLEanBnygYGG+BFSGybLpxOGH8BWFqUD0bjE4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 68/98] ALSA: timer: Relax start tick time check for slave timer elements
Date: Sun,  1 Sep 2024 18:16:38 +0200
Message-ID: <20240901160806.261812465@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160803.673617007@linuxfoundation.org>
References: <20240901160803.673617007@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit ccbfcac05866ebe6eb3bc6d07b51d4ed4fcde436 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/timer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -532,7 +532,7 @@ static int snd_timer_start1(struct snd_t
 	/* check the actual time for the start tick;
 	 * bail out as error if it's way too low (< 100us)
 	 */
-	if (start) {
+	if (start && !(timer->hw.flags & SNDRV_TIMER_HW_SLAVE)) {
 		if ((u64)snd_timer_hw_resolution(timer) * ticks < 100000) {
 			result = -EINVAL;
 			goto unlock;



