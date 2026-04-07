Return-Path: <stable+bounces-233533-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6D3uMaHR1GlJxwcAu9opvQ
	(envelope-from <stable+bounces-233533-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 11:42:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0B73AC39F
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 11:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC7E9300E612
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 09:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B943A6B95;
	Tue,  7 Apr 2026 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QY6PiRkZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55152397E9F;
	Tue,  7 Apr 2026 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775554967; cv=none; b=dkYCjLJDaZP3+9wDUxhZqQylf9kxmp/ktT8D6SajVddums4NYpl3TCTvJpbiZYSMfysN4pl8HPPw4MD05Z5i3smlp7y9Wgf2gXhisRUhBvWd5NXfpkaILCv4hbd/YAb4uLZcr0Bwb1WGiO3fTnWP2xBcUF/ztosk2YiK0yHWV1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775554967; c=relaxed/simple;
	bh=y/MUDuKf1fp3qW2A2KMP8ftGm+5U0I/jI3IAY3322ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6jlx/r9TqERQs69N8LQBUJ67WM7XJWAdDa+FjVzypEXAmOFQuF9CgdEwdXwPbl2p31a6f8aBmmYTHGOuDUmOTr1d9agjoIhzKMlTXHhJxZMNjymOfAmftMEwwVTXStbtwvnaSZTyNAymD7Pu0xbdPFXW71lPN78sGnQx7yfcMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QY6PiRkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E40AC116C6;
	Tue,  7 Apr 2026 09:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775554967;
	bh=y/MUDuKf1fp3qW2A2KMP8ftGm+5U0I/jI3IAY3322ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QY6PiRkZ0Xp+NlWeoSwAZTsy/hLIjity164nLHvTYREiBC34ju2xC3Zt6YeP+6Bxt
	 0S9h4/b1tkmrq/DrchYW0Fu+XZ7R0niJ/RP0LQMzVbhDEWV8NwqtVHPOmBRYbRzBn0
	 rHzJdhJWHSpVljqxl//XDvS19Pi68paD+zBLiU7yz1sPgTYSmrTXdl0Q2z8S8TO0Jp
	 6TmnPDjOuAD4F7D0YK0ZlATv6Sbwm+Od9xmRgS7BtMAJKi+ft9iwT1u4HrJ7Df82rc
	 457J88B0zJoLg72R+7QKQPWVO6FHu5m0kD6IVCNzp0rxlRtmzYjKkJggSYGzmbCQpH
	 wp041ba9/Ge9g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wA2xI-0000000AnNP-3lQe;
	Tue, 07 Apr 2026 11:42:44 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 2/2] regulator: rk808: fix OF node reference imbalance
Date: Tue,  7 Apr 2026 11:41:56 +0200
Message-ID: <20260407094156.2573027-3-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407094156.2573027-1-johan@kernel.org>
References: <20260407094156.2573027-1-johan@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233533-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,chromium.org,vger.kernel.org,kernel.org,collabora.com];
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
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8A0B73AC39F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver reuses the OF node of the parent multi-function device but
fails to take another reference to balance the one dropped by the
platform bus code when unbinding the MFD and deregistering the child
devices.

Fix this by using the intended helper for reusing OF nodes.

Fixes: 5111c931f36c ("regulator: rk808: cleanup parent device usage")
Cc: stable@vger.kernel.org	# 6.5
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/regulator/rk808-regulator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index e66408f23bb6..1e956153427e 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -2114,8 +2114,7 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	int ret, i, nregulators;
 
-	pdev->dev.of_node = pdev->dev.parent->of_node;
-	pdev->dev.of_node_reused = true;
+	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
 
 	regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!regmap)
-- 
2.52.0


