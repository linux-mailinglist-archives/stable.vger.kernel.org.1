Return-Path: <stable+bounces-254560-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6P9vJXDbFmq2twcAu9opvQ
	(envelope-from <stable+bounces-254560-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:54:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E68675E3B28
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC5CC3052898
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 11:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C925B4014B8;
	Wed, 27 May 2026 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ut9g5InD"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9480540149B;
	Wed, 27 May 2026 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882533; cv=none; b=NvO3Ad6Ee103p6hXZUSoU1eTntQX7l5GYT5oWu5crighV8WaEgkCySc27n8w5Xz83alwZ6t2028H+1T4DytheMjvkP+h6ZDGwDIGdZrnsxh0ps4IS5Z4Z15mPUjiCZwEslNKh/b5l9yI9piEw5rTqZ9TLu85LVEz0GuPvyf9TNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882533; c=relaxed/simple;
	bh=y8JM+pufb5jnYFreDbrky1DQdR2gaF4Z/oOHRZgIifM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=b6QSYLEPuIaIj0VJUeNA3/hF9+Bmj6yO0pTWYWVGF5rT1B4c3w812zMeQsb76sHkGXVKuT35KyoXJcEfZMsicsWmoJzQrMIh+EXzutUU0xi5cZ7OkMtc6tesjalT2hbf8sUDcocfPOq2Oy6VSJASZzib3cdDEQg/KPagbmrqd7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ut9g5InD; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779882524;
	bh=j1HJcfF1ZxYogMGF+2RVAp2LuWQpwxqJzxl34ZOTwfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ut9g5InDIspGb/TdOSRwPgizg1+LPwfWDhegIj9EX4iKCKsBod7tFB4JdgQUZsvE9
	 PjTO3cUev8f7IP8t4oFFl8v4nQuA3SrCkVgSHa8banhoK00FN5x0UbSDR06xaL1PBl
	 UcIvFVwCQuAP3PdB1lbHDwqdJ3FvvDD4A/TJ4QWk=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id C15A3CA3; Wed, 27 May 2026 19:48:21 +0800
X-QQ-mid: xmsmtpt1779882521t0gnf1cqz
Message-ID: <tencent_4A40C6868B7EFBC49D4C71CD0D9D6898FB06@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5J+iumhW1t+l3OpEJuB0K03YTRCetEmb38Qndx6NCOmwEY99kGE
	 BjggMXUuAp4DENVXm+zrzcmB3pTJzFKpHCTpKi66dKVoJIPnog7p0PMRwGWLWCRYInTbgZA1dDWs
	 1tmhZOSFIZ2ud5+cQAtARw4e/e2evbb4+RSE1dGqtxI8StkdbLj4pZlcrL3fe4qB7l2s3xSJLISG
	 FyRInydM2/4dlb4O7CCk3tSvL3PnA/Jykyr2G3Pqb7ngiFrEshULMM4OLR/Jt0SuhmZLUTmM/8/I
	 0QOKt25eYRF58AA0zn+kTWczqaIVoPynRqz7+FlnfRHjz3TJV3l+dbFxw2Fb1kK40+YIOrqkCnX5
	 V2pnwaMJBtL02PpMyRSur71YrdcxktyEJP+QuSsKFbTuspVFk8KDm2ceXjSqpFoOD6ZSi3MHqQa7
	 kZOeoo0OmswbAJqwZ0geS99PTD/CMW73XpW3Hz16+PtyxqkcC7YEff5o1kcrDpgb8CKv6ku+GkgE
	 qNuNLDRnR6lTbnv2wsx3Q8m3Q9qm56sBq+FcigLDt9YrkEE6zPyrCLza8bTH4oANfQWsoZWIZ03G
	 /XJmTUt8gx8u2hfYW+Jq6A8VHLWAmH0/gQj4GKyaIJEtGyCZZSyfWYj8LDNjy4JojJY6egg8Vbjs
	 dje8ra7iqYC712VFuP8sI1H3w9plN0MVfyoo95cbFiYMMH7DlndjKrowwoL9osYzC7HXknoVBPEB
	 rqh0wYQAVk8PCsQiD9stEv5VvthPQVpl4Eop6OF9/7vU9xelKxgCNpMQ8HdCAtAemLNtlpbx0RUY
	 3WHzjdygXvY5YMaCArhGWM3aBtJwk25YREKUHx0SIlyBk2xNzYiGTqQTrMdiTVaG5sE8u/1QDOon
	 OORq2Y+shnEzkFXIDgl6UeTlSHiwWk/DSK1KszlvxbZQzfWw6hVXNXQJnKsoGkjSLLoci+N39M2B
	 YXUfRN6lsyYknf8UvB0WUA+FHiIAaKdMgowV1TDMGM873Ch/S5T3U78622l1Hqy+l3gw+Q8NQ3ce
	 I8WttEQ095st72fot9yiOHr4oHV3IMXz6e2IKknp8rQkNmsTfMBx9niGtnPrESI5EudeQoOh5Ehm
	 wk9T7xNG65fN9ys0g=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Zhao Dongdong <winter91@foxmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	Zhao Dongdong <zhaodongdong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/6] ALSA: ice1712: check snd_ctl_new1() return value
Date: Wed, 27 May 2026 19:48:16 +0800
X-OQ-MSGID: <20260527114819.498119-4-winter91@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260527114819.498119-1-winter91@foxmail.com>
References: <20260527114819.498119-1-winter91@foxmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[foxmail.com];
	TAGGED_FROM(0.00)[bounces-254560-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[winter91@foxmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E68675E3B28
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


