Return-Path: <stable+bounces-233586-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id T4/cLsn21GlkzQcAu9opvQ
	(envelope-from <stable+bounces-233586-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 14:21:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 550553AE3E4
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 14:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B8DA3029A5D
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 12:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7CC3B38AA;
	Tue,  7 Apr 2026 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpHnZQbR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A215B3AA516;
	Tue,  7 Apr 2026 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775564483; cv=none; b=AgK0bnV6NmRhx5ag9ZBEt6HTlz+0OJF/vHoYbwbB4vCDIavwgi0AnmsE+/Ay9GCzvMOQfDwn1miVezB2Pqh1VMxBcg0HiLHgs4JX4D6pzMXbJH9Vhidu11ZujKZg04k+xZMrPzbrg0ahlAQjz4dmE8VTAuGpqEPaYmlcDPwOdZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775564483; c=relaxed/simple;
	bh=FXyQ24BYf7morxcDyu4vsmcVP7Ek1/v6ZJhPAKuWC8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8xvsPrbq9mH4fYnJsKQy6N7MNmIUWxhjLGTkfIubTZIhMpodEROZVsH033Gr8tnHrxVSULi5cQasJUrBAh+xpVfxrDDYBpVAtipi+k0DxGAHcVFvenwTbvCG3qh9rmzFhkdSIbZBpNCD1fwO59zXSG62TvstH+wdMTeRbJuAa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpHnZQbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761BDC2BCB1;
	Tue,  7 Apr 2026 12:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775564483;
	bh=FXyQ24BYf7morxcDyu4vsmcVP7Ek1/v6ZJhPAKuWC8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IpHnZQbRuZPZFiqRBChLN4lzaBWDz63duZisZlsayDeuDOMtmz8dCeNgFzljGQRsQ
	 8y2EagF50WA3s1KLZyT9szg+ElLOhlG3MEaERmbefMebOHNdm7BhzTmuJNhGechf2p
	 DfPE1ZUzCyuA+jW0kEeiwBfWvNccmjp87y7BYewYIAV0gmLp1nrHi8vYZwbaLAWoDP
	 Wrq05YQulN/eGo0ZMGTf99+Pe1QGZKO2YkSBbrBhQEe9XNYskKqPV2DJ747zDEl7YO
	 Yuz6I+bztwOEYOH7mzIk8SMHq1E4ue73u6C5ILPHOlHge5v/VND0vCIhx2/rkbD8Dq
	 9EVYKUiD708VQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wA5Qn-0000000BCSC-0r7f;
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
	stable@vger.kernel.org,
	Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH 3/3] regulator: s2dos05: fix OF node reference imbalance
Date: Tue,  7 Apr 2026 14:20:31 +0200
Message-ID: <20260407122031.2669397-4-johan@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,collabora.com,linaro.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233586-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 550553AE3E4
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


