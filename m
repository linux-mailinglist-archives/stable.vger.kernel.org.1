Return-Path: <stable+bounces-120275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 593DDA4E753
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E6E8A7BAC
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 16:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA15296151;
	Tue,  4 Mar 2025 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d18mcY1t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE531294EE2
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105764; cv=none; b=gIKzvluRM4iqlh/B1P4dfqbTv/5wrLPTerhgdhMrjpbchPfzefgRH2z6zOTW/hxBWtOxrR3wuYxyUuCZGYaK5GuKazWGetPNLObRTjIr3uSlguQW0ybhidf2sHWuwBp3XHiWRQmXiABzYzkfNXa0f3oXTLC5oeF9Y8EVhavCmnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105764; c=relaxed/simple;
	bh=5JgzB865rwTvasw4vlXXl61P8y/pIMkJ7UJYVylkd/4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=K1reV6ysG2sPqVL2b6Saz29Z+oGIkI0sd3jLTgZ3FuS6b01wmYIdlfpE5DJoLMQDlyITaFlRf51jaApDvTAVFdFEu+zUpeb50um2Sc3CsDeihof/ubblf3DpUrDF7s3k4JnoisQLjxA0L5kPMHIjB21fM6y+DKepJXTzWqu3GOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d18mcY1t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6838C4CEE5;
	Tue,  4 Mar 2025 16:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741105764;
	bh=5JgzB865rwTvasw4vlXXl61P8y/pIMkJ7UJYVylkd/4=;
	h=Subject:To:Cc:From:Date:From;
	b=d18mcY1t9K4DYp5RRaGGQHoQ8VAxXQe0n0d5NVHkSEdUavxWiig0W/Cbbad5eYc4F
	 AeRakoeQw1Bg1iGbzUg8aBVUAfnyoj9bc7EzMP6Qc1DVrTsG00zTJ1DTP3ZUHu2EtG
	 qKWbDWmTgar7h9g8Tf4GfWWdW2zj0gA/rgPLsWCw=
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: Fix microphone regression on ASUS N705UD" failed to apply to 5.15-stable tree
To: adrienverge@gmail.com,chris.chiu@canonical.com,tiwai@suse.de,visitorckw@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 17:29:19 +0100
Message-ID: <2025030419-scavenger-anchor-1521@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c6557ccf8094ce2e1142c6e49cd47f5d5e2933a8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030419-scavenger-anchor-1521@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c6557ccf8094ce2e1142c6e49cd47f5d5e2933a8 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Adrien=20Verg=C3=A9?= <adrienverge@gmail.com>
Date: Wed, 26 Feb 2025 14:55:15 +0100
Subject: [PATCH] ALSA: hda/realtek: Fix microphone regression on ASUS N705UD
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This fixes a regression introduced a few weeks ago in stable kernels
6.12.14 and 6.13.3. The internal microphone on ASUS Vivobook N705UD /
X705UD laptops is broken: the microphone appears in userspace (e.g.
Gnome settings) but no sound is detected.
I bisected it to commit 3b4309546b48 ("ALSA: hda: Fix headset detection
failure due to unstable sort").

I figured out the cause:
1. The initial pins enabled for the ALC256 driver are:
       cfg->inputs == {
         { pin=0x19, type=AUTO_PIN_MIC,
           is_headset_mic=1, is_headphone_mic=0, has_boost_on_pin=1 },
         { pin=0x1a, type=AUTO_PIN_MIC,
           is_headset_mic=0, is_headphone_mic=0, has_boost_on_pin=1 } }
2. Since 2017 and commits c1732ede5e8 ("ALSA: hda/realtek - Fix headset
   and mic on several ASUS laptops with ALC256") and 28e8af8a163 ("ALSA:
   hda/realtek: Fix mic and headset jack sense on ASUS X705UD"), the
   quirk ALC256_FIXUP_ASUS_MIC is also applied to ASUS X705UD / N705UD
   laptops.
   This added another internal microphone on pin 0x13:
       cfg->inputs == {
         { pin=0x13, type=AUTO_PIN_MIC,
           is_headset_mic=0, is_headphone_mic=0, has_boost_on_pin=1 },
         { pin=0x19, type=AUTO_PIN_MIC,
           is_headset_mic=1, is_headphone_mic=0, has_boost_on_pin=1 },
         { pin=0x1a, type=AUTO_PIN_MIC,
           is_headset_mic=0, is_headphone_mic=0, has_boost_on_pin=1 } }
   I don't know what this pin 0x13 corresponds to. To the best of my
   knowledge, these laptops have only one internal microphone.
3. Before 2025 and commit 3b4309546b48 ("ALSA: hda: Fix headset
   detection failure due to unstable sort"), the sort function would let
   the microphone of pin 0x1a (the working one) *before* the microphone
   of pin 0x13 (the phantom one).
4. After this commit 3b4309546b48, the fixed sort function puts the
   working microphone (pin 0x1a) *after* the phantom one (pin 0x13). As
   a result, no sound is detected anymore.

It looks like the quirk ALC256_FIXUP_ASUS_MIC is not needed anymore for
ASUS Vivobook X705UD / N705UD laptops. Without it, everything works
fine:
- the internal microphone is detected and records actual sound,
- plugging in a jack headset is detected and can record actual sound
  with it,
- unplugging the jack headset makes the system go back to internal
  microphone and can record actual sound.

Cc: stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Chris Chiu <chris.chiu@canonical.com>
Fixes: 3b4309546b48 ("ALSA: hda: Fix headset detection failure due to unstable sort")
Tested-by: Adrien Vergé <adrienverge@gmail.com>
Signed-off-by: Adrien Vergé <adrienverge@gmail.com>
Link: https://patch.msgid.link/20250226135515.24219-1-adrienverge@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e5c80d4be535..c735f630ecb5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10657,7 +10657,6 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x19ce, "ASUS B9450FA", ALC294_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x19e1, "ASUS UX581LV", ALC295_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
-	SND_PCI_QUIRK(0x1043, 0x1a30, "ASUS X705UD", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1a63, "ASUS UX3405MA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1a83, "ASUS UM5302LA", ALC294_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1a8f, "ASUS UX582ZS", ALC245_FIXUP_CS35L41_SPI_2),


