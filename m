Return-Path: <stable+bounces-221521-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIO2BJCWo2l7HQUAu9opvQ
	(envelope-from <stable+bounces-221521-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:29:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D40AD1CACEA
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94517302CEBC
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B255C72631;
	Sun,  1 Mar 2026 01:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIK+EqQ6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FDE25228C;
	Sun,  1 Mar 2026 01:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328473; cv=none; b=uYWsr8eVA+l1YOzOkC4oYHcq9dp4M6Pxsd56SQQylNCm43ygI5A/LAtdtFaQz4mvgn2uk9NT8qUsvyCvECkU7xzeQ1t0IyCPBXuhANIcGwv0Zr5HZfY1PfC5QSWVwgM2nABvEOcOGxzLYmsvICU6yRSQuvoEQdSPxIj91cFjrnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328473; c=relaxed/simple;
	bh=hIXQLformX9FVpvSBQhOJUqVPR6SQMFpYDH4fC3YoBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lG1+UgrnCQZCiyg9dtnWa9VEq9sRr4lY1Ka0c2BI5yHaqPPB1pqKw7R9rvBwC/sTCkohj8WZ/2iAbz5dg9F7+ur/zYfNkEGvouQFrrvp/I3n9fRNlBjzVwp7bEs4OIIyfVYxcqmtYLv8H3qyhjsD2lBzC97XG87xCHGJcPVqRo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIK+EqQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FAEC19421;
	Sun,  1 Mar 2026 01:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328473;
	bh=hIXQLformX9FVpvSBQhOJUqVPR6SQMFpYDH4fC3YoBM=;
	h=From:To:Cc:Subject:Date:From;
	b=NIK+EqQ6Hlc1gIRB50DKeT8a/1DithUYehnZCoCzCR6i5X7VKaQqHZdemeVvJ92wS
	 KvfE37jv7pQJbZ4lMOJFeumDoUgLfcbhE3ziTkIo1pL1bw2zp8C8L3La8dEOIwTtI8
	 GYXSO29We8bBBKEiThnYlr7zfLlFctRIkkV1AxWuGy2auy64fJ4IWYwbQnus1z/J4C
	 dBelPCJM9GeNMfWpECcKCV/8V8GM2rdxtzublF9o9agK661nRdH9toCG6temzqIcxn
	 Ev+rFp9IWVCVi6ZzktWlFHiDhv0qSVevbawwT8u5BTowgePicIfCT3a4xYDLi7uwX6
	 bwjyxr4uHaNag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	dnaim@cachyos.org
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org
Subject: FAILED: Patch "ALSA: hda/realtek: Add quirk for Gigabyte G5 KF5 (2023)" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:27:51 -0500
Message-ID: <20260301012751.1685468-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221521-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:email,msgid.link:url]
X-Rspamd-Queue-Id: D40AD1CACEA
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
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





