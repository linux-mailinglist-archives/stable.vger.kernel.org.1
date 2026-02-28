Return-Path: <stable+bounces-220324-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFhpCp1Fo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220324-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:44:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 498611C74FA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8E0031586E7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A480036C9DE;
	Sat, 28 Feb 2026 17:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XD8JYPZT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D78394E39;
	Sat, 28 Feb 2026 17:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300225; cv=none; b=JUjktgJqBvaOEb0u4HPjEYDH57/s0T05Dv5KqKb+Tb+EZGSLXVk+dlAgbeYiswgjhb+eUk7x1Y4510HDV0aYI6EkwPXy52O6PYDCMxCWEqs/wsS5gw0gXkj+512tjsU3Kmt5XIBx8bJuv2NPbUrwZ9FXBJ0QUjQns9Lu9Zga50w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300225; c=relaxed/simple;
	bh=/yZCBkpeV0BRKG6Vz2LJomJytJ3XnnRPg8lfsfyM9Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lWGwlwl7YrK9D0H7k2yULCYCZwnUwNhLJHiuxza6f9F33HESMQFp3hiD6/Ri7kZk8dEZApDhR4rIMONLU8ESj//AjCspPA2SoAJzYA4U1pOgq2yGHRyRhYkevBd0TZnQD951Lc5lNPL4U1DozU7DkFAS1dg+UL1vTGvQp9PSiPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XD8JYPZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CF0C19423;
	Sat, 28 Feb 2026 17:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300225;
	bh=/yZCBkpeV0BRKG6Vz2LJomJytJ3XnnRPg8lfsfyM9Vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XD8JYPZTGqZeJKrsyPQUijd8gsQwJ5GdVMiOS7EUsvi70bjNEKK3H3g4NooXwxa3t
	 DjQwSfxs28hD1BlYnszxxwiXjXz1aI2r8f4aCnMphGo9f6AvRV4uOWaUZONWnisw2o
	 EuYt146Pz+TVqZMmV4/peZFjbn1xSy1VDSLZkwghmo149KDlU3IVZclyUI9VfpZft7
	 BQozSXrF9zC0xXdQ8qoA6QsC3wnhw2qRocpYq/CBoUgkEetzGwRW444ReSE/ys606i
	 9etcSsHJZih8QY+AeNoH5fD0gssDoaLIy0Nh3Ui4Q/PD/vl3T3a+J3781HJfeByh3v
	 m+0LzbaStmDcg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qihang Guo <v-conet@outlook.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 246/844] ALSA: usb-audio: Add DSD support for iBasso DC04U
Date: Sat, 28 Feb 2026 12:22:39 -0500
Message-ID: <20260228173244.1509663-247-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[outlook.com,suse.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220324-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,outlook.com:email,suse.de:email]
X-Rspamd-Queue-Id: 498611C74FA
X-Rspamd-Action: no action

From: Qihang Guo <v-conet@outlook.com>

[ Upstream commit fe7cd89f0e29f0852316857b4861309f9b891370 ]

Vendor ID 0x0661 is assigned to Hamamatsu Photonics K.K.,
but is used by iBasso for iBasso DC04U (0x0661:0x0883),
which supports native DSD playback.

This patch adds QUIRK_FLAG_DSD_RAW for iBasso DC04U, enabling
native DSD playback (DSD_U32_BE). The change has been verified
on Arch Linux using mpd and pw-cat.

Signed-off-by: Qihang Guo <v-conet@outlook.com>
Link: https://patch.msgid.link/TYYPR01MB14098529E0BD900921BE6F42CF465A@TYYPR01MB14098.jpnprd01.prod.outlook.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 4f9d19bf1ccac..7fabaeb3781a2 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2235,6 +2235,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x0644, 0x806c, /* Esoteric XD */
 		   QUIRK_FLAG_ITF_USB_DSD_DAC | QUIRK_FLAG_CTL_MSG_DELAY |
 		   QUIRK_FLAG_IFACE_DELAY | QUIRK_FLAG_FORCE_IFACE_RESET),
+	DEVICE_FLG(0x0661, 0x0883, /* iBasso DC04 Ultra */
+		   QUIRK_FLAG_DSD_RAW),
 	DEVICE_FLG(0x06f8, 0xb000, /* Hercules DJ Console (Windows Edition) */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x06f8, 0xd002, /* Hercules DJ Console (Macintosh Edition) */
-- 
2.51.0


