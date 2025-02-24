Return-Path: <stable+bounces-118706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1557CA4167A
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 08:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41AE3A2B64
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 07:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FC218B482;
	Mon, 24 Feb 2025 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="McTsKz6d"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1633E1BC3C;
	Mon, 24 Feb 2025 07:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740383013; cv=none; b=hBIuPNfwXLigOv47fKli8Nbaz+OMW9x+9LUvB2PWCPB78AaT3Mb+DYAXHMtuhmLPAnopruFP+057sWzq5LtLS1RAEcR74floTPq4NigJpkgCbFh0NW+/rR4OUCqy+y0sYCigQd7jBRfab7M/j7bFkneeL4zzbpNmfxKdFuWTL7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740383013; c=relaxed/simple;
	bh=YGsuhljqccKPHTYpawWHibXzqUjkIgNy6z/pL7cScYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rqhNViM3h+ksxudWBo4RT0h3s9e6pxoo2vecQh1/WVx1ciE4ccinNsXqL+8ScHCq+peTdQt2EsJZto4ZThLoMccax/5AAoVKZ0HCu7fFCiDVx8vjHfXIEnK6xWBjYxBdMbVt083KmDXDjFW+s5xjMMBhnzrp9QFj/CeRlGrhVcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=McTsKz6d; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=JBeRk
	4co3+uSwf3WyPiW0R5ciRcTZIeouYHkX7tcL/M=; b=McTsKz6dcaZmybhL4zeys
	KZLrr5bcTkC1DHyjwS0DFwmle2Q6erq8+CcKTpCFJDOeUQjZEMmN6G2Fse1KzGDX
	Y9xVuSo/9cSUqMs5zZZFe47Mxel2qEqR0u8nJju4NpRoyYS12n9HLimCkWfvLI/A
	h3ZsPElFwhTMpYQBcTAslk=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCXu_oSI7xnHWzkNg--.62438S4;
	Mon, 24 Feb 2025 15:43:16 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: airlied@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] agp: Fix a potential memory leak bug in agp_amdk7_probe()
Date: Mon, 24 Feb 2025 15:43:13 +0800
Message-Id: <20250224074313.2958696-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXu_oSI7xnHWzkNg--.62438S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF4DCF47tFyktw17JF17trb_yoWDXFb_G3
	yUAr9293s5AFW8ur1akw4F9rWF9a1rXryku3ZFgwnxAFy3Zr4xXanrWFs5WF17ursrCFy7
	t34DXr4Uuw1IyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRXyCLJUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbBkA39bme77loMFgABs9

Variable "bridge" is allocated by agp_alloc_bridge() and
have to be released by agp_put_bridge() if something goes
wrong. In this patch, add the missing call of agp_put_bridge()
in agp_amdk7_probe() to prevent potential memory leak bug.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/char/agp/amd-k7-agp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/agp/amd-k7-agp.c b/drivers/char/agp/amd-k7-agp.c
index 795c8c9ff680..40e1fc462dca 100644
--- a/drivers/char/agp/amd-k7-agp.c
+++ b/drivers/char/agp/amd-k7-agp.c
@@ -441,6 +441,7 @@ static int agp_amdk7_probe(struct pci_dev *pdev,
 			gfxcard = pci_get_class(PCI_CLASS_DISPLAY_VGA<<8, gfxcard);
 			if (!gfxcard) {
 				dev_info(&pdev->dev, "no AGP VGA controller\n");
+				agp_put_bridge(bridge);
 				return -ENODEV;
 			}
 			cap_ptr = pci_find_capability(gfxcard, PCI_CAP_ID_AGP);
-- 
2.25.1


