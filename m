Return-Path: <stable+bounces-254318-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGMxC/eCFWoSWQcAu9opvQ
	(envelope-from <stable+bounces-254318-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:24:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B025D4D61
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 810A6302A693
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 11:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B953E0220;
	Tue, 26 May 2026 11:19:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A500352018;
	Tue, 26 May 2026 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794398; cv=none; b=ZcNM1qFDdC73p6FrEYgU/TA2clpx5xlGfYhC1J8j4gnNRiEX1AxlRGFwW5fT8PUsiOtXbz2CIytfcUkufCFdvpR4AWdeov6LT38Mh2MUJD7i9eeglYwY7Qo/1YkjeqItuFy0tbtiVoSHrmOWpKzPKqd/K+D6knOn8Jw24Jn7h2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794398; c=relaxed/simple;
	bh=WQ4SdafjrpdwH5ugIfFTqVp5aZ5MRpu9oaEXrPEbYjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CvyQOvPmG886tnC+dorbWwq2aBpxUb8+zrDrmXr8/G/4PTljxHgSP6+TVXcmzqZY01y3zr/PVYCVw/0yhVwKRVnD/FRSc+cW5KDtPjRJHbsAqEeSwTtZHaCJiO9eO+9dM8NCBDGMwCBIPk90hVJ8Zujh3h/WpDoCjj0w+n+d31g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.59])
	by gateway (Coremail) with SMTP id _____8CxRXjYgRVqQGENAA--.13838S3;
	Tue, 26 May 2026 19:19:52 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.59])
	by front1 (Coremail) with SMTP id qMiowJBx58DTgRVqGomRAA--.57362S2;
	Tue, 26 May 2026 19:19:51 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org,
	Baoqi Zhang <zhangbaoqi@loongson.cn>,
	Haowei Zheng <zhenghaowei@loongson.cn>
Subject: [PATCH] ALSA: hda/hdmi: Use 'AC_PINSENSE_ELDV' to detect pinsense for Loongson
Date: Tue, 26 May 2026 19:19:40 +0800
Message-ID: <20260526111940.2347847-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx58DTgRVqGomRAA--.57362S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr17Cw48tr43GryxAF1rZrc_yoW5Aw1xpF
	n5urWxKrW3tr4Iyrs5ArykuF1SkayrC3W7K34xt34UZrs5KrWrXw1qqrWUXF4akr9IgFyx
	Zry2gr95tay3JabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxU2MKZDUUUU
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.969];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	DMARC_NA(0.00)[loongson.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@loongson.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-254318-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: A1B025D4D61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Due to a hardware defect, for Loongson PCI HDMI devices with a reversion
ID of 2, the pin sense status must be determined via the ELD.

Add a codec flag, eld_jack_detect, to indicate this case, and do special
handlings in read_pin_sense().

Cc: stable@vger.kernel.org
Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 include/sound/hda_codec.h    | 1 +
 sound/hda/codecs/hdmi/hdmi.c | 8 +++++++-
 sound/hda/common/jack.c      | 4 ++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
index 24581080e26a..1a1fe7a904c3 100644
--- a/include/sound/hda_codec.h
+++ b/include/sound/hda_codec.h
@@ -259,6 +259,7 @@ struct hda_codec {
 	unsigned int forced_resume:1; /* forced resume for jack */
 	unsigned int no_stream_clean_at_suspend:1; /* do not clean streams at suspend */
 	unsigned int ctl_dev_id:1; /* old control element id build behaviour */
+	unsigned int eld_jack_detect:1;	/* Machine jack-detection by ELD */
 
 	unsigned long power_on_acct;
 	unsigned long power_off_acct;
diff --git a/sound/hda/codecs/hdmi/hdmi.c b/sound/hda/codecs/hdmi/hdmi.c
index f20d1715da62..423cd9f683c6 100644
--- a/sound/hda/codecs/hdmi/hdmi.c
+++ b/sound/hda/codecs/hdmi/hdmi.c
@@ -2285,6 +2285,7 @@ EXPORT_SYMBOL_NS_GPL(snd_hda_hdmi_acomp_init, "SND_HDA_CODEC_HDMI");
 enum {
 	MODEL_GENERIC,
 	MODEL_GF,
+	MODEL_LOONGSON,
 };
 
 static int generichdmi_probe(struct hda_codec *codec,
@@ -2302,6 +2303,11 @@ static int generichdmi_probe(struct hda_codec *codec,
 	if (id->driver_data == MODEL_GF)
 		codec->no_sticky_stream = 1;
 
+	if (id->driver_data == MODEL_LOONGSON) {
+		if (codec->bus && codec->bus->pci->revision == 0x2)
+			codec->eld_jack_detect = 1; /* Jack-detection by ELD */
+	}
+
 	return 0;
 }
 
@@ -2319,7 +2325,7 @@ static const struct hda_codec_ops generichdmi_codec_ops = {
 /*
  */
 static const struct hda_device_id snd_hda_id_generichdmi[] = {
-	HDA_CODEC_ID_MODEL(0x00147a47, "Loongson HDMI",		MODEL_GENERIC),
+	HDA_CODEC_ID_MODEL(0x00147a47, "Loongson HDMI",		MODEL_LOONGSON),
 	HDA_CODEC_ID_MODEL(0x10951390, "SiI1390 HDMI",		MODEL_GENERIC),
 	HDA_CODEC_ID_MODEL(0x10951392, "SiI1392 HDMI",		MODEL_GENERIC),
 	HDA_CODEC_ID_MODEL(0x11069f84, "VX11 HDMI/DP",		MODEL_GENERIC),
diff --git a/sound/hda/common/jack.c b/sound/hda/common/jack.c
index 98ba1c4d5ba4..1f0ebf9cd151 100644
--- a/sound/hda/common/jack.c
+++ b/sound/hda/common/jack.c
@@ -58,6 +58,10 @@ static u32 read_pin_sense(struct hda_codec *codec, hda_nid_t nid, int dev_id)
 				  AC_VERB_GET_PIN_SENSE, dev_id);
 	if (codec->inv_jack_detect)
 		val ^= AC_PINSENSE_PRESENCE;
+	if (codec->eld_jack_detect) {
+		val &= ~AC_PINSENSE_PRESENCE;
+		val |= !!(val & AC_PINSENSE_ELDV) << 31;
+	}
 	return val;
 }
 
-- 
2.52.0


