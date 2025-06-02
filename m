Return-Path: <stable+bounces-150078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E084ACB73C
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C122A23C9A
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE08233134;
	Mon,  2 Jun 2025 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KlJaL1Ai"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC80E22F14C;
	Mon,  2 Jun 2025 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875964; cv=none; b=RZYRuXsjv20FaocF14Wv86hHPhZHqPlDV3+PnoIrEPERTp45Mn9Q3hn4AQIwOZC1ol+6PLz2vtu+giDcNyMsZNqzffkjFZQcjPc92B8tB9+nG8KyI0ketH1qQzd3A4sTFnqvkJF+A2YlrpBAqvn/aMwnq5rcBBxGWWv0wB5RT6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875964; c=relaxed/simple;
	bh=dxIngcH18gH7e4ZqazC9xmuiSu11A7gumHkpSzMCH/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBfXqj4peNRDmTZk9dybW6MIH2CTFJBqxMkShDOaVtRdvvSUW/9/lLYumzr/DnGfbD6VUC+WsJtprbZIclYezdpYBrit9Ccw7su+8KCC/+VFX61UoQ3CYOcjhOvXGfnWsfScK4ttBM+DkB+sdwaLKfjIHPxot8AYws/iukwGOWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KlJaL1Ai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFAFC4CEEB;
	Mon,  2 Jun 2025 14:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748875963;
	bh=dxIngcH18gH7e4ZqazC9xmuiSu11A7gumHkpSzMCH/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KlJaL1AiOiPMMPXSQrGPxGWAfEVky7kiHgjqUitDNeTtUhHq2GqrBkBcHMQ6m4Em6
	 LCzVtT82Wmml2cnFK1pLweJAswm+SNaQ30nORmwKLsr0RycKdUu+YmbUMJlCmkqUyv
	 aRAch2qBsg7zG6HZWisrsFJQ8BBklS+azAH3XiMQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vitalii Mordan <mordan@ispras.ru>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 029/207] i2c: pxa: fix call balance of i2c->clk handling routines
Date: Mon,  2 Jun 2025 15:46:41 +0200
Message-ID: <20250602134259.908755100@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134258.769974467@linuxfoundation.org>
References: <20250602134258.769974467@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 35ca2c02c9b9b..7fdc7f213b114 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1508,7 +1508,10 @@ static int i2c_pxa_probe(struct platform_device *dev)
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




