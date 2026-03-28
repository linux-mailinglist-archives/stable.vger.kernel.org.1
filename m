Return-Path: <stable+bounces-230774-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLpzLbimx2mraAUAu9opvQ
	(envelope-from <stable+bounces-230774-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 11:00:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9776234DFF7
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 11:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A51A300E190
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 10:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD6B1DF25C;
	Sat, 28 Mar 2026 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="it9SIwmA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A2E23E330
	for <stable@vger.kernel.org>; Sat, 28 Mar 2026 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774692017; cv=none; b=FHfi1YXKtixOJPVIIdaq4med48D0PrklSMWEm/AdNepkKNriBd5FNzsdHQAa6/z2WGR/8lU7hCg7K2NTcWadAyxXkS5ocH2/4vYGx/dvUAnKJ42K6D5b+lbKI9N/irug8cPcLlm+GkJASIDyEpMTb6EUTjH7UH/VqXOT6qXKxx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774692017; c=relaxed/simple;
	bh=DllPNEY5HJhelRRWtMlz2dJNBymbUWyXeyN0iDUfRcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dff5IVvrb13a1pCLzS+c7YoMML707UjmNAjxQ515B7ytUavvOZhmud1tJ8saM4dIYIN6Aja8TrQnD7oM5BA4B+QUaO+WplKK98hfZYOGj7jAO4I8k2XEC1teOojFOyJd0o29mtqtHv93QJ/Cv50oGk3Vj2v0OCDgUc39V8tIAWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=it9SIwmA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486fb439299so26780725e9.0
        for <stable@vger.kernel.org>; Sat, 28 Mar 2026 03:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774692014; x=1775296814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5w1Y1b3TwAv79lqz5JishdxGsbpyNm4BW0hPIUDQcY=;
        b=it9SIwmANu+b8aFxqnpuxVGu4DUGY1APNUgKaqkSa/m+1a4SlF5Z1q/wnb6+pwrVfg
         JqtOCuSRndPt1pGoXl/GNwI4I3XoR9hLCKjEdUg+gnqYREi4NkwXN8xY0sd9OvHKGu/L
         ivxLGfaC1COdvgxZBPT2zoKirf47iEqgv2dABnI0Vw4rT7KzmkW30NXjTZqB/AfQI5EQ
         x7COvAYrTMv1/j3xlDPjhg/ezpdYlDmM4S2NNpJJWHzr4OiBeoeWNYrxEM3hzBXuSwIU
         O9FP7Hb6H4JeylVbeN/IrXsUkb14D3x3KObv33ZMCzcV3Cw5JrrtPKKRxKLGrHyMhpyS
         EVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774692014; x=1775296814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K5w1Y1b3TwAv79lqz5JishdxGsbpyNm4BW0hPIUDQcY=;
        b=SKSNXMNqDF66zT/2h4XjnmZgnUSgToreXtOaKCyO7jVrPNosqZuwUNs6brkj6OiGUm
         13mN4m70IP6sPMK4dB9D0vGY4dGehdzsYip75ZLptHcXaU9dMHNVf+snu3nPlPXrI+0k
         FFvJ/iRaQIkIlTQ/I19t7bvKgwBLgS+Md9zBUlLiv5ZX2dFgjA9qhkv1+XHABywqYr2b
         WWeHrzFnbEokNeJGnYtpfD71rAuMMmqmstcrfS8/umuO8NHK48J8vXq81ZgqPldvPM7C
         rfF6d5g2uRVwKn6iXBGGnahrHacDZD6JeQG1EhqAEosvQ+gJd007W9Tg8zKerh2M66k3
         5u0A==
X-Forwarded-Encrypted: i=1; AJvYcCWuZ7otcioAT39dW1zzBm7/e1hYfG/T4whvAFJfsdBEC6WzZeP94dATiE1M2nK4L3FEqFD41jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7nN+idE1SjG4oFWz4hH6JA5SJnq6FUX1iZvmyQCsqLZOgLPfT
	XhYjXApBKrFFnVUpXFgjCNaWM4LQiOB0ddhMKr4J/ZyoWfiWt1AQ+ztU
X-Gm-Gg: ATEYQzzzdIPVZw2B2BHEOJ6k8jhoqiJLAIGHH91GDcMSytE3gKqP66jR1SfZ1eu5XRm
	x4L7xhOMlCHCRgPySf6T4Xu4cSm/YXC1DUvOuI/V86x3xVGB3licZrwawmBfq/X+T5rSZ8gEHBh
	FtpREiYqFzov1bY2s8X1Hv+sPvA7KiohHZ5k6yLLYeZHryDnWkitYGpJjAUR+U0XSlIo8rOK3rc
	KXipNHLKDzqiU6gRdFjkiZxpK7DlWkbR62kO89cb+w0/js4ZNGrRmHgp9rSItPdi1cCWqS1oSyr
	+M/WaCaXrZZprstpGMwIi68628/gOoJhOsesqLqQwL08a+4eetbncw0FmTAwI8ZSlq6t44SW/m5
	dtDMAS86D2iqEurcoucK/HpVgicNCoj86nOOr67lWU4szDRh58y8kgoSIMjVqQVmQgiU4j3cs2/
	Yvt2aDw6Dg0E+AquCZyRyh8EFDwd0vOOxWRT0xpkP0mg1gsLtYl1f/BniZAmfj5jKW6yRSitH+b
	hhJcOC86lAYh13Pf4lgQFw=
X-Received: by 2002:a05:600c:6814:b0:486:fbe1:2499 with SMTP id 5b1f17b1804b1-48727f7be29mr91414145e9.22.1774692014189;
        Sat, 28 Mar 2026 03:00:14 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d4d884sm198418535e9.15.2026.03.28.03.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 03:00:13 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: laurent.pinchart@ideasonboard.com,
	mchehab@kernel.org
Cc: Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	jacopo@jmondi.org,
	aisheng.dong@nxp.com,
	guoniu.zhou@nxp.com,
	linux-media@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v2] media: nxp: imx8-isi: fix memory leaks in probe error paths and remove
Date: Sat, 28 Mar 2026 10:00:10 +0000
Message-ID: <20260328100010.41236-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327222711.268132-1-devnexen@gmail.com>
References: <20260327222711.268132-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230774-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[nxp.com,pengutronix.de,gmail.com,jmondi.org,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9776234DFF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mxc_isi_probe() allocates isi->pipes with kzalloc_objs() but never
frees it on any probe failure path or in mxc_isi_remove(), leaking the
allocation on every failed probe and every normal unbind.

Additionally, when mxc_isi_pipe_init() fails partway through the
channel loop or when mxc_isi_v4l2_init() fails, the already initialized
pipes are not cleaned up — their media entities and mutexes are leaked.

Fix both by adding kfree(isi->pipes) to all probe error paths and to
mxc_isi_remove(), and cleaning up already-initialized pipes in the
err_xbar error path.

Fixes: cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 .../platform/nxp/imx8-isi/imx8-isi-core.c     | 24 +++++++++++++++----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
index 4bf8570e1b9e..ab32c5b6ac9c 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
@@ -490,33 +490,43 @@ static int mxc_isi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	isi->num_clks = devm_clk_bulk_get_all(dev, &isi->clks);
-	if (isi->num_clks < 0)
+	if (isi->num_clks < 0) {
+		kfree(isi->pipes);
 		return dev_err_probe(dev, isi->num_clks, "Failed to get clocks\n");
+	}
 
 	isi->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(isi->regs))
+	if (IS_ERR(isi->regs)) {
+		kfree(isi->pipes);
 		return dev_err_probe(dev, PTR_ERR(isi->regs),
 				     "Failed to get ISI register map\n");
+	}
 
 	if (isi->pdata->gasket_ops) {
 		isi->gasket = syscon_regmap_lookup_by_phandle(dev->of_node,
 							      "fsl,blk-ctrl");
-		if (IS_ERR(isi->gasket))
+		if (IS_ERR(isi->gasket)) {
+			kfree(isi->pipes);
 			return dev_err_probe(dev, PTR_ERR(isi->gasket),
 					     "failed to get gasket\n");
+		}
 	}
 
 	dma_size = isi->pdata->has_36bit_dma ? 36 : 32;
 	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(dma_size));
 
 	ret = devm_pm_runtime_enable(dev);
-	if (ret)
+	if (ret) {
+		kfree(isi->pipes);
 		return ret;
+	}
 
 	ret = mxc_isi_crossbar_init(isi);
-	if (ret)
+	if (ret) {
+		kfree(isi->pipes);
 		return dev_err_probe(dev, ret,
 				     "Failed to initialize crossbar\n");
+	}
 
 	for (i = 0; i < isi->pdata->num_channels; ++i) {
 		ret = mxc_isi_pipe_init(isi, i);
@@ -538,7 +548,10 @@ static int mxc_isi_probe(struct platform_device *pdev)
 	return 0;
 
 err_xbar:
+	while (i--)
+		mxc_isi_pipe_cleanup(&isi->pipes[i]);
 	mxc_isi_crossbar_cleanup(&isi->crossbar);
+	kfree(isi->pipes);
 
 	return ret;
 }
@@ -556,6 +569,7 @@ static void mxc_isi_remove(struct platform_device *pdev)
 		mxc_isi_pipe_cleanup(pipe);
 	}
 
+	kfree(isi->pipes);
 	mxc_isi_crossbar_cleanup(&isi->crossbar);
 	mxc_isi_v4l2_cleanup(isi);
 }
-- 
2.53.0


