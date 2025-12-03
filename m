Return-Path: <stable+bounces-198691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBD2CA0ECA
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 19:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FB1B341C9A6
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6050D337B84;
	Wed,  3 Dec 2025 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eamezIPm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247F2338F4A;
	Wed,  3 Dec 2025 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777374; cv=none; b=SuqaDi4Tmt6mE38SWUa2MdLI9NECudU5INcSwjzNghdF640ilbnMZBmbddWsxMByec240TDAiG4aLmlsXXN8g6PcMhzNgY4yL93M0fam8vWlcRuARoHy5oKi0EBo9Y/lmwkLWKDDDfVkbbmfhjLr6U2fuNVzEBZVIHtY/VLGVEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777374; c=relaxed/simple;
	bh=ZdnAP1Hhv2KHUYSlRD4WOOBeleBgQOahKu2wlsMRW3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0MriN87pzow2qSSy46joy0MF2jWpQRbB1+FXHDv/KJFx5NFC7sXsWcsAa4aEHppAB1dAbxOaFPBMKTlnX56/1zp/hMculS4ae8sHEB4sfZwx7ArskxPthmQ+guDeQezxUaSrXXWsu7i3jg7U3zuZguuf0jz6YqQ8X4HEkJNVCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eamezIPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10832C116B1;
	Wed,  3 Dec 2025 15:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764777373;
	bh=ZdnAP1Hhv2KHUYSlRD4WOOBeleBgQOahKu2wlsMRW3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eamezIPmgW97NVGFIuaB6sx8w7uoAv3/fOe4BktBR1Eae2ByOWk/62U1RSD1/W2OY
	 6UNps1g2aUgVD0PBjdnmZmdK/3B3wi/OAFFiOSJsn8gd9BcY9rRSpU3N4xQ6zXc0hf
	 5dques1yvPgoLgzHtqEcT8BhF7QrCeupNptMqVVc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Roy Vegard Ovesen <roy.vegard.ovesen@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 018/392] ALSA: usb-audio: fix control pipe direction
Date: Wed,  3 Dec 2025 16:22:48 +0100
Message-ID: <20251203152414.773625169@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152414.082328008@linuxfoundation.org>
References: <20251203152414.082328008@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roy Vegard Ovesen <roy.vegard.ovesen@gmail.com>

[ Upstream commit 7963891f7c9c6f759cc9ab7da71406b4234f3dd6 ]

Since the requesttype has USB_DIR_OUT the pipe should be
constructed with usb_sndctrlpipe().

Fixes: 8dc5efe3d17c ("ALSA: usb-audio: Add support for Presonus Studio 1810c")
Signed-off-by: Roy Vegard Ovesen <roy.vegard.ovesen@gmail.com>
Link: https://patch.msgid.link/aPPL3tBFE_oU-JHv@ark
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_s1810c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/mixer_s1810c.c b/sound/usb/mixer_s1810c.c
index 0255089c9efb1..38e56ad857243 100644
--- a/sound/usb/mixer_s1810c.c
+++ b/sound/usb/mixer_s1810c.c
@@ -181,7 +181,7 @@ snd_sc1810c_get_status_field(struct usb_device *dev,
 
 	pkt_out.fields[SC1810C_STATE_F1_IDX] = SC1810C_SET_STATE_F1;
 	pkt_out.fields[SC1810C_STATE_F2_IDX] = SC1810C_SET_STATE_F2;
-	ret = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0),
+	ret = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
 			      SC1810C_SET_STATE_REQ,
 			      SC1810C_SET_STATE_REQTYPE,
 			      (*seqnum), 0, &pkt_out, sizeof(pkt_out));
-- 
2.51.0




