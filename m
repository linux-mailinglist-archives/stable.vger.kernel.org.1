Return-Path: <stable+bounces-222209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CK/DEW2fo2k3IQUAu9opvQ
	(envelope-from <stable+bounces-222209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:07:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 620721CD061
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5650305B8C3
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF962FB969;
	Sun,  1 Mar 2026 01:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pb8V+aVk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20D12F999F;
	Sun,  1 Mar 2026 01:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330311; cv=none; b=ZQRFKcaNgJM2vq1I+W7Ul7Pxex2X9PZsAr7dQ+QXiktPBryVyFwAdkq0w6VZK2b2ifn92K6xo9WuNmzotONnrjZXGAtkNrzqERan9SKfHKKsa3e8mlU/uq5v3lV7Dj/exu7qaEg0YO1pndEcYl+d5d50s1qZKVvvnizTKQmN7GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330311; c=relaxed/simple;
	bh=sqFy7dxL1p8kAhrRAuh4n2fwGH2thHF5BkYE099Ytk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ab0/6wZI/g5BJ60O6DvgErk5dTV6SiA3bdSEo2x9rDaZ9wEuMoaaG/17kdpeGFHRCP1ZZn+0K4TSQ/D08HmrazLAtU0s/Fg4GYYsldzTu8XeLIxd6sZRgPG3KVPhA9D5kAAu+Gvuk7O9tp2IZpTzmHFwE872+5DOvAUH+Ggs/HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pb8V+aVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1734CC19424;
	Sun,  1 Mar 2026 01:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330311;
	bh=sqFy7dxL1p8kAhrRAuh4n2fwGH2thHF5BkYE099Ytk4=;
	h=From:To:Cc:Subject:Date:From;
	b=Pb8V+aVkgJ59B2jl0KSMQ0/Olyfvyxry4lxwTdhU4njFGluwfh6cL2ETWt0YMPwqs
	 uZJtAZKLVSkkmZva9QZziu5r1yLBQCKVQnKOo6rI4JU1DCtt7NN9A3G7HWHIRTEzSL
	 lpAFljzRkoMOv2OaUydR/hRU5vV6j0nU+cSVnzYWkoA9FdlRnJJ0Jj4wvM/Lq7jGqZ
	 8CqQsDSF0rZGxN+Hhc6SsJcn0JJ3cpnb3GdVVL6qSDUq5yNIZdjiZwCAPdeT2pN7Nd
	 a1LWR9pU3TGpBTkncdsNt0a76ziY7A6/LfdngzVDvUtKTiCrXXXLfcsFoDBszKS8GA
	 l+AWPoIXyGXfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	tiwai@suse.de
Cc: linux-sound@vger.kernel.org
Subject: FAILED: Patch "ALSA: hda/conexant: Fix headphone jack handling on Acer Swift SF314" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:58:29 -0500
Message-ID: <20260301015830.1723965-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222209-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: 620721CD061
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7bc0df86c2384bc1e2012a2c946f82305054da64 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 17 Feb 2026 11:44:11 +0100
Subject: [PATCH] ALSA: hda/conexant: Fix headphone jack handling on Acer Swift
 SF314

Acer Swift SF314 (SSID 1025:136d) needs a bit of tweaks of the pin
configurations for NID 0x16 and 0x19 to make the headphone / headset
jack working.  NID 0x17 can remain as is for the working speaker, and
the built-in mic is supported via SOF.

Cc: <stable@vger.kernel.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221086
Link: https://patch.msgid.link/20260217104414.62911-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/codecs/conexant.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/hda/codecs/conexant.c b/sound/hda/codecs/conexant.c
index 5623d8c0a0f7c..f71123a475464 100644
--- a/sound/hda/codecs/conexant.c
+++ b/sound/hda/codecs/conexant.c
@@ -299,6 +299,7 @@ enum {
 	CXT_PINCFG_SWS_JS201D,
 	CXT_PINCFG_TOP_SPEAKER,
 	CXT_FIXUP_HP_A_U,
+	CXT_FIXUP_ACER_SWIFT_HP,
 };
 
 /* for hda_fixup_thinkpad_acpi() */
@@ -1024,6 +1025,14 @@ static const struct hda_fixup cxt_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cxt_fixup_hp_a_u,
 	},
+	[CXT_FIXUP_ACER_SWIFT_HP] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x16, 0x0321403f }, /* Headphone */
+			{ 0x19, 0x40f001f0 }, /* Mic */
+			{ }
+		},
+	},
 };
 
 static const struct hda_quirk cxt5045_fixups[] = {
@@ -1073,6 +1082,7 @@ static const struct hda_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x1025, 0x0543, "Acer Aspire One 522", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x054c, "Acer Aspire 3830TG", CXT_FIXUP_ASPIRE_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x054f, "Acer Aspire 4830T", CXT_FIXUP_ASPIRE_DMIC),
+	SND_PCI_QUIRK(0x1025, 0x136d, "Acer Swift SF314", CXT_FIXUP_ACER_SWIFT_HP),
 	SND_PCI_QUIRK(0x103c, 0x8079, "HP EliteBook 840 G3", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x807C, "HP EliteBook 820 G3", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x80FD, "HP ProBook 640 G2", CXT_FIXUP_HP_DOCK),
-- 
2.51.0





