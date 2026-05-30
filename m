Return-Path: <stable+bounces-256970-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIgnJi4PG2q/+ggAu9opvQ
	(envelope-from <stable+bounces-256970-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:24:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F6B60E21B
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 907783001852
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBAF348C4E;
	Sat, 30 May 2026 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vwOr5U20"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FA1348C46;
	Sat, 30 May 2026 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780158249; cv=none; b=eDCuRB6c9JJitX/VeasDkSgnYUpQzBFT6Ffw0eG8WlVu85lB5jfuclVlXrt8/pwhWEXgqRzaC7IKQ9vtGQpHD3jSfwM0CDdgf1f3d14kRCAbl6Nm8mAzZ6MZK4LB+Xhd4nP3+7iMUNHxIfoSJalNl6/qj5dxxxgwvTvJohYW84k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780158249; c=relaxed/simple;
	bh=MEa+POPfIZlCRr7iQjm3DOnUB5eMzVf4SP8NiHKhRn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5ckHoRcUqLhVbWb7EvhJANV3/JUAdUM0mg6W2yTzE4btvzC+oH0WnauptR0mjaJdtJKipoAM2a+gUz5jdE4hnCT79pxU/Bd5JwIjFbgo8VdOa8wb/jVbcVVg8UQ5ghqOlHz9Xbs3Wm3iZQ6T3z/ofROm+vpiEyH/FaeArb8vq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vwOr5U20; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235AE1F00893;
	Sat, 30 May 2026 16:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780158247;
	bh=WknNfhVZ6FynkHPO3vEgfrHLyRCrOaE6WZDiXHJXex0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vwOr5U20mACDRxS3x2lvlMAoo8POgtvC2+2dycODZbV+wI03SM33XeL2yyj4NuWjd
	 VVmgerjwo6YabP7UGSUfwGqy7wT6FOJuiQg0J6SEEwfD5qatYHB82MVgHS+bkAwoWR
	 EyDmzqBA+b/I0mNfvszPTHZ6BwQkk0TbT2+Jscfo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yue Wang <yuleopen@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Phil Willoughby <willerz@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 014/969] ALSA: usb-audio: Fix quirk flags for NeuralDSP Quad Cortex
Date: Sat, 30 May 2026 17:52:18 +0200
Message-ID: <20260530160300.865897909@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,perex.cz,suse.com,suse.de,kernel.org];
	TAGGED_FROM(0.00)[bounces-256970-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.de:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 92F6B60E21B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Phil Willoughby <willerz@gmail.com>

[ Upstream commit bc5b4e5ae1a67700a618328217b6a3bd0f296e97 ]

The NeuralDSP Quad Cortex does not support DSD playback. We need
this product-specific entry with zero quirks because otherwise it
falls through to the vendor-specific entry which marks it as
supporting DSD playback.

Cc: Yue Wang <yuleopen@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Signed-off-by: Phil Willoughby <willerz@gmail.com>
Link: https://patch.msgid.link/20260328080921.3310-1-willerz@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 74828de545e22..23361e78189d0 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2177,6 +2177,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_PLAYBACK_FIRST | QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x13e5, 0x0001, /* Serato Phono */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
+	DEVICE_FLG(0x152a, 0x880a, /* NeuralDSP Quad Cortex */
+		   0), /* Doesn't have the vendor quirk which would otherwise apply */
 	DEVICE_FLG(0x154e, 0x1002, /* Denon DCD-1500RE */
 		   QUIRK_FLAG_ITF_USB_DSD_DAC | QUIRK_FLAG_CTL_MSG_DELAY),
 	DEVICE_FLG(0x154e, 0x1003, /* Denon DA-300USB */
-- 
2.53.0




