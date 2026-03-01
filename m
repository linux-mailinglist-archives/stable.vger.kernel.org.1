Return-Path: <stable+bounces-222192-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBfSEPieo2k3IQUAu9opvQ
	(envelope-from <stable+bounces-222192-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:05:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B81151CCED7
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3049B301F14B
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D632F39B4;
	Sun,  1 Mar 2026 01:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jL/05uYo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC70238150;
	Sun,  1 Mar 2026 01:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330127; cv=none; b=LbzEeItgh85IIFPa3cFA9gEv9prDmzI+tDwD6Qt/Js3I4OPzq+oISvUEDyKJypdcgoxGxYeRhP1YRU9clNCrsWhFpiAB3irc8WnLE4lq6QA3uZQOlWiyneCTgBXDlnns1q2sZe8fezuBVyFzi+9BGCVbovOeJwizN4IkyqyQEzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330127; c=relaxed/simple;
	bh=AlYyGMrnrJmWbNDTF7be86YwmlNzUi8uKXv+nNGpP0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R/ZvE6orESGOZFNEIOF40B5hjW36AjB28lUkL+hpEPKe55UYud/XOkAkQjQNAK2Ki0+9TVW6C4bgrvIS5xyGdZpldxaiBeNUmejyzopKcJrRRM9fhSwcEIPuabUebkX+Bb4L8RbfMyDI+IxJVU3lzzJr874jXrZX14ken06QHzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jL/05uYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90085C19424;
	Sun,  1 Mar 2026 01:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330127;
	bh=AlYyGMrnrJmWbNDTF7be86YwmlNzUi8uKXv+nNGpP0E=;
	h=From:To:Cc:Subject:Date:From;
	b=jL/05uYoWFwmcIpjJBJ2563I/9FEiFIFXeQOCSTtSJBgsYCzq/qAuam9iVW1YOiGp
	 ZC7MR9rKC8gqB8R/B5UDJmeGQmYOd+fKGGO2JbPWdPNmWDewDWfSyKEoPFkfN/pEeY
	 zD5J6CG77ZMR9vyc7/4IOaozVSpdirz2fnlBgNrFH140aOqti8EdahLwLye8RsFmHv
	 iI7OQ6aCLvfuZ7ZMA2/BvChh5waJPpqnZ9aV7CI7SECS6SU+AGwazuF7Wsui0C8o9j
	 3roLyW8Y7AC1nMF+PIdSCKR2NUmELn5UW6CZpbb6VNihV4LFB7uYppPyoa8429XWFn
	 M1CiJd1kPDwqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	dnaim@cachyos.org
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org
Subject: FAILED: Patch "ALSA: hda/realtek: Add quirk for Gigabyte G5 KF5 (2023)" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:55:25 -0500
Message-ID: <20260301015525.1722636-1-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222192-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,cachyos.org:email]
X-Rspamd-Queue-Id: B81151CCED7
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 405d59fdd2038a65790eaad8c1013d37a2af6561 Mon Sep 17 00:00:00 2001
From: Eric Naim <dnaim@cachyos.org>
Date: Tue, 10 Feb 2026 17:34:02 +0800
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Gigabyte G5 KF5 (2023)

Fixes microphone detection when a headset is connected to the audio jack
using the ALC256.

Cc: stable@vger.kernel.org
Signed-off-by: Eric Naim <dnaim@cachyos.org>
Link: https://patch.msgid.link/20260210093403.21514-1-dnaim@cachyos.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 80f0be13b69f5..8664446648096 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7319,6 +7319,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xc886, "Samsung Galaxy Book3 Pro (NP964XFG)", ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
 	SND_PCI_QUIRK(0x144d, 0xc1ca, "Samsung Galaxy Book3 Pro 360 (NP960QFG)", ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
 	SND_PCI_QUIRK(0x144d, 0xc1cc, "Samsung Galaxy Book3 Ultra (NT960XFH)", ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
+	SND_PCI_QUIRK(0x1458, 0x900e, "Gigabyte G5 KF5 (2023)", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1462, 0xb120, "MSI Cubi MS-B120", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1462, 0xb171, "Cubi N 8GL (MS-B171)", ALC283_FIXUP_HEADSET_MIC),
-- 
2.51.0





