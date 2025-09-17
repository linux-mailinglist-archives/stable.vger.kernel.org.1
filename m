Return-Path: <stable+bounces-180375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7FAB7F634
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9F532600B
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009302FBE0E;
	Wed, 17 Sep 2025 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTwhzm6V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96E62FBDE5
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115793; cv=none; b=jLPMmRPjk46vDYJN9tz38XfkQAL1dPwUtLzBQS4aLegLDyOkJlskDq1qEk3O83Jvie76QTqxljnF6581OFeKGKlN1Clu1fWUlbdCSnyy9pcrJCdtXXGGHv0PFYgtlgPKtA+HBWJBV8R5PldwNAbfHPyOeEIkcjW/JPqRmvQZC9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115793; c=relaxed/simple;
	bh=9/mRxEkwQKf26havym0D41BoxyhJs2oFwS7bg1hj8Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W79ypJJo8eFhcvDoH9D34noRxfk3Lljdz9HMWeq77QqfaunAPLtg/NliYxAFZjxeRm7hewdljfB8vDdF+IO1BBRkJCk1g6yBSigm+FfM1sYYfB9dqLHuCpsyKYUDCfsYdNj4FiWKMu4JpK3d+/WDqiMsC/zqqU23x5jnSs5LPAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTwhzm6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8428C4CEF0;
	Wed, 17 Sep 2025 13:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758115793;
	bh=9/mRxEkwQKf26havym0D41BoxyhJs2oFwS7bg1hj8Es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iTwhzm6V8ol6I4UhTu4Bqg+wq97GjUpmfRG5IVlXh+reyPV8z0S80b1o/0FpG0Ag1
	 qzAQfCeQXbub2pF+7t3WnloVKERFIrhvnAuJ7AkmAQ/zl/yOR2Bhjq+dUgEaxxY35e
	 NvtD6WqpD+o7qL+ZnQlpdU5NbluBR6Vq2Ja37EbStyI+4GC7xEX2iIgaTGHpXnwKwo
	 X1AScl72u5pfR4HQ4TNQ08X4H00IQChCExtwdfYf5otaAlP/E268zFBQZT20lWJ8oc
	 Nu2+WQtgKLsw09KIWwej9owpWfvH9mt8/twAlH5y/RqFUA80vEgkV/J16UiusQBvoI
	 wr+pQX/buCEbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] phy: broadcom: ns-usb3: fix Wvoid-pointer-to-enum-cast warning
Date: Wed, 17 Sep 2025 09:29:49 -0400
Message-ID: <20250917132951.550844-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091751-geometry-screen-8bd7@gregkh>
References: <2025091751-geometry-screen-8bd7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit bd6e74a2f0a0c76dda8e44d26f9b91a797586c3b ]

'family' is an enum, thus cast of pointer on 64-bit compile test with
W=1 causes:

  drivers/phy/broadcom/phy-bcm-ns-usb3.c:209:17: error: cast to smaller integer type 'enum bcm_ns_family' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230810111958.205705-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: 64961557efa1 ("phy: ti: omap-usb2: fix device leak at unbind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/broadcom/phy-bcm-ns-usb3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/broadcom/phy-bcm-ns-usb3.c b/drivers/phy/broadcom/phy-bcm-ns-usb3.c
index bbfad209c890f..69584b685edbb 100644
--- a/drivers/phy/broadcom/phy-bcm-ns-usb3.c
+++ b/drivers/phy/broadcom/phy-bcm-ns-usb3.c
@@ -206,7 +206,7 @@ static int bcm_ns_usb3_mdio_probe(struct mdio_device *mdiodev)
 	of_id = of_match_device(bcm_ns_usb3_id_table, dev);
 	if (!of_id)
 		return -EINVAL;
-	usb3->family = (enum bcm_ns_family)of_id->data;
+	usb3->family = (uintptr_t)of_id->data;
 
 	syscon_np = of_parse_phandle(dev->of_node, "usb3-dmp-syscon", 0);
 	err = of_address_to_resource(syscon_np, 0, &res);
-- 
2.51.0


