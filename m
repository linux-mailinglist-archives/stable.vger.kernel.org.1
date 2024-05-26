Return-Path: <stable+bounces-46202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C071F8CF350
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 11:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6306DB224EE
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 09:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8882B9C5;
	Sun, 26 May 2024 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lky8T/+M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64C7C8DD;
	Sun, 26 May 2024 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716537; cv=none; b=t7ZLBS1SA6+z7ygG1izWHSqLVKF/kp+1gMbnHpA1jVhkH/aI+d0t2JPPXX5n6NeEGTewUfFeNEKP8yfBbXcVTuz/tgvGvOGVjhrSVkMhV42zEIwXxcaKGkVntP4Dzcy8tHt7Xsh371FhEkiRJfeAQ4NvLlUD3GaY4ed4Gr2aDIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716537; c=relaxed/simple;
	bh=Iy1s+KC0uSkjFUYaCy3sPwcLnyzHW1lN1IrwxGEiB1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKcrMaHz3HqPVJtsmMTD72QddPIKiip9b/Az967qC3Kef3OxyiceQJbU2Hh09ntueEXs1IVYzsju4LU0d7CE2NrNCyBLB2FPMGSWxeA092XoCJR4wyfYqQTpa1tLcTdX3dXt3S1oERc0jA7YeVX4IwnvgiJl90z5jVVVJvJjQPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lky8T/+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E53C2BD10;
	Sun, 26 May 2024 09:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716537;
	bh=Iy1s+KC0uSkjFUYaCy3sPwcLnyzHW1lN1IrwxGEiB1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lky8T/+MbPgbwMw/iIwkpgVus3TCC8UbZ4/Di3Xj9QXKklTawdaNvuO3+02bideqN
	 kJuBBF9s+8u6EwcL56RhL2Y96M+gIafCPdmozrl4qLT2zLHhWcT5apJs3m+iqJXojS
	 WH2OKuhkOAcYhqdOmhY6VV0jkmHty9VpqJNLRd3f9bvNbqM0JP0gGq3QZf5hQ2UgIk
	 oDV37ss3X+lHB6YCQnBfbVFM7nUU8P4GgKGuBPW3QsEKvP0QY6AIYujfS7X+/b8pNN
	 hajjbc8wdveDMDCrfyKHGC62GMrA3pT200gOM8NywFbqHh3Ey1raO5aQjX2ftMAJJt
	 c6Dxfm+I2NDLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	catalin.marinas@arm.com,
	will@kernel.org,
	quic_bjorande@quicinc.com,
	krzysztof.kozlowski@linaro.org,
	geert+renesas@glider.be,
	konrad.dybcio@linaro.org,
	shawnguo@kernel.org,
	neil.armstrong@linaro.org,
	biju.das.jz@bp.renesas.com,
	arnd@arndb.de,
	m.szyprowski@samsung.com,
	nfraprado@collabora.com,
	u-kumar1@ti.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.9 14/15] arm64: defconfig: select INTERCONNECT_QCOM_SM6115 as built-in
Date: Sun, 26 May 2024 05:41:46 -0400
Message-ID: <20240526094152.3412316-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526094152.3412316-1-sashal@kernel.org>
References: <20240526094152.3412316-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.1
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit b052c7fe3cb787282ab7e1fa088c794a1eb7fdb0 ]

Enable CONFIG_INTERCONNECT_QCOM_SM6115 as built-in to enable the
interconnect driver for the SoC used on Qualcomm Robotics RB2 board.
Building as built-in is required as on this platform interconnects are
required to bring up the console.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20240424-enable-sm6115-icc-v3-1-21c83be48f0e@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2c30d617e1802..8d39b863251b2 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1585,6 +1585,7 @@ CONFIG_INTERCONNECT_QCOM_SC8180X=y
 CONFIG_INTERCONNECT_QCOM_SC8280XP=y
 CONFIG_INTERCONNECT_QCOM_SDM845=y
 CONFIG_INTERCONNECT_QCOM_SDX75=y
+CONFIG_INTERCONNECT_QCOM_SM6115=y
 CONFIG_INTERCONNECT_QCOM_SM8150=m
 CONFIG_INTERCONNECT_QCOM_SM8250=y
 CONFIG_INTERCONNECT_QCOM_SM8350=m
-- 
2.43.0


