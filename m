Return-Path: <stable+bounces-153218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CECADD31E
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AADD16587B
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ACD2DFF32;
	Tue, 17 Jun 2025 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nNG8AO+e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57312DFF2C;
	Tue, 17 Jun 2025 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175254; cv=none; b=qT3nJfijufBgXL9wykAf/0R2ZPw2y5cIOSRNCKSDE1QNFLHH3dEZ+2g1lnt5LEEOwUvkEWiC0Ibqhwb/BjDxWf47ctGkgoQazitkU8cnPxPuTRMn842GUmnnPpc0Z+8VeqV/bLzQyWTcx0ubS6DXws2x3eGS36N3HgWYdaNctks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175254; c=relaxed/simple;
	bh=HviFDJSEjr96H49vcTrowhU2XWxGDm+Redp5d1CCyds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jj4NTemMmV0CZmIH/Gu/DT00qRjIxgt9MUy/GRutBqMPE6g4GK+Wo030j6FOWoxuObYn9LwXeYS2hxWTpkN8D0l7lLgIX3ggVJ9q1NtOtnD3+kU54GQNnI5kSa3ONoX15+JUtwT7qwWIHXGmzBr0xoqvrN3y2QQ+E0OXSQ/9yR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nNG8AO+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27821C4CEE3;
	Tue, 17 Jun 2025 15:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750175254;
	bh=HviFDJSEjr96H49vcTrowhU2XWxGDm+Redp5d1CCyds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nNG8AO+e9WIyVmWY90As7IqIwX6cDFMIDid2eTG2wA18Jvhb1cyBVk8P3xDoF7OZh
	 p0i37L6fW5ZkZSmYQYlMtwTR9ynbRj+g9eW5BoL5Hu9gGl1+XPO/hEiwabCuiHYvJe
	 6CBZs9kf8coCSp46+/KrfbEESlZVSM+7+CuDYqno=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 067/780] power: supply: max77705: Fix workqueue error handling in probe
Date: Tue, 17 Jun 2025 17:16:15 +0200
Message-ID: <20250617152454.233190200@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 11741b8e382d34b13277497ab91123d8b0b5c2db ]

The create_singlethread_workqueue() doesn't return error pointers, it
returns NULL.  Also cleanup the workqueue on the error paths.

Fixes: a6a494c8e3ce ("power: supply: max77705: Add charger driver for Maxim 77705")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/547656e3-4a5f-4f2e-802b-4edcb7c576b0@stanley.mountain
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/max77705_charger.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index eec5e9ef795ef..329b430d0e506 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -545,20 +545,28 @@ static int max77705_charger_probe(struct i2c_client *i2c)
 		return dev_err_probe(dev, ret, "failed to add irq chip\n");
 
 	chg->wqueue = create_singlethread_workqueue(dev_name(dev));
-	if (IS_ERR(chg->wqueue))
-		return dev_err_probe(dev, PTR_ERR(chg->wqueue), "failed to create workqueue\n");
+	if (!chg->wqueue)
+		return dev_err_probe(dev, -ENOMEM, "failed to create workqueue\n");
 
 	ret = devm_work_autocancel(dev, &chg->chgin_work, max77705_chgin_isr_work);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to initialize interrupt work\n");
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to initialize interrupt work\n");
+		goto destroy_wq;
+	}
 
 	max77705_charger_initialize(chg);
 
 	ret = max77705_charger_enable(chg);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to enable charge\n");
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to enable charge\n");
+		goto destroy_wq;
+	}
 
 	return devm_add_action_or_reset(dev, max77705_charger_disable, chg);
+
+destroy_wq:
+	destroy_workqueue(chg->wqueue);
+	return ret;
 }
 
 static const struct of_device_id max77705_charger_of_match[] = {
-- 
2.39.5




