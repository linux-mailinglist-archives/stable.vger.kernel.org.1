Return-Path: <stable+bounces-213328-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP98L0yVgmkRWgMAu9opvQ
	(envelope-from <stable+bounces-213328-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 01:39:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6244CE010F
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 01:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C51653051B38
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 00:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8056720CCE4;
	Wed,  4 Feb 2026 00:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDTYmZjV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C3620468E
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 00:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770165576; cv=none; b=uC0OUrUJJbZaLsOatplLiwb24qlEGd31s8g2NUw01VSDUDPvA7q6qGoEI0YLM40EJyeNQUnqrq/8ktmFQTqUUNMmWWo0Gxao0deBcY7g0RVIbBOUeOQcgwPd7VvEl3i5GzD5ZAd+wIUAyss8o+J0iQoU2ut3Hv+9uT+k2pP+wNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770165576; c=relaxed/simple;
	bh=lcKAaJYsGvk3HdJJq8HEaq96Hx+FZh0/BALaoVV1GOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtHEtDNASyroVFmf8QsBOu/PbxlcX9TDJJXKmlYKdiDA8xtqiSemSgXIGh9HOLTfBxg3IcCOBmzqhr/ou2X4J8t/ZBQhC1YKc6+dqEqK2FeGcZb8NX0DIQm8awiBjfGjWyqH1jazeL5SpBpz0bLlpl5bVFFx++5C0V48SWKZDlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDTYmZjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB0AC19425;
	Wed,  4 Feb 2026 00:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770165576;
	bh=lcKAaJYsGvk3HdJJq8HEaq96Hx+FZh0/BALaoVV1GOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EDTYmZjVzwQ/tVl65Yk7mPtqN3COzJcM31bqOlc8hjjR45e1rvg5VJrwZx25HEWS8
	 9v1e1iAysEf6zx3LM6pkZm/4xSzwzpBxb6TjZqiJTdpXeog6voCOzt0vrbyAtEooqg
	 +ltB8pB2zrVuJKAAB7VfNwdezWowutTySv5+1UGAw3F6SWouD1I8PbVYzBLUNYOA8t
	 xIwXZdikDtIGUPicXIFLRwfNfBDsH/kpenUoE5SOe2ZA1ZV3raujbo4qZms447tPoj
	 9foWgt+O0CRwZ99h2vY+Gs5PEKPSb1R9r0Cp0ElvP6eGPtm81co9+2lgbbtin3Hplp
	 q/7BlnZ00yWUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] drm/imx: imx-tve: move initialization into probe
Date: Tue,  3 Feb 2026 19:39:32 -0500
Message-ID: <20260204003933.1467160-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204003933.1467160-1-sashal@kernel.org>
References: <2026020324-unsure-backfield-4511@gregkh>
 <20260204003933.1467160-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213328-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6244CE010F
X-Rspamd-Action: no action

From: Philipp Zabel <p.zabel@pengutronix.de>

[ Upstream commit a91cfaf6e6503150ed1ef08454f2c03e1f95a4ec ]

Parts of the initialization that do not require the drm device can be
done once during probe instead of possibly multiple times during bind.
The bind function only creates the encoder.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Stable-dep-of: e535c23513c6 ("drm/imx/tve: fix probe device leak")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/imx/imx-tve.c | 42 ++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/imx/imx-tve.c b/drivers/gpu/drm/imx/imx-tve.c
index f80fe025be18d..8c16b0579e568 100644
--- a/drivers/gpu/drm/imx/imx-tve.c
+++ b/drivers/gpu/drm/imx/imx-tve.c
@@ -439,6 +439,9 @@ static int imx_tve_register(struct drm_device *drm, struct imx_tve *tve)
 	encoder_type = tve->mode == TVE_MODE_VGA ?
 				DRM_MODE_ENCODER_DAC : DRM_MODE_ENCODER_TVDAC;
 
+	memset(connector, 0, sizeof(*connector));
+	memset(encoder, 0, sizeof(*encoder));
+
 	ret = imx_drm_encoder_parse_of(drm, encoder, tve->dev->of_node);
 	if (ret)
 		return ret;
@@ -504,8 +507,19 @@ static int of_get_tve_mode(struct device_node *np)
 
 static int imx_tve_bind(struct device *dev, struct device *master, void *data)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	struct drm_device *drm = data;
+	struct imx_tve *tve = dev_get_drvdata(dev);
+
+	return imx_tve_register(drm, tve);
+}
+
+static const struct component_ops imx_tve_ops = {
+	.bind	= imx_tve_bind,
+};
+
+static int imx_tve_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct device_node *ddc_node;
 	struct imx_tve *tve;
@@ -515,8 +529,9 @@ static int imx_tve_bind(struct device *dev, struct device *master, void *data)
 	int irq;
 	int ret;
 
-	tve = dev_get_drvdata(dev);
-	memset(tve, 0, sizeof(*tve));
+	tve = devm_kzalloc(dev, sizeof(*tve), GFP_KERNEL);
+	if (!tve)
+		return -ENOMEM;
 
 	tve->dev = dev;
 
@@ -623,28 +638,9 @@ static int imx_tve_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		return ret;
 
-	ret = imx_tve_register(drm, tve);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static const struct component_ops imx_tve_ops = {
-	.bind	= imx_tve_bind,
-};
-
-static int imx_tve_probe(struct platform_device *pdev)
-{
-	struct imx_tve *tve;
-
-	tve = devm_kzalloc(&pdev->dev, sizeof(*tve), GFP_KERNEL);
-	if (!tve)
-		return -ENOMEM;
-
 	platform_set_drvdata(pdev, tve);
 
-	return component_add(&pdev->dev, &imx_tve_ops);
+	return component_add(dev, &imx_tve_ops);
 }
 
 static int imx_tve_remove(struct platform_device *pdev)
-- 
2.51.0


