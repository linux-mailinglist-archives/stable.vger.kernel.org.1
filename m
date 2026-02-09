Return-Path: <stable+bounces-215295-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCDHDkf2iWl7FAAAu9opvQ
	(envelope-from <stable+bounces-215295-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:59:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B99AE11152D
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6414F30AF07C
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78CC28725B;
	Mon,  9 Feb 2026 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MbYkjUi6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB0427CCF2;
	Mon,  9 Feb 2026 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648327; cv=none; b=X3hdiqutxdE+zeM7El4gMFBSRaOUmd2KzHGm+y/+JZUcZbWSNG/WsWFy+1eLXHFDeS8bXVii5BqApyHMKFI6Vdde2OUrQGvgspMzkRi0uifwQazi9UrdCs/czUnSgelkRExkEUChf4OALYM9jHdGJf4wrK5TnmhJxE7KK0d48Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648327; c=relaxed/simple;
	bh=m+Z8OkdJaW/HIZjJNMeMWXnSaUp3+sWLhSk5ENvatbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbSQXSxfP9hfyOTzY5DdwcdNZ33Ie3awgY+9gcwmJpKZsbyXcCchj57Sx+dEnXOCCIQG6/C7h4E7sccMn8XFJv0WObOSEGBBMNXnFk9hHONmS9ycMzax8kq/jC0IKVec2f4VyRuNgjElTz56iJt2Gs1T6O7E7o60/FzibHh9pNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MbYkjUi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2922EC116C6;
	Mon,  9 Feb 2026 14:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648327;
	bh=m+Z8OkdJaW/HIZjJNMeMWXnSaUp3+sWLhSk5ENvatbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MbYkjUi6L9GVOIOvXX1GGlaDCQK3L75pnoNmlSzb5lcyUZW404v6iuKMFCkRtk27E
	 qTRScdvGRTTh5b7pA6JerRf3Gt2xAtSVQJCJekEvSLcDXYL0ABf8mkhYmsspy/3Es2
	 x+E80TMknio8zHEn9lJz4C9Xrx7xIQoPxWWptsP4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tim Guttzeit <t.guttzeit@tuxedocomputers.com>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 42/69] ALSA: hda/realtek: Fix headset mic for TongFang X6AR55xU
Date: Mon,  9 Feb 2026 15:24:10 +0100
Message-ID: <20260209142303.437890806@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142301.913348974@linuxfoundation.org>
References: <20260209142301.913348974@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215295-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tuxedocomputers.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,msgid.link:url]
X-Rspamd-Queue-Id: B99AE11152D
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tim Guttzeit <t.guttzeit@tuxedocomputers.com>

[ Upstream commit b48fe9af1e60360baf09ca6b7a3cd6541f16e611 ]

Add a PCI quirk to enable microphone detection on the headphone jack of
TongFang X6AR55xU devices.

Signed-off-by: Tim Guttzeit <t.guttzeit@tuxedocomputers.com>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Link: https://patch.msgid.link/20260119151626.35481-1-wse@tuxedocomputers.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4ab3feb5e5929..32543db09d8b2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10905,6 +10905,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x12, 0x90a60140},
 		{0x19, 0x04a11030},
 		{0x21, 0x04211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0274, 0x1d05, "TongFang", ALC274_FIXUP_HP_HEADSET_MIC,
+		{0x17, 0x90170110},
+		{0x19, 0x03a11030},
+		{0x21, 0x03211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0282, 0x1025, "Acer", ALC282_FIXUP_ACER_DISABLE_LINEOUT,
 		ALC282_STANDARD_PINS,
 		{0x12, 0x90a609c0},
-- 
2.51.0




