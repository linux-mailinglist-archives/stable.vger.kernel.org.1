Return-Path: <stable+bounces-221985-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCv5C6qbo2l4IAUAu9opvQ
	(envelope-from <stable+bounces-221985-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:51:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5091CC0DE
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBDEE303E6AA
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214CD2F6586;
	Sun,  1 Mar 2026 01:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZvXn70e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D996E244670;
	Sun,  1 Mar 2026 01:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329622; cv=none; b=t2e0TgNBjBAUDfzB++iJjEXd8KZi2/vAPCLIQQjq6KjDTLKsZnx9xCx5lL1/wF/D9t9UWZ5HUQpW1CWpga1HLKJToPKRRdlyJ+6kc8gnU/UESa9YU8gek37tiRJmoly1GTWdGwRKhbZ8cwTSbiAW1fmG+De5aPEV4ul4LUqlZ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329622; c=relaxed/simple;
	bh=DI7CriJEZh8qBsAv6qqWR30Z4fP3jri8eIrAEjiwl2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UocRvZfw17C5+J7Rdq1uRcuDfP59Eb521BSZC28PIyQROijhQqGZIDOqg/Y9/2vvxmFzJ9rmKjv8Sw3LaNqdaNUD7ObtRh9TRB5RAFeUs6hOydUy+Fen83BLQsHDsMrf+O8rNkh+rOJc8Y5FwHRdPyKQtrpPA+6It/M0FQPVCqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZvXn70e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBD0C19421;
	Sun,  1 Mar 2026 01:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329622;
	bh=DI7CriJEZh8qBsAv6qqWR30Z4fP3jri8eIrAEjiwl2o=;
	h=From:To:Cc:Subject:Date:From;
	b=rZvXn70eSZu3GIFbu2rY1B3/8Pc2H8359vR0tC45QC07vazSSWbd/9IwIjQyKwxDW
	 nN0geo9djVenWsWR4o5RgLzstnXdGl4yOPrfn/DIDbkCYf7YZpBjNWQjMDOT/tSLIs
	 hz9AEh0EO09nQsQazV7llco9wFN+PU6a6m+kPzNZaEvoENdWPZpOQ4SYw+AJpM6hVa
	 jHrAsCYi/fBjy0nGxKoQjFPRXX0EvwFbmz6PmnNtVXfombKrcYAV0W+3JMwuOblxPl
	 p7IlPH8QiPlfyQUWbLl+pWDHlvdAR09q+nlEPRsrXOV+z3BjlvolM/0T3BIbac/nxv
	 PuFeL/2AlWmmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	dnaim@cachyos.org
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org
Subject: FAILED: Patch "ALSA: hda/realtek: Add quirk for Gigabyte G5 KF5 (2023)" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:47:00 -0500
Message-ID: <20260301014701.1710192-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221985-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,cachyos.org:email]
X-Rspamd-Queue-Id: CA5091CC0DE
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
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





