Return-Path: <stable+bounces-13277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB4A837BAD
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CD5AB2C352
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B7014AD0C;
	Tue, 23 Jan 2024 00:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vpW+kLNA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC1F14A4FA;
	Tue, 23 Jan 2024 00:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969240; cv=none; b=ZlbhiJLVwtF1lGa0SOzyvnQTewaFiC7C0UEX0J5HXw3bk8b/xoXb1J36ED5CcyHU+rtTPa+juRlvJ9xFfQdAYlw3qof5HbgPBVMEK+muKkcyN23I4X4r21nZOCiplit+qH009eOhDQH0viP/mVjBbkdxwjKa6k6q3e02JEGOA/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969240; c=relaxed/simple;
	bh=Bf+R0A9VsRIsBDDiukmGNhR1ajhjZMwVNDRZ2Ff1Ft4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTHXh37eyq68cY2whsUC6kTveERUVowaV7NCwOlVXUhopA9+3XBQHokpKvU7hoagt9gt+f6/egueBkunOaIAuREmWbiCkKO7Zj6Ex0qNO+SiSLtEu/pxECB5fd8Et4Mpdm9NhUCjU1f2tORn/J5rv1s8dlsDHx6DcRGVF7mLl5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vpW+kLNA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88483C433F1;
	Tue, 23 Jan 2024 00:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969239;
	bh=Bf+R0A9VsRIsBDDiukmGNhR1ajhjZMwVNDRZ2Ff1Ft4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vpW+kLNAIRuAf76fXJlKI7xKf6bLEmls2XaX3qIK2c0ayA/lZJL7LiDPJgfduHhBl
	 fdPVROpQb4jCrRzI3d+fBL8v9klAxT9+fo41jFskH8muUUVxjUTz8OASRApUT5ehay
	 wBAJANNuoB8c0l2hTm/7AJnbJnAPaP4fRIQ4KZ60=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 120/641] arm64: dts: qcom: sc8180x-primus: Fix HALL_INT polarity
Date: Mon, 22 Jan 2024 15:50:24 -0800
Message-ID: <20240122235821.808704390@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Andersson <quic_bjorande@quicinc.com>

[ Upstream commit 1aaa08e8de365cce59203541cafadb5053b1ec1a ]

The hall sensor interrupt on the Primus is active low, which means that
with the current configuration the device attempts to suspend when the
LID is open.

Fix the polarity of the HALL_INT GPIO to avoid this.

Fixes: 2ce38cc1e8fe ("arm64: dts: qcom: sc8180x: Introduce Primus")
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20231130-sc8180x-primus-lid-polarity-v1-1-da917b59604b@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
index fd2fab4895b3..a40ef23a2a4f 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
@@ -43,7 +43,7 @@ gpio-keys {
 		pinctrl-0 = <&hall_int_active_state>;
 
 		lid-switch {
-			gpios = <&tlmm 121 GPIO_ACTIVE_HIGH>;
+			gpios = <&tlmm 121 GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_SW>;
 			linux,code = <SW_LID>;
 			wakeup-source;
-- 
2.43.0




