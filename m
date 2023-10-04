Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527D77B82A5
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 16:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjJDOs7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 10:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjJDOs7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 10:48:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0488CBF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 07:48:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E07C433C7;
        Wed,  4 Oct 2023 14:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696430935;
        bh=DoJJFEDye9+Jw37m1SaUZGmQBBKQwPSktdC3M/ix37U=;
        h=Subject:To:Cc:From:Date:From;
        b=ObubeVke7MTWRsin8Uut9BH5YEmf9Ihogb/xZj+fQg3zFj4CVF57azROFOJIo7MMx
         8pXmuXaTROEEcPpTW9mZi9ephD3webfiN02AdICwhpUBOxhxEjhZ3ov9E0uWIPINp9
         AJsvmr9DAFVRv+UwOC0sLvSzQs4JBPHfWZ/kl7o8=
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek - ALC287 Realtek I2S speaker platform" failed to apply to 6.5-stable tree
To:     kailang@realtek.com, stable@vger.kernel.org, tiwai@suse.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 04 Oct 2023 16:48:52 +0200
Message-ID: <2023100451-alarm-grasp-7872@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 41b07476da38ac2878a14e5b8fe0312c41ea36e3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100451-alarm-grasp-7872@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 41b07476da38ac2878a14e5b8fe0312c41ea36e3 Mon Sep 17 00:00:00 2001
From: Kailang Yang <kailang@realtek.com>
Date: Tue, 19 Sep 2023 16:27:16 +0800
Subject: [PATCH] ALSA: hda/realtek - ALC287 Realtek I2S speaker platform
 support

New platform SSID:0x231f.

0x17 was only speaker pin, DAC assigned will be 0x03. Headphone
assigned to 0x02.
Playback via headphone will get EQ filter processing.
So, it needs to swap DAC.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/8d63c6e360124e3ea2523753050e6f05@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 883a7e865bc5..751783f3a15c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10577,6 +10577,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x17, 0x90170110},
 		{0x19, 0x03a11030},
 		{0x21, 0x03211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0287, 0x17aa, "Lenovo", ALC287_FIXUP_THINKPAD_I2S_SPK,
+		{0x17, 0x90170110}, /* 0x231f with RTK I2S AMP */
+		{0x19, 0x04a11040},
+		{0x21, 0x04211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0286, 0x1025, "Acer", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE,
 		{0x12, 0x90a60130},
 		{0x17, 0x90170110},

