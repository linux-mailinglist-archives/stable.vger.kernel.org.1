Return-Path: <stable+bounces-198420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A02CEC9FA64
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 16:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A90613026299
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 15:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14A830C37A;
	Wed,  3 Dec 2025 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PgGJo4uQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD62303A3D;
	Wed,  3 Dec 2025 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776484; cv=none; b=OfsYtlMK6bIHAO8YOQLw4vl8DZyIgWnQ9L9SisLD0lq8jiGCD1wFwWQVr782jhBUfew7S7kfLXRXOs2THFmER+Ks9QIgRo4K6RmDiuJcrxExEE3fB3LQA2IflvELtzYtxCiHiILfBJNi2gh8YMH8lFjmJBm2C2K723Y6wK9cr0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776484; c=relaxed/simple;
	bh=SshqYvR+kx/Xj8RwkbOJOvVRgO9cqki6lW6WaOmWmmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a85LXSLYvD5c0R/qBmEBKaW86rdZV2x3xR9YypJ4OZfD+x+7AFlq+zfZBESKsNau7HQagH9eII/wOIBhLUXxXDxHsRRMfWNUES4EM6OkbktfaTgcSCkQN3dl8b51hoKC3YTOt/QRfdo/vpYFZ5xCtwEHAbs2NXcEE0az0w1q2yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PgGJo4uQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FC3C4CEF5;
	Wed,  3 Dec 2025 15:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764776484;
	bh=SshqYvR+kx/Xj8RwkbOJOvVRgO9cqki6lW6WaOmWmmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PgGJo4uQv3Dgp0ok34q5JD6tpnAhH11fZO5HnNBKHfiMJTzyBchUAEo8syaFCz/2U
	 X2oy1tjV30DH0Jnzp9uyu6wK6YXY8+CKuuf0DlNfbUWKM8pfuI0aiLsxwBZdb1XhZo
	 SqTiO0Tklkd05G24c2Qz4sIDnRrvkVsWQJ0XhM/E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 196/300] regulator: fixed: fix GPIO descriptor leak on register failure
Date: Wed,  3 Dec 2025 16:26:40 +0100
Message-ID: <20251203152407.887464838@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152400.447697997@linuxfoundation.org>
References: <20251203152400.447697997@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haotian Zhang <vulab@iscas.ac.cn>

[ Upstream commit 636f4618b1cd96f6b5a2b8c7c4f665c8533ecf13 ]

In the commit referenced by the Fixes tag,
devm_gpiod_get_optional() was replaced by manual
GPIO management, relying on the regulator core to release the
GPIO descriptor. However, this approach does not account for the
error path: when regulator registration fails, the core never
takes over the GPIO, resulting in a resource leak.

Add gpiod_put() before returning on regulator registration failure.

Fixes: 5e6f3ae5c13b ("regulator: fixed: Let core handle GPIO descriptor")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20251028172828.625-1-vulab@iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/fixed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 49e162b3cf42d..1503a5ea0cc89 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -241,6 +241,7 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 		ret = dev_err_probe(&pdev->dev, PTR_ERR(drvdata->dev),
 				    "Failed to register regulator: %ld\n",
 				    PTR_ERR(drvdata->dev));
+		gpiod_put(cfg.ena_gpiod);
 		return ret;
 	}
 
-- 
2.51.0




