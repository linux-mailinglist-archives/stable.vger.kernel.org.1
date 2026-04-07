Return-Path: <stable+bounces-233593-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMTaG2b91GnOzQcAu9opvQ
	(envelope-from <stable+bounces-233593-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 14:49:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF993AEA2F
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 14:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93D6A30107CE
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 12:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5243B4E80;
	Tue,  7 Apr 2026 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+deckva"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00CD3B38A0;
	Tue,  7 Apr 2026 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775566133; cv=none; b=WjYL0kiaSjyUZLV2bHdaKlQL4e/zVXMtBlSjBblY2iTAShjWBeC/tcJWDdpX3wWmT3qSn9EWRqRNTyXcQOh3wGl2lNGBMSy5ZaNdaDv/dxym3sCHevx+4jbcTY7PQCrXWRvk5mhNKG6Smyo0nIUC2uH2y7DQQBjbpMIK+oZF3Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775566133; c=relaxed/simple;
	bh=vWCNuhUoewsighVgd5hZe21pawPiAvd2Jv9BdMisxM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovFeNB52LP1HSfXkRSAesYETg9mcutLEbEch0nx1y7icCedLX/AtSt2lQ7dFnVxFOG0q1CoTTfcpjZl14f6MWNn+CSgztWuOR+ljvat2VTFgY7AqigVK8UKTJmUUBhR5z6193J+rGWlVoAww2V6UuZGhtqcmVMJINzXnPog0NKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+deckva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D1DC116C6;
	Tue,  7 Apr 2026 12:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775566132;
	bh=vWCNuhUoewsighVgd5hZe21pawPiAvd2Jv9BdMisxM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D+deckvaRb6p0GV93gFF1SamlsXNEE4aHkc9T6eRuH95fYuGEJloOEqaWmGDy/VC+
	 TdeUXlXheeXbNuWfeaeDahoMvG4TzABaSWaHId3zIrmtGXz1Ndl/q1fI+t1M2/U91j
	 tYJlFePb06Sf0yxYEIPPfyplhh8ruIdz7QnwNtzM8Jo/MU3sWL03dd/I2MfFdDsmrz
	 2t4JxPShIvxckDT1sJo/mVz/EXrn3qfB+SONsYGqiwx97CkyinSls9gn3Y0gXUK4Tn
	 nFAMyY7j8sb9LT0DyIzr4sU8Zrm7p8AYIoG5uom5DCRNES2vjmHvybf5KnpgQnc4g7
	 EZBfe3xRKoH5w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wA5rO-0000000BHeR-26CI;
	Tue, 07 Apr 2026 14:48:50 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH 1/2] regulator: act8945a: fix OF node reference imbalance
Date: Tue,  7 Apr 2026 14:48:35 +0200
Message-ID: <20260407124836.2689436-2-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407124836.2689436-1-johan@kernel.org>
References: <20260407124836.2689436-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233593-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,atmel.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,renesas];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DBF993AEA2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver reuses the OF node of the parent multi-function device but
fails to take another reference to balance the one dropped by the
platform bus code when unbinding the MFD and deregistering the child
devices.

Fix this by using the intended helper for reusing OF nodes.

Fixes: 38c09961048b ("regulator: act8945a: add regulator driver for ACT8945A")
Cc: stable@vger.kernel.org	# 4.6
Cc: Wenyou Yang <wenyou.yang@atmel.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/regulator/act8945a-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act8945a-regulator.c
index 24cbdd833863..5bbe2bce740e 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -302,8 +302,9 @@ static int act8945a_pmic_probe(struct platform_device *pdev)
 		num_regulators = ARRAY_SIZE(act8945a_regulators);
 	}
 
+	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
+
 	config.dev = &pdev->dev;
-	config.dev->of_node = pdev->dev.parent->of_node;
 	config.driver_data = act8945a;
 	for (i = 0; i < num_regulators; i++) {
 		rdev = devm_regulator_register(&pdev->dev, &regulators[i],
-- 
2.52.0


