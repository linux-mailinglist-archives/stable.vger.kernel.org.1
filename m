Return-Path: <stable+bounces-146330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8B4AC3BC7
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 10:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C1537A2F46
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 08:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3611DFDB9;
	Mon, 26 May 2025 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BQT95dpo"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C7028EB;
	Mon, 26 May 2025 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748248673; cv=none; b=nR5GjzXwiIeq39x1V7NIAd5XFuVKhYaqp5Wh6DOxJ5nMlN1SVAz1XG+41XcSnv8BVnEluvhlMio4EYmuPKNw0+zOmZjJdMcpWYhCT4kYG56aJ/OjG+pXZhQiVLX2h9ji0UW2XjsMBXhztRNKVL2akmmzsJv6NyJ0Ly4S7QSqXPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748248673; c=relaxed/simple;
	bh=DpALoa6V+fZtoP0H2/uI5NDHHXECHCMv0cVK+1IhvMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R5M8cU2jZRIt4ua/hVGZryOwGQbjCbs34WkSjJ3AXsyqis6br+lp1/TFh/Ezz8Fo7BfvUmkEnx0uRoDTPXeNjoH2bFXY/FN+hHI9KfoM24ME9zA0XGI7kDZcbNhuPVfOxVDtRCRaMlHSDvJXUAeNn5pWZ7D+ldOh1zOXz+xQbE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BQT95dpo; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9i
	fPqH6zbI8ViTf4QstJWVzTrvwBhrJhkxi4m69KFzg=; b=BQT95dpoHbHEL6/F9z
	aSm83Tb3DjKE5hO0qnXLyBtu0pEWz1yCiFdK6nBqP8oVuvdeHpP/EZ0SKQR3dc8p
	KCN1vYq9zNL2zWz41Z0TwJwiqb/do583D06pwHSlUKp09DtZOWps0Pd+YTZDTtKg
	1AGJKCkictIcTBR6K/bj6ekdw=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wAXskEIKDRoXZkzEQ--.11424S4;
	Mon, 26 May 2025 16:36:25 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: ioana.ciornei@nxp.com,
	agraf@suse.de,
	German.Rivera@freescale.com,
	stuart.yoder@freescale.com,
	gregkh@linuxfoundation.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] bus: fsl-mc: Fix an API misuse in fsl_mc_device_add()
Date: Mon, 26 May 2025 16:36:22 +0800
Message-Id: <20250526083622.3671123-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXskEIKDRoXZkzEQ--.11424S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr13Jw48tF47Xry7Aw1DKFg_yoW3KrX_Ar
	4Yqr47Xr4qyFnrtw43Ww1SyryI9F4qgr4fXrs7tFWfAryUZrs0qr4rXFZ5Zr15XaySkF9x
	AasrJryrJr48ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRRAR6UUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbBkBpZbmg0Jq05qAAAs7

In fsl_mc_device_add(), use put_device() to give up the
device reference instead of kfree().

Fixes: bbf9d17d9875 ("staging: fsl-mc: Freescale Management Complex (fsl-mc) bus driver")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index a8be8cf246fb..dfd79ecf65b6 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -905,9 +905,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 	return 0;
 
 error_cleanup_dev:
-	kfree(mc_dev->regions);
-	kfree(mc_bus);
-	kfree(mc_dev);
+	put_device(&mc_dev->dev);
 
 	return error;
 }
-- 
2.25.1


