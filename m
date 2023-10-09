Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3596C7BDD29
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376698AbjJINIH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376680AbjJINIG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:08:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0B89C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:08:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02861C433C8;
        Mon,  9 Oct 2023 13:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696856883;
        bh=CSmQ22dwdebQAPUTT2Dls9dsW5YbssuU61b0fZPMX1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N0sqyc/PwAxsfSMAVa5k8TPBQv9qByYQkEDUkv0g6D0XXk+ZzT97L1PiIcx5nDalu
         39RxMM0B2mpD4o3L3STZI0X5G+fac4kbkKwRL6ELfr9I5io9ICpZUGmKmPYqKca1DM
         d5rFKDFXj/LtlnssrCnEU9emojN+mrusbYbU2+Dk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 005/163] ALSA: hda/realtek - ALC287 Realtek I2S speaker platform support
Date:   Mon,  9 Oct 2023 14:59:29 +0200
Message-ID: <20231009130124.171728708@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

[ Upstream commit 41b07476da38ac2878a14e5b8fe0312c41ea36e3 ]

New platform SSID:0x231f.

0x17 was only speaker pin, DAC assigned will be 0x03. Headphone
assigned to 0x02.
Playback via headphone will get EQ filter processing.
So, it needs to swap DAC.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/8d63c6e360124e3ea2523753050e6f05@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b040889b22880..45fa102060cef 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10567,6 +10567,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
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
-- 
2.40.1



