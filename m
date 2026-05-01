Return-Path: <stable+bounces-242426-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHqYL0eo9GkbDQIAu9opvQ
	(envelope-from <stable+bounces-242426-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 15:19:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 690504AC9EA
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 15:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6444630089BF
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 13:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7FA355F35;
	Fri,  1 May 2026 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LozZSXGs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FA6285072
	for <stable@vger.kernel.org>; Fri,  1 May 2026 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777641540; cv=none; b=sos+8DorwUcTJAMq+sS0imnTwDUkfyArg22F/tkQGYJ9fY9ch0eLZh2nIa9cGo8fWPF8mOAuDXnuq9Ef6vzL4K9JALHosleqddMObs1/yq2hNqElyOV5skMoedusRZ57meGdVxCGS6y9SlB4FuOlbcCRexOAzpomrrfA2PckteM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777641540; c=relaxed/simple;
	bh=p47eQOiLjEYJnkJpsjgabXWThQjkxRbY63B9AUUNHuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWoi2bEr36zzwbHLWpUpmeTFtnTvtF6cWNuv2ev0cZ/VhnEVcZpw5/kLZGRCKpq1vmLEKU4GmCjPMfMxFEdZ4MS+vpZM6sXQhI9G7t0jMLGy9Thcf92juBRkklJBtQSYE0bIr33wQrb17EMDMCZrqdI2pbx5h5byRvZM81Ovdpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LozZSXGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC083C2BCB4;
	Fri,  1 May 2026 13:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777641540;
	bh=p47eQOiLjEYJnkJpsjgabXWThQjkxRbY63B9AUUNHuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LozZSXGsDqpu0A4xuJ0hE5dqWdHPdtAmQkd/XWaHSLPpoVI5K9FjQfmYbDP/sE17A
	 7oXmGKJfC1QQLTSbWFBkvmTKsQi1e+Ns63R0RUa0visu32MiTz2WzB+O8SxcVlTujk
	 O8sjjUGWobfsPVvBOeZXxeJ3ymP+5mACf1dCKbmhBgzrRDIUbWqwVkAaZ/+XC+dcrl
	 wccEM801xmr80F/FyYJuPpqM7J1byTD+0Fy28qV5wG7+ybARMPy5Uo2ygj8c4CO/pZ
	 BI4nKByaXQwFHkzIEhQiD0d6p8xKzkxLOJg61oAiYCGK5x7ULeI2exWVME/CErlwdN
	 frJ7NZom/09/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ronak Raheja <ronak.raheja@oss.qualcomm.com>,
	Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] phy: qcom: m31-eusb2: Update init sequence to set PHY_ENABLE
Date: Fri,  1 May 2026 09:18:55 -0400
Message-ID: <20260501131857.3242270-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050131-exfoliate-garter-519b@gregkh>
References: <2026050131-exfoliate-garter-519b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 690504AC9EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242426-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,linaro.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]

From: Ronak Raheja <ronak.raheja@oss.qualcomm.com>

[ Upstream commit 7044ed6749c8a7d49e67b2f07f42da2f29d26be6 ]

Certain platforms may not have the PHY_ENABLE bit set on power on reset.
Update the current sequence to explicitly write to enable the PHY_ENABLE
bit.  This ensures that regardless of the platform, the PHY is properly
enabled.

Signed-off-by: Ronak Raheja <ronak.raheja@oss.qualcomm.com>
Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patch.msgid.link/20250920032158.242725-1-wesley.cheng@oss.qualcomm.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: 520a98bdf7ae ("phy: qcom: m31-eusb2: clear PLL_EN during init")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-m31-eusb2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c b/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
index 0a0d2d9fc8464..95cd3175926d5 100644
--- a/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
@@ -25,6 +25,7 @@
 #define POR				BIT(1)
 
 #define USB_PHY_HS_PHY_CTRL_COMMON0	(0x54)
+#define PHY_ENABLE			BIT(0)
 #define SIDDQ_SEL			BIT(1)
 #define SIDDQ				BIT(2)
 #define FSEL				GENMASK(6, 4)
@@ -81,6 +82,7 @@ struct m31_eusb2_priv_data {
 static const struct m31_phy_tbl_entry m31_eusb2_setup_tbl[] = {
 	M31_EUSB_PHY_INIT_CFG(USB_PHY_CFG0, UTMI_PHY_CMN_CTRL_OVERRIDE_EN, 1),
 	M31_EUSB_PHY_INIT_CFG(USB_PHY_UTMI_CTRL5, POR, 1),
+	M31_EUSB_PHY_INIT_CFG(USB_PHY_HS_PHY_CTRL_COMMON0, PHY_ENABLE, 1),
 	M31_EUSB_PHY_INIT_CFG(USB_PHY_CFG1, PLL_EN, 1),
 	M31_EUSB_PHY_INIT_CFG(USB_PHY_FSEL_SEL, FSEL_SEL, 1),
 };
-- 
2.53.0


