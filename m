Return-Path: <stable+bounces-254594-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOHQG4j4FmrUywcAu9opvQ
	(envelope-from <stable+bounces-254594-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 15:58:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDDA5E571C
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 15:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4EDFE3030DA6
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0D6413D96;
	Wed, 27 May 2026 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hN8mZyyD"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A31402439
	for <stable@vger.kernel.org>; Wed, 27 May 2026 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890303; cv=none; b=uCMpikJtLi28Vzy1jy9nsg0xsI5V8X7PgzzFcOo6efy/h/XRfDuSkpVI0QRid4pFGFdW7VI/SwsWYWRjmzhImaf4ZOGcXhCQDH3jRWVVz51EOM6HhRwcNwpLp/e87SUZ6BkBngqotY+dYy3KQLLNMSQ3HQqLbyzoKLPiyrVhOoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890303; c=relaxed/simple;
	bh=r0AY6balmI5LK5cBrk9Sz6C0q7ffejwvtR4gMM36msY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kjkHNVQOcfClVIIuS8+WNRms/GjIidti0JAukX+ID8hIKjAiCP3SC+F01yYy4xmRfLema65iN5vlzmySugvXEctTS9HAX9iK4AHpdcTlPNGL0OZuTAO7Fhl5nQ0Rg4ubBELbE9GRtSlBBnTGUo7o+nqhXzegpuV9aBfVVrKkLkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hN8mZyyD; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2f7020a928eso17222222eec.1
        for <stable@vger.kernel.org>; Wed, 27 May 2026 06:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779890301; x=1780495101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbmScUewxy69yzIsUCuE8aXgVmgMHcoBqHlMt7xLKm8=;
        b=hN8mZyyD6yLsc+dAqBZZL0WZhm+jwqzsQ86mt4IlMVSr51mZGcuehMaJmj8rY0oQMJ
         OVt0ISJtzxqT9V1JL8trmciMvbsEfhA89P/U35ApOwLmB54hrikYjF7++mIZv5T4nj1B
         BJS8ZVFCaLc53rPBwjYiLwk2tJTUaFeoWLeGe5clLt2bIheICqV81CH4azxnVonEBECc
         faBkQxYKWWrOpZRkYQGYhuogo3E0po281Z0ZPK2p3mkIHdYc9XSwWKoTJgjDm1bxn6f1
         e6rYVmpxb9iF7m9eH16ph21F5T9baeuCSjESwI1h/+/zB2FffGRl4vVGZ72ZKqg/KzHQ
         tkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779890301; x=1780495101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sbmScUewxy69yzIsUCuE8aXgVmgMHcoBqHlMt7xLKm8=;
        b=oR0ZoExKI5V8nxmwLGQdaEQZR0YyaYt4D7l+9X2Kiz5zWitojIVgLgnJ9+n5jUrgsU
         /fnl7iE8xq4vjegOTxFuhlqlIxgOqWw9MkCFchXjH0oKcofOm2iLrlokX/hd3UvJykmG
         Lk91y1YLEF61VpGzzB5lfZa0TZUKCMQzGwLgpOuDkQHYQ6UmnMpFoeDu/l86fhlU4yvh
         jGW3SyjUuaewxe9QVQbq0+g9ElYyYaGW8pNZMFDSXya7ayQAzsptuERJGNWk/X+ZJDqB
         fxW/HKx84yD3kLBasEnDd6h4HChgXXlDUPx8KjfbEmgm4Q8d1m6OmTLtXhgHKuKwg52t
         fpDg==
X-Forwarded-Encrypted: i=1; AFNElJ9x5rYLv4kVRIAkc2DlXExaz7AxqGtxaJaR1+rnBcTU7uqCASwwG2ixSyMnGgSqXj4vgk3Y3Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+11tkoLu4TjT0Edt4zwKqf0ey9BRYJZFAXfvIgee4HdazbbGq
	hkw+0NdqjaHMDYpHt8ni5O7BXm+5IGoBb+dK3y4OZfTlgorbuQ6Qa+nM
X-Gm-Gg: Acq92OEo7aXvIpo58wOLGQWyVFOeH71OK4mC1DOUu8Gb0TZcI8D1UP+ZfkRjlWkTvJ/
	OV0Imr7EaGpLh3yB/ZV1YYwAQFYEybavFJ8O7YFL6VJ95fsXqaIhLJQbaX3w2V/gaIsUt0IYu+4
	tqLjh++DZGWXIhWDEVLs9i3TnerpMLCCaSCbpzVq/du/A0Jr2a4heZP5Ei2tc2XbzWLKZqpIaWS
	1wtKCctdXvf3XCi9UBB1t53oYdwHoskBSokPIsS/RDnnpTHeV9gKK/ms9SBZCipdFiqjwzab1Th
	lYcvIrsJJbCa3CvlwOJ7nvgJPlauliE13mggJVpsnGjRLRQWn2Wq6qrBvq4w7UPwj50J/91jk2L
	0a2o1DgOVg/yJt6YtWY8Q0FZpeRufLsrbldqEAeH7rOv8NLWz+wU697fwpwyUrRHyM1v16It+Jr
	FtkMgz0h7jK3xgC2uHdh+kzndTpnxXa7VW/g0M7FoHrS8Z0bX3FdJo1ARxt7U1P1bxcSqUiUULE
	A==
X-Received: by 2002:a05:7301:37ca:b0:2ed:e14:7f5b with SMTP id 5a478bee46e88-3044922a4d1mr10566374eec.31.1779890300526;
        Wed, 27 May 2026 06:58:20 -0700 (PDT)
Received: from [192.168.1.18] (177-4-162-74.user3p.v-tal.net.br. [177.4.162.74])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366aba2b9asm13013788c88.15.2026.05.27.06.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 06:58:20 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Wed, 27 May 2026 10:55:46 -0300
Subject: [PATCH 1/2] ASoC: mediatek: mt8192: Release reserved memory on
 cleanup
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260527-asoc-mt8192-probe-cleanup-v1-1-1bb834d05b72@gmail.com>
References: <20260527-asoc-mt8192-probe-cleanup-v1-0-1bb834d05b72@gmail.com>
In-Reply-To: <20260527-asoc-mt8192-probe-cleanup-v1-0-1bb834d05b72@gmail.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chen-Yu Tsai <wenst@chromium.org>, Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 notify@kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1634;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=r0AY6balmI5LK5cBrk9Sz6C0q7ffejwvtR4gMM36msY=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDFliP4oslk4/pFEex7tum9+WL9wiE02MQh9tun/h9d0vl
 5K52bNOdJSyMIhxMciKKbKsTlpkuafrwdX6uBUeMHNYmUCGMHBxCsBEKvQZGX72MgtpmK0vun6+
 dHdfYPiNXz9mzhP3TzR6l2byzE41Jo6R4USD2QwLlhkTnNbLPbDZfPBamp/jK2bTFyt3WDx+vts
 rnhsA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254594-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1DDDA5E571C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MT8192 AFE probe calls of_reserved_mem_device_init() and falls
back to preallocated buffers when no reserved memory region is
available. When the reserved memory assignment succeeds, however, the
driver never releases it.

Register a devm cleanup action after a successful reserved-memory
assignment so the assignment is released on probe failure and driver
unbind.

Fixes: ec4a10ca4a68 ("ASoC: mediatek: use reserved memory or enable buffer pre-allocation")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
index 3d32fe46118e..9f5057eeeff9 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
@@ -2155,6 +2155,11 @@ static const dai_register_cb dai_register_cbs[] = {
 	mt8192_dai_memif_register,
 };
 
+static void mt8192_afe_release_reserved_mem(void *data)
+{
+	of_reserved_mem_device_release(data);
+}
+
 static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 {
 	struct mtk_base_afe *afe;
@@ -2184,6 +2189,10 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_info(dev, "no reserved memory found, pre-allocating buffers instead\n");
 		afe->preallocate_buffers = true;
+	} else {
+		ret = devm_add_action_or_reset(dev, mt8192_afe_release_reserved_mem, dev);
+		if (ret)
+			return ret;
 	}
 
 	/* init audio related clock */

-- 
2.54.0


