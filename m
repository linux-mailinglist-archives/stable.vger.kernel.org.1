Return-Path: <stable+bounces-157794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42081AE5596
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2FB77AF391
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16411225A38;
	Mon, 23 Jun 2025 22:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ws9pU7Fk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6101C2E0;
	Mon, 23 Jun 2025 22:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716737; cv=none; b=tVE4FtF7SxTQH+5Qm8rEWQQfPrOrN1+CCo9k9JclfDhfQqynmC+LGc7FZePQyiUnV0lAn8D/vTNG/oxcq8qtV+5VCCFuBR7ihIXRPqkaU8xi2+qfLajgkpkbkaR5MncrDfQuCTwXH0qT8jBO4EiwZ6bWjSWxSa7h/8gr4eOM0EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716737; c=relaxed/simple;
	bh=ukjj3l98DALCm6y+MvEtaTyhRZ0uC/kvh/4baZl36QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRkgdyZmAyEhNG7VjulROM9z8QvPulsuln6CxUYv6HCzMdszS2NneBn2U3EC7GoGWwl+pmAOXE/sJxo7E3X0vc8Zz9BLVSxL0TzQprEQCZ/9OgzpQDkF4UdqcR6VlwRrZNuV4w3XkFbfN5l6hkc5B80L+wYP+j3YNKbU/ebrWX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ws9pU7Fk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B1FC4CEEA;
	Mon, 23 Jun 2025 22:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750716737;
	bh=ukjj3l98DALCm6y+MvEtaTyhRZ0uC/kvh/4baZl36QI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ws9pU7Fk/KtFbyrs4PXk/0fPOaYGvoICZZegS5MFiEwzEuw/f1P7TA5WF3XRwckfn
	 DLIIQKcaHxjFnW9T6WifmRj7mNkJ0Qyr9JpZD80YnR5zYAc1JsLOd4WXERtjeHAFeH
	 sDOz0N7/4BRoxP8kvfE7l3MpEWsV2LYrNfkKnCNI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Thompson <davthompson@nvidia.com>,
	Asmaa Mnebhi <asmaa@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 551/592] mlxbf_gige: return EPROBE_DEFER if PHY IRQ is not available
Date: Mon, 23 Jun 2025 15:08:29 +0200
Message-ID: <20250623130713.551324692@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
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

From: David Thompson <davthompson@nvidia.com>

[ Upstream commit e7ea5f5b1858ddb96b152584d5fe06e6fc623e89 ]

The message "Error getting PHY irq. Use polling instead"
is emitted when the mlxbf_gige driver is loaded by the
kernel before the associated gpio-mlxbf driver, and thus
the call to get the PHY IRQ fails since it is not yet
available. The driver probe() must return -EPROBE_DEFER
if acpi_dev_gpio_irq_get_by() returns the same.

Fixes: 6c2a6ddca763 ("net: mellanox: mlxbf_gige: Replace non-standard interrupt handling")
Signed-off-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250618135902.346-1-davthompson@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index fb2e5b844c150..d76d7a945899c 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -447,8 +447,10 @@ static int mlxbf_gige_probe(struct platform_device *pdev)
 	priv->llu_plu_irq = platform_get_irq(pdev, MLXBF_GIGE_LLU_PLU_INTR_IDX);
 
 	phy_irq = acpi_dev_gpio_irq_get_by(ACPI_COMPANION(&pdev->dev), "phy", 0);
-	if (phy_irq < 0) {
-		dev_err(&pdev->dev, "Error getting PHY irq. Use polling instead");
+	if (phy_irq == -EPROBE_DEFER) {
+		err = -EPROBE_DEFER;
+		goto out;
+	} else if (phy_irq < 0) {
 		phy_irq = PHY_POLL;
 	}
 
-- 
2.39.5




