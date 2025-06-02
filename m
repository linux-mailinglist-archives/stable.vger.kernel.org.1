Return-Path: <stable+bounces-149241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 897BFACB1BE
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277651941E02
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2A222FE11;
	Mon,  2 Jun 2025 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DN3PuDGM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84A622FDEE;
	Mon,  2 Jun 2025 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873352; cv=none; b=utPlzBGnmKd23lgi/RUux+g9w9Ke/whz95HUDo4MSbeK6990QGjsOg6ANM+bzcFeWFbSw1Z1FjPrPYdt1gj0Pi/GGj9N65lF6S/DLXG2tpwTkUkZQF2tSYNicfv4z5po4Wu1QWzDDT6xXcPoH+3yu9F+DxYUFQggkHn9x4Mb5Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873352; c=relaxed/simple;
	bh=E3hgb3nU4efIuV40sqryKbWcIk9RS+MfdmZJyJfouKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4Hmvhe2Y5P64W3LT7SFg0tGVk8Sngp82v5+ELqIFPXUboEI7hSI01WRi+KzaYsnjfR8kjFYaijPHET/qeDwwf6Wrbg5PNpH7ojp274/keyRHNH8hxFKNKmJG9fNpdeZtFHaDGgDJh+PCfF0lbUKbst0jPSkCkTM+DMvnrRvh/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DN3PuDGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A61C4CEEB;
	Mon,  2 Jun 2025 14:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748873351;
	bh=E3hgb3nU4efIuV40sqryKbWcIk9RS+MfdmZJyJfouKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DN3PuDGMeM/nukxJsT3RWlOluQzGQ4C1GmJ1NOkSgJNytGx26cij0TLqCAd0mcp+D
	 9Uq+CR1QpRr4r84+bO02FlisxZUhEmCw95bjGfhOcWL0aStDmK4TD6TPNqj2W7g7iQ
	 Oc3ZJN00RKf1fY2Z47uhA4pRG3RscPpXGapW91Uc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vitalii Mordan <mordan@ispras.ru>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 074/444] i2c: pxa: fix call balance of i2c->clk handling routines
Date: Mon,  2 Jun 2025 15:42:18 +0200
Message-ID: <20250602134343.916166940@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
References: <20250602134340.906731340@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitalii Mordan <mordan@ispras.ru>

[ Upstream commit be7113d2e2a6f20cbee99c98d261a1fd6fd7b549 ]

If the clock i2c->clk was not enabled in i2c_pxa_probe(), it should not be
disabled in any path.

Found by Linux Verification Center (linuxtesting.org) with Klever.

Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20250212172803.1422136-1-mordan@ispras.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-pxa.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 3bd406470940f..affdd94f06aaf 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1504,7 +1504,10 @@ static int i2c_pxa_probe(struct platform_device *dev)
 				i2c->adap.name);
 	}
 
-	clk_prepare_enable(i2c->clk);
+	ret = clk_prepare_enable(i2c->clk);
+	if (ret)
+		return dev_err_probe(&dev->dev, ret,
+				     "failed to enable clock\n");
 
 	if (i2c->use_pio) {
 		i2c->adap.algo = &i2c_pxa_pio_algorithm;
-- 
2.39.5




