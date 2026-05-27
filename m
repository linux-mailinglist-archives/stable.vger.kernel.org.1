Return-Path: <stable+bounces-254587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOrwEJf2FmrUywcAu9opvQ
	(envelope-from <stable+bounces-254587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 15:50:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFAE5E555C
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 15:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4045430CD6B1
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E65A421A02;
	Wed, 27 May 2026 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9QpYYZj"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94274219E8
	for <stable@vger.kernel.org>; Wed, 27 May 2026 13:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889334; cv=none; b=Y4+zp7g6jqGzllzdjQVG7wHH/uheA9hoRFmFCtr6OFHowx9rJRDS9QwKgZVJOuTq5HysVdhYz61c27NHA3syNh9Uxq6DO1jo7nft+79FZYAX9CcvbFNJAz9XoeU/ugB4HBWzKgJRgsOS8OXwiaCBUdbysDiQKgmbVf/WqMWKZJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889334; c=relaxed/simple;
	bh=VzV/fPvjI+XqWxKprvzJZVYA2YFkSP4aBOscYa8+RWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UrJP3DpgHvsLTFKpCBkBcaJ9wZ5CLxrcMrJK36zytbeei4TvR1tS2XAVcehhlJwdFu0rj55erH0kiRhqhKfj31FcpXS6g4BnuXxQTrcPf/8v7SG6gMdJYaFBtRsjORagYAWjomtNZcK9Hozhth+irWRqnUpe9NSjEm98XNeSz40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9QpYYZj; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-304545f5206so7458065eec.0
        for <stable@vger.kernel.org>; Wed, 27 May 2026 06:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779889332; x=1780494132; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sxLsjsge6FjE23brvA4cB6kvPU6JOYpV69fL9+pATJc=;
        b=C9QpYYZjvfkcA/JsWh2JWt7RLMRFdl9FTVUzc/ZOE9YwpzgrNglKmH5/HciVQ/9Os/
         feh3sQSEtfzRtRKJAwdIPJ2+41dAYvk/KSdUArrpmnzZCpkA2/TI10FR3InlaJoD5zpD
         oi5i/haSKFu9KYkfqw7osHRfh4tw5PYuAtOAoES6ORNmREv8M2FMdRSvhr53ZbHFpjuF
         nHrMSZL8dUc5TYYe0irSGwcG2LRl+U9zg+/oS2zxVJIL2eSerdW5jrclDrtw0gMVM2k2
         AQMnGxkvqF9Pyw56NDT9XhZ770DiIfmYLTDL23UIRFSu+OJUG50fVjWd96/GKKDvDIiA
         kixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779889332; x=1780494132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sxLsjsge6FjE23brvA4cB6kvPU6JOYpV69fL9+pATJc=;
        b=ojEITZStzZPxk7slBH7wJnc4RKZZkvV4H4wJGUnma07czHp/khOP04x/sEGYuk6jvk
         M3qHvyBvLTfkEAmuXbIPlQYP2HBxspkAqyjGILfbyjRUnUNQnjOBIozcbpaBLZBQBfTH
         rWGbjag+nWEP1Nb/7mxEjq5fRIEoxj7ouFEsfRoYNLB6cZ/8uQEIxnAq9CcxyGwFam6s
         8wiYR2vqFrQxTaf6X8RdmA8GIv1/UXc+gdx+k07jeBKS0ZSIcbbxuoRhhdZs70lp8jHx
         SFV3Ylrus7xK/vfF6PbAeADIqZODibu8aX/dhBsOcvMRCOkjICyVjZum8fGETAO4QUL9
         cXcw==
X-Forwarded-Encrypted: i=1; AFNElJ9iL1nA08RajC4fbem9/31OieLU5cCnxTrWdleXj7u6IgAJYVsoSeUZP0qNu9b3E197sgz4ylA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjEcyVe/zJ9LKPHTcVmlysdQI3BN7l2uTYk5vRHvcN2A3pOYcS
	PAGY3W25F6CEwyLDlmtyObsCOTuzzTYJMz+0Wy6ntu4twpH1oA/GFIq3
X-Gm-Gg: Acq92OHhgDqlobn2vN3p6p4f0oncU4vOeZsw4dIayV2x1TFrraNMjc7Ud4k+zibdCYS
	1P5uHy+S5TEEK1rfDJ+9qBvXH1hc2yT3PnzYOTa+/RfQKdytV4o0T2KRG7F42WHc46PBf1kNElg
	RckM8uim5LSS6AYxTdJVfpiRZg6u9LT966MMIF3MMpFKh5tShurD764iovjKV8mERkqLA1BQN30
	VTrzjNeHoZqJZdgIOqT/0KrohjhT1xacQbL3bfe7YervEFdrGfrprK3Nz/Xv8VzjiM7Y1hPo6fQ
	MRSogpf4Ihzyp17eUhhVQorqHj9DHI0na5B9FepE3So4y9tJpVs7OWdoz8gKB2dSNQJwAuxpAGe
	QEztUmuR6MuM6S2oTjzr2KuNWUiLzKenMB4hOIa/jML1BOgSRxXqoIPmf9ukc5nD7oKHPKHe1OE
	B9FqIiL4RGgAKY4H5sOPZn7uBiOcfkQ/4L3OxQz2py3pjXFKDKrfS8DIhUW6dEJGw3CdQgYdsLa
	y24Zd/x9mwpfHTSDQUoftg=
X-Received: by 2002:a05:693c:2285:b0:304:3c33:7ad6 with SMTP id 5a478bee46e88-30449001dd5mr10880555eec.11.1779889331603;
        Wed, 27 May 2026 06:42:11 -0700 (PDT)
Received: from [192.168.1.18] (177-4-162-74.user3p.v-tal.net.br. [177.4.162.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ccdaa124sm311702eec.11.2026.05.27.06.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 06:42:11 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Wed, 27 May 2026 10:41:48 -0300
Subject: [PATCH 1/2] ASoC: mediatek: mt8183: Release reserved memory on
 cleanup
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260527-asoc-mt8183-probe-cleanup-v1-1-4f4f5593c8d1@gmail.com>
References: <20260527-asoc-mt8183-probe-cleanup-v1-0-4f4f5593c8d1@gmail.com>
In-Reply-To: <20260527-asoc-mt8183-probe-cleanup-v1-0-4f4f5593c8d1@gmail.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chen-Yu Tsai <wenst@chromium.org>, Shunli Wang <shunli.wang@mediatek.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 notify@kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1586;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=VzV/fPvjI+XqWxKprvzJZVYA2YFkSP4aBOscYa8+RWs=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDFliX1YeEzh78zWH703pVZqrvTeuWL526atwxjdhBwS39
 7CtZm1L7ChlYRDjYpAVU2RZnbTIck/Xg6v1cSs8YOawMoEMYeDiFICJfDNm+Kc1XYkx5/BGR6aP
 S5Jv73u+L4OR4d7Hw36J036ccnm7bNNjhv8JapdZPIUlUs+z7D+Tof32xs24+sMPi1v/nz0x85e
 09lsWAA==
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254587-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,suse.com,perex.cz,collabora.com,chromium.org,mediatek.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BBFAE5E555C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MT8183 AFE probe can assign reserved memory with
of_reserved_mem_device_init(), but the assignment is never released on
driver removal or later probe failures.

Register a devm cleanup action so the reserved memory assignment is
released consistently, matching newer Mediatek AFE drivers.

Fixes: ec4a10ca4a68 ("ASoC: mediatek: use reserved memory or enable buffer pre-allocation")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
index a7fef772760a..49a69728fd72 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -766,6 +766,11 @@ static const dai_register_cb dai_register_cbs[] = {
 	mt8183_dai_memif_register,
 };
 
+static void mt8183_afe_release_reserved_mem(void *data)
+{
+	of_reserved_mem_device_release(data);
+}
+
 static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 {
 	struct mtk_base_afe *afe;
@@ -794,6 +799,12 @@ static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_info(dev, "no reserved memory found, pre-allocating buffers instead\n");
 		afe->preallocate_buffers = true;
+	} else {
+		ret = devm_add_action_or_reset(dev,
+					       mt8183_afe_release_reserved_mem,
+					       dev);
+		if (ret)
+			return ret;
 	}
 
 	/* initial audio related clock */

-- 
2.54.0


