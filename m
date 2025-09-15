Return-Path: <stable+bounces-179615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC87B578E7
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 13:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F92F1A22159
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 11:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E7A2FE060;
	Mon, 15 Sep 2025 11:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Uv9pjGXI"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E8A2FD7D3;
	Mon, 15 Sep 2025 11:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936822; cv=none; b=QQZ5noEJAFt8shdT6ErQH8jlua098t8gTA3MXmF9dV14uYNGblmBFFosz7BbmfeJfL4ymOnl8beHANHaQBQfR7JAORgNNXRJC4/JHg2//F4WJeV9erGtHhuG1t96W7Qe0YM1/zEQql7LAxYMaDNZUwfDDlFfda3K4/2233MUsjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936822; c=relaxed/simple;
	bh=YH1lYv37rvuaCIt3LkdDU2QwLfCom7OlCQhnjTrSLaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VEeHkUMpCK2Vjh/pizfvGUcT6Ts3aKN+ey54bcsrGEQMDc4lILiL5P6F11QM7YHdpI9NgRJ89zkLqQOxr3RCUoQ+9OqXrkp1iVd7usBzhrj57GzrFyGbyBlot1qtnuuVO+E+Esqi0/y1cKQtJThktaYDM5/S8Am4qMIwKGPxaJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Uv9pjGXI; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=g7
	bBZ08Y30YBsmASg69y6dlkae34XywuX+RyAixm0dw=; b=Uv9pjGXIfw6UMFCeeb
	EnxoUMEgtn/DY1qMT70OwSudd4X4Z+5NciXB5gJ/EOAS2oMrNiLtO3tr0HssMl9F
	a1ZU1aJoub1DSeWasHglvtxlfhVhQc+Bhy+irzCK7LjVfm9R0Aqtt1rMVoJZQD7c
	ERGLzvZOnLNH717HkflvjNZ04=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAnhAuW_Mdoi3VIDA--.37972S4;
	Mon, 15 Sep 2025 19:46:31 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: pdeschrijver@nvidia.com,
	pgaikwad@nvidia.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	linmq006@gmail.com
Cc: linux-clk@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] clk: tegra: tegra124-emc: Fix a reference leak in emc_ensure_emc_driver()
Date: Mon, 15 Sep 2025 19:46:29 +0800
Message-Id: <20250915114629.174472-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAnhAuW_Mdoi3VIDA--.37972S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw1DXry5XF1DCF43Jr4kXrb_yoWDZrbEkF
	4jv3s7Xw45Cr1UCF15Gr4fZryIyFn8WF4vvFy7tFZ3G345ur45Xr45ursakrnIg3yDCa4D
	WF10g398Gr98CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMsjjDUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbBEBnJbmjH+kpShwAAsk

put_device() is only called on the error path, causing a reference leak
on the success path. Fix this by calling put_device() once pdev is no
longer needed.

Fixes: 6d6ef58c2470 ("clk: tegra: tegra124-emc: Fix missing put_device() call in emc_ensure_emc_driver")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/clk/tegra/clk-tegra124-emc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-tegra124-emc.c b/drivers/clk/tegra/clk-tegra124-emc.c
index 2a6db0434281..b9f2f47ec6e5 100644
--- a/drivers/clk/tegra/clk-tegra124-emc.c
+++ b/drivers/clk/tegra/clk-tegra124-emc.c
@@ -197,8 +197,9 @@ static struct tegra_emc *emc_ensure_emc_driver(struct tegra_clk_emc *tegra)
 	tegra->emc_node = NULL;
 
 	tegra->emc = platform_get_drvdata(pdev);
+	put_device(&pdev->dev);
+
 	if (!tegra->emc) {
-		put_device(&pdev->dev);
 		pr_err("%s: cannot find EMC driver\n", __func__);
 		return NULL;
 	}
-- 
2.25.1


