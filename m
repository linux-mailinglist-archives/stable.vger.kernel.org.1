Return-Path: <stable+bounces-46216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DDB8CF375
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 11:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A0B28226C
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 09:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C2F537E0;
	Sun, 26 May 2024 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3QNQ2tM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A3712E74;
	Sun, 26 May 2024 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716567; cv=none; b=NWz1RH5E7mP8zV1cnXWX/qlYL1BA2MWO5zmmKjxY5Ymhtgmsb6+UNtFJBKLx0H86oTdVA5K29m7D16NDeKQh1TwfmZPVWLl608k/LPWfCr64F5Mw9RHasBqfDdBVIbptEUv3nZiu2a62LSjK1NB0s83Tnh+bUhcwXtp83KJ11VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716567; c=relaxed/simple;
	bh=qRe2D9mgfqKq4vCqWykSQ53xb+kaDpSjGt8v/D2IG4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pW1eesKr/gBv/HRgEpHYze1GF4Ld9aVqMWXOnReBMQmEWgos9EaTVXtRWrg8U/+lodJvj++cUFl3cZ4TkZ9/k+a9ZsHupvpNp5soEusGDYm+CWJNitzhc7qREntpeEEzy/3PqF22tX8cqyTBJDHm3oxv7tY/oEbSwKr5PYPpFrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3QNQ2tM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E00FC32782;
	Sun, 26 May 2024 09:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716567;
	bh=qRe2D9mgfqKq4vCqWykSQ53xb+kaDpSjGt8v/D2IG4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a3QNQ2tMbNUw5f+CFL69oeZmdF2Y1FdBNtPXRDItfhbNkRZ20jVZmjs4MuqOrFYJm
	 gxkxvoHMN6JjU02Hf2kyxtbPnRYYJ6C0JRZ3sKnEuFcVS5vjMoLaMw4JkeGXGQvsHY
	 XqJ4Z9HveKc4SzHn+/DUdxaypSZauvJQ6rCe6+v6cP/lvripskClLVe8TVkePzAt/1
	 tPbF2m87NBPjlRWjxdOgqUcHA0c7x1ypCoXtxDnKRL3PDsmu9oLIb2k6+kLFvUhJOZ
	 IIuC6iGACrJgCda3F+/EwmXnxdxNQfl5DFDbmqu/GRo4n7jGx6mRxUxhXEiN5xBQbW
	 tbLW1/qxpnSkg==
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
Subject: [PATCH AUTOSEL 6.8 13/14] arm64: defconfig: select INTERCONNECT_QCOM_SM6115 as built-in
Date: Sun, 26 May 2024 05:42:18 -0400
Message-ID: <20240526094224.3412675-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526094224.3412675-1-sashal@kernel.org>
References: <20240526094224.3412675-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.10
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
index e6cf3e5d63c30..f13e930a7cf25 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1559,6 +1559,7 @@ CONFIG_INTERCONNECT_QCOM_SC8180X=y
 CONFIG_INTERCONNECT_QCOM_SC8280XP=y
 CONFIG_INTERCONNECT_QCOM_SDM845=y
 CONFIG_INTERCONNECT_QCOM_SDX75=y
+CONFIG_INTERCONNECT_QCOM_SM6115=y
 CONFIG_INTERCONNECT_QCOM_SM8150=m
 CONFIG_INTERCONNECT_QCOM_SM8250=m
 CONFIG_INTERCONNECT_QCOM_SM8350=m
-- 
2.43.0


