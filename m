Return-Path: <stable+bounces-222371-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEfQATOvo2kmJwUAu9opvQ
	(envelope-from <stable+bounces-222371-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:14:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4518C1CE594
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDCD43586C96
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7503090CD;
	Sun,  1 Mar 2026 02:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taU4CDUA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49292D97AA;
	Sun,  1 Mar 2026 02:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330712; cv=none; b=pfSER+8DPXTNWCKcFfMhJ0HHuZ3IdlfA8L64OMWSIh5e7/jQ1vKDahWa0netps0MNDBAoJAjhOkau1mmqeG8X4/1jAK12m0bGIT3hgdUC5wEBGQwRdrmAqN29gXqxrOwwPW5TdKh4ySToqhrVntt3o89JmjXqxPHdVBniwtyvHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330712; c=relaxed/simple;
	bh=6iJJdg59GHZ+DGw3lKpzkykOeGOj7wh87hpRJwQeJdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bYXAK0SGlmEOgfSakFBWqobTQG4lGx+5xHWzdIQXhVxn1YOQzuNC8EEf1k7SFa5mmm7KBTj5nUngDjUnerr6gIEMf8S7hsb19x4OPkJG057G04xMph5IN34SIxMJkoiewT5m2T6yepgo/vagKf663PmVQZi2aNRBYHg4jAjodSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taU4CDUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500BFC19421;
	Sun,  1 Mar 2026 02:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330711;
	bh=6iJJdg59GHZ+DGw3lKpzkykOeGOj7wh87hpRJwQeJdg=;
	h=From:To:Cc:Subject:Date:From;
	b=taU4CDUAhY2edlpKttBAzEWF5S5TiAvS3ps1gVg0syGfO6dGLrv9sWRxdeYaXEPJu
	 FJj1qqMg13aICmqAkjY+HCb8YWQjaNdd0hHhSqhbqNycYnxZlqEmLYvO3H3p/MA9xZ
	 +DBkfPeBeK1Oe3nAds2eVs0XYdvQxElHnspiTosmoc5gGRqnbHAVZqHiX5QPkzAWWP
	 VRhN/0XgAX8mHJ+o5yFy9CtmJb+Dq0Zygaj9qmkmU9jqqzwfVQug6yHthEXtXCxJOp
	 +BBAzly1rfPpK8cuNH40lCylQJW5Zw2Qf8WfOkFyLvf9qSxek3bt+3J5peWPDBtBVg
	 ByccE95jJTTtA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	dnaim@cachyos.org
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org
Subject: FAILED: Patch "ALSA: hda/realtek: Add quirk for Gigabyte G5 KF5 (2023)" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:05:09 -0500
Message-ID: <20260301020510.1733817-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222371-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,cachyos.org:email]
X-Rspamd-Queue-Id: 4518C1CE594
X-Rspamd-Action: no action

The patch below does not apply to the 5.10-stable tree.
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





