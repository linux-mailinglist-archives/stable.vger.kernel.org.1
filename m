Return-Path: <stable+bounces-36752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F100689C229
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5209AB288C0
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90254763F1;
	Mon,  8 Apr 2024 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wH6YhN/X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8076F53D;
	Mon,  8 Apr 2024 13:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582241; cv=none; b=tENAayOpNWwcI1PBozmsLLguDFanTvi2pD0u6tfLzBuDr1kk9E0V0ITuYL36p7X1BYacS3wXdoz2MO7bH+iGqVvysEe1V9W1tWKGrHzBiVnT7Txfh37z+gtHehHqL/UTAxPLu+LGdS5PrlRR226Pa1dhouzrtSyDai35rCOjSJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582241; c=relaxed/simple;
	bh=WzhgZ1XHEcwaZFeMC/HMPjD/FtOj3YddoMrqjry3cKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RoYxbMYWC+Mq7aqCNCGK4qFpuKYpHPJie2413y8csIOXMRcyDbZ7AaMS7mFVeySn0T5uBTZUiyUjPpPk1DDvMShyZAsjWULZmkTn0JX6GY9pXU3wZxeRxZzP+076LM2YP8aSN1LVne0+g9rMg5K/v74vzTIWYKaTMYe0DnMhBu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wH6YhN/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C5EC433C7;
	Mon,  8 Apr 2024 13:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712582240;
	bh=WzhgZ1XHEcwaZFeMC/HMPjD/FtOj3YddoMrqjry3cKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wH6YhN/XBCAjFwl/3P762mwH7f39QCx+XIDCbVNDEX3Foti0ZbqfoitPrYXm8q/6c
	 Shol1ErIZAYTzDE+toslsfQZkwRmxw0jndzsBJSOfd6JoR/YUKFqdGoGdLF2iphQbJ
	 lrmPuhQqrxKGajG1Y1ZZQWDk7i3U+ZK2yaJ/zlD0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.15 126/690] ALSA: hda/realtek - Fix headset Mic no show at resume back for Lenovo ALC897 platform
Date: Mon,  8 Apr 2024 14:49:52 +0200
Message-ID: <20240408125404.114784262@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

commit d397b6e56151099cf3b1f7bfccb204a6a8591720 upstream.

Headset Mic will no show at resume back.
This patch will fix this issue.

Fixes: d7f32791a9fc ("ALSA: hda/realtek - Add headset Mic support for Lenovo ALC897 platform")
Cc: <stable@vger.kernel.org>
Signed-off-by: Kailang Yang <kailang@realtek.com>
Link: https://lore.kernel.org/r/4713d48a372e47f98bba0c6120fd8254@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10783,8 +10783,7 @@ static void alc897_hp_automute_hook(stru
 
 	snd_hda_gen_hp_automute(codec, jack);
 	vref = spec->gen.hp_jack_present ? (PIN_HP | AC_PINCTL_VREF_100) : PIN_HP;
-	snd_hda_codec_write(codec, 0x1b, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
-			    vref);
+	snd_hda_set_pin_ctl(codec, 0x1b, vref);
 }
 
 static void alc897_fixup_lenovo_headset_mic(struct hda_codec *codec,
@@ -10793,6 +10792,10 @@ static void alc897_fixup_lenovo_headset_
 	struct alc_spec *spec = codec->spec;
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		spec->gen.hp_automute_hook = alc897_hp_automute_hook;
+		spec->no_shutup_pins = 1;
+	}
+	if (action == HDA_FIXUP_ACT_PROBE) {
+		snd_hda_set_pin_ctl_cache(codec, 0x1a, PIN_IN | AC_PINCTL_VREF_100);
 	}
 }
 



