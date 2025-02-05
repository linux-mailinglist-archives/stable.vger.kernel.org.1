Return-Path: <stable+bounces-112880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8C6A28EDA
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9E216035F
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1655282EE;
	Wed,  5 Feb 2025 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZluwrUU2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F69D1519A4;
	Wed,  5 Feb 2025 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738765066; cv=none; b=JfsOa4sWg10J4D1H9k+SI7GK8quHfdUeYCt199YWkoDIkXZid+cCnZWKg2HvPGRXyF7SWx4Uor25OZWWfhZNuve+s4U1fMp971e58KG1iUIi6XmuwQKybEnw9kzGubtmv836NNzLwYc50Lg7zyz2Gg+nWWs/Tkas0WkgkngIi+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738765066; c=relaxed/simple;
	bh=mxAdCT/x+XP2DmZwh0TIHvIxT441AHoCWfMtfpL3Ogc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3VMaxHXXSNkAN0aAIyRGsx989ny7K9eZ4t8U/qGdl+vKTpnvCwrSLZgpblrTGF+oeA1c+ytdZ3ch2tiJEDy7QZuOeoyNV9ldBfPgJJzHUXU3Xn1Qcr/hkPf7XkwyoSZbRIKdHStXmBW1pza5Me0rjNdFl2FWdtMv9D4y2AHwD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZluwrUU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23110C4CED1;
	Wed,  5 Feb 2025 14:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738765066;
	bh=mxAdCT/x+XP2DmZwh0TIHvIxT441AHoCWfMtfpL3Ogc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZluwrUU29sBaCWn+26uGFpcrx39Ibqmh4zVsimNK+l/FJ4N6STJKiX0KX45sKU4QP
	 vQZ8YEFESjuaU7ZE8IBOAgh5OePS0TEo6Cwdz2VRChI9UpY3rWEcgbLcNwR6FGWFGd
	 LXYWS9sPh8kqYWimicca40wU8PFAOKjlR4njAZ80=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shazad Hussain <quic_shazhuss@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 229/393] arm64: dts: qcom: sa8775p-ride: enable pmm8654au_0_pon_resin
Date: Wed,  5 Feb 2025 14:42:28 +0100
Message-ID: <20250205134429.067459954@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
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

From: Shazad Hussain <quic_shazhuss@quicinc.com>

[ Upstream commit 81c8ec77b86fde629d5beea1ebe42caeea57c5a4 ]

The volume down key is controlled by PMIC via the PON hardware on
sa8775p platform, so enable the same for sa8775p-ride.

Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
Link: https://lore.kernel.org/r/20231107120503.28917-1-quic_shazhuss@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Stable-dep-of: 30f7dfd2c489 ("arm64: dts: qcom: sa8775p: Update sleep_clk frequency")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 9760bb4b468c4..26ad05bd3b3ff 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -461,6 +461,11 @@
 			  "ANALOG_PON_OPT";
 };
 
+&pmm8654au_0_pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
 &pmm8654au_1_gpios {
 	gpio-line-names = "PMIC_C_ID0",
 			  "PMIC_C_ID1",
-- 
2.39.5




