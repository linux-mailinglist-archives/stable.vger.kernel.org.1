Return-Path: <stable+bounces-213327-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIAHGT2WgmllWgMAu9opvQ
	(envelope-from <stable+bounces-213327-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 01:43:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6803E0166
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 01:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E287306758C
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 00:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0321120A5F3;
	Wed,  4 Feb 2026 00:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZZGRU5z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA61820468E
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 00:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770165575; cv=none; b=mktfOFDq66JvFJXPlmrZ42S8aX47MTkPUCF/EMlNwwXWKc4xp9eUSA24NdAEMUS1w2UTUqQw+SiDiHyFfxDMzKZhX/TLs6eLyxkywolLZIwm8MvQpKnWSU2zyWBiqttwr1V6BqOj32xvIcvCmg4VIq5erIq+YhtQW2B5rPe/wrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770165575; c=relaxed/simple;
	bh=S98IAsZG9Cv5huK2K6ffu09b9rZbUC2lfSsPuCsXUI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SmoNAxYVgFf7xKtoIv8g6T88fhE39QGVTUXVADULB8yWzaOpl7zdPcWx75CY7/cvizi4XRdn8/mWZPYbknzBYB7MplUTKNMG8TTZFBuFeABxxtIhPNkRpT7TIyl/kucsYG6evLrVZyLuapGnFbNGjauTRj7QIKAkPMwL8PX0oxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZZGRU5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77E2C19422;
	Wed,  4 Feb 2026 00:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770165575;
	bh=S98IAsZG9Cv5huK2K6ffu09b9rZbUC2lfSsPuCsXUI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JZZGRU5zOCGzW3IY/qxG/yQy7/D4JH5xxy2W3SWknAJqIpbFKgOkLnsCEXAISfST/
	 B/hljFWf1HhNXpFB1uJvT/JHTFmOHbYUTQxDr7onBJD7njzLJGI9AibWRctdgexHHf
	 cfjFhK3ygaEwOcHH7PYsIQOhQ92OpuwLZu93ic4qhEknQ0jlnD/Kfgo/6gJ54C6/8T
	 Hc458OxyejpwmUfEWAlKEIaZCqNnRs5D5ky7x9ftYbTWGVj3RrywHCUcnBXd9lntLb
	 OPOInGG56lzGqw9NLiq8RvoqLccMCCNFBjlsSkGMdqKJ6nC/xyGSCVrZ3NIOeOyPQW
	 CHXcSuJIZ8a3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] drm/imx: imx-tve: use local encoder and connector variables
Date: Tue,  3 Feb 2026 19:39:31 -0500
Message-ID: <20260204003933.1467160-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020324-unsure-backfield-4511@gregkh>
References: <2026020324-unsure-backfield-4511@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213327-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ffwll.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: B6803E0166
X-Rspamd-Action: no action

From: Philipp Zabel <p.zabel@pengutronix.de>

[ Upstream commit 396852df02b9ff49fe256ba459605fc680fe8d89 ]

Introduce local variables for encoder and connector.
This simplifies the following commits.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Stable-dep-of: e535c23513c6 ("drm/imx/tve: fix probe device leak")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/imx/imx-tve.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/imx/imx-tve.c b/drivers/gpu/drm/imx/imx-tve.c
index 9fe6a47331067..f80fe025be18d 100644
--- a/drivers/gpu/drm/imx/imx-tve.c
+++ b/drivers/gpu/drm/imx/imx-tve.c
@@ -431,27 +431,28 @@ static int tve_clk_init(struct imx_tve *tve, void __iomem *base)
 
 static int imx_tve_register(struct drm_device *drm, struct imx_tve *tve)
 {
+	struct drm_encoder *encoder = &tve->encoder;
+	struct drm_connector *connector = &tve->connector;
 	int encoder_type;
 	int ret;
 
 	encoder_type = tve->mode == TVE_MODE_VGA ?
 				DRM_MODE_ENCODER_DAC : DRM_MODE_ENCODER_TVDAC;
 
-	ret = imx_drm_encoder_parse_of(drm, &tve->encoder, tve->dev->of_node);
+	ret = imx_drm_encoder_parse_of(drm, encoder, tve->dev->of_node);
 	if (ret)
 		return ret;
 
-	drm_encoder_helper_add(&tve->encoder, &imx_tve_encoder_helper_funcs);
-	drm_simple_encoder_init(drm, &tve->encoder, encoder_type);
+	drm_encoder_helper_add(encoder, &imx_tve_encoder_helper_funcs);
+	drm_simple_encoder_init(drm, encoder, encoder_type);
 
-	drm_connector_helper_add(&tve->connector,
-			&imx_tve_connector_helper_funcs);
-	drm_connector_init_with_ddc(drm, &tve->connector,
+	drm_connector_helper_add(connector, &imx_tve_connector_helper_funcs);
+	drm_connector_init_with_ddc(drm, connector,
 				    &imx_tve_connector_funcs,
 				    DRM_MODE_CONNECTOR_VGA,
 				    tve->ddc);
 
-	drm_connector_attach_encoder(&tve->connector, &tve->encoder);
+	drm_connector_attach_encoder(connector, encoder);
 
 	return 0;
 }
-- 
2.51.0


