Return-Path: <stable+bounces-181735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 126C3BA01C0
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 17:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9943E1B233D0
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 15:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDD02E282C;
	Thu, 25 Sep 2025 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAEhzFjJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204FF2ECD36;
	Thu, 25 Sep 2025 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812577; cv=none; b=SMeWqMPYE1gUoKCdyKfRU2TJHJDpa1O7eEgCfVV/ZnkjTliB6drCpOFDSyADp94AgBbGS5yrphUNXrC1A0xzcCNgpsVzA/3D6XzkmS5qk7VKHSzZiGRzU99l4OXm9MMYSOL2WFbz1aDleQm2VByj5cn3JLXCYHq/R5+rLjU1c6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812577; c=relaxed/simple;
	bh=f96Akqi91wDUkb2jbBfRZORuWKfC1sS/5pzaMZxecxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XDPh6nyP5dEfjhk20m5JmDZyEGyjxJYuc+p27WKDH4kWK1fMEXvZ+kFgV2FoWE6J28TE1jJ5uGQOQwzxyZI5xrrn+nuXDjLlxhyNP1EZRB3qI2LddLkjMxa46CFelWKoOksVFX3KXMYOLJ3Mya2mk31oJQum3csM3hbnWrZTyMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAEhzFjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDC9C113D0;
	Thu, 25 Sep 2025 15:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758812576;
	bh=f96Akqi91wDUkb2jbBfRZORuWKfC1sS/5pzaMZxecxw=;
	h=From:To:Cc:Subject:Date:From;
	b=jAEhzFjJoMqIFHLF21veHHWE4VMd7nyVqJdDMQd47s/NYfV0joRS2ifMuhCYSkypn
	 RI6HgN9oxFjGSH+8AE92X4m9fTCzcUOd1UOFE0fw1Fbr7T+EYJU1y6rAhilPPpBsw7
	 PS+fsNsT6gp3q9hIIpLx4YBm23Qq8TRF68rOcmaQEkDcrGnpnauN6vDLJRrc+X9SDq
	 0K2Ed5ivzZ9bTn5+HhqnGRFVJdkMfMxwgRnZIaLHQmeW14YAsK4j4Ea6fFi8Ov3y8i
	 ds78tncbbnJxGVEhkDXzLM+RA3Hw10ofrRG6kINqebrR3hEJAjhIx8t8SNPhNt/wGd
	 I81y/5hmv4uAA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1nUf-000000006Lc-0Tb4;
	Thu, 25 Sep 2025 17:02:49 +0200
From: Johan Hovold <johan@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] mfd: altera-sysmgr: fix device leak on sysmgr regmap lookup
Date: Thu, 25 Sep 2025 17:02:19 +0200
Message-ID: <20250925150219.24361-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken to the sysmgr platform device when
retrieving its driver data.

Note that holding a reference to a device does not prevent its driver
data from going away.

Fixes: f36e789a1f8d ("mfd: altera-sysmgr: Add SOCFPGA System Manager")
Cc: stable@vger.kernel.org	# 5.2
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/mfd/altera-sysmgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
index fb5f988e61f3..90c6902d537d 100644
--- a/drivers/mfd/altera-sysmgr.c
+++ b/drivers/mfd/altera-sysmgr.c
@@ -117,6 +117,8 @@ struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
 
 	sysmgr = dev_get_drvdata(dev);
 
+	put_device(dev);
+
 	return sysmgr->regmap;
 }
 EXPORT_SYMBOL_GPL(altr_sysmgr_regmap_lookup_by_phandle);
-- 
2.49.1


