Return-Path: <stable+bounces-97823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7DD9E2628
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987701676AA
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647961F75B9;
	Tue,  3 Dec 2024 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BT9T6ik/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D041DE8A5;
	Tue,  3 Dec 2024 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241850; cv=none; b=uBahPX+J28Qr+QDq5KYgPIO7KIJaMVGloQLMtZbcVHZY6LW7fQ0hUfwfmr5PoH52OTryWjlVdfzYhnLR8meAdwvKU3/0UW8E237FhK7579ATFgXr3D5fqDuwLNDbaW0TK0Dn+F+d9I4GUCozfT5VdhmIgmJZeGGZpHf5wWAMejI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241850; c=relaxed/simple;
	bh=IyCbXifK4y6avAZeQJ+LEAQKjNq2+PVs6SddhaBaVD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UpS2pKSeO9uVpcbDZ3R6bqyGKG+Ec5+EqpaPVacVPQhk416SM/q0v1JzMMrbBzfR8mTRUL8wpeF8JRRBmngJmSE436aKYUsJTARRqktruGi8fxnckvwBKUEXLPSr1E6C3kLOCNZQXiAR8XtQpd1yF+L3Po3ny0caWMvV/w/9ezI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BT9T6ik/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E37C4CECF;
	Tue,  3 Dec 2024 16:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733241850;
	bh=IyCbXifK4y6avAZeQJ+LEAQKjNq2+PVs6SddhaBaVD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BT9T6ik/II42H7ffOhHpdVkITzn4/Mzkm+Qaml/7v4liBFNexMK5uccB+MPDwBY0l
	 YvVpq2ONs1VYjtg6zQo3BogdWaxKjLQ60XH/3NiTusTu+VDqkxTf2eJI4/QDB/dryv
	 2MEeAVb1S4W18lGzJB4pdD/Tf9zvUABE7O0Ja9uc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 535/826] phy: airoha: Fix REG_CSR_2L_PLL_CMN_RESERVE0 config in airoha_pcie_phy_init_clk_out()
Date: Tue,  3 Dec 2024 15:44:22 +0100
Message-ID: <20241203144804.625055278@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 09a19fb75498985cbb598f1fa43a7d2416925c30 ]

Fix typo configuring REG_CSR_2L_PLL_CMN_RESERVE0 register in
airoha_pcie_phy_init_clk_out routine.

Fixes: d7d2818b9383 ("phy: airoha: Add PCIe PHY driver for EN7581 SoC.")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://lore.kernel.org/r/20240918-airoha-en7581-phy-fixes-v1-1-8291729a87f8@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/phy-airoha-pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-airoha-pcie.c b/drivers/phy/phy-airoha-pcie.c
index 1e410eb410580..4624aa9dd7127 100644
--- a/drivers/phy/phy-airoha-pcie.c
+++ b/drivers/phy/phy-airoha-pcie.c
@@ -459,7 +459,7 @@ static void airoha_pcie_phy_init_clk_out(struct airoha_pcie_phy *pcie_phy)
 	airoha_phy_csr_2l_clear_bits(pcie_phy, REG_CSR_2L_CLKTX1_OFFSET,
 				     CSR_2L_PXP_CLKTX1_SR);
 	airoha_phy_csr_2l_update_field(pcie_phy, REG_CSR_2L_PLL_CMN_RESERVE0,
-				       CSR_2L_PXP_PLL_RESERVE_MASK, 0xdd);
+				       CSR_2L_PXP_PLL_RESERVE_MASK, 0xd0d);
 }
 
 static void airoha_pcie_phy_init_csr_2l(struct airoha_pcie_phy *pcie_phy)
-- 
2.43.0




