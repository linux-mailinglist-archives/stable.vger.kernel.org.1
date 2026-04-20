Return-Path: <stable+bounces-239058-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNV7NXM85mlutgEAu9opvQ
	(envelope-from <stable+bounces-239058-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:47:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B65B42D71A
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22E5830BC7A3
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923A03CCFBD;
	Mon, 20 Apr 2026 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUZJxvul"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530D83A1D1C;
	Mon, 20 Apr 2026 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691748; cv=none; b=Ggs/5tuvPYP41bWUYYXwUGbJdJPHzlAccNx0tAPnn7e+omFs15H/nfo+Veov/cfOwGSF0qpSoKQAZ6vY+qggmQn+oaO3moYN5m195MfepTx1BSpqVNHjIzt8zo2yOXMTQj0dn13pV/dD8qGd2+imZFDWzZ83ZMPW8s263PwKNpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691748; c=relaxed/simple;
	bh=VmfMivM0rY51f8lXjrIrejEQtSAu8i+UdkT8nIH6So8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WB/bBFi0gQzvmlDnyPrO1D6AuFn/StyS5Gst6/w33IM/IWuYtKzgfKKI/R+XX9i+enjt5ouquDuOZUp42c/WPLrnmJ1L3wXQlrE2qg2schwjCS9qVCtEi0JQhpW2w3ToYRXPRal8rou6v9PbXno+1f1QkiDFnO9E7bVLAghFnd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUZJxvul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0385FC19425;
	Mon, 20 Apr 2026 13:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691748;
	bh=VmfMivM0rY51f8lXjrIrejEQtSAu8i+UdkT8nIH6So8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZUZJxvul3K0okHrM7+gWVcWBqNi86irSHHDRJO7ziD8x9WDY6SYJQQcaxt0cxnxnz
	 7KrU9RhhjXI3Rc5KR0p4gRLKdVHtpJz57PQfjahiA8fhsHaXv0nMa7vECP6qA5CfZt
	 Ei6xRKF9Jyxm+9xSx0uHUjGsTnvphY8ifUbVYb70TPKF94uPzPh4Fwe5aFP3F3ROlG
	 YEMQ7gaZ6eRmDwKJWteSfNVLOJ59zUomOePr9vn3vQXdmTokor5DtPNRHPR9FSuC5F
	 w9kOo9ybJsKF0igAo63LteC5H5mz64HCWq3rv1gO0vKKEzj7z7Pn6VMnQZ+woTVRmO
	 9LBjCQd89mk1w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: songxiebing <songxiebing@kylinos.cn>,
	Garcicasti <andresgarciacastilla@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] ALSA: hda/realtek: Add quirk for Lenovo Yoga Slim 7 14AKP10
Date: Mon, 20 Apr 2026 09:19:24 -0400
Message-ID: <20260420132314.1023554-170-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.23
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kylinos.cn,gmail.com,suse.de,kernel.org,perex.cz,suse.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239058-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,msgid.link:url]
X-Rspamd-Queue-Id: 5B65B42D71A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: songxiebing <songxiebing@kylinos.cn>

[ Upstream commit e6c888202297eca21860b669edb74fc600e679d9 ]

The Pin Complex 0x17 (bass/woofer speakers) is incorrectly reported as
unconnected in the BIOS (pin default 0x411111f0 = N/A). This causes the
kernel to configure speaker_outs=0, meaning only the tweeters (pin 0x14)
are used. The result is very low, tinny audio with no bass.

The existing quirk ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN (already present
in patch_realtek.c for SSID 0x17aa3801) fixes the issue completely.

Reported-by: Garcicasti <andresgarciacastilla@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221298
Signed-off-by: songxiebing <songxiebing@kylinos.cn>
Link: https://patch.msgid.link/20260331033650.285601-1-songxiebing@kylinos.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index c76d339009a9b..1c8ee8263ab3a 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7464,6 +7464,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x390d, "Lenovo Yoga Pro 7 14ASP10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3913, "Lenovo 145", ALC236_FIXUP_LENOVO_INV_DMIC),
+	SND_PCI_QUIRK(0x17aa, 0x391a, "Lenovo Yoga Slim 7 14AKP10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x391f, "Yoga S990-16 pro Quad YC Quad", ALC287_FIXUP_TXNW2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3920, "Yoga S990-16 pro Quad VECO Quad", ALC287_FIXUP_TXNW2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3929, "Thinkbook 13x Gen 5", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
-- 
2.53.0


