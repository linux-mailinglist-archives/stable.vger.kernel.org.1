Return-Path: <stable+bounces-180380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B23B7F730
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1282540306
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27751233140;
	Wed, 17 Sep 2025 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T907qn/u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5D6307AE5
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 13:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115974; cv=none; b=FLUSgAUY1fQmfFe79Ni0kP7fshtRknBjKzg56KQkDQ6wam7eZEhQ5d20Lsaxd7DcjsFfxmkYVVLMN+QB9d5P7HJKaBdyjSPy1sdbN6uwf6ZMAhWm2hSAkKF8G7StE0vdnTKlPIchJUDN6JPZ9EXiJnD6/b/C7dqOJjaDBEVDbcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115974; c=relaxed/simple;
	bh=apgMw0rUKXeVH0Ffy8gNef8Wx51RRe82T0jwj6yQvcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QF5eccRgLmlXUqMLGcNqpoDYP1lPnHOn4/vRfFkzge8bD0wXhedKXH2qopggw0ZBexcDq2MeAfJNX8iWgZMU73HdteR9mXkKIJ7lOYu+hrXf1zTTupQKgDXYSMmczrbBErnkm0/5aq5E7yuRWVNr4o6BA0fdBYmntDltSl2J1/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T907qn/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE29C4CEF0;
	Wed, 17 Sep 2025 13:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758115974;
	bh=apgMw0rUKXeVH0Ffy8gNef8Wx51RRe82T0jwj6yQvcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T907qn/uHgYT/01cubfL1+/ar57ZWDk0WK2YUh9QOtnSHbfYtjj0Q6kyKvdLvt5pb
	 pWD/kVUWSJUzGKKZ2uAO17YIpjpZoaueOX3JoH68btrd9L31Afc3rSuqO4R/XpozAJ
	 KZFOztl6/LuRr6FsLzr2JFRcnIVlb4ombUGDumPf8DA+cAsNQf+PdrDpxL72OQq9wp
	 YAHlDELtSpHuh8qjz5BBMsBbvoT95FFRbDFhKIei/sN8lCWiNRQzRqJg5nhlFRdzm3
	 0V98e8TbJrb9acHmnhcxVZU+Uv6MIQCS5oS+8zzpGX0QlQkGX1dbIgqqy2gWigFUtC
	 th5yGLfJGD/ig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] phy: broadcom: ns-usb3: fix Wvoid-pointer-to-enum-cast warning
Date: Wed, 17 Sep 2025 09:32:50 -0400
Message-ID: <20250917133252.552245-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091751-nuzzle-jolt-dcac@gregkh>
References: <2025091751-nuzzle-jolt-dcac@gregkh>
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
index b1adaecc26f84..6eb4c173e1f36 100644
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


