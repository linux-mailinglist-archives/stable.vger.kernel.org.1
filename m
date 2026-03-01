Return-Path: <stable+bounces-221773-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNPRII+co2l2IQUAu9opvQ
	(envelope-from <stable+bounces-221773-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:55:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAC51CC418
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24C5C305D6FD
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B2C2BE033;
	Sun,  1 Mar 2026 01:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHyIdLkr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D31EDA0F;
	Sun,  1 Mar 2026 01:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329101; cv=none; b=U/UKaUC9s8Pb8Or+5ZelBqetiAwVfaXqlebeds48ljxcfToO0+p73tixGVaZPuFFQK5gUkBZg09P+ysDkNN7afByTln23StOoYdGTM9RDV+rcY+JFq3QXjcBg9DDkZ6ei7QTawX5NB5GqwP8sNsPmFDVhEOA0OS6e5COwnvMLyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329101; c=relaxed/simple;
	bh=GXlfke1AgJTqYxEM4Bm92H4I+8xlXhr7EnHjM0biUbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ObgrMEgYjBurQdH/Me94/2PfrJuu9K5ekd0YtcYiIwZdjdsq82bDefwPhgYTQqudQDAi1KJFIGG5si7vBrRZ4jgS7uBmo6NDhF8qo6dM+vbTrVgUu3y10H0aAh/h3j2EsT3ubBJlNl4VSNlwn0H6YE5/DYxtEEbvYEX4hNZ+bmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHyIdLkr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF71DC19421;
	Sun,  1 Mar 2026 01:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329101;
	bh=GXlfke1AgJTqYxEM4Bm92H4I+8xlXhr7EnHjM0biUbw=;
	h=From:To:Cc:Subject:Date:From;
	b=WHyIdLkrSx1Za1mcnJ9Knu6N4VIZQl9dPcmL07wyxyVdiWl4sC87DPtlW+ijzTH4X
	 sQh8qDCCgD/XTX0EBvBKhA/yLV+KTOSmO+BdM4ngt4yLxajoizUqMcxVPk6TgmY5Zp
	 NDk+R74n/10thZuUl0GopxVg5X+Vsz5S4dHQnRYOGRvClNnrVhxdRYWuyxVarEre84
	 pEpxiGloJ3Prp0JWbSnLV0lS8TtjovtnzLnGxS9o/x5OANdDzbd5c0LYBvJ+YBDKdo
	 qUMPmGvfYdCTOVelOxlrsb98xP9CiKTRyl38tvR8jwssb/Q492UBYRxbgFEAvJaMHj
	 DF+c4fFrLncqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mason8110@gmail.com
Cc: Lewis Mason <lewis@ocuru.co.uk>,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org
Subject: FAILED: Patch "ALSA: hda/realtek: Add quirk for Samsung Galaxy Book3 Pro 360 (NP965QFG)" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:38:19 -0500
Message-ID: <20260301013819.1698724-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221773-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ocuru.co.uk:email]
X-Rspamd-Queue-Id: CEAC51CC418
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 3a6b7dc431aab90744e973254604855e654294ae Mon Sep 17 00:00:00 2001
From: Lewis Mason <mason8110@gmail.com>
Date: Tue, 10 Feb 2026 23:13:37 +0000
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Samsung Galaxy Book3 Pro 360
 (NP965QFG)

The Samsung Galaxy Book3 Pro 360 NP965QFG (subsystem ID 0x144d:0xc1cb)
uses the same Realtek ALC298 codec and amplifier configuration as the
NP960QFG (0x144d:0xc1ca). Apply the same ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS
fixup to enable the internal speakers.

Cc: stable@vger.kernel.org
Signed-off-by: Lewis Mason <lewis@ocuru.co.uk>
Link: https://patch.msgid.link/20260210231337.7265-1-lewis@ocuru.co.uk
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 8664446648096..c11312aa5ca76 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7318,6 +7318,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xc872, "Samsung Galaxy Book2 Pro (NP950XEE)", ALC298_FIXUP_SAMSUNG_AMP_V2_2_AMPS),
 	SND_PCI_QUIRK(0x144d, 0xc886, "Samsung Galaxy Book3 Pro (NP964XFG)", ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
 	SND_PCI_QUIRK(0x144d, 0xc1ca, "Samsung Galaxy Book3 Pro 360 (NP960QFG)", ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
+	SND_PCI_QUIRK(0x144d, 0xc1cb, "Samsung Galaxy Book3 Pro 360 (NP965QFG)", ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
 	SND_PCI_QUIRK(0x144d, 0xc1cc, "Samsung Galaxy Book3 Ultra (NT960XFH)", ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
 	SND_PCI_QUIRK(0x1458, 0x900e, "Gigabyte G5 KF5 (2023)", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_HEADSET_MIC),
-- 
2.51.0





