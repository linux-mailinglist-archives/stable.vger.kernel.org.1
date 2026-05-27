Return-Path: <stable+bounces-254572-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALt2N2nfFmo9uQcAu9opvQ
	(envelope-from <stable+bounces-254572-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:11:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 831EE5E3E71
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 105493008C36
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 12:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6F73CF047;
	Wed, 27 May 2026 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="G09rgce+"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19653CFF50;
	Wed, 27 May 2026 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883839; cv=none; b=R8ziY/7zk/WgExY84H0aCUP11d6Vr4Jkj6u78DOAPwVVj4iyGZeSewrowJsE2YygDt8t8e1gABanaZM/p/ZmjXXoeNtQ8add4pMC8EjENEeALYIyZCyruQjmY3g7IuKxpsofSkIA+WBovD7KcgQMgdexUgjs7OMn49Y97pyvtzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883839; c=relaxed/simple;
	bh=y8JM+pufb5jnYFreDbrky1DQdR2gaF4Z/oOHRZgIifM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=jSdewI/YsfPBnJrTt/HlBI8KM5/DnuXJjl2F7+49t2z/xm0Xgu9GCF49N58XQrN5KgVvZizTN2c117GKT/Zizh9Yd/A5cP+ZuGBTQAzKUwAx8PjGCsgJJMiXP1d4Upl4P9NEa+AqgKFmcwCZfoYGOIIRAK8/B6te7aR9RV46UY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=G09rgce+; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779883832;
	bh=j1HJcfF1ZxYogMGF+2RVAp2LuWQpwxqJzxl34ZOTwfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G09rgce+e95a4ZrKRYQ5xqoyEWrz8jgE1Wlh+uFSKDxL3KjaGQAKdnXa/EkXi57P2
	 2UkBmC1xRk/VtW4I2beVlg42HdGkq0/RgruJaUyiaHB9PU+dBI8ahk+Vt0aL2MGXyz
	 xZLj4n6GRTsbl2BwqcssD2WkUmMgYzKJQ38pn8gc=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 2518B808; Wed, 27 May 2026 20:09:17 +0800
X-QQ-mid: xmsmtpt1779883762tdhwzrvxe
Message-ID: <tencent_42E5E2AB1B6A5101F7EE8C2117F1F687BB07@qq.com>
X-QQ-XMAILINFO: M+5cKLn0wXDtUPw/Ak0TzKIOq/KdVz9Aj3cfCILzSY5i33zuMphqvZBKmgBG8A
	 ZDS578NZ2CzVYfpBSmClBLsr1j8L6yWzFmELHlLK5YumgKm9E/mgXK+8OJdF7guSDLi9aJt4VT+z
	 z74X+vHNgHsk5vctc5SkgX6OZTYAmzwzqkgiC4GOTBZlP1rOcGYZ9laNLCyuO3nylSJurPWWkMez
	 ijkHIGxhQxePNB4TDGnYQzNNbDBl4y8m51jkVF1sWHQWXPxq4grqx02a+q64bn7voJ/c4fQ3yxzy
	 /HI78W4EUUJkZqhprNyhBjK38RweU5QjJgkX9oWt6AMYojzCdfeTy15QZkFYmHLfoGSqycN8nrAK
	 2dAA4wFi2tEp5YGcRgH11C9jhs4OereOnf2bOCKGZ4ziN8FVlwBfrLqsVL802aKXy/QDNvqnRpGg
	 PQnx4vWR4RnwMZJ5pGt1hDFZCQs6CPUIAcWnkZvXDcKd61p0PI0FFmXYqDSt9NYezine1G1/0ESr
	 4g/EHa59eSgsK7qMfn9O6HFhV/9dVqhSfYAbjErKBh910ihcv+gllzn72Pza+HclAO5+lY4qV8yt
	 kRqrBHF465gIX/ALTT6zGPhw4yzEUNxT6Tb32kJH/riJ60ISxlW1grBYbRp+aCjGAJtCaifJ+VRU
	 qwcot1axfdCTlL/WkY/CvYe1Xal1KIYJJVAPLRJB1TpHGnFcm9RiHGjo79R1Tp/PpZW3AuWp/JT0
	 R0mLXYcUPWkr/lH38G8Z33aKuU7GAkzULmlGxIF1F/Mge6DiWUFThrHuhbfie649/rr2Cpnwozaf
	 OAlJEKKPnSvzcJXv1s1wmMrOEMeOftR68XauT2XLV4976w6WfZFt2EIFxwurntZXsANtInorxl/n
	 gJt7qexmj1OGp9nUC/MKwHbstq+veKYjGl9QOW50m6a+SID5XO4vXgUjR9pyTx5wPvSshdEMs21x
	 SaEiML72PNYtuNKXAZuxTvkdhKs42/9CXXoGHQxNDki6VB8EiALlNMDgq2SK7dHUAmc9d3M6kfub
	 swKMpudNjySUT0lZi/tfejOaOizuhzo/gLxfVPcuFjUzF9nex3ggytAoD9RqMH+H/nIjzs1r9igZ
	 ATy7pUuL7wd511ipnilYNItxph1A==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Zhao Dongdong <winter91@foxmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	Zhao Dongdong <zhaodongdong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/6] ALSA: ice1712: check snd_ctl_new1() return value
Date: Wed, 27 May 2026 20:09:11 +0800
X-OQ-MSGID: <20260527120914.515037-4-winter91@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260527120914.515037-1-winter91@foxmail.com>
References: <20260527120914.515037-1-winter91@foxmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[foxmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-254572-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[winter91@foxmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[foxmail.com:dkim,qq.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Queue-Id: 831EE5E3E71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zhao Dongdong <zhaodongdong@kylinos.cn>

snd_ctl_new1() can return NULL when memory allocation fails. The
ice1712 driver calls snd_ctl_new1() without checking the return value
before dereferencing the pointer in multiple places (ice1712.c,
ice1724.c, aureon.c), which can lead to NULL pointer dereferences.

Add NULL checks after snd_ctl_new1() calls and return -ENOMEM if any
fails.

Assisted-by: Opencode:DeepSeek-V4-Flash
Cc: stable@vger.kernel.org
Fixes: b9a4efd61b6b ("ALSA: ice1712,ice1724: fix the kcontrol->id initialization")
Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
---
 sound/pci/ice1712/aureon.c  | 2 ++
 sound/pci/ice1712/ice1712.c | 8 ++++++++
 sound/pci/ice1712/ice1724.c | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/sound/pci/ice1712/aureon.c b/sound/pci/ice1712/aureon.c
index 1191a2686dfd..d6abff2978f3 100644
--- a/sound/pci/ice1712/aureon.c
+++ b/sound/pci/ice1712/aureon.c
@@ -1891,6 +1891,8 @@ static int aureon_add_controls(struct snd_ice1712 *ice)
 			for (i = 0; i < ARRAY_SIZE(cs8415_controls); i++) {
 				struct snd_kcontrol *kctl;
 				kctl = snd_ctl_new1(&cs8415_controls[i], ice);
+				if (!kctl)
+					return -ENOMEM;
 				if (i > 1)
 					kctl->id.device = ice->pcm->device;
 				err = snd_ctl_add(ice->card, kctl);
diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index 1e39b985bef2..4cec56769c0f 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -2346,21 +2346,29 @@ int snd_ice1712_spdif_build_controls(struct snd_ice1712 *ice)
 	if (snd_BUG_ON(!ice->pcm_pro))
 		return -EIO;
 	kctl = snd_ctl_new1(&snd_ice1712_spdif_default, ice);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = ice->pcm_pro->device;
 	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
 	kctl = snd_ctl_new1(&snd_ice1712_spdif_maskc, ice);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = ice->pcm_pro->device;
 	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
 	kctl = snd_ctl_new1(&snd_ice1712_spdif_maskp, ice);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = ice->pcm_pro->device;
 	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
 	kctl = snd_ctl_new1(&snd_ice1712_spdif_stream, ice);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = ice->pcm_pro->device;
 	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index 65bf48647d08..b16c84983b81 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -2379,16 +2379,22 @@ static int snd_vt1724_spdif_build_controls(struct snd_ice1712 *ice)
 		return err;
 
 	kctl = snd_ctl_new1(&snd_vt1724_spdif_default, ice);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = ice->pcm->device;
 	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
 	kctl = snd_ctl_new1(&snd_vt1724_spdif_maskc, ice);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = ice->pcm->device;
 	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
 	kctl = snd_ctl_new1(&snd_vt1724_spdif_maskp, ice);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = ice->pcm->device;
 	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
-- 
2.25.1


