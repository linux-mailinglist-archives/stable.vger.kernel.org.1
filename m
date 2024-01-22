Return-Path: <stable+bounces-13358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7CC837BED
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73602B21A9E
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CACD153BCC;
	Tue, 23 Jan 2024 00:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vKMmC3y+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BEE15351C;
	Tue, 23 Jan 2024 00:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969370; cv=none; b=Ku6LNsYYVrQGul/9rEHHPSOwpNM/Ojfq9Y19j8V5TgW0L5kYb0r6t7ovF/CcboWotVHkexhfDCvtyhsgZxeSGz0ENexzvCbv2w3CASNjq4n1omiv8RPDBH71yUzqzT4w5ACOlggC9tbTqeQ7mA+9dWKpKrd9ai70XV/2r7Qc/Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969370; c=relaxed/simple;
	bh=AUOdGRLDJt2cP+RMcck7TjLBx+mQhn64EVOmaslhw1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnPq1YWNPJnvI2sgXaZEugvVU3WSbtEPYueVBdJP8IxQdum10vwvIyEXLzmruAjbBNLoEsDTjqgx80eL/2WqUpI3DFE659VBAu05ApBZOmyctHgxqFxOOsW3bbOtbNkPSrJQ3jVZqJg0iXgZbZbebs5gN4q7bFTnOyOdI36d7+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vKMmC3y+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C9EC43394;
	Tue, 23 Jan 2024 00:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969369;
	bh=AUOdGRLDJt2cP+RMcck7TjLBx+mQhn64EVOmaslhw1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vKMmC3y+01J00gdvB19G950LaaxIrhmw08zlBvtgfuXRO1svzT/IROLCvUuuyfykk
	 Mu0+TsYXD3Z55N0UPlzMCvhOpJI9Q9WZjy5RmEeisqnnLVM3TjMS/VrSKAtRdrg6F6
	 fKa/wPXob4KU/c15HBj1n4q0wVzir8+Iko2tZ12g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 201/641] arm64: dts: qcom: ipq6018: fix clock rates for GCC_USB0_MOCK_UTMI_CLK
Date: Mon, 22 Jan 2024 15:51:45 -0800
Message-ID: <20240122235824.249156857@linuxfoundation.org>
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

From: Chukun Pan <amadeus@jmu.edu.cn>

[ Upstream commit 5c0dbe8b058436ad5daecb19c60869f832607ea3 ]

The downstream QSDK kernel [1] and GCC_USB1_MOCK_UTMI_CLK are both 24MHz.
Adjust GCC_USB0_MOCK_UTMI_CLK to 24MHz to avoid the following error:

clk: couldn't set gcc_usb0_mock_utmi_clk clk rate to 20000000 (-22), current rate: 24000000

1. https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/commit/486c8485f59

Fixes: 5726079cd486 ("arm64: dts: ipq6018: Use reference clock to set dwc3 period")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
Link: https://lore.kernel.org/r/20231218150805.1228160-1-amadeus@jmu.edu.cn
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index e59b9df96c7e..0b1330b521df 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -557,7 +557,7 @@ usb3: usb@8af8800 {
 					  <&gcc GCC_USB0_MOCK_UTMI_CLK>;
 			assigned-clock-rates = <133330000>,
 					       <133330000>,
-					       <20000000>;
+					       <24000000>;
 
 			resets = <&gcc GCC_USB0_BCR>;
 			status = "disabled";
-- 
2.43.0




