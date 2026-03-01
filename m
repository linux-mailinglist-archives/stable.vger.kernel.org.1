Return-Path: <stable+bounces-221483-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPQAB26Wo2lPHgUAu9opvQ
	(envelope-from <stable+bounces-221483-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:29:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5871CAC3D
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C10C301F795
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B357628725B;
	Sun,  1 Mar 2026 01:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftIEooZY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EAE284898;
	Sun,  1 Mar 2026 01:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328375; cv=none; b=r4dSzxV7yrsbtZKMj1ZkIPiufbM9Kve1r914QVYpJUyI82/g19iEMeshGaOlMKMocETW9FJ5By/LUCe1gotpbPISICk3XmgtP+9W21Stdx00grZadlJVOLG6EwRdK51ndZhUKOUna7WPzhsqH7KdtTvlBP4F8QsKZYuicRQHuYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328375; c=relaxed/simple;
	bh=0YBoZkuBhWQY4AkmUH0Bgi7uK2R+Kp9cbMA0T2At4Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NH1G9F7lRC1eNyjT/HEZBFl8chHatu6Tp4J9BZhFwBuQ+tsgVC+270tRE+Za2axnPT7gyKTIqBt5OU/2hRrJzuZdPDUMOKv+A4kzfuJYB+uwXnRuqzOQMmkn+6P4PejvPIRfTeR0J2UcuCq3lF+5o2/Zry0tdwuG9oXUPLe6YkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftIEooZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE591C19421;
	Sun,  1 Mar 2026 01:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328375;
	bh=0YBoZkuBhWQY4AkmUH0Bgi7uK2R+Kp9cbMA0T2At4Hk=;
	h=From:To:Cc:Subject:Date:From;
	b=ftIEooZYl5WlPXc3xSPmS7abvB5ZERD2YezpChRNsYQOsOTe6l3WTHBku+LprUOEQ
	 20RyGKu0IAWX+mdcWcC3QtkmyIcXHkX92BWHrmEOpbQRMnHZhzRT6Kd0A3qHkhf9bq
	 5vsSn3oDdbXWvXIjOblIl9X5j4YLjLBeojXHmeSfuFMvfoiIH8uI4DpowfH/OCeDkw
	 vam3UF31yNa5IXjxf8oWTt5i0CcYsai+czpUMBPTihwth/2DvzZ1Sv5ch5XLZ7paYM
	 lOTOxTs0GCmFSlb4unnFMhI48oO1IH9OeWoW5NLq3N5lZQCrE2P8NW1DOkHJzMK2qc
	 jZeFKe35dJKuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	tiwai@suse.de
Cc: linux-sound@vger.kernel.org
Subject: FAILED: Patch "ALSA: hda/conexant: Add quirk for HP ZBook Studio G4" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:26:13 -0500
Message-ID: <20260301012613.1683590-1-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221483-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,suse.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B5871CAC3D
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1585cf83e98db32463e5d54161b06a5f01fe9976 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Sat, 7 Feb 2026 14:13:17 +0100
Subject: [PATCH] ALSA: hda/conexant: Add quirk for HP ZBook Studio G4

It was reported that we need the same quirk for HP ZBook Studio G4
(SSID 103c:826b) as other HP models to make the mute-LED working.

Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/64d78753-b9ff-4c64-8920-64d8d31cd20c@gmail.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221002
Link: https://patch.msgid.link/20260207131324.2428030-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/codecs/conexant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/conexant.c b/sound/hda/codecs/conexant.c
index 2384e64eada36..5623d8c0a0f7c 100644
--- a/sound/hda/codecs/conexant.c
+++ b/sound/hda/codecs/conexant.c
@@ -1081,6 +1081,7 @@ static const struct hda_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),
 	SND_PCI_QUIRK(0x103c, 0x822e, "HP ProBook 440 G4", CXT_FIXUP_MUTE_LED_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x8231, "HP ProBook 450 G4", CXT_FIXUP_MUTE_LED_GPIO),
+	SND_PCI_QUIRK(0x103c, 0x826b, "HP ZBook Studio G4", CXT_FIXUP_MUTE_LED_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x828c, "HP EliteBook 840 G4", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x8299, "HP 800 G3 SFF", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x829a, "HP 800 G3 DM", CXT_FIXUP_HP_MIC_NO_PRESENCE),
-- 
2.51.0





