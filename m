Return-Path: <stable+bounces-48024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BCD8FCB5A
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 13:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109111F244C9
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 11:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB03195FE1;
	Wed,  5 Jun 2024 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKiItUdE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AF2191462;
	Wed,  5 Jun 2024 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588268; cv=none; b=iFcflL+7tT7UfYeenxh2NXrh7X0i92Jr7FFA182Q2ywFfTxmzgVHvmpVPb9sQJjVlHVLKcyo8fyjXi1IRcSPN0mF+F+tIwL1g6hc6corzeR7tRfCEr9Mu1xJAm+WGrZLAsrwx3WUDzxW3t0zNO7lq5mnVayz/IOlYN2hzGgrRgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588268; c=relaxed/simple;
	bh=dfOEL015ORH+6IM7K8biVLVLo1OBKrxckpzA/YbrmQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3gMpHM5nFrpbXsD4yM/NwPDSGKjiGAQ3MD2qHL6icqJfMjWqI1YKtXLfBLwmuoETRIky+ZcJaTO6qsiLnHTvfFSi6pfRYcqxB5a8Y9BCqXbyPv24UoX+w4w7oZUuRKvOP1WG+bJhK4Rkn8SWDSP88AtQsn/rl/ATQrGJggMh8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKiItUdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D65C32781;
	Wed,  5 Jun 2024 11:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588268;
	bh=dfOEL015ORH+6IM7K8biVLVLo1OBKrxckpzA/YbrmQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LKiItUdEAY7h1eEgnv0ws+LqzhqqHteYN3YUj/OsFX9x8dTRGU/rF//GH97CoaaJG
	 2Rlf1CVC4hniTHJvhV53L+tjmy1szc1ftuDxwJ0CsTX714N/ba3r4G0A3CIBhgimTK
	 oCBfZHBK2t5NJ8aoX1LHCnCm3QADiaBECb4UA2EuhqwhNo2WoJSV6h8ojDn2fewKQm
	 tglrGedy9I7NC7Ju1JHGDLteRmRf9lbLXWOb8wWd9RCRqwRUCey9osDsGbYDCMPe7d
	 H6g1nKhpRlFaRhcZ/SqRZJA0TmIvuTgGtUwB3RZLjMjS0Sc+nAIXJcdqQFeIa7/+qT
	 J1optcrq4I6Wg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	neil.armstrong@linaro.org,
	johan+linaro@kernel.org,
	robh@kernel.org,
	quic_kriskura@quicinc.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 03/24] usb: typec: ucsi_glink: rework quirks implementation
Date: Wed,  5 Jun 2024 07:50:13 -0400
Message-ID: <20240605115101.2962372-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115101.2962372-1-sashal@kernel.org>
References: <20240605115101.2962372-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.12
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 3f81cf54c1889eeecbb8d9188f5f2f597622170e ]

In preparation to adding more quirks, extract quirks to the static
variables and reference them through match->data. Otherwise adding
more quirks will add the table really cumbersome.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20240329-qcom-ucsi-fixes-v2-8-0f5d37ed04db@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index ce08eb33e5bec..0e6f837f6c31b 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -311,12 +311,14 @@ static void pmic_glink_ucsi_destroy(void *data)
 	mutex_unlock(&ucsi->lock);
 }
 
+static unsigned long quirk_sc8180x = UCSI_NO_PARTNER_PDOS;
+
 static const struct of_device_id pmic_glink_ucsi_of_quirks[] = {
-	{ .compatible = "qcom,qcm6490-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
-	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
-	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
-	{ .compatible = "qcom,sm8350-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
-	{ .compatible = "qcom,sm8550-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
+	{ .compatible = "qcom,qcm6490-pmic-glink", .data = &quirk_sc8180x, },
+	{ .compatible = "qcom,sc8180x-pmic-glink", .data = &quirk_sc8180x, },
+	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = &quirk_sc8180x, },
+	{ .compatible = "qcom,sm8350-pmic-glink", .data = &quirk_sc8180x, },
+	{ .compatible = "qcom,sm8550-pmic-glink", .data = &quirk_sc8180x, },
 	{}
 };
 
@@ -354,7 +356,7 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
 
 	match = of_match_device(pmic_glink_ucsi_of_quirks, dev->parent);
 	if (match)
-		ucsi->ucsi->quirks = (unsigned long)match->data;
+		ucsi->ucsi->quirks = *(unsigned long *)match->data;
 
 	ucsi_set_drvdata(ucsi->ucsi, ucsi);
 
-- 
2.43.0


