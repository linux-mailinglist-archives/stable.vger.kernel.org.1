Return-Path: <stable+bounces-153326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFDAADD3F5
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17A2194522D
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0692A2EE5E3;
	Tue, 17 Jun 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mi1SG5fZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86B62ED870;
	Tue, 17 Jun 2025 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175587; cv=none; b=HNda72GXVhmplZdAZ2sNl772WfBFomeRcMnZXCGsJ4iamTIDPYw3z18+YUBqs0BBimc5dlr2wo1r7JKL6+jaUYdOo89m5+qyV6MsMzx8i4eVrwM1C6BgECH31E++l1bTuVRV8maBH1WdHRyKO+VMWw9lX/Y3LYu90m6Wey2VfdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175587; c=relaxed/simple;
	bh=bFm647MVY5sPqUgFZZHAzqI0QPqezOmKEvrem7brkFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3Nej3OzMhjbFd/xYLWV5Agi5X4bkrsaiSt8bXgbbpCbqHkTZ0YrxEwjcB3+852h7JS73NSF6n8Fw3jiu2f6X/s3xOXVP2qyBW89bBsaHEjavPwkZ+/WZZXMhyYlwN/uw4wgi4hJaFhvJum7lOMsJUIpiD9ymAx5xSpG2XwbfPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mi1SG5fZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296E6C4CEF0;
	Tue, 17 Jun 2025 15:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750175587;
	bh=bFm647MVY5sPqUgFZZHAzqI0QPqezOmKEvrem7brkFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mi1SG5fZgIJgJ6toth9llCCwKQ6EOB1y/Z1hCiHMUtbR7GfsEnby5uuagbCSthziR
	 6yQ6lOkyl0bJjq9f+kRS2/QNvC+Kt9ekN2lshnkq2gEleHqz3TboBgJMaovkcM7zha
	 6bf11sg8T1Zl9WI1l2SxNTdv4j88wDraMVXwOLqc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Julien Massot <julien.massot@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 191/356] arm64: dts: mt6359: Rename RTC node to match binding expectations
Date: Tue, 17 Jun 2025 17:25:06 +0200
Message-ID: <20250617152345.898179993@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
References: <20250617152338.212798615@linuxfoundation.org>
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

From: Julien Massot <julien.massot@collabora.com>

[ Upstream commit cfe035d8662cfbd6edff9bd89c4b516bbb34c350 ]

Rename the node 'mt6359rtc' to 'rtc', as required by the binding.

Fix the following dtb-check error:

mediatek/mt8395-radxa-nio-12l.dtb: pmic: 'mt6359rtc' do not match
any of the regexes: 'pinctrl-[0-9]+'

Fixes: 3b7d143be4b7 ("arm64: dts: mt6359: add PMIC MT6359 related nodes")
Signed-off-by: Julien Massot <julien.massot@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20250514-mt8395-dtb-errors-v2-3-d67b9077c59a@collabora.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt6359.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6359.dtsi b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
index 57af3e7899841..779d6dfb55c00 100644
--- a/arch/arm64/boot/dts/mediatek/mt6359.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
@@ -298,7 +298,7 @@
 			};
 		};
 
-		mt6359rtc: mt6359rtc {
+		mt6359rtc: rtc {
 			compatible = "mediatek,mt6358-rtc";
 		};
 	};
-- 
2.39.5




