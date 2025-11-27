Return-Path: <stable+bounces-197102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B81E5C8E893
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 63DA234E2BE
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 13:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F5228C014;
	Thu, 27 Nov 2025 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8Hacogj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09485695;
	Thu, 27 Nov 2025 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764250985; cv=none; b=i9Agaeo4tf+IeXwugT+oVwAxoY4XwbGcqcyZat2/dFkKQUtvGbxJKVc9t5dwPsc6WWM4pBY437oaCPf9X1ccimNNjK0FxErXX5ApyTOpE2VZi0g7NUNIwLbO3QqOA5juOLV+FpgDqs4CjYMnJTTl792nopmo7yMc1fZARhtK3xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764250985; c=relaxed/simple;
	bh=45UyrorjIXkvnps/rHKrDFx6Ggb0CaIoByAc/eOwfhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fDy78/bHXkhUISM/MNI7QZSU5z3ZxNiyVonf9H4zMUBUBZfTVHERQpL2hAIvZrmtPgPuPYc8h37HqtkklZ5uj+Djb0t4DMG1zPmtYgbR6E6Cic0yTqfRxKrw/N7PAyXddBhBGDx9uyaKIwYGQOaKlid44UhQhQ644jhr3WEMbRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8Hacogj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF7EC4CEF8;
	Thu, 27 Nov 2025 13:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764250985;
	bh=45UyrorjIXkvnps/rHKrDFx6Ggb0CaIoByAc/eOwfhI=;
	h=From:To:Cc:Subject:Date:From;
	b=u8HacogjKKObaE8JBN8IuCxz0b50HkO3miSyGmn3UfDi06WoA1Ff7fhO1ubfxF+ti
	 DIHUXFhYmiezBgg6rJAdRWkImS+wyt+yvqptB8OlyWti3LDH0bS89e+1+4exhPjHQj
	 LWiBzvbEexG8dTneUxkw3wUy6sVhWoEMAfSnhaa60+5ltFdv4ZwZZCPI2hvLlZzYa3
	 GDKENwLXVRU+xyePchaHr80G9JFV0QwJeslWE5uDmuR/bTsjtUtbVrkWBCdc95pMWh
	 VGOW26kza5Kq+Hu9hWt8eBhpvJDxZgqBv/NqZmfwFkYhQuaIhCHqICowYfEfBqAPpI
	 LQwCMZzb++sAA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vOcH5-000000000Oc-4BCs;
	Thu, 27 Nov 2025 14:43:08 +0100
From: Johan Hovold <johan@kernel.org>
To: Santosh Shilimkar <ssantosh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Andrew Davis <afd@ti.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] clk: keystone: syscon-clk: fix regmap leak on probe failure
Date: Thu, 27 Nov 2025 14:42:43 +0100
Message-ID: <20251127134243.1486-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mmio regmap allocated during probe is never freed.

Switch to using the device managed allocator so that the regmap is
released on probe failures (e.g. probe deferral) and on driver unbind.

Fixes: a250cd4c1901 ("clk: keystone: syscon-clk: Do not use syscon helper to build regmap")
Cc: stable@vger.kernel.org	# 6.15
Cc: Andrew Davis <afd@ti.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/clk/keystone/syscon-clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/keystone/syscon-clk.c b/drivers/clk/keystone/syscon-clk.c
index c509929da854..ecf180a7949c 100644
--- a/drivers/clk/keystone/syscon-clk.c
+++ b/drivers/clk/keystone/syscon-clk.c
@@ -129,7 +129,7 @@ static int ti_syscon_gate_clk_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	regmap = regmap_init_mmio(dev, base, &ti_syscon_regmap_cfg);
+	regmap = devm_regmap_init_mmio(dev, base, &ti_syscon_regmap_cfg);
 	if (IS_ERR(regmap))
 		return dev_err_probe(dev, PTR_ERR(regmap),
 				     "failed to get regmap\n");
-- 
2.51.2


