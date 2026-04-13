Return-Path: <stable+bounces-236161-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFu9JkoU3WkOZQkAu9opvQ
	(envelope-from <stable+bounces-236161-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:05:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BB83EE4C0
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFB65301455D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EAC3AE6E6;
	Mon, 13 Apr 2026 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="D0LKuiDJ"
X-Original-To: stable@vger.kernel.org
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11618137750;
	Mon, 13 Apr 2026 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776095904; cv=none; b=qyRzF9rWpECEceZQYRdfekw1gJjYFY+huCv2vjfYVpFI8gCBQU5aJclnrwNObiEcKNIazZAWzFThKuHqOyaNLs95NfBx+Qyd0+XoF47aMQK5L2RKYX11oQdmN1ao1aowkclYFn949nhsce5Cb4eLILnvx7iRtMgJbWh8OUUxHFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776095904; c=relaxed/simple;
	bh=CAcnStAUkH7ssAYOB9XOeGnOJ+//22UgwQAFbMIWDnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kCAWa9IdFGJdU/LoYkn7xsYSgzijPXoWJcSkILOlKFThMBHDjxpldZTw3bWqPHGe0e3WnxCsXarSJ6DOzW6D1lVtNrZ50GV8cFKUsz6EiyXSJ98P6BO/vexRvrjYdzcf89h1A/c00i/njnuLcULcX9E72VjLFxPfw/JOvOO+6GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=D0LKuiDJ; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6F8AE285FA9;
	Mon, 13 Apr 2026 17:48:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1776095342; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=AXbIFam313eUjm4s10Dqibfnk/5nAR5in+w11u4PpkE=;
	b=D0LKuiDJelcaOzj684pRUC9U+bTsBs/pVyLOCYipR73QjDFg9Zwwg2nBNSAL+MU6cmlWOJ
	ZNRdmECnPxZbfX9LIeVVSL/XfVCQC4BubH6BMvlvhD4RTjvfmYf2kafUDtALF/vj0SqQW5
	0KWxD3GX0SpRD/45ImJNVHWZGOfUaljIJnKtrzp+nkA7of79576Ju1JM0UXmL2KMDxq98F
	WgKD8HHC7J/sDYUs4AB18tACFFbUWZd0DLjH5BsDuZRQRVTssXQGibbvzV8j/Q7Cqb9Ls2
	YBFYjhh78Hjq3lLw1Om7SGGstQJ30oF84G1KYHEqvHh0nu2Gxd6ayNzDCCEv3A==
From: Eric Naim <dnaim@cachyos.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Eric Naim <dnaim@cachyos.org>,
	stable@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Legion S7 15IMH
Date: Mon, 13 Apr 2026 23:48:17 +0800
Message-ID: <20260413154818.351597-1-dnaim@cachyos.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cachyos.org,quarantine];
	R_DKIM_ALLOW(-0.20)[cachyos.org:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236161-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dnaim@cachyos.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cachyos.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cachyos.org:dkim,cachyos.org:email,cachyos.org:mid]
X-Rspamd-Queue-Id: 00BB83EE4C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix speaker output on the Lenovo Legion S7 15IMH05.

Cc: stable@vger.kernel.org
Signed-off-by: Eric Naim <dnaim@cachyos.org>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 45f9d6487388..ae74e1b69eb3 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7605,6 +7605,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3801, "Lenovo Yoga9 14IAP7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	HDA_CODEC_QUIRK(0x17aa, 0x3802, "DuetITL 2021", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo Yoga Pro 9 14IRP8", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x3811, "Legion S7 15IMH05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3813, "Legion 7i 15IMHG05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3818, "Lenovo C940 / Yoga Duet 7", ALC298_FIXUP_LENOVO_C940_DUET7),
 	SND_PCI_QUIRK(0x17aa, 0x3819, "Lenovo 13s Gen2 ITL", ALC287_FIXUP_13S_GEN2_SPEAKERS),
-- 
2.53.0


