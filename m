Return-Path: <stable+bounces-222580-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJW1G7t+pWl1CgYAu9opvQ
	(envelope-from <stable+bounces-222580-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 13:12:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AD41D81B3
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 13:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D12B2303FA83
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 12:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D78366052;
	Mon,  2 Mar 2026 12:11:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F533644D1;
	Mon,  2 Mar 2026 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772453498; cv=none; b=RiLYH95Bf8aM6jIpUAR2zb9+eEhqratKXpshj4cL0T0xUJgKk7VIBoUDGOUai8o/J33uMHe7kgLzwIILG7cng0nBS38veL5N855AUbQ36F3uIKHA+7Ksiq79PvPEAkxxaZ+A3J3y9yNJozxEEH5VaGAZl0J/nKOID2bMT5wDvWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772453498; c=relaxed/simple;
	bh=6xW/g5kxMIN5+I0c2VQIT0gANuaYJxuLQmzyp/e/VGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AzylgS86NYvQLxEfIanesaV8Rft9JttJIvPRTjfq/5UFxDWBJTfzAoVxZEU1mNHd5HpwrtMux+TS7H+nUF0h/GSUSTzP2P1sELfBnTzK2ndOpGNfM7lV73hag1Fvq1bWchbIE8+ugqqoatqdqieXlxyM4dTPxg4AJqV9JxhBClQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f13a12b0163011f1a21c59e7364eecb8-20260302
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:0c9dfff1-b0e1-41c5-896e-77c5a2b8c10a,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:89c9d04,CLOUDID:7b5872595dd2aa63dbf5912c392f383c,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|898,TC:nil,Content:0|15|50,EDM:5,IP:
	nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f13a12b0163011f1a21c59e7364eecb8-20260302
X-User: zhangheng@kylinos.cn
Received: from kylin-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1152913194; Mon, 02 Mar 2026 20:11:28 +0800
From: Zhang Heng <zhangheng@kylinos.cn>
To: david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com
Cc: linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	paul@mirliton.io,
	Zhang Heng <zhangheng@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda: cs35l41: Fix errors caused by software reset
Date: Mon,  2 Mar 2026 20:11:06 +0800
Message-ID: <20260302121106.66805-1-zhangheng@kylinos.cn>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222580-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[zhangheng@kylinos.cn,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.913];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: 93AD41D81B3
X-Rspamd-Action: no action

Performing software reset again after hardware reset is redundant
and may result in errors. Software reset should be performed when
hardware reset is not possible.

[  +0.013038] cs35l41-hda spi1-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=10476
[  +0.010741] cs35l41-hda spi1-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 19
[  +0.012471] cs35l41-hda spi1-CSC3551:00-cs35l41-hda.1: Failed waiting for OTP_BOOT_DONE
[  +0.000002] cs35l41-hda spi1-CSC3551:00-cs35l41-hda.1: PM: dpm_run_callback(): cs35l41_system_resume [snd_hda_scodec_cs35l41] returns -110
[  +0.000011] cs35l41-hda spi1-CSC3551:00-cs35l41-hda.1: PM: failed to restore: error -110

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221161
Fixes: 2ee06ff5d7cf ("ALSA: hda: cs35l41: Force a software reset after hardware reset")
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
---
 sound/hda/codecs/side-codecs/cs35l41_hda.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.c b/sound/hda/codecs/side-codecs/cs35l41_hda.c
index b64890006bb7..c546a42754bb 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda.c
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda.c
@@ -1023,15 +1023,13 @@ static int cs35l41_system_resume(struct device *dev)
 		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
 		usleep_range(2000, 2100);
 		gpiod_set_value_cansleep(cs35l41->reset_gpio, 1);
+		usleep_range(2000, 2100);
+	} else {
+		regmap_write(cs35l41->regmap, CS35L41_SFT_RESET, CS35L41_SOFTWARE_RESET);
+		usleep_range(2000, 2100);
 	}
-
-	usleep_range(2000, 2100);
-
 	regcache_cache_only(cs35l41->regmap, false);
 
-	regmap_write(cs35l41->regmap, CS35L41_SFT_RESET, CS35L41_SOFTWARE_RESET);
-	usleep_range(2000, 2100);
-
 	ret = cs35l41_wait_boot_done(cs35l41);
 	if (ret)
 		return ret;
@@ -1973,12 +1971,12 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
 		usleep_range(2000, 2100);
 		gpiod_set_value_cansleep(cs35l41->reset_gpio, 1);
+		usleep_range(2000, 2100);
+	} else {
+		regmap_write(cs35l41->regmap, CS35L41_SFT_RESET, CS35L41_SOFTWARE_RESET);
+		usleep_range(2000, 2100);
 	}
 
-	usleep_range(2000, 2100);
-	regmap_write(cs35l41->regmap, CS35L41_SFT_RESET, CS35L41_SOFTWARE_RESET);
-	usleep_range(2000, 2100);
-
 	ret = cs35l41_wait_boot_done(cs35l41);
 	if (ret)
 		goto err;
-- 
2.47.1


