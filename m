Return-Path: <stable+bounces-230621-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEIHNB5YxmmMIwUAu9opvQ
	(envelope-from <stable+bounces-230621-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 11:12:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45588342454
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 11:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E040E30523F6
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 10:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8539A3ACA79;
	Fri, 27 Mar 2026 10:12:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3233A9DAB;
	Fri, 27 Mar 2026 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774606351; cv=none; b=LfUNWPUz1UqvTv3wfW80gPmhsDDOZIjQNqiNRGMAZ8WBPF0KRgIic6w3/ywuZ22uwSvtF/T6NJHOxKbbzv8ymiHIclGAbSpqOaoY08ku4kyZxvcLA5bOzcxX8Ikqp+4bDHRdqij9Q+PJhnzF4Auetf0Nzc/EwE5+pWjeCWWeaQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774606351; c=relaxed/simple;
	bh=P5gv6ffXPh56TDq1hjs484CYMUT16f40aTrz2lgibS4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GK/EJ6KGcvzSDG8y4gHcVazsCZ0OmjPCG7Cu9kvOfxPf4p1MWTIWIgYk/RpJJW8RfDSaHo31jHyx9SPWAvwKNRSIzYSDR+eUbLMIW2jgTfiO+yKlOL8Jlqnl3KffhEWfsJSIMXBy7pn+STuQU5zdua/IyXdd4zscdQYHuleWtc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 70ade03829c511f1a21c59e7364eecb8-20260327
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
X-CID-O-INFO: VERSION:1.3.11,REQID:09e43b4c-2810-4be2-b380-5af3eb90bbdf,IP:10,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:0
X-CID-INFO: VERSION:1.3.11,REQID:09e43b4c-2810-4be2-b380-5af3eb90bbdf,IP:10,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:d7b685bf7469621e8a2beb7e6ad9b0a7,BulkI
	D:260327181221Z376PBZ7,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|898
	,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 70ade03829c511f1a21c59e7364eecb8-20260327
X-User: zhangheng@kylinos.cn
Received: from thinksys.. [(112.64.161.44)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 148420416; Fri, 27 Mar 2026 18:12:20 +0800
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
Subject: [PATCH] ALSA: hda/realtek: change quirk for HP OmniBook 7 Laptop 16-bh0xxx
Date: Fri, 27 Mar 2026 18:12:15 +0800
Message-Id: <20260327101215.481108-1-zhangheng@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-230621-lists,stable=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kylinos.cn,gmx.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[zhangheng@kylinos.cn,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gmx.com:email]
X-Rspamd-Queue-Id: 45588342454
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

HP OmniBook 7 Laptop 16-bh0xxx has the same PCI subsystem ID 0x103c8e60,
and the ALC245 on it needs this quirk to control the mute LED.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221214
Cc: <stable@vger.kernel.org>
Tested-by: Artem S. Tashkinov <aros@gmx.com>
Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
---
 sound/hda/codecs/realtek/alc269.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 327f4dc1b09f..ffd4295aab53 100644
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
 
@@ -7155,7 +7162,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8e37, "HP 16 Piston OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8e3a, "HP Agusta", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8e3b, "HP Agusta", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x103c, 0x8e60, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8e60, "HP OmniBook 7 Laptop 16-bh0xxx", ALC245_FIXUP_CS35L41_I2C_2_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e61, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8e62, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8e8a, "HP NexusX", ALC245_FIXUP_HP_TAS2781_I2C_MUTE_LED),
-- 
2.34.1


