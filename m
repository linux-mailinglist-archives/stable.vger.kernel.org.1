Return-Path: <stable+bounces-81384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA00299340E
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 18:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B27A1F2289D
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 16:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C6F1DC064;
	Mon,  7 Oct 2024 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CQjyGIZv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AE11DBB34
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319853; cv=none; b=MdlCV2iizGEjAe4t72B/OHG2l/Uhte65iJPBd1SRP9V9BbAkTdY/FTYuHWPP9gLEBU7Q6F5Rn2TCc5PbpTDIQlnX4+8a505636uW/DgVZf56YeMX9H+Vuk8ZuR+AuTlnxylBYUzWaaunaGPZVly7K0RMrMtrKOLwIt9UfuMhvlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319853; c=relaxed/simple;
	bh=Z0AwmrCbxfAjfcg6NrXbSReEhbL5MvM6M0O0XOPFvG0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=h4e/UYkY3TfXyJZcumOziTdSRGRgI2EGJZpyM3LiPv65lHUJq0dCSEKap/c0vQGaXbiiGWQ1QtTdfURETKna9Hqhww6GFNINvCpZxEwhqDBKLVEdxA5tLh77ATLWeEsUBoJARyr9Qe1QuSich5eFkvBntV7r87+PUwwlyYyqj3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CQjyGIZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5EEC4CEC7;
	Mon,  7 Oct 2024 16:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728319853;
	bh=Z0AwmrCbxfAjfcg6NrXbSReEhbL5MvM6M0O0XOPFvG0=;
	h=Subject:To:Cc:From:Date:From;
	b=CQjyGIZvOp8DeaLA4kQlZTG95lvF1zy9+V/UITaNfIOqYJWYvOJB74IkJRBbZs+wG
	 j1j8lw3IbJBgXKX1tBTLt3ZlaYd19Mo3FFagiPKpMq4R8SZs0diEhithJMMqFP17jt
	 1dJPC4DUE3iSZ2jyKMdCB4nYPSwS1FB/TbTgk2rI=
Subject: FAILED: patch "[PATCH] dt-bindings: clock: qcom: Add GPLL9 support on gcc-sc8180x" failed to apply to 6.1-stable tree
To: quic_skakitap@quicinc.com,andersson@kernel.org,krzysztof.kozlowski@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 18:50:41 +0200
Message-ID: <2024100741-garlic-spectacle-6ff4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 648b4bde0aca2980ebc0b90cdfbb80d222370c3d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100741-garlic-spectacle-6ff4@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

648b4bde0aca ("dt-bindings: clock: qcom: Add GPLL9 support on gcc-sc8180x")
26447dad8119 ("dt-bindings: clock: qcom: Add missing UFS QREF clocks")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 648b4bde0aca2980ebc0b90cdfbb80d222370c3d Mon Sep 17 00:00:00 2001
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Mon, 12 Aug 2024 10:43:02 +0530
Subject: [PATCH] dt-bindings: clock: qcom: Add GPLL9 support on gcc-sc8180x

Add the missing GPLL9 which is required for the gcc sdcc2 clock.

Fixes: 0fadcdfdcf57 ("dt-bindings: clock: Add SC8180x GCC binding")
Cc: stable@vger.kernel.org
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Link: https://lore.kernel.org/r/20240812-gcc-sc8180x-fixes-v2-2-8b3eaa5fb856@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/include/dt-bindings/clock/qcom,gcc-sc8180x.h b/include/dt-bindings/clock/qcom,gcc-sc8180x.h
index 487b12c19db5..e364006aa6ea 100644
--- a/include/dt-bindings/clock/qcom,gcc-sc8180x.h
+++ b/include/dt-bindings/clock/qcom,gcc-sc8180x.h
@@ -248,6 +248,7 @@
 #define GCC_USB3_SEC_CLKREF_CLK					238
 #define GCC_UFS_MEM_CLKREF_EN					239
 #define GCC_UFS_CARD_CLKREF_EN					240
+#define GPLL9							241
 
 #define GCC_EMAC_BCR						0
 #define GCC_GPU_BCR						1


