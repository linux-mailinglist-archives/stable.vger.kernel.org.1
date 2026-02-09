Return-Path: <stable+bounces-214933-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QApdOmXkiWnGCwAAu9opvQ
	(envelope-from <stable+bounces-214933-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 14:43:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 658CB10FD8D
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 14:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71879302B81B
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 13:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8425E3793B6;
	Mon,  9 Feb 2026 13:42:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B0336F425;
	Mon,  9 Feb 2026 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770644524; cv=none; b=ZsfFNEZqT10QT4IvBf8lBKykhaq0B4jpCKbxnEsB2E1C6yfCrDq2OpvGYaqY4oUC7dT+hQIWWRTGXfqcRaG4SZj4VCYRVFI9EX28hhM7SP+p2CINo6xhqg8/KC9YUL+3ifbXXkhzeqv2rBfDhnwebCRgn3Ihf/LspHTmvAPnAGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770644524; c=relaxed/simple;
	bh=lVs8Si8Z2R42UoPGdQMp03LDeDGSS5OmAm8Zyz7u6Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+V1La/RvD8LOMv8A9ZGrtJq/gA5slTJBOAy60MyFYWoD2+++kVtMIeAUsvu7Hc+rgm07acfF/3pHaR8RHH5TNwYVtaDOm8CJUCoUeESOLl173As4slbiBPYiJw2XIhMS+GpYDNzJr0Vl8JxumEsj7RH+LOXAecDoBwk0TxCktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 187db76605bd11f1b0f03b4cfa9209d1-20260209
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:36384692-47de-4f38-8a4f-1c2075c295f0,IP:0,UR
	L:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:ff362aafda7649171c38f987d93f5ce4,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|898,TC:nil,Content:0|15|50,EDM:5,IP:
	nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 187db76605bd11f1b0f03b4cfa9209d1-20260209
X-User: zhangheng@kylinos.cn
Received: from kylin-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1216626094; Mon, 09 Feb 2026 21:41:54 +0800
From: Zhang Heng <zhangheng@kylinos.cn>
To: perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	chris.chiu@canonical.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Heng <zhangheng@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: add quirk for Acer Nitro ANV15-51
Date: Mon,  9 Feb 2026 21:41:49 +0800
Message-ID: <20260209134149.3076957-1-zhangheng@kylinos.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangheng@kylinos.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-214933-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: 658CB10FD8D
X-Rspamd-Action: no action

fix mute/micmute LEDs and headset microphone for Acer Nitro ANV15-51.

[ The headset microphone issue is solved by Kailang]

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220279
Cc: <stable@vger.kernel.org>
Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
---
There is a small issue now, the mute LED stays on when I mute the
laptop microphone, unmute the headphone microphone, and set the
headphone mic as default. Is it possible to fix this?

 sound/hda/codecs/realtek/alc269.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index c4228d982271..1c11f7c3b193 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -4047,6 +4047,7 @@ enum {
 	ALC236_FIXUP_HP_MUTE_LED_MICMUTE_GPIO,
 	ALC233_FIXUP_LENOVO_GPIO2_MIC_HOTKEY,
 	ALC245_FIXUP_BASS_HP_DAC,
+	ALC245_FIXUP_ACER_MICMUTE_LED,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -6554,6 +6555,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		/* Borrow the DAC routing selected for those Thinkpads */
 		.v.func = alc285_fixup_thinkpad_x1_gen7,
 	},
+	[ALC245_FIXUP_ACER_MICMUTE_LED] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc285_fixup_hp_coef_micmute_led,
+		.chained = true,
+		.chain_id = ALC2XX_FIXUP_HEADSET_MIC,
+	}
 };
 
 static const struct hda_quirk alc269_fixup_tbl[] = {
@@ -6605,6 +6612,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x159c, "Acer Nitro 5 AN515-58", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1597, "Acer Nitro 5 AN517-55", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x169a, "Acer Swift SFG16", ALC256_FIXUP_ACER_SFG16_MICMUTE_LED),
+	SND_PCI_QUIRK(0x1025, 0x171e, "Acer Nitro ANV15-51", ALC245_FIXUP_ACER_MICMUTE_LED),
 	SND_PCI_QUIRK(0x1025, 0x1826, "Acer Helios ZPC", ALC287_FIXUP_PREDATOR_SPK_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1025, 0x182c, "Acer Helios ZPD", ALC287_FIXUP_PREDATOR_SPK_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1025, 0x1844, "Acer Helios ZPS", ALC287_FIXUP_PREDATOR_SPK_CS35L41_I2C_2),
-- 
2.47.1


