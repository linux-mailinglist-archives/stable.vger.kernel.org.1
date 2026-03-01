Return-Path: <stable+bounces-221524-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UI6kNmOXo2neHgUAu9opvQ
	(envelope-from <stable+bounces-221524-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:33:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AA11CAF3F
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B86BA3026BE2
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80D22874ED;
	Sun,  1 Mar 2026 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikre+hWc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A504287265;
	Sun,  1 Mar 2026 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328480; cv=none; b=ex5BABsJZC7AqslxQrbAv0zRJPsXND8BcHjoyyWrzeBhBLXjeCV4bY+8kfgB6MTS4n/EE5xWXyvdqPpfhmTa7zTRk9mhxgcmWLPB5yaGLFnIJzrT/9QYjzbU0iLdaU69372WExrvrhTfvMmOw01ewmQEyLakTjHzF5ejFalE5nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328480; c=relaxed/simple;
	bh=ys/o4yzy0c9Wme9/BZsLqJFYT6JpQHh2MXo3m/IMZLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GzI7ENg6agJr7RqEN50pvHGMVJ89nKFV0IYq5G+2j357y3RADUWrHawgLQhJHx2afsaOwUBYUdN/WNks2N90at678QZgy/4j06jyJhyJ7JUCt1LIyGIXBZt5bsZ2x876u32icOptTtU1IZ0XAMavzPSch+BAAvK3wiVSojaj1dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikre+hWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FFAC19421;
	Sun,  1 Mar 2026 01:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328480;
	bh=ys/o4yzy0c9Wme9/BZsLqJFYT6JpQHh2MXo3m/IMZLY=;
	h=From:To:Cc:Subject:Date:From;
	b=ikre+hWcNX7RdHS1/+BC50C87X6h77zjcH9XU1U1DkxzJ38RHOlA0o7wD2KEstkFg
	 iV9u9tkm4AS0s0CsqM1XcxrWxgYabRjTOVNloNcdZpnNk9qyxU22XCDcTbReC/dp3P
	 Ia9K83HHVdp2HZUSKGPyPPwdye/nWKilwcRDO+7s4SY2hbqGCCKmEfjq6/meXVdr6F
	 U2IM/sQLbAMDFF2jBexhj6a26owRfer7vFMQ8BKvDsgIncJjyVXY/yibGJK/j+Bip3
	 7Kym4g/2eU27AQuntvNofmueRpZ7BSoS94WLHJBvrubc2FAKms1zSKFz/WRW0gyG/i
	 5W9LCgv1yy3HQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mason8110@gmail.com
Cc: Lewis Mason <lewis@ocuru.co.uk>,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org
Subject: FAILED: Patch "ALSA: hda/realtek: Add quirk for Samsung Galaxy Book3 Pro 360 (NP965QFG)" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:27:58 -0500
Message-ID: <20260301012758.1685614-1-sashal@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-221524-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D8AA11CAF3F
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
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





