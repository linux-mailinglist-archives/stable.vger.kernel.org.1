Return-Path: <stable+bounces-182148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C03DDBAD527
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 16:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC263AACD1
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 14:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0657C302755;
	Tue, 30 Sep 2025 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FexY7CCh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61EE8F7D;
	Tue, 30 Sep 2025 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243995; cv=none; b=faxg+uKphv4yGkj3O6/R7667o3spz4kh5nOoJrNFzqajPeHJs0dMkfbwTBBVGC/eDYLTYR+aeEoztH9vDzaSncJu6ZVC3A2HFXa9vTKvmjcw+8JJYSiVdeCmF9VUSeOHjpJh/SEvw0rdB5nRfTxVDg+TfP/gun1aj1IpS755SHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243995; c=relaxed/simple;
	bh=w0TkskhZalLCl/EhklwXHt4MU1oc3cU44n7U68B+7xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1+yDM5puvZ+vtDoWKovRnVXW97EcBSsJEZzblA9d7XpgVcMbZCeJpH9QccU/H8bqn27R4cRN75muMBlyOC7bp9drHfW2SSLZjf9jXkcw1dx2016C3x/k8eoOoEvZNSKxIcsyiyuzer9Wrqba+tNJthLXpCIJdWYPCaqHftMNew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FexY7CCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A6AC4CEF0;
	Tue, 30 Sep 2025 14:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759243995;
	bh=w0TkskhZalLCl/EhklwXHt4MU1oc3cU44n7U68B+7xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FexY7CChRnqty3OW0vAro4lDy4kEtoW06WS9bRLFedtbP/1LbEr0VtdQ6xkWBbVP8
	 j4zB66YNe8nGeU0c38h1ZEi7f5Ht7ySW4Xo2RvXtFnMrWAybsyq5FJYoD7tSDEq7Et
	 aG95giJQjXPL+IC8ys7SXIdawLmc5sda4pRiYZwE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 61/81] ALSA: usb-audio: Fix build with CONFIG_INPUT=n
Date: Tue, 30 Sep 2025 16:47:03 +0200
Message-ID: <20250930143822.233185361@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143819.654157320@linuxfoundation.org>
References: <20250930143819.654157320@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit d0630a0b80c08530857146e3bf183a7d6b743847 ]

The recent addition of DualSense mixer quirk relies on the input
device handle, and the build can fail if CONFIG_INPUT isn't set.
Put (rather ugly) workarounds to wrap with IS_REACHABLE() for avoiding
the build error.

Fixes: 79d561c4ec04 ("ALSA: usb-audio: Add mixer quirk for Sony DualSense PS5")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506130733.gnPKw2l3-lkp@intel.com/
Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Link: https://patch.msgid.link/20250613081543.7404-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 833f894a692c7..974926d907c2f 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -527,6 +527,7 @@ static int snd_emu0204_controls_create(struct usb_mixer_interface *mixer)
 					  &snd_emu0204_control, NULL);
 }
 
+#if IS_REACHABLE(CONFIG_INPUT)
 /*
  * Sony DualSense controller (PS5) jack detection
  *
@@ -783,6 +784,7 @@ static int snd_dualsense_controls_create(struct usb_mixer_interface *mixer)
 
 	return snd_dualsense_jack_create(mixer, "Headset Mic Jack", false);
 }
+#endif /* IS_REACHABLE(CONFIG_INPUT) */
 
 /* ASUS Xonar U1 / U3 controls */
 
@@ -2639,10 +2641,12 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 		err = snd_emu0204_controls_create(mixer);
 		break;
 
+#if IS_REACHABLE(CONFIG_INPUT)
 	case USB_ID(0x054c, 0x0ce6): /* Sony DualSense controller (PS5) */
 	case USB_ID(0x054c, 0x0df2): /* Sony DualSense Edge controller (PS5) */
 		err = snd_dualsense_controls_create(mixer);
 		break;
+#endif /* IS_REACHABLE(CONFIG_INPUT) */
 
 	case USB_ID(0x0763, 0x2030): /* M-Audio Fast Track C400 */
 	case USB_ID(0x0763, 0x2031): /* M-Audio Fast Track C400 */
-- 
2.51.0




