Return-Path: <stable+bounces-225496-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPu3EBprt2kuRAEAu9opvQ
	(envelope-from <stable+bounces-225496-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 03:29:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 975EB29411F
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 03:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B612300F9FF
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 02:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4090E30C63B;
	Mon, 16 Mar 2026 02:28:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D866F30C37B;
	Mon, 16 Mar 2026 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773628139; cv=none; b=dHtsMYDfFOUdN2BjG0NsCuzxXXEWGkTQU3h3jEwIkH+2gkvWfKUHIfxgGalYA5eVXrZzfDDO7xE6lGDqqbxWq0ZRodV8n6Z6VxAjhB9+4w7DMZG9vq91O7kGT3OTxGRi21C8F7ZArdppkjRZmdFSuvoEbqjzFG4jgqy7eSfjvNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773628139; c=relaxed/simple;
	bh=mmp62MrrCOCESyBRQSDFmVdab3QIStL6vtm9gBwvsjk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Esut8wE571tDVfka6jwDITz5Vaw3QNJPPZdArU8u4SX0pqHXXxkKlhHin401RMhjYjP73vAVqNsPXTzulYYiabXmQv4uzH9iHHzStBa8QPexAf6UMUM4XLQa5H9JYYyVsp0eWxTW/4Xd+TzV6eYppfrjPGhOdq77i3UMPg9ndgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: dcdb379a20df11f1a21c59e7364eecb8-20260316
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, UD_TRUSTED
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI
	GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:450d16d7-08a6-478a-bbb7-5671805982f4,IP:10,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:0
X-CID-INFO: VERSION:1.3.11,REQID:450d16d7-08a6-478a-bbb7-5671805982f4,IP:10,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:9c86387c8d5efe42be7b6a8a75ec43dc,BulkI
	D:260316102850WCD2VXOF,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|898
	,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: dcdb379a20df11f1a21c59e7364eecb8-20260316
X-User: zhangheng@kylinos.cn
Received: from thinksys.. [(112.64.161.44)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1250051832; Mon, 16 Mar 2026 10:28:48 +0800
From: Zhang Heng <zhangheng@kylinos.cn>
To: tiwai@suse.com,
	perex@perex.cz,
	chris.chiu@canonical.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com
Cc: danYc_LG@outlook.com,
	baojun.xu@ti.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Heng <zhangheng@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: add quirk for ASUS Strix G16 G615JMR
Date: Mon, 16 Mar 2026 10:28:43 +0800
Message-Id: <20260316022843.2809968-1-zhangheng@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-225496-lists,stable=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[outlook.com,ti.com,vger.kernel.org,kylinos.cn];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[zhangheng@kylinos.cn,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.920];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,kylinos.cn:mid]
X-Rspamd-Queue-Id: 975EB29411F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The machine is equipped with ALC294 and requires the
ALC287_FIXUP_TXNW2781_I2C_ASUS quirk for the amplifier to work properly.
Since the machine's PCI SSID is also 1043:1204, HDA_CODEC_QUIRK is
used to retain the previous quirk.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221173
Cc: <stable@vger.kernel.org>
Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index ab4b22fcb72e..0e8b005cf5fa 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7177,6 +7177,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x115d, "Asus 1015E", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1043, 0x1194, "ASUS UM3406KA", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x11c0, "ASUS X556UR", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
+	HDA_CODEC_QUIRK(0x1043, 0x1204, "ASUS Strix G16 G615JMR", ALC287_FIXUP_TXNW2781_I2C_ASUS),
 	SND_PCI_QUIRK(0x1043, 0x1204, "ASUS Strix G615JHR_JMR_JPR", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x1214, "ASUS Strix G615LH_LM_LP", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x125e, "ASUS Q524UQK", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
-- 
2.34.1


