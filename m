Return-Path: <stable+bounces-140203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 327C3AAA619
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A442E1A84EDD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5486B31E191;
	Mon,  5 May 2025 22:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYG4CV8y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0008128EA4E;
	Mon,  5 May 2025 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484329; cv=none; b=fhQIclxnFrynTVASSAs1EUo07XQwjGnILll8ZuqcgHSbWUXgq6Dn/oFCPyDs0PCiXtXUqrVMQZmIC5RjWPq867X6Mqhp/AhiNcWcPw4UpSB4AIIVfDFMYWzPuGGpeBDm89tBLi9VSja8mMd2Vs9RFCa5qd2Xd2ncWSgXQ64VXmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484329; c=relaxed/simple;
	bh=mma8tzwZ/NqwWnsXqPq43wQ4tvCGsiw9PyvHomQ17l4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n48lV6OVnoZAwfACKw7DgP9ursm+18wf9edCDefzzfanwDMHAPD0Pq5+xogkP2iJQL5rlJ6sugJp0uKbjDSUCsdT9DoJt07FRJBP5r+zybqP8NEcGi4fgCfRfoeZORfHChnTZti/mx46POftxXSvqwH/rf7lnc9aEitQuoFalnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYG4CV8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8971DC4CEEE;
	Mon,  5 May 2025 22:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484328;
	bh=mma8tzwZ/NqwWnsXqPq43wQ4tvCGsiw9PyvHomQ17l4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JYG4CV8yg2byv9RZHH6b9s4ar4Ogju745AHK4JvJHnvNFOwOCSJxmagvkPL0BeKJd
	 IphkUa/J1A+Jjrj6blAZCghi8d1BPhHBLdXh7jU5j5PbPn0PsSjmbMjPdF9BtU1bi7
	 89pSU+V3JSszCQwQOSGFGo3pBJjKpvX4kpaYIC+UX6UXbdOlvEvMYK/hinNcXKztrI
	 V/NhgexE7xL4sYGGNzp2ap/Uo2xF2Wt6lFaDPJHVt10GwqL43lbAxCsuzq56nfG+tq
	 h/XZH9FA7PrVGNcK+R7fMCcep+w07PA5+RqpsbsOnFFGCmVxyjyDDzq1NEZIjgKbdE
	 F4lv0J+Fn0olA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Yanteng Si <si.yanteng@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Chong Qiao <qiaochong@loongson.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	chenhuacai@kernel.org,
	chenfeiyang@loongson.cn,
	fancer.lancer@gmail.com,
	phasta@kernel.org,
	zhaoqunqin@loongson.cn,
	rmk+kernel@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 456/642] net: stmmac: dwmac-loongson: Set correct {tx,rx}_fifo_size
Date: Mon,  5 May 2025 18:11:12 -0400
Message-Id: <20250505221419.2672473-456-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 8dbf0c7556454b52af91bae305ca71500c31495c ]

Now for dwmac-loongson {tx,rx}_fifo_size are uninitialised, which means
zero. This means dwmac-loongson doesn't support changing MTU because in
stmmac_change_mtu() it requires the fifo size be no less than MTU. Thus,
set the correct tx_fifo_size and rx_fifo_size for it (16KB multiplied by
queue counts).

Here {tx,rx}_fifo_size is initialised with the initial value (also the
maximum value) of {tx,rx}_queues_to_use. So it will keep as 16KB if we
don't change the queue count, and will be larger than 16KB if we change
(decrease) the queue count. However stmmac_change_mtu() still work well
with current logic (MTU cannot be larger than 16KB for stmmac).

Note: the Fixes tag picked here is the oldest commit and key commit of
the dwmac-loongson series "stmmac: Add Loongson platform support".

Acked-by: Yanteng Si <si.yanteng@linux.dev>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Link: https://patch.msgid.link/20250210134328.2755328-1-chenhuacai@loongson.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index ab7c2750c1042..702ea5a00b56d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -590,6 +590,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	if (ret)
 		goto err_disable_device;
 
+	plat->tx_fifo_size = SZ_16K * plat->tx_queues_to_use;
+	plat->rx_fifo_size = SZ_16K * plat->rx_queues_to_use;
+
 	if (dev_of_node(&pdev->dev))
 		ret = loongson_dwmac_dt_config(pdev, plat, &res);
 	else
-- 
2.39.5


