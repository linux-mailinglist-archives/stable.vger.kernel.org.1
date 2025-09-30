Return-Path: <stable+bounces-182583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C75BADB02
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13151162350
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E9F2FD1DD;
	Tue, 30 Sep 2025 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D/NRmXwG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71522217F55;
	Tue, 30 Sep 2025 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245416; cv=none; b=TpgETiodA37RXLteR4zh9hl8gY4MrAJ71QyjRBCclcgyuJYkBLx0KXs8mwmkJ0csjRrLny4eV04eEEmf8NhHRYwiE8FuV0f8XktyUMu1Bg4MRDtHwu1ZkWEuCIp+8zRBj4m6yoHKW8r79WugHuLlquDcV17DWv5yNldrj/lP/S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245416; c=relaxed/simple;
	bh=vR0gw6mwqcrvrPU8WDYytuYhV1oW33WoLLJWEqR4LfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMdK3xS6VybK+hvxy8sR0u+xmd7jCLsSFKqWqwYDW6kTU0ZCsfAYhTbcp6CDb9sQRWdz9PkZBUMUgExEOaiOlxkL3IvgkRdVbRvJS8yzUzoT5oF1B6JZuGgPbkVxmIwA2r11nNBtGzuAU5DewLxinRcJDWPKzyoB6cQ5UxSq/X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D/NRmXwG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9EEC113D0;
	Tue, 30 Sep 2025 15:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759245416;
	bh=vR0gw6mwqcrvrPU8WDYytuYhV1oW33WoLLJWEqR4LfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D/NRmXwGqlgR64klCJj4Mo9sFAItmuqXHuxeo7b8Lfe5JdptBGa30a1QnAGuiheYZ
	 XPpImuee/k9gJjw4dI+CmwU8YCordpbj7LUuzsJSn2irmceVhVTyRHLmc1IRrUWD4G
	 NDIqmFtxEciiEHNT/X7qTxrAJ4hk3ZTRL9t/GCHw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 12/73] ALSA: usb-audio: Fix build with CONFIG_INPUT=n
Date: Tue, 30 Sep 2025 16:47:16 +0200
Message-ID: <20250930143821.071472938@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143820.537407601@linuxfoundation.org>
References: <20250930143820.537407601@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index f1b663a05f295..8c0b8383abe1e 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -528,6 +528,7 @@ static int snd_emu0204_controls_create(struct usb_mixer_interface *mixer)
 					  &snd_emu0204_control, NULL);
 }
 
+#if IS_REACHABLE(CONFIG_INPUT)
 /*
  * Sony DualSense controller (PS5) jack detection
  *
@@ -784,6 +785,7 @@ static int snd_dualsense_controls_create(struct usb_mixer_interface *mixer)
 
 	return snd_dualsense_jack_create(mixer, "Headset Mic Jack", false);
 }
+#endif /* IS_REACHABLE(CONFIG_INPUT) */
 
 /* ASUS Xonar U1 / U3 controls */
 
@@ -3648,10 +3650,12 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
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




