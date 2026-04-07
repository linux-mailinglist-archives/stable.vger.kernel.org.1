Return-Path: <stable+bounces-233584-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KR+NCD41Gl+zQcAu9opvQ
	(envelope-from <stable+bounces-233584-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 14:27:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCEC3AE59B
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 14:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F79B30315F2
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 12:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1CC3B2FDF;
	Tue,  7 Apr 2026 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYfCgxEM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD821ACED5;
	Tue,  7 Apr 2026 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775564483; cv=none; b=ab9+8V5ndRD30UR2BQvOOD7m4Rbcubtmw351sIFOh+tOnQ4h3mV3vIC1zpmuRjc7a7kdnOraUkpagRolZpmIYefovDZg2qyuANu5pJqtj3a6hCq0yyvFuruX0gFJGQVrHIalMxF2UDYiBS57oG8uDRsD6E7WDBZ5mcRyqy+zguE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775564483; c=relaxed/simple;
	bh=qe9hzNCzhvX11xJ50GGWKhIIpom0rXz4h7ZFWfkxfCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAIC5vV+XnBDsILC/7gfa3XpX/LBuxw+5dV/mucqdZST5ks3jNEOD7Oze4rLjtLITXYQAGlQ38zZFxoFHW6AKtjLpu6ZsG/Xol0wmN/mPhs1qvRXxb0q0SEcOK3Zt0vISrZOR+YNLeKiuuhxLoodemboQEBqzxrZiLdN8zNnz0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYfCgxEM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF60C116C6;
	Tue,  7 Apr 2026 12:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775564483;
	bh=qe9hzNCzhvX11xJ50GGWKhIIpom0rXz4h7ZFWfkxfCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UYfCgxEMLMNQEZXRYNXj7efNn6WXiOS8ySWce1KwsBc0gwuGSjeTZvfRnC7OxNODh
	 NNLutUhKrV+GLlJETkBqaE9gSQZiouy+bAa2zvkowz4gN0LeGsU/lAe4IaeB611Jdc
	 dWxM8ai5gZPvMSRzAHlzJi38cqv5MaxT88Cqmir1tPbwp4zekXVsJSWvIpbUm6SmR0
	 oXGG8+BaP110IRRJy/O4X7Q2r1vIdDtYddPbmKv21H+OLfr1jHdfh06PsR/gbffyFU
	 S2eqSK4jAKG3bxFCiFGd8W14JluifR0HU+X7c6WDGVGFEggO4MBCJQZgNIVu2u2a6k
	 igAGs6XQjEMMA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wA5Qn-0000000BCS8-0lcp;
	Tue, 07 Apr 2026 14:21:21 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] regulator: max77650: fix OF node reference imbalance
Date: Tue,  7 Apr 2026 14:20:29 +0200
Message-ID: <20260407122031.2669397-2-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407122031.2669397-1-johan@kernel.org>
References: <20260407122031.2669397-1-johan@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,collabora.com,linaro.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233584-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2CCEC3AE59B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver reuses the OF node of the parent multi-function device but
fails to take another reference to balance the one dropped by the
platform bus code when unbinding the MFD and deregistering the child
devices.

Fix this by using the intended helper for reusing OF nodes.

Fixes: bcc61f1c44fd ("regulator: max77650: add regulator support")
Cc: stable@vger.kernel.org	# 5.1
Cc: Bartosz Golaszewski <brgl@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/regulator/max77650-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index a809264c77fc..11b04a13f889 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -337,7 +337,7 @@ static int max77650_regulator_probe(struct platform_device *pdev)
 	parent = dev->parent;
 
 	if (!dev->of_node)
-		dev->of_node = parent->of_node;
+		device_set_of_node_from_dev(dev, parent);
 
 	rdescs = devm_kcalloc(dev, MAX77650_REGULATOR_NUM_REGULATORS,
 			      sizeof(*rdescs), GFP_KERNEL);
-- 
2.52.0


