Return-Path: <stable+bounces-233594-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CRiM2P91GnOzQcAu9opvQ
	(envelope-from <stable+bounces-233594-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 14:49:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 432803AEA28
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 14:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EDA4300FC41
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 12:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1B93B47FE;
	Tue,  7 Apr 2026 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRd7IXJA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F004B3B27DB;
	Tue,  7 Apr 2026 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775566133; cv=none; b=qv1f1sIn0skeulsmSWPjqkQQNd0sdcwWFws0zA2CeXTUswi+uU8/Q3+wJ7Pv/tb+2NjTMn05+PqCupbxq3l/oHxKPbwlZq9rFgOhny3ZXrj47p2z6AJxKcIeWIuO3rnErWV48O+IcqlUiCYPTSWksD/LCCErzQz2rW2nIHOIHzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775566133; c=relaxed/simple;
	bh=9gM2k/aOqDg3x+DNA75R0DRTcMQqkKPvr6drbsDSsPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOxQIfiVpibBzmMZKmcexCanpFwafMcVNrLF/Rbd0fdCfpvnZ3TeuDo8ajacGTGF+5x8K7UNWNiOgWr67bWdEj1pCUikVbX9M6545lQTuuadEMvLsEL7XIAylxJWC6vm5fy3NfA7m21fbgAH2OaXQ8pSE0h8v4VqA0C4vnBcuo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRd7IXJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AB2C2BCB0;
	Tue,  7 Apr 2026 12:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775566132;
	bh=9gM2k/aOqDg3x+DNA75R0DRTcMQqkKPvr6drbsDSsPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TRd7IXJAgQxuuJ6z+aeFojkcIKQJIFuqhklGXiUWe3VmhuPQOg9Nlb6C/tB2HtIYr
	 sKsna6voOwv+9GFFFQlPX9IuAK/NA3OZNesWI5dssIdX9M65IukfQHaGCzYWrMeeXN
	 PGKaIGumfr/flgQuzuiiumcJ9ylJjFPPTs4CGoHcr5/cSqOh1UAejdz2xH7Ss+ykhv
	 Dsfvm1iDR8zNxJkl16sPFNLgZcwg6d/uI1U0T95oP4Id+MaXCLweXOCW29wMvTO53t
	 cFsN71CxMrGsLwhpiuDo77jW3hvzvhoa4zbOEKyi9C4MLzyuE1cxG49a1bfQAIQC15
	 2e3zm6qiv3o5g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wA5rO-0000000BHeT-28Vf;
	Tue, 07 Apr 2026 14:48:50 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH 2/2] regulator: bd9571mwv: fix OF node reference imbalance
Date: Tue,  7 Apr 2026 14:48:36 +0200
Message-ID: <20260407124836.2689436-3-johan@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233594-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org];
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
X-Rspamd-Queue-Id: 432803AEA28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver reuses the OF node of the parent multi-function device but
fails to take another reference to balance the one dropped by the
platform bus code when unbinding the MFD and deregistering the child
devices.

Fix this by using the intended helper for reusing OF nodes.

Fixes: e85c5a153fe2 ("regulator: Add ROHM BD9571MWV-M PMIC regulator driver")
Cc: stable@vger.kernel.org	# 4.12
Cc: Marek Vasut <marek.vasut@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/regulator/bd9571mwv-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/bd9571mwv-regulator.c b/drivers/regulator/bd9571mwv-regulator.c
index 209beabb5c37..f4de24a281b1 100644
--- a/drivers/regulator/bd9571mwv-regulator.c
+++ b/drivers/regulator/bd9571mwv-regulator.c
@@ -287,8 +287,9 @@ static int bd9571mwv_regulator_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, bdreg);
 
+	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
+
 	config.dev = &pdev->dev;
-	config.dev->of_node = pdev->dev.parent->of_node;
 	config.driver_data = bdreg;
 	config.regmap = bdreg->regmap;
 
-- 
2.52.0


