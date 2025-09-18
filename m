Return-Path: <stable+bounces-180392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC839B7FA93
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 16:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5271F189D5DF
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CB332E729;
	Wed, 17 Sep 2025 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtkRFSIm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546D31C6FFA
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117309; cv=none; b=Y7twNd0Dw6CPmZyO4lHqQ/44VokbfBhEpULawQZ8ejhO2zh7XN+AWhuIdMwtOl8GNvM29xm6XvnFOZ8hI7zLnb4zgePBtVdUcyPutwUIB/cEj4Qku5v7pxfkXAWuazPcYehVcdb7df6OfRWhB+bWst1/CnzKarUQruY+lAn8GWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117309; c=relaxed/simple;
	bh=+fsEiaB/+64UX2R3atClirU9bNKipMlpKUNX3g8FRP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aN27rU/OnZYMMTtQFF74uQRVKQXugUURDL7/PPtuHAEWLqgVqUAcOraSliHuaRP4sHbl35TTBOsdD1ZGYmKs202WpAGVPzoExmWqho9U6QArs1rhnkKRMcG6EJlXgpaR+cwJJCUtx1a6p91URSPnomc+dWsHFj29p7h8X7wRkus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtkRFSIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4CBC4CEF0;
	Wed, 17 Sep 2025 13:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758117308;
	bh=+fsEiaB/+64UX2R3atClirU9bNKipMlpKUNX3g8FRP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YtkRFSIm5ae4OmYH32VfrGHRPAOfJMDSrA6GuNdnrhROdTHDwSAWsIy4bnnh7nuSQ
	 8AvnYe6vQJ1uDYahXtkGGo8uX+aEHhdbb8Jm53KKDYEgCu4doW3U2uznzdoPEmIySO
	 xRSBwoUBUz/EqHQuVe6E0SNz2FVgNOI4o2OkvXk7vi0W3VzGx8An2mxqjIYaynuNWa
	 ZS3QK92ACkN8xFM+OhHrY9BGofnu2rnLpf4UE5nZwpVCN/6MljuqWoNcDB+Oew3Nra
	 J1a6bBflIOZnOugrmK0aH/jiO2CuFAeqtBk3ZLA6KRYa+5GRlgCh4jSNWIYfZa50KU
	 3s6C/suXXuOrg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/6] phy: broadcom: ns-usb3: fix Wvoid-pointer-to-enum-cast warning
Date: Wed, 17 Sep 2025 09:55:00 -0400
Message-ID: <20250917135502.565547-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917135502.565547-1-sashal@kernel.org>
References: <2025091752-daycare-art-9e78@gregkh>
 <20250917135502.565547-1-sashal@kernel.org>
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
index eb10ffa13a62e..3b017f20d1742 100644
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


