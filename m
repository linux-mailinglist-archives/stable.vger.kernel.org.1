Return-Path: <stable+bounces-213319-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KPLAdOJgmk9WAMAu9opvQ
	(envelope-from <stable+bounces-213319-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 00:50:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A689DFD96
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 00:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53E5B30F96BD
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 23:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B9F2EF66E;
	Tue,  3 Feb 2026 23:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNiT4aCA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364C11E7C18
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 23:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770162482; cv=none; b=JRaiQIaOeA2Wt3stxC5aUfyrz6t+UJeQSap3aYYTuZ836JcjXQJQ5qJwXJsCvKvD2FrLPqtX3KeafNbcu2EnCJu6+QiWI1WbNFNcQUR92uvQaQHldwICH4mpTwJpG/inzp0w/gIpDKdUx24qaYl+TtoC3tyl1khdLxxyeyn0HdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770162482; c=relaxed/simple;
	bh=RF9I/c+3fdmKDy/7ODtOtYTeQNiuC5QGxfTMvlJsZc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIy3nmi8xUKLaIyxvSYGs+hLfdfK30M5IskkhmaWKFrnKqNogYXFphHNAQYbHTznGssqlqfbSqDzeDAKp/9wH02qBSZLrvk3OolrYpaVr5UpB+7BMSf/V9yM/YfCa64SlvaVigGYeGozlnH95HpuTahsEZglI6BkvAlywpTBu5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNiT4aCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B96C116D0;
	Tue,  3 Feb 2026 23:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770162481;
	bh=RF9I/c+3fdmKDy/7ODtOtYTeQNiuC5QGxfTMvlJsZc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vNiT4aCANI+eQdvebnnxYXuwFwJ3XvnVhbkGjhS8glRmlQj2p0GV4CO4BZR0Mj+Cj
	 F+CjrNAgvsbFV8E9g59Za0Pl/LRfrX6GU/8iVqnemUQ+TFonfFqF0CfmxHUPXBY5lQ
	 04GCMJ/L2bCD7Zgu/GmUuas/bUgvJrQK5V0uvvx7BrzB9QGDk9sKbECltPMXHHWqmO
	 sA8f1fTyQQYZ7ygDslvAf7j+gQr2tEX3q4vxCP4bbKrq+bxfuFAF/cRM3qjqkJP2D/
	 XLKqGioNdNEscpLH0Kk0cW6lDtxFSBrpCX+VM1uHZXQwY/yd9SPbYQEmYjJ2i869ue
	 p5R/7VZpMpQNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/imx/tve: fix probe device leak
Date: Tue,  3 Feb 2026 18:47:59 -0500
Message-ID: <20260203234759.1453100-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020323-unseemly-venus-00e3@gregkh>
References: <2026020323-unseemly-venus-00e3@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213319-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: 1A689DFD96
X-Rspamd-Action: no action

From: Johan Hovold <johan@kernel.org>

[ Upstream commit e535c23513c63f02f67e3e09e0787907029efeaf ]

Make sure to drop the reference taken to the DDC device during probe on
probe failure (e.g. probe deferral) and on driver unbind.

Fixes: fcbc51e54d2a ("staging: drm/imx: Add support for Television Encoder (TVEv2)")
Cc: stable@vger.kernel.org	# 3.10
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20251030163456.15807-1-johan@kernel.org
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/imx/imx-tve.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/imx/imx-tve.c b/drivers/gpu/drm/imx/imx-tve.c
index fbfb7adead0b3..3394018d79ee2 100644
--- a/drivers/gpu/drm/imx/imx-tve.c
+++ b/drivers/gpu/drm/imx/imx-tve.c
@@ -521,6 +521,13 @@ static const struct component_ops imx_tve_ops = {
 	.bind	= imx_tve_bind,
 };
 
+static void imx_tve_put_device(void *_dev)
+{
+	struct device *dev = _dev;
+
+	put_device(dev);
+}
+
 static int imx_tve_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -543,6 +550,12 @@ static int imx_tve_probe(struct platform_device *pdev)
 	if (ddc_node) {
 		tve->ddc = of_find_i2c_adapter_by_node(ddc_node);
 		of_node_put(ddc_node);
+		if (tve->ddc) {
+			ret = devm_add_action_or_reset(dev, imx_tve_put_device,
+						       &tve->ddc->dev);
+			if (ret)
+				return ret;
+		}
 	}
 
 	tve->mode = of_get_tve_mode(np);
-- 
2.51.0


