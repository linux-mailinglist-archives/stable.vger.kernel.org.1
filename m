Return-Path: <stable+bounces-47997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B228FCAEB
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 13:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6C70B2406E
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 11:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1712E19415D;
	Wed,  5 Jun 2024 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeZ4UL0+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8D4193078;
	Wed,  5 Jun 2024 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588175; cv=none; b=Vva7jWzs+NApAPKvQeW3Rz1M/y+UbqFjimbQv+3pL74RsYtB1Ty1lcZD7PxhTvMSy3o0Xe9GeyUDv/LrH0yXXIoNSRSMac8vB8hmG4ZebpJxZKgTh3fAsF5bLNjslIyglJ1uDUMAdxrROMCVNvW5xq8HENvT4zFW8LhTfffD/qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588175; c=relaxed/simple;
	bh=dfOEL015ORH+6IM7K8biVLVLo1OBKrxckpzA/YbrmQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIUJYJg6ByaP40Qgc6NrCYztQj8ZWoeB3WSQEpCr5eMxHr2ulaE3wYIOVwKCKlWuBmz1GMsPeJXdoI4Be06xQCgNn7bQKyEU/3cn5PU0mXQs0mjOn6CjkoqY57Xo/ypkxCY4UEl6LaCQle1oEy2EvpyjQrOUI9d5XlCjB5qbjw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeZ4UL0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2B7C32781;
	Wed,  5 Jun 2024 11:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588175;
	bh=dfOEL015ORH+6IM7K8biVLVLo1OBKrxckpzA/YbrmQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MeZ4UL0+pv31wDBY2zRXDV9fnzYtOaqnmFZC4FLIbHDhY8Z1q9R1ZF3s4R5RHG79s
	 7hosjCDCReBpDNWJ/biWE2acstMfIbD1QhxMyXa+tuwKKorSsvuO/bZvzL5jOzaeIa
	 mJrog/9uQT1daJbRqM47+obJP2idFsOK7A5hC++hkX4Bai9E33kzfchjQ4T2sqkEvq
	 RtDZSu35mSywu+ELrfdjkj+1x7pIqEmBjyTLuRv/PKdV9YOQu/QpBTNz7Ybs1NfCPp
	 JOjtqsFsV4Ung+JsV8jzimSYagGZcyupwLMb/dqK6EUPLRTrbdmoXJXfGB1ufcjDtA
	 cEC/pYh9SKzeQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	neil.armstrong@linaro.org,
	quic_kriskura@quicinc.com,
	luca.weiss@fairphone.com,
	robh@kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 04/28] usb: typec: ucsi_glink: rework quirks implementation
Date: Wed,  5 Jun 2024 07:48:33 -0400
Message-ID: <20240605114927.2961639-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605114927.2961639-1-sashal@kernel.org>
References: <20240605114927.2961639-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
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


