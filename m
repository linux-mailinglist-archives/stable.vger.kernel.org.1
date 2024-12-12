Return-Path: <stable+bounces-102682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A69B9EF30F
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8AB32905D3
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C714723A593;
	Thu, 12 Dec 2024 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VXzYKoK7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BEA1F2381;
	Thu, 12 Dec 2024 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022110; cv=none; b=gayPZZqkfGHbhqWkBsfN9Zkx72zYinsLMO7oJ9XuGMiW1vW8nqy2XO2hQxUsF1dv3dsr2XUzopSeIFy4fxX2MgzvUJJ1SRr8m+VRe1HSvqwrbOMI0L2Isjz7I8gzr9Pl1C2XD9Z/3xL2VkI/LHqyAEwAU+88dsz0ke4A8KWJvR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022110; c=relaxed/simple;
	bh=T93IiUiNXVdtTUYTbtnLLBaBYtnBrSIoiQEHvyo3f5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JD8ALud7y422Q6strLsriIHbTrG1zNLXseohbh51oqqjU+yEZ7ufTIj7uo3guSaQflPhP63ALsoRhHa8hjFrVVIhA/qVIDppl7J2vsvkRHiCjXTiOh5ghQWCkSVQE9/hDBzDylywxllqtdzmmkjvu4EaWRmNlIcqc4HAXKF6Hms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VXzYKoK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA78C4CECE;
	Thu, 12 Dec 2024 16:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734022110;
	bh=T93IiUiNXVdtTUYTbtnLLBaBYtnBrSIoiQEHvyo3f5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VXzYKoK739FCBVCyuESblebL8rwcVqzXgNGIhgtejPluRPpVvwAviHHh4zjC9mIqD
	 kDm+b+2TClMwDp+GQegAeYdQgerIQdfmsgNMIJtm8LSjw3paioVdql4J/aExeKfQPB
	 esBiU6hNDwwnMblExS4Fvu8+bdavRAvtaJeEV8Ww=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daolong Zhu <jg_daolongzhu@mediatek.corp-partner.google.com>,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 123/565] arm64: dts: mt8183: Damu: add i2c2s i2c-scl-internal-delay-ns
Date: Thu, 12 Dec 2024 15:55:18 +0100
Message-ID: <20241212144316.347873994@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daolong Zhu <jg_daolongzhu@mediatek.corp-partner.google.com>

[ Upstream commit 6ff2d45f2121c698a57c959ae21885a048615908 ]

Add i2c2's i2c-scl-internal-delay-ns.

Fixes: cabc71b08eb5 ("arm64: dts: mt8183: Add kukui-jacuzzi-damu board")
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Daolong Zhu <jg_daolongzhu@mediatek.corp-partner.google.com>
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
Link: https://lore.kernel.org/r/20241025-i2c-delay-v2-4-9be1bcaf35e0@chromium.org
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
index 42ba9c00866cd..8e0cba4d23726 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
@@ -29,3 +29,6 @@ &qca_wifi {
 	qcom,ath10k-calibration-variant = "GO_DAMU";
 };
 
+&i2c2 {
+	i2c-scl-internal-delay-ns = <20000>;
+};
-- 
2.43.0




