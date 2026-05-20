Return-Path: <stable+bounces-250470-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHfCB4YQDmrB5wUAu9opvQ
	(envelope-from <stable+bounces-250470-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:50:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC95598C80
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C27337905B6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A303C8723;
	Wed, 20 May 2026 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XRZYBK5w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3803BCD2A;
	Wed, 20 May 2026 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295493; cv=none; b=PFDnrHSMOrwt8P4EJ6ns5vqRivdsiX2GFCw4WrtTLCo62qpCXKDIH/oIfZVIYs5Yt95besRppCqVSowKJZ9qHoZmRKmK1cgRmZWf8Sc1czpbMjO3uG9IX2PmGFZj8TX01VwiCGQtMyKs/7JbazF7tL6OmwGo59JCah4HOFnYBM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295493; c=relaxed/simple;
	bh=lVhXZK72qh+Be/D7KF8De3Fr1EnjQWYDwZN0hezIzkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1KZbOQHnAT4D8IpAuupDamkeCNy8cYAgPRMEiekDE4v0E8j7MYk8sueolJ5ez2hNNAnhOB9fhUjLA12eegs29SzgREbr5EdNWBQZiZ4UQROI2FpqAWb97WHPSRcrLng3hqbgzxnjeQsKVKPlxpm7SIsFsRZlHy39dojWlYOjyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XRZYBK5w; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7D31F000E9;
	Wed, 20 May 2026 16:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295492;
	bh=FD9t3FS2c8R3AsQ2vck8AxOu/WPDY9N2uflGkhuXUJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XRZYBK5wHvYI2Tsye2+GfyHW+AGr2NLT4mX4wU15kI/f+SPLhZl2+YO9SHUjpFgY0
	 svq+FGZIz/OZ0MZHUyH5Z2kV00bTe6YEnuBoREpVFMDgTAOT4x4spHtFhXxMJgDGoi
	 FGlAsOtxr4Ra4+vaRjZXbI6Pr6BS1vU0honVkSiE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Geoffrey D. Bennett" <g@b4.vu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0441/1146] ALSA: usb-audio: Exclude Scarlett 18i20 1st Gen from SKIP_IFACE_SETUP
Date: Wed, 20 May 2026 18:11:31 +0200
Message-ID: <20260520162158.179208266@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250470-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,b4.vu:email,suse.de:email]
X-Rspamd-Queue-Id: 7DC95598C80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geoffrey D. Bennett <g@b4.vu>

[ Upstream commit a47306a74c31557b1e5cab54642950bbb20294cb ]

Same issue as the other 1st Gen Scarletts: QUIRK_FLAG_SKIP_IFACE_SETUP
causes distorted audio on the Scarlett 18i20 1st Gen (1235:800c).

Fixes: 38c322068a26 ("ALSA: usb-audio: Add QUIRK_FLAG_SKIP_IFACE_SETUP")
Reported-by: tucktuckg00se [https://github.com/geoffreybennett/linux-fcp/issues/54]
Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
Link: https://patch.msgid.link/ad0ozNnkcFrcjVQz@m.b4.vu
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 4cfa24c06fcdf..6f2a053d971c9 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2435,6 +2435,7 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_VALIDATE_RATES),
 	DEVICE_FLG(0x1235, 0x8006, 0), /* Focusrite Scarlett 2i2 1st Gen */
 	DEVICE_FLG(0x1235, 0x800a, 0), /* Focusrite Scarlett 2i4 1st Gen */
+	DEVICE_FLG(0x1235, 0x800c, 0), /* Focusrite Scarlett 18i20 1st Gen */
 	DEVICE_FLG(0x1235, 0x8016, 0), /* Focusrite Scarlett 2i2 1st Gen */
 	DEVICE_FLG(0x1235, 0x801c, 0), /* Focusrite Scarlett Solo 1st Gen */
 	VENDOR_FLG(0x1235, /* Focusrite Novation */
-- 
2.53.0




