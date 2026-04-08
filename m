Return-Path: <stable+bounces-233807-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OxmER0F1mkbAwgAu9opvQ
	(envelope-from <stable+bounces-233807-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:34:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 046CB3B85B8
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B51A302AED5
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 07:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F91E38238C;
	Wed,  8 Apr 2026 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kp8lQJ/L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E89382397;
	Wed,  8 Apr 2026 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633514; cv=none; b=M5692UfJHeIFeL76zkdLH1ricy5yewhO+xEd47Dg1OZ6+OLZ9dzlLP6Oci9CR4opoKXmvi7tmDgjNeQV0KtGZDsdRM19pM/PvYmyEKffEJJxKxUv9TMnjkBw54s9U8Yi9bDiosF16+XZC890mjP864/+XfMZ0G6COUtOC2vqShc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633514; c=relaxed/simple;
	bh=FXyQ24BYf7morxcDyu4vsmcVP7Ek1/v6ZJhPAKuWC8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=peJ/CGtWhpRsnnrMY1lPQa3mY/VvMygnMTNbNl0L08SSLtbhIFdGLunDClrwHTW7DvlnaqSYeva3rCup2B9KML41VvYLS6TsuboVn9zT2YGovyR0JQ0QyhoKdPr5Dj/TgIGHURIgs0XiwjZt8eZ8nvJKjVn++YU295ppApVn0TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kp8lQJ/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62531C4AF0B;
	Wed,  8 Apr 2026 07:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775633514;
	bh=FXyQ24BYf7morxcDyu4vsmcVP7Ek1/v6ZJhPAKuWC8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kp8lQJ/L0u5ybf9Q7lVrBotLS5woDg6adq2Isbvz5u2cgxwY7w2iWkR4uyQB00l01
	 bWxwl5INeJoZ3f+rC0yJqtYfV6VpxWP8fmSSP/wJpPYWh78Xt6EEr/RK4OsOgg7ZLz
	 Gw76WnahwE55VYOFscSGryQyyy9PeI+2tGb+fDpD4+UaxBkKQ2NsBCwQaNSrBcrVyZ
	 tu66aqkf/UYJlis6sEiepEmqxwEI45r4gFoEGTEqzLm/56oN2DpOjiLFNGpC9awhdP
	 apvwRZOnrXkXyjOpSvNCkA2N/xZkEx8Qm4k0ZOe2CJAtpLd42+3EWDqMTpHhNnbtlb
	 Tvd94MVByKmpA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wANOC-000000001Mj-038S;
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
	stable@vger.kernel.org,
	Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v2 5/7] regulator: s2dos05: fix OF node reference imbalance
Date: Wed,  8 Apr 2026 09:30:53 +0200
Message-ID: <20260408073055.5183-6-johan@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,collabora.com,linaro.org,chromium.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233807-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,renesas];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 046CB3B85B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver reuses the OF node of the parent multi-function device but
fails to take another reference to balance the one dropped by the
platform bus code when unbinding the MFD and deregistering the child
devices.

Fix this by using the intended helper for reusing OF nodes.

Fixes: bb2441402392 ("regulator: add s2dos05 regulator support")
Cc: stable@vger.kernel.org	# 6.18
Cc: Dzmitry Sankouski <dsankouski@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/regulator/s2dos05-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/s2dos05-regulator.c b/drivers/regulator/s2dos05-regulator.c
index 1463585c4565..a1c394ddbaff 100644
--- a/drivers/regulator/s2dos05-regulator.c
+++ b/drivers/regulator/s2dos05-regulator.c
@@ -126,7 +126,7 @@ static int s2dos05_pmic_probe(struct platform_device *pdev)
 	s2dos05->regmap = iodev->regmap_pmic;
 	s2dos05->dev = dev;
 	if (!dev->of_node)
-		dev->of_node = dev->parent->of_node;
+		device_set_of_node_from_dev(dev, dev->parent);
 
 	config.dev = dev;
 	config.driver_data = s2dos05;
-- 
2.52.0


