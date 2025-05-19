Return-Path: <stable+bounces-144797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7D2ABBE01
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68DAC3A3698
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 12:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE16B278E42;
	Mon, 19 May 2025 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xS+KeGQ6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D63920C00E
	for <stable@vger.kernel.org>; Mon, 19 May 2025 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747658202; cv=none; b=laXBAOOc9Ny6tcW30KbveQ7iLmhpC5qfAIHrNP2zSOIBC8uj+2WLDCG7RpUeKnWuKOQbd9v482qtYhNd/PrA48/iMTE2eJmPMTKrwH5bCfbr2NV2HD+61Iwz4RZGfu1Qc5k5fUOCGrECVaGKP420RorIycEP6tcuzRyv6Jm07AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747658202; c=relaxed/simple;
	bh=z6v/LHHqLtM5zQilyY6uY68sZcG+tOYWqysUjcHlTp8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Q19rFnpK4GMv1D0tK4/Nq0K6RhL5TsDgubBATqgzH6u6uF4szgB/8Hi004Um1tPKi/7z9dgDhGlN5wWzBmRkFWWRX4YFnSYnBrxYZOeJF5kAWMRGtncm5f8Cidc+Q3AfcxYJ5muH4hnbelFsMDmeMJf47FgCnqAuadJn6bbXHEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xS+KeGQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AF1C4CEE4;
	Mon, 19 May 2025 12:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747658202;
	bh=z6v/LHHqLtM5zQilyY6uY68sZcG+tOYWqysUjcHlTp8=;
	h=Subject:To:Cc:From:Date:From;
	b=xS+KeGQ6cmBkdvOR4o62DFn627AtYo9FfDN/6ivrBl2Am71wVUr0kT1kvsnMqUGw1
	 tRRvX6ZjbWwn/9ceZlPuQWoasXV4PmZuAXeWI5UqfPwjOFZQAmGt9lfLP9Qe6UIOZ1
	 gtRwTL9iwn0AKYotRRfKEL1tCsUXYmooh0CocJJM=
Subject: FAILED: patch "[PATCH] ALSA: usb-audio: Add sample rate quirk for Audioengine D1" failed to apply to 5.10-stable tree
To: christian@heusel.eu,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 14:34:50 +0200
Message-ID: <2025051950-shrunk-outboard-edca@gregkh>
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
git cherry-pick -x 2b24eb060c2bb9ef79e1d3bcf633ba1bc95215d6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051950-shrunk-outboard-edca@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2b24eb060c2bb9ef79e1d3bcf633ba1bc95215d6 Mon Sep 17 00:00:00 2001
From: Christian Heusel <christian@heusel.eu>
Date: Mon, 12 May 2025 22:23:37 +0200
Subject: [PATCH] ALSA: usb-audio: Add sample rate quirk for Audioengine D1

A user reported on the Arch Linux Forums that their device is emitting
the following message in the kernel journal, which is fixed by adding
the quirk as submitted in this patch:

    > kernel: usb 1-2: current rate 8436480 is different from the runtime rate 48000

There also is an entry for this product line added long time ago.
Their specific device has the following ID:

    $ lsusb | grep Audio
    Bus 001 Device 002: ID 1101:0003 EasyPass Industrial Co., Ltd Audioengine D1

Link: https://bbs.archlinux.org/viewtopic.php?id=305494
Fixes: 93f9d1a4ac593 ("ALSA: usb-audio: Apply sample rate quirk for Audioengine D1")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Heusel <christian@heusel.eu>
Link: https://patch.msgid.link/20250512-audioengine-quirk-addition-v1-1-4c370af6eff7@heusel.eu
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 9112313a9dbc..eb192834db68 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2250,6 +2250,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x0fd9, 0x0008, /* Hauppauge HVR-950Q */
 		   QUIRK_FLAG_SHARE_MEDIA_DEVICE | QUIRK_FLAG_ALIGN_TRANSFER),
+	DEVICE_FLG(0x1101, 0x0003, /* Audioengine D1 */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x1224, 0x2a25, /* Jieli Technology USB PHY 2.0 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE | QUIRK_FLAG_MIC_RES_16),
 	DEVICE_FLG(0x1395, 0x740a, /* Sennheiser DECT */


