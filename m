Return-Path: <stable+bounces-227878-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sI+aER2uwGkRKAQAu9opvQ
	(envelope-from <stable+bounces-227878-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 04:06:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C752EC0DF
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 04:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B8063016526
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 03:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5240C22F75E;
	Mon, 23 Mar 2026 03:05:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8438948CFC;
	Mon, 23 Mar 2026 03:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774235117; cv=none; b=PfcX3uev+YPfUn67CU2qGIgSsuFjaZ1DqQs+6sBHvfng8RbapS22ZrUYkK5B6Dm54qgXrGJ/NQFrUoTUxCHhiyUzvKTcm5bPh5BqG4XmYwJ1JtzLm8gLO9y/GzbjO/zvRFQyjaN0Es2ZfQniVhlV7BV75StEn0BeIAHDMqufVag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774235117; c=relaxed/simple;
	bh=9IduxKpJVjar/aAfE1tWZpPfjMk9vwtWFubXWBp+Tdo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cQ2c7vJK50yaGi1Q06jJcakg5I5gs1C0KzxUKw0sANLy4byvlvfWnrKQnCS9Cw0JpeOzXooInXyO5yqLIeFe6rrN/vH2fgEctHpPQAz/Q263Hbw2E5iXD1nIet+f7i4UOdeQIlnJgvx+inz57BVALw8gUNuF3g/g0LxnQlB/kj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1978c6d8266511f1a21c59e7364eecb8-20260323
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, UD_TRUSTED, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_C_CI, GTI_FG_IT, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:1eaa2d04-9098-428d-b059-811c06730abe,IP:20,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:10
X-CID-INFO: VERSION:1.3.11,REQID:1eaa2d04-9098-428d-b059-811c06730abe,IP:20,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:10
X-CID-META: VersionHash:89c9d04,CLOUDID:06e51f860f338c33fb58ccd350a057f5,BulkI
	D:260323110509WUGC5OXJ,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|898
	,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1978c6d8266511f1a21c59e7364eecb8-20260323
X-User: zhangheng@kylinos.cn
Received: from thinksys.. [(112.64.161.44)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1890194445; Mon, 23 Mar 2026 11:05:08 +0800
From: Zhang Heng <zhangheng@kylinos.cn>
To: tiwai@suse.com,
	perex@perex.cz,
	chris.chiu@canonical.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Heng <zhangheng@kylinos.cn>,
	stable@vger.kernel.org,
	"Artem S . Tashkinov" <aros@gmx.com>
Subject: [PATCH] ALSA: hda/realtek: add new quirk for HP OmniBook 7 Laptop 16-bh0xxx
Date: Mon, 23 Mar 2026 11:05:03 +0800
Message-Id: <20260323030503.3988941-1-zhangheng@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-227878-lists,stable=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kylinos.cn,gmx.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[zhangheng@kylinos.cn,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,kylinos.cn:mid]
X-Rspamd-Queue-Id: A8C752EC0DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The alc245 on this machine requires this quirk to control the mute LED.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221214
Cc: <stable@vger.kernel.org>
Tested-by: Artem S. Tashkinov <aros@gmx.com>
Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
---
 sound/hda/codecs/realtek/alc269.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 327f4dc1b09f..482489caf565 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -4102,6 +4102,7 @@ enum {
 	ALC233_FIXUP_LENOVO_GPIO2_MIC_HOTKEY,
 	ALC245_FIXUP_BASS_HP_DAC,
 	ALC245_FIXUP_ACER_MICMUTE_LED,
+	ALC245_FIXUP_CS35L41_I2C_2_MUTE_LED,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -6631,6 +6632,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.v.func = alc285_fixup_hp_coef_micmute_led,
 		.chained = true,
 		.chain_id = ALC2XX_FIXUP_HEADSET_MIC,
+	},
+	[ALC245_FIXUP_CS35L41_I2C_2_MUTE_LED] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc245_fixup_hp_mute_led_coefbit,
+		.chained = true,
+		.chain_id = ALC287_FIXUP_CS35L41_I2C_2,
 	}
 };
 
@@ -7155,6 +7162,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8e37, "HP 16 Piston OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8e3a, "HP Agusta", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8e3b, "HP Agusta", ALC287_FIXUP_CS35L41_I2C_2),
+	HDA_CODEC_QUIRK(0x103c, 0x8e60, "HP OmniBook 7 Laptop 16-bh0xxx", ALC245_FIXUP_CS35L41_I2C_2_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e60, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8e61, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8e62, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.34.1


