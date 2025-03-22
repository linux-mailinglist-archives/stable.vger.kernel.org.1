Return-Path: <stable+bounces-125804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D40FA6CA43
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 14:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1713A87F7
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 13:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F813214A7A;
	Sat, 22 Mar 2025 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="hYlTovW2"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBE32E337D
	for <stable@vger.kernel.org>; Sat, 22 Mar 2025 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742649748; cv=none; b=pMY+MWOvXQF87+PVJtEXWiqFVKSV059w4AQlQcYBYwkNHTDyRaDZqQJCCFJNDcTQNREBwjttagIUN9bQK+83Y7b8GHaDGBlPzFsRxRH68Rws4dPqdAmQBWiFXZJxNFkn4eXwhpmQ3d98LvDARbF3638BQTE1VKY5QZzNHQeY4qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742649748; c=relaxed/simple;
	bh=9E4GTeSONW1b9sMold4C8JwoJCUACRfu9bfQgf0i1lc=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=PArvGROD6ktBKP3HPeplQSuElZu46m76+3xN19hS2yHEhAHPLh5Qz/jcTd+6tV1SbssThmQszTgX+mHAEgPx87C8/v9UWKWkdcYBabajYhebHqIC9psqI2b7D5jcQ2Lr21iC283mh4JKmcI/Dx8jV2j6/yOuQnuw4Ijd2376Mec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=hYlTovW2; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1742649434;
	bh=sS4r10wBV9m8+Md3CTlv2u0c233DGQvZuAY7+0okET0=;
	h=From:To:Cc:Subject:Date;
	b=hYlTovW2/v/Z14t1x3WrtBgUGMRI5MaXBA094DF1NyV/fXoaUmFaP+WPoDOHD8eNW
	 /SFZvFfUTd+puUHOvhvrnq8atFKf0FDXMyYkxhOskF/k+CIZbaGyLSzBAsb8S3s6ye
	 BmCLbfYpaebgxjgFv4y+49hsNngDF1GrqWLbxq28=
Received: from pek-blan-cn-l1.corp.ad.wrs.com ([120.244.194.128])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 2B0956ED; Sat, 22 Mar 2025 21:10:48 +0800
X-QQ-mid: xmsmtpt1742649048tl3xbakz0
Message-ID: <tencent_E426386D30240DE4B48C35371F2E921AD608@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJJkX9TAriN/M1nuSTfhJMXJz2gM5++txK5CglRgeAxQjajUTtfM
	 mvrQk2Qcil6K/WnIerRjVK4G1rsVDjo5e4bjS3RRqqq9sWU3Gf92ggLuw79TL5+6giySPB0CRwK0
	 aKfbK9FiinXFJa6JBbmf0L2N8zbGsHQyIj9sUBX1ASON5Q+WwH39VzskF3X0HeLFxaOdDxYxJAOx
	 aSSHjIHsYxH3OkNJWYUgQzXunf+GfPOKzTdSYVhvg2LtngL30Dhf55v9ZEF4Wl3hnE8eL1Ru6Y2D
	 Pvj/Sw+Brb09lpoSPXh882Z3skuLusEG87wVaE1FwN/n9bVdYp3Gi41/K+jFdWzfJPN5nczFLMTi
	 UQB3CKaCgAmouZfkgoxx8z74Kw5XbavbUnFwhX6sFSQGkZ38A+icbQqyfGhqIrZnmnjhnSBgJjob
	 hbIMxyCzR/AP6ugQEVu7VDyMY1P8FACckp7yfcuKAra+b0/wPvAH8UYLe7a2o54N5u7bH7MB+xZv
	 2C8bs8/eQZYxP/ArtD5C1iffUr2g12aDAi3d7uegNiPzfacZccNTMFjGTnmHCOoXfRXPqBtAkuti
	 yZcM+MZ6kUDwESpTdKI6XvvMDvNZ5NyHCis2L6w1HehwlhyK1Taa35g4rxM5OrlzkuWqA/AZQ1TR
	 RRopWvknuO/601Z14TspXvtr6HbX990eSd2bJVdt0oExkcCaFj5AtQuJNFAwZp2pt5JsNE+snQkr
	 kaB5DwmF4BW7JiPZS4tFS5cNwCQ2/F2oGYUeulJLmi60heBboc+19KwP4/WCJ3gwCDSkdSYIWEcn
	 +Mfu7Z1CXQjwZpzPOhVcY2YJxNbSKgm5QRHVOmm3rInvXPl37iXY+wtrZzYiahY2F9/Hm0cdmBYs
	 kddBdp3fxit8Zpcg1XpXeZ8tEKaedMKtePENuh/AWXRz+5yNILGUZhHMc6AnP6JbdCeDxWqHOuVi
	 INv6a+jB1IonJzTO5a5nB5tnJ6dqeoIultmr5vueYeSR822GQy600iEDPIr4S7EkRDg7FsHt0HI+
	 1D8INygNzb6M2Vgq7r95vCE7Yrz6MKIwZNOy9mzA==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: alvalan9@foxmail.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Miaoqian Lin <linmq006@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Vinod Koul <vkoul@kernel.org>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 5.10.y] phy: tegra: xusb: Fix return value of tegra_xusb_find_port_node function
Date: Sat, 22 Mar 2025 21:10:45 +0800
X-OQ-MSGID: <20250322131045.1157-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit 045a31b95509c8f25f5f04ec5e0dec5cd09f2c5f ]

callers of tegra_xusb_find_port_node() function only do NULL checking for
the return value. return NULL instead of ERR_PTR(-ENOMEM) to keep
consistent.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Link: https://lore.kernel.org/r/20211213020507.1458-1-linmq006@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 drivers/phy/tegra/xusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 856397def89a..8bd8d1f8eba2 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -449,7 +449,7 @@ tegra_xusb_find_port_node(struct tegra_xusb_padctl *padctl, const char *type,
 	name = kasprintf(GFP_KERNEL, "%s-%u", type, index);
 	if (!name) {
 		of_node_put(ports);
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 	}
 	np = of_get_child_by_name(ports, name);
 	kfree(name);
-- 
2.34.1


