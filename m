Return-Path: <stable+bounces-241955-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBPLAdaB8mmHsAEAu9opvQ
	(envelope-from <stable+bounces-241955-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 00:10:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0944349ACC9
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 00:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44B2D300186E
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 22:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0E14266BE;
	Wed, 29 Apr 2026 22:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/9PPq/X"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F0A3B3881
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 22:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777500589; cv=none; b=nEOve8ukF0ruDHmBbHNi6XtRa5mkpk3leip6RaYj++NxlR5j63PHxv3zrEV/msTd3vbxu3Rk9IsE+V3uHw/cirqv7xtxrL7FgDJvinQhUtHir3F0iKIxOPteZv7oOh5zgFKsMico7nfKpdvpUvPFlyKaOlJrMmv/NLSfP+8+i9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777500589; c=relaxed/simple;
	bh=hCNOSBLXAjUMQtoBtP5UMR9WCVq4JZvnEwgHJmZlwqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WB7fDLqVeGxVwGttv0gNkb8MaCHfSRQhURBgikXm58pstBRvYngkgPCVpOfWQHa8Z9M9XtUwWMBwcmq4NRN/L4uBtAo/Bo5gK5H+CHY/tiiqW8rUGN/Z5Rjw/k8HT5i9aEDYWmAyDjzlgdqHWw5JyMjMs2tLVvxfGIgrfH6elis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/9PPq/X; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so381254e87.0
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 15:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777500585; x=1778105385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BxIGaH1g/MCNNZJvRxFr0b29r98pjCvj5WhhCw3MOiQ=;
        b=A/9PPq/XoL3dL1fsag/E5PndZEev/4D2IL7mlDZB4J4Jul+l3n+mj9DW3ODJw8RbXj
         WRPQydvE7709l2JgwMnD162blbOJHIBmk/RoZVFa3pt6DX7M2zKPOR9aKYTBrEy6lwJM
         m2jFpxsRtMSAqYmLOgiQVDBHojZ/BuK5+sWXUN8vkPRAbJ1o2T1P+gGt6e34WA7PtWOJ
         IJugemLs2v1IxzsW/+vGhcAd1Tpz+0FB+JfKcGNyTiCwOqpmYyyHfjt6u+rc3FOjDzNs
         F3FMYW8XIRKXDpn8J9quIaNTWqt6Wjx1btInhok8PFeW5LkskYBuoBqOJKJFonH/gN4O
         WPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777500585; x=1778105385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxIGaH1g/MCNNZJvRxFr0b29r98pjCvj5WhhCw3MOiQ=;
        b=GlJakSHigzzzUBUgk0ltCgMdxC498+QbA/8OMPWt/h7WnIwXpEhKAgoLzTRC/ijP1M
         0AUHtaIlJWY7HuQvrclqNY7ifdx43rTPJBavoSSSWDw+G1IeeiebhFOd1utQ1I+3WsZA
         42CKn6NfHkqZrN1ZS1KoIqd4E3v3soHu9zoejy47BpY39oPOef0neOjLFculoPVDMBTl
         nCk+tTz8zV7VbdIUHGNQRYisASd1fH7n3cgnTuqCd1wjOdku+cy7m4uVqfi6q7o+2l03
         v69MYLi6fhDd/Dp8LE6a73l/RDXc0m07S7ET9YjZ+3yqoPELpL6bhlZKjwnAS1ExGBdh
         sMbw==
X-Forwarded-Encrypted: i=1; AFNElJ8Gjx68eRCXoKb/QFi/Hcl/UhaSuL8S51EtVjeQx6HP+aR0EA9gRdLg54dLlyqA1TUH4IAIUDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe/hqiU2Vu/EA0ddwCBPo/v+a9VPQhV1TV7IEOcNeFmqNYldN9
	r7KF0H+Zf3k9NTdyd/NDjM1iizVMHhMnGgJqzmquXLwd77KAFqOdSGcCpy4FC0/Z
X-Gm-Gg: AeBDies3gQ7mZcgG+wLaiVLIjJfwbsdHo7f8jlMXcrF+ffCF1E9ATlZMZQDPeRkTzNB
	gTR5qDTfSSpVOfiHpCWQMvaJf9Uf9aykFLNJaipqJXecJ984FM1LGDJQdG92xNcI/g8yD1I04CQ
	Dd8eZanb+cIpMg4adt+vQIbhLc/T9REKL95h9jN7qygq2dkobepNJJ2iBCYOPHxpWVKhlHBtiVA
	8TdU+Gx10hvz0UBkAHqG6R/0+68oQf+UCcr6K8HyyfmV93eVFIFZSptdM3cLnm3vW/wzRCQ55Bp
	HUWb0UUCnCvEUGUavAyis98fRKaBfsMJ8WBAWVWh754Bq9EfukUqM5pOYBJV2yVLFsB0JhYaCWC
	EofBA09zAiwwPUC6Vy1eg3UA//IaVhHunUKllgLmG/ltZFmN8/DB1IOwFTawYqol8GbPiIZHK9n
	1ttwaSGH2UDLX7IYPv8yNxBahaHHQ/ILyKFGibh2sseQ==
X-Received: by 2002:a05:6512:3b90:b0:5a4:ea:724f with SMTP id 2adb3069b0e04-5a8522d7f95mr17256e87.30.1777500584405;
        Wed, 29 Apr 2026 15:09:44 -0700 (PDT)
Received: from yurko-laptop.lan ([213.174.0.72])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a74a769586sm883314e87.64.2026.04.29.15.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 15:09:44 -0700 (PDT)
From: Yuriy Padlyak <yuriypadlyak@gmail.com>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuriy Padlyak <yuriypadlyak@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Fix speaker silence after S3 resume on Xiaomi Mi Laptop Pro 15
Date: Thu, 30 Apr 2026 01:09:03 +0300
Message-ID: <20260429220903.14918-1-yuriypadlyak@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0944349ACC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241955-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuriypadlyak@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

The Xiaomi Mi Laptop Pro 15 (TM1905, subsystem 1d72:1905) ships with the
Realtek ALC256 codec on Intel Comet Lake PCH-LP. After S3 resume the
codec sets coefficient register 0x10 to 0x0220 instead of 0x0020 — bit 9
is erroneously set, which silences the internal speaker. Bluetooth and
HDMI audio are unaffected because they use different paths.

This is the same mechanism fixed for Clevo NJ51CU by commit edca7cc4b0ac
("ALSA: hda/realtek: Fix quirk for Clevo NJ51CU"), but the existing
ALC256_FIXUP_MIC_NO_PRESENCE_AND_RESUME also reconfigures pin 0x19 as a
front mic, which is wrong for this Xiaomi where pin 0x19 default is
0x411111f0 (disabled). Add a minimal fixup that only clears the stuck
coef bit, and add the Xiaomi SSID to the quirk table.

Verified by reading coef 0x10 with hda-verb after resume (returns
0x0220), writing 0x0020, and confirming the internal speaker resumes
output. With this fixup applied the bit is cleared on every codec init,
including post-resume.

Signed-off-by: Yuriy Padlyak <yuriypadlyak@gmail.com>
Cc: <stable@vger.kernel.org>
Tested-by: Yuriy Padlyak <yuriypadlyak@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index d720565db..2ec0b9158 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -3390,6 +3390,19 @@ static void alc256_fixup_mic_no_presence_and_resume(struct hda_codec *codec,
 	}
 }
 
+static void alc256_fixup_xiaomi_pro15_resume(struct hda_codec *codec,
+					     const struct hda_fixup *fix,
+					     int action)
+{
+	/*
+	 * On the Xiaomi Mi Laptop Pro 15 (TM1905, SSID 1d72:1905) the ALC256
+	 * codec sets coefficient 0x10 bit 9 to 1 after S3 resume, silencing
+	 * the internal speaker. Bluetooth and HDMI audio are unaffected.
+	 * Clear the bit so the speaker keeps working across suspend cycles.
+	 */
+	alc_update_coef_idx(codec, 0x10, 1<<9, 0);
+}
+
 static void alc256_decrease_headphone_amp_val(struct hda_codec *codec,
 					      const struct hda_fixup *fix, int action)
 {
@@ -4041,6 +4054,7 @@ enum {
 	ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
 	ALC233_FIXUP_NO_AUDIO_JACK,
 	ALC256_FIXUP_MIC_NO_PRESENCE_AND_RESUME,
+	ALC256_FIXUP_XIAOMI_PRO15_RESUME,
 	ALC285_FIXUP_LEGION_Y9000X_SPEAKERS,
 	ALC285_FIXUP_LEGION_Y9000X_AUTOMUTE,
 	ALC287_FIXUP_LEGION_16ACHG6,
@@ -6229,6 +6243,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
 	},
+	[ALC256_FIXUP_XIAOMI_PRO15_RESUME] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc256_fixup_xiaomi_pro15_resume,
+	},
 	[ALC287_FIXUP_LEGION_16ACHG6] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc287_fixup_legion_16achg6_speakers,
@@ -7762,6 +7780,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1602, "RedmiBook", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1701, "XiaomiNotebook Pro", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1d72, 0x1905, "Xiaomi Mi Laptop Pro 15", ALC256_FIXUP_XIAOMI_PRO15_RESUME),
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1e39, 0xca14, "MEDION NM14LNL", ALC233_FIXUP_MEDION_MTL_SPK),
-- 
2.53.0


