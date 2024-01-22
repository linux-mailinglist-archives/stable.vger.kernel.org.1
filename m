Return-Path: <stable+bounces-13145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CA6837AAE
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4A91C24B10
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0434F130E2B;
	Tue, 23 Jan 2024 00:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wug8pJ4R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30D412FF86;
	Tue, 23 Jan 2024 00:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969050; cv=none; b=ud8slfM+38R2CW/Wv5GAA6dy7Gjz/8D/czPAfZVQKJXHFDKA6hm8/bUkaF3R0mwe5L5EJ1ujm7iMNGsoBqNHi4nZI4zCgLOBN4Z5EdnolPCgse4jUkMogUfEIMh+R5D2nOBdhGm4OfG2xFl5X4ao0DQlAce6+Jcpf/iPf5bLB9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969050; c=relaxed/simple;
	bh=uiLA4hmYfLuAVFvtUaXa7SK5n98JDh/y9/1hO5jEdlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rSHY7xM1Um+hfOzT3MhuGxKS202cA5dd0x53+A7yRikZqq6IIXTXxpMi9Fw3vHgHO9V18T045c2vOkb3Mo1kJ+4WxAIjEdDaZSJHnD9itKYMyLOOfRcPBgikuC3quktupxMVI1FuRqsHohVSiEMud1BwWND7iw1t/3JWFlZeJaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wug8pJ4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB5EC433F1;
	Tue, 23 Jan 2024 00:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969050;
	bh=uiLA4hmYfLuAVFvtUaXa7SK5n98JDh/y9/1hO5jEdlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wug8pJ4R6OmofRSWTthxApmf0w80hsYfnYFxpXgaLne3IdW3RtGjHMDpIupNp3pSm
	 UtcZylItaDhByVb4fFAksgzoCtljxdlnd6vF0qInQeLdjz1xzxnKLdXjV35RQvd4x5
	 0lE1dINx2hJF3BcQ/ttiWjvAZsCnVcTF9MN/iLj4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 181/194] PCI: keystone: Fix race condition when initializing PHYs
Date: Mon, 22 Jan 2024 15:58:31 -0800
Message-ID: <20240122235726.993379163@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235719.206965081@linuxfoundation.org>
References: <20240122235719.206965081@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Siddharth Vadapalli <s-vadapalli@ti.com>

[ Upstream commit c12ca110c613a81cb0f0099019c839d078cd0f38 ]

The PCI driver invokes the PHY APIs using the ks_pcie_enable_phy()
function. The PHY in this case is the Serdes. It is possible that the
PCI instance is configured for two lane operation across two different
Serdes instances, using one lane of each Serdes.

In such a configuration, if the reference clock for one Serdes is
provided by the other Serdes, it results in a race condition. After the
Serdes providing the reference clock is initialized by the PCI driver by
invoking its PHY APIs, it is not guaranteed that this Serdes remains
powered on long enough for the PHY APIs based initialization of the
dependent Serdes. In such cases, the PLL of the dependent Serdes fails
to lock due to the absence of the reference clock from the former Serdes
which has been powered off by the PM Core.

Fix this by obtaining reference to the PHYs before invoking the PHY
initialization APIs and releasing reference after the initialization is
complete.

Link: https://lore.kernel.org/linux-pci/20230927041845.1222080-1-s-vadapalli@ti.com
Fixes: 49229238ab47 ("PCI: keystone: Cleanup PHY handling")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Acked-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-keystone.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 920444b1cfc7..b18ddb2b9ef8 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1305,7 +1305,16 @@ static int ks_pcie_probe(struct platform_device *pdev)
 		goto err_link;
 	}
 
+	/* Obtain references to the PHYs */
+	for (i = 0; i < num_lanes; i++)
+		phy_pm_runtime_get_sync(ks_pcie->phy[i]);
+
 	ret = ks_pcie_enable_phy(ks_pcie);
+
+	/* Release references to the PHYs */
+	for (i = 0; i < num_lanes; i++)
+		phy_pm_runtime_put_sync(ks_pcie->phy[i]);
+
 	if (ret) {
 		dev_err(dev, "failed to enable phy\n");
 		goto err_link;
-- 
2.43.0




