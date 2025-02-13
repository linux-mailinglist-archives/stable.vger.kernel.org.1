Return-Path: <stable+bounces-115845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4685AA34504
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 039BF7A4659
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0735684;
	Thu, 13 Feb 2025 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qmHwXXwP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0456E26B0AD;
	Thu, 13 Feb 2025 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459451; cv=none; b=mMEN2m5OZ0nPrGF+G+Ok6N/dhuUXemzAF4XwCItz6IgXDzs5Blm32ozGSBPeUFi5AbQQyrgeIDVoqFaNGPULzTmjhFmk+ECllavDnKLoMT8i3l5fuJgBTJNH4xP6z4eXAI+W5LOv/zUwlyfwNiUIirJAfr6X8A/VwIR0Fu0PtQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459451; c=relaxed/simple;
	bh=zz0UxuGoHgt4IlHBnmmGdjQX3/8vIusgElgtPdP5Ksg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cN/HfslChX2tlwD67G2moOYuB8oMW3cfUTwmVV1JrgJxzBbkkl5Cu0yfO6Z37dGDw5LnMC6UMJ17ozhIU4uIVaCVeK0IjTbwl209EEeHo8Ya82rwQJW5z64UkT6H7JVdlNmGCKQKWETJy9CoHXS2TX+AYCmrxEhmYzkdCbJ+m+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qmHwXXwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EA0C4CED1;
	Thu, 13 Feb 2025 15:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739459450;
	bh=zz0UxuGoHgt4IlHBnmmGdjQX3/8vIusgElgtPdP5Ksg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qmHwXXwPogzn1ILDjYFXndWY30i/wTj8p4WOtcy6k8z3kJWmjU8Zp+1OGCXqEw0Px
	 g21ki++wZSufGl0cK9ZeWeEkGdeKanIcjqEKsTAUKZJGf07BYSzBYB7/NQg+QI9/Cy
	 isYQ6BykRNsgK+a8cKkM1J6ZhT318v79+GzX8Ng0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Edson Juliano Drosdeck <edson.drosdeck@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.13 267/443] ALSA: hda/realtek: Enable headset mic on Positivo C6400
Date: Thu, 13 Feb 2025 15:27:12 +0100
Message-ID: <20250213142450.917485099@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
References: <20250213142440.609878115@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>

commit 1aec3ed2e3e1512aba15e7e790196a44efd5f0a7 upstream.

Positivo C6400 is equipped with ALC269VB, and it needs
ALC269VB_FIXUP_ASUS_ZENBOOK quirk to make its headset mic work.
Also must to limits the microphone boost.

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20250114170619.11510-1-edson.drosdeck@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10965,6 +10965,7 @@ static const struct hda_quirk alc269_fix
 	SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
 	SND_PCI_QUIRK(0x17aa, 0x9e56, "Lenovo ZhaoYang CF4620Z", ALC286_FIXUP_SONY_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1849, 0x0269, "Positivo Master C6400", ALC269VB_FIXUP_ASUS_ZENBOOK),
 	SND_PCI_QUIRK(0x1849, 0x1233, "ASRock NUC Box 1100", ALC233_FIXUP_NO_AUDIO_JACK),
 	SND_PCI_QUIRK(0x1849, 0xa233, "Positivo Master C6300", ALC269_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1854, 0x0440, "LG CQ6", ALC256_FIXUP_HEADPHONE_AMP_VOL),



