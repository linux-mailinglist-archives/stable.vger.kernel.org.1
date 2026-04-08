Return-Path: <stable+bounces-233806-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAr2HrQE1mnbAQgAu9opvQ
	(envelope-from <stable+bounces-233806-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:33:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D27203B841D
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2F03304AAFD
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 07:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DD038424A;
	Wed,  8 Apr 2026 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRncHCrR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8029382395;
	Wed,  8 Apr 2026 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633514; cv=none; b=jidkHhhmMS84iOfpI2CJYk7NgLGsrgy8gotj8ZpsGBfhsyXaLPs1XHVV5AKSdH0ENDAxVr6RZ6cJxikGvd9jLqYY9gX5rMNCddQOJm1sbGt5QPgOpidxthqwd9b0KEHg98NmkRFSWt/nLOrTl3OCRU1y/p602Tce0ma9Qdb36Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633514; c=relaxed/simple;
	bh=jrQBeK2x6KLluU2H0Ges4ATakn3LsGMgIHcBGMIrXB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIJ2SusGD0sO9HqJWf8isw9oKF5W861nsOC1xUJKeK5tLg03Y4pXQqlAXr+N4mEO6aKc8R7cO7XYIObgk3ytLAO5yZx7LIPdDYDBASzfTmMrcxshvJoGTpxU2mCb1CCOuQ4M0D6HqFS1T4B2kSycki677LTMySkiTC2jReWqXus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRncHCrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C7BC2BCB1;
	Wed,  8 Apr 2026 07:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775633514;
	bh=jrQBeK2x6KLluU2H0Ges4ATakn3LsGMgIHcBGMIrXB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FRncHCrRy4aJMsh9jVOWTKZR+94RM2pGQMyQ7HaQeJ7aWmiHKDJj+2Nkn8/4DkM17
	 F2dokLDnaQOdGBpOctJCNaJc/3hcnu/WX3ckncwZjFiTn8M3u6LdtZhSw4jN3VgyOV
	 R3ZsVZ0DISN1xn3uz7N/EQ6cZ7OFZ/vch5eP4bZOtxoge0uymd57xNr8q8VFFLlBZs
	 x5CR978eJ2Hg48YwUVCWa18vrLkcOQxGwqgf2yuIF72atrzZFVIY/y0r/+VB74Y4jB
	 b2yqUvWw7/3fJLO0uq63whLp2q+MTNBwrCElV4gbTnX7EeWDPPkx4IzZQQRAV9hU9A
	 GHW0UWjJrBN3w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wANOB-000000001Mh-4C3p;
	Wed, 08 Apr 2026 09:31:52 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 4/7] regulator: mt6357: fix OF node reference imbalance
Date: Wed,  8 Apr 2026 09:30:52 +0200
Message-ID: <20260408073055.5183-5-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408073055.5183-1-johan@kernel.org>
References: <20260408073055.5183-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,collabora.com,linaro.org,chromium.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233806-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,renesas];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D27203B841D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver reuses the OF node of the parent multi-function device but
fails to take another reference to balance the one dropped by the
platform bus code when unbinding the MFD and deregistering the child
devices.

Fix this by using the intended helper for reusing OF nodes.

Fixes: dafc7cde23dc ("regulator: add mt6357 regulator")
Cc: stable@vger.kernel.org	# 6.2
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/regulator/mt6357-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/mt6357-regulator.c b/drivers/regulator/mt6357-regulator.c
index 1eb69c7a6acb..09feb454ab6b 100644
--- a/drivers/regulator/mt6357-regulator.c
+++ b/drivers/regulator/mt6357-regulator.c
@@ -410,7 +410,7 @@ static int mt6357_regulator_probe(struct platform_device *pdev)
 	struct regulator_dev *rdev;
 	int i;
 
-	pdev->dev.of_node = pdev->dev.parent->of_node;
+	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
 
 	for (i = 0; i < MT6357_MAX_REGULATOR; i++) {
 		config.dev = &pdev->dev;
-- 
2.52.0


