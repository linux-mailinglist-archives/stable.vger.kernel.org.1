Return-Path: <stable+bounces-168463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDCDB2351F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302DA1883CCE
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9AB2FDC55;
	Tue, 12 Aug 2025 18:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FQg14SVA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB9E2FD1A4;
	Tue, 12 Aug 2025 18:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024256; cv=none; b=IYCNwEmHJgv9Zh7pOWnCgFYd/fXGtTGBI3fvsvNYXUFLSmHRXZo6xbPdeFLvTsGRiqqXlx6nSZusLW5PDOTtiTNR+YBeZDwLo5ckDJqecGMowXD8mLCO37STrlJYyiW3jx4TyhshV76wxa6uHAqNjmRgaEc2QRANacK6Jzz4YuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024256; c=relaxed/simple;
	bh=jEPDOZtwiULrZd0gymXpe7DWfYjbDu1sCquWF83or/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SS8GtFv8FMgXBLBaZwSaci+bOhsG05sJLJg555pGhkcS48QgtGW6qrUAbJWJT+udQqWgz0kPsaQfKoQr9yHxRv+9KrDbXdl6XL0asvKLzz9yD7RoSZyo+wfbY97MEEQ7cMUXak35jp0LvnwsFwbWFWjqjVwFUCtt5+ehhC0NSVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FQg14SVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B5CC4CEF0;
	Tue, 12 Aug 2025 18:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755024255;
	bh=jEPDOZtwiULrZd0gymXpe7DWfYjbDu1sCquWF83or/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FQg14SVAPIGxaYaVkFqNjumxTWRZ/M2YjjEKCw8a3bnCZk5A2sYnNRaGlbqXYaO3U
	 c7/PLOgjqBfd0w07qK/fnGZnPD0WHZoDJQ1TfWP8Dngtq2AONV0cNNQa/lDeez/6aS
	 iy5IZT7FEisk6HHRX3V3Ecy+BOtrOHLi+414eXtM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Casey Connolly <casey.connolly@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 320/627] power: supply: qcom_pmi8998_charger: fix wakeirq
Date: Tue, 12 Aug 2025 19:30:15 +0200
Message-ID: <20250812173431.474031386@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Casey Connolly <casey.connolly@linaro.org>

[ Upstream commit 6c5393771c50fac30f08dfb6d2f65f4f2cfeb8c7 ]

Unloading and reloading the driver (e.g. when built as a module)
currently leads to errors trying to enable wake IRQ since it's already
enabled.

Use devm to manage this for us so it correctly gets disabled when
removing the driver.

Additionally, call device_init_wakeup() so that charger attach/remove
will trigger a wakeup by default.

Fixes: 8648aeb5d7b7 ("power: supply: add Qualcomm PMI8998 SMB2 Charger driver")
Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20250619-smb2-smb5-support-v1-3-ac5dec51b6e1@linaro.org
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/qcom_pmi8998_charger.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_pmi8998_charger.c b/drivers/power/supply/qcom_pmi8998_charger.c
index c2f8f2e24398..cd3cb473c70d 100644
--- a/drivers/power/supply/qcom_pmi8998_charger.c
+++ b/drivers/power/supply/qcom_pmi8998_charger.c
@@ -1016,7 +1016,9 @@ static int smb2_probe(struct platform_device *pdev)
 	if (rc < 0)
 		return rc;
 
-	rc = dev_pm_set_wake_irq(chip->dev, chip->cable_irq);
+	devm_device_init_wakeup(chip->dev);
+
+	rc = devm_pm_set_wake_irq(chip->dev, chip->cable_irq);
 	if (rc < 0)
 		return dev_err_probe(chip->dev, rc, "Couldn't set wake irq\n");
 
-- 
2.39.5




