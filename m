Return-Path: <stable+bounces-162358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB05B05D52
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912841C2144B
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF5D2E4249;
	Tue, 15 Jul 2025 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tpYb5QKe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4671B0F23;
	Tue, 15 Jul 2025 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586346; cv=none; b=Llq1AQjFQ/8sxARJ6XN1PocphLVshS1pRzVaFhlszH3cSYx68dREETf/jARNpueZOW6Bx1D4oE7ezPDZwrCebdCGpMzkcqsXxUY5uDIVyj05FaVAFZg53LtS1AGxGXtCv5ZVqGwrSu4kKA58vnBS//lwdk1vi/jkEtOmCpjhrfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586346; c=relaxed/simple;
	bh=pfe4+yVwtOarYy+CXljrx7dC71XQ88mMhv9P+KDCjpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0XLQ6iLl3bR4FBJeK8K6jODOeYtE8GTeQPmsYgBRBTdfzJGS+WrT1/6Iw+4sVNxKkWisA5WntPgwHnBGUUwKWZac6Mvpj4fAJu8R1cvT2ZbI0v4CL3MkkhYgB3rSN1WDoBjauA+nUxQ3CfGDI8WtsZoF8DPUCqg3tMGyJU8kBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tpYb5QKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783BFC4CEE3;
	Tue, 15 Jul 2025 13:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586345;
	bh=pfe4+yVwtOarYy+CXljrx7dC71XQ88mMhv9P+KDCjpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tpYb5QKem/lMAR8E/X2VtGGUcGOZotLUFR1dqlPnR/jGF0KXEiRuVB5SdIsD4YoaC
	 kZihOMpNboIsd1PBYQVbTnvMdq8BqISY+6/Ziut3Kb0ubFccYf3rlx/gj0hQhUCAmR
	 OvkpBpa1Cns9hcoJV59x2sgDAYr847GP3dX+kE0E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 003/148] mfd: max14577: Fix wakeup source leaks on device unbind
Date: Tue, 15 Jul 2025 15:12:05 +0200
Message-ID: <20250715130800.436486471@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130800.293690950@linuxfoundation.org>
References: <20250715130800.293690950@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit d905d06e64b0eb3da43af6186c132f5282197998 ]

Device can be unbound, so driver must also release memory for the wakeup
source.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20250406-mfd-device-wakekup-leak-v1-3-318e14bdba0a@linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/max14577.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
index fd8864cafd25c..4d87b429a7bad 100644
--- a/drivers/mfd/max14577.c
+++ b/drivers/mfd/max14577.c
@@ -467,6 +467,7 @@ static int max14577_i2c_remove(struct i2c_client *i2c)
 {
 	struct max14577 *max14577 = i2c_get_clientdata(i2c);
 
+	device_init_wakeup(max14577->dev, false);
 	mfd_remove_devices(max14577->dev);
 	regmap_del_irq_chip(max14577->irq, max14577->irq_data);
 	if (max14577->dev_type == MAXIM_DEVICE_TYPE_MAX77836)
-- 
2.39.5




