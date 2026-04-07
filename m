Return-Path: <stable+bounces-233585-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sE+TDcn21GkjywcAu9opvQ
	(envelope-from <stable+bounces-233585-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 14:21:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B133AE3DC
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 14:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4F3D302735F
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 12:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57E43B38A3;
	Tue,  7 Apr 2026 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmASZz3m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CB8279792;
	Tue,  7 Apr 2026 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775564483; cv=none; b=RW3cOqW0uHQs7JrqVA5j2Px3f4WVGx6W5mexK9CD8tf4IHpBLM1D7s34mtZVGEJz11S2NXYl9razYaxdYVijMEJZ3zVppSgUHjRIN7oP35G2zKnq6bWS0wgzsQSM7LzEjVHYIdtjPDE17CHbxDPcI8QLZChS6MlQKbhGr+H8LNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775564483; c=relaxed/simple;
	bh=jrQBeK2x6KLluU2H0Ges4ATakn3LsGMgIHcBGMIrXB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twLLBxSrRXAaHkcGqLxN+Irw/DzfFdzecba23m9YJXLflYBgzimB5DcMEmDBcbWvi3+ovGjUJNQjbFo3y1lcwOkZ7JUvVGNVUE+D/RB0cxb3o34gGYNPGpTJMIG/9SjuPTGrPfUsjFAKhcbDYVl3YkduG5yzBJRDoVBuQ+h09+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmASZz3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7360AC2BCB0;
	Tue,  7 Apr 2026 12:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775564483;
	bh=jrQBeK2x6KLluU2H0Ges4ATakn3LsGMgIHcBGMIrXB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PmASZz3mzPigCoOU3VTC0MMR69Ji4P0O79gQuVls7oHnYViE7WiS01wCItjwZi+z5
	 GzS6aSYgQoBWebmcCi68qP1lO/2ffVsz2KsU12chhQqXnnOunCXN7krahC43jLZjUB
	 vdtN1OcHlygmrzfQblQGCkgmdAgrF7HOWYO4wH0S2Z4foWcKPrSQ5DFQEgu+p8+18q
	 CNajA1QJh7By5ZhMYd2ma6XSP69INSz63GYrv53aIymOvsAx7u+M1dwojriYCd12cX
	 wJadn2kVrZJjv6KaZu+v4XhJSMzfCH7IQAcsGGza1eIMk63yWt14CiiOgF9gJMpXcO
	 8xRpdfuCid1bA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wA5Qn-0000000BCSA-0o2p;
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
Subject: [PATCH 2/3] regulator: mt6357: fix OF node reference imbalance
Date: Tue,  7 Apr 2026 14:20:30 +0200
Message-ID: <20260407122031.2669397-3-johan@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-233585-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A4B133AE3DC
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


