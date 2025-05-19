Return-Path: <stable+bounces-144798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 312BEABBDFD
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D269C17D47D
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 12:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D4720C00E;
	Mon, 19 May 2025 12:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ukxz9MPT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F1E278E71
	for <stable@vger.kernel.org>; Mon, 19 May 2025 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747658206; cv=none; b=ZB3QHxsoQEI1O4Z+w5Yhiik+VWNBSZ7g9HEXLeBmmr6ohgrqyKug0imh/SR3RQjEt1NIPABSCHLX5qz/xMr91gobbGsEy8uRSJraVk8h6ioS0YQnHw0RZ2azt6ken/tq7S5fY1Bcc7dHJDsC2Lshwn3cNyE70LDTPIsQfOumKLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747658206; c=relaxed/simple;
	bh=ubhBphRphOdw+HB0IfwevX2Z6bv5NJ4frpcG/5hkJvc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nWuzyDD04m1hwx6DJX1vUtkVLQLSLio+t5WnI9F6rmJs3Rc9XZhWS2lzcC05xBkbFQ4gYdHd1nPuBhEvP0E/26+fFY4hNWMebaY9AuwcVzG0i4imSqy+useShyWxVB6XFxyi8s25UG3JOpMYNKICuS+5NLojKQEpQeEvcIHt0IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ukxz9MPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399AAC4CEEF;
	Mon, 19 May 2025 12:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747658205;
	bh=ubhBphRphOdw+HB0IfwevX2Z6bv5NJ4frpcG/5hkJvc=;
	h=Subject:To:Cc:From:Date:From;
	b=Ukxz9MPThj1ggfkesIGtW3/0BIY0AQ/fZs3WT2PzsYNQSGJXl/UCAZ91rOKIlW64e
	 XUlG8IIqw1cUB+lxnPii9J/Gb1c3XrF0b5IgyVP48GkVYJbrqkQ6ENhrYcYQyooKul
	 qE1Fn4NFRMnSx9sgWyVH9fStMazKpjzXyG5u697Y=
Subject: FAILED: patch "[PATCH] ALSA: usb-audio: Add sample rate quirk for Audioengine D1" failed to apply to 5.4-stable tree
To: christian@heusel.eu,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 14:34:51 +0200
Message-ID: <2025051950-washer-silica-cf99@gregkh>
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
git cherry-pick -x 2b24eb060c2bb9ef79e1d3bcf633ba1bc95215d6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051950-washer-silica-cf99@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


