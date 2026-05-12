Return-Path: <stable+bounces-246668-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CIWBg6PA2qM7QEAu9opvQ
	(envelope-from <stable+bounces-246668-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:35:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AE15294F7
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7655F30588B2
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A058D36C9D0;
	Tue, 12 May 2026 20:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="fYu96lYB"
X-Original-To: stable@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FE93EDE68
	for <stable@vger.kernel.org>; Tue, 12 May 2026 20:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618123; cv=none; b=fQr0djnpNihCullj97Z7rsQauelPugcS9PiYeJ/r82XYpYwQq60SzTVG2sit6ioDRn5a4DNH6en7C/G7tgx1KAugK3I9F+msruhF/oFC8dWJjFgUbiPFw+13UcDNs2f4oiAfMArCUXKva+YVvomhyRITVaFbCFj8Zxruv2iaPQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618123; c=relaxed/simple;
	bh=AznCOY2fnBNDiwjj1e/AiZWmbVZi1Y8doiQv0EQNSGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OYDl4k19jPzsJb/WR4qGPSPKDJ/S/JApu2gCUJjZ6gUmadMpU5LKTsH5n240r5XGoIjS9fAlvNgrSPYHfpeg6vGxjFQhfLXp93Dunn0t60iI0qjOqk5ZjqopJOJLupk6zUsqWx0FhwDxEJ937cx8OBxYrmZnSRLFzk4KAlD5hVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=fYu96lYB; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wsembach-tuxedo.fritz.box (business-24-134-105-141.pool2.vodafone-ip.de [24.134.105.141])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id A45D82FC0215;
	Tue, 12 May 2026 22:35:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1778618112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aZqZSRzuGbFy/nqiVBWd4n73jH2UWwbeLAJWanR6nVA=;
	b=fYu96lYB0uas+Dzx91FmaVRw300XwTYng3Ys8F5mhW7imcWZ2vnYbvl2norPlUt+jropEU
	yxUOxtMl4DItcS+zXvrzmOL+6mV2peHHpBUDrZlpwtNnR5IlCnCEtzi1L6yaRo/IWHXPx/
	l5Nsjvp98X73Y9jWR7hxfvOweIDXZiE=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: stable@vger.kernel.org
Cc: aer@tuxedocomputers.com,
	wse@tuxedocomputers.com
Subject: [PATCH] ALSA: hda/hdmi: Add quirk for TUXEDO IBS14G6
Date: Tue, 12 May 2026 22:35:05 +0200
Message-ID: <20260512203508.160494-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 75AE15294F7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[tuxedocomputers.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[tuxedocomputers.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246668-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wse@tuxedocomputers.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[tuxedocomputers.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

From: Aaron Erhardt <aer@tuxedocomputers.com>

[ Upstream commit d649c58bcad8fb9b749e3837136a201632fa109d ]

Depending on the timing during boot, the BIOS might report wrong pin
capabilities, which can lead to HDMI audio being disabled. Therefore,
force HDMI audio connection on TUXEDO InfinityBook S 14 Gen6.

Backport for 6.6, 6.1, 5.15, and 5.10. Identical to the backport for 6.12,
that already got included, but without this paragraph in the commit
message.

Signed-off-by: Aaron Erhardt <aer@tuxedocomputers.com>
Link: https://patch.msgid.link/20260218213234.429686-1-wse@tuxedocomputers.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 sound/pci/hda/patch_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 80c015af09efd..763c92a848d4b 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1999,6 +1999,7 @@ static const struct snd_pci_quirk force_connect_list[] = {
 	SND_PCI_QUIRK(0x1043, 0x86ae, "ASUS", 1),  /* Z170 PRO */
 	SND_PCI_QUIRK(0x1043, 0x86c7, "ASUS", 1),  /* Z170M PLUS */
 	SND_PCI_QUIRK(0x1462, 0xec94, "MS-7C94", 1),
+	SND_PCI_QUIRK(0x1558, 0x14a1, "TUXEDO InfinityBook S 14 Gen6", 1),
 	SND_PCI_QUIRK(0x8086, 0x2060, "Intel NUC5CPYB", 1),
 	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", 1),
 	{}
-- 
2.43.0


