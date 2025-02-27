Return-Path: <stable+bounces-119785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7AFA473DF
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 04:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B17B7A25D9
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 03:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CF31D90DB;
	Thu, 27 Feb 2025 03:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W7/AXjWO"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF90270031;
	Thu, 27 Feb 2025 03:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740628788; cv=none; b=s/XcU45BX6lNM53w2a/iahLNMXL+G2VT/oeR19Q8vj3Wo7trf6b66/8VXe3JyTlG0QspQTwFTOO2D72RQ3RBudnkO8hu7EqfgTKG7mwAVWLlXTzk0AxNx7bGhfYQKJxMcZ3nnYQXfea9YhN3XbFiwXnpRhymML0jarFOoayRMqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740628788; c=relaxed/simple;
	bh=CTbn3mDU1q2bd4YekBgaUFA9rOPCxfYb+qhX0gJiXmw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KmfCfFNZDnm1+nKBA/PpM43Bvuz5I9dLdG8/yioWPbbaL8k442h3M/AGU0EKWKI6dFecU3kSIC7XhLms9UPMgDXSlKek6EshC5UISCddkEW/7jDSi7Hjmtax93vGi/R014dew/bM6/AkoIbhYAsmtMxSm55ppSRYV8SRbO8U8a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W7/AXjWO; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Hn/CJ
	t9Yrsg1ucTjtdL991VMH20VtNJuTV1fblUx8lI=; b=W7/AXjWO9sBuU2jjR6NAV
	EMDpwzSYG05pI+mTZbozJ1G7WojV/FEuo5uy7Pdpy+GtZZo4YxXexhG6hyYijWWh
	WKR+rWXzFg5b58AlFE2PtA2vKYa4Fyfozi2vO//Nd/HGgaH26vWgDbZ+TJfFxAjS
	3Tm1KmSN+gfU8SYilu7hgg=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDX79EF479nOIz7Ow--.31489S4;
	Thu, 27 Feb 2025 11:59:02 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: mporter@kernel.crashing.org,
	alex.bou9@gmail.com,
	haoxiang_li2024@163.com,
	error27@gmail.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] rapidio: fix an API misues when rio_add_net() fails
Date: Thu, 27 Feb 2025 11:58:59 +0800
Message-Id: <20250227035859.3675795-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX79EF479nOIz7Ow--.31489S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF1ktr15GrW8Jw1UXrWUArb_yoWfZrgEkw
	48urn7Xws5AF4rJ345Wwn3ZF4F9F1xtrZ5ZF4jqFZ3GrZ3XF9Fgr1DXFs5tw15ZF1xZF97
	Za40gr1rCw47GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sREs2atUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbB0hsBbme-4c0gOwAAsJ

rio_add_net() calls device_register() and fails when device_register()
fails. Thus, put_device() should be used rather than kfree().

Fixes: e8de370188d0 ("rapidio: add mport char device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 27afbb9d544b..cfff1c82fb25 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -1742,7 +1742,7 @@ static int rio_mport_add_riodev(struct mport_cdev_priv *priv,
 		err = rio_add_net(net);
 		if (err) {
 			rmcd_debug(RDEV, "failed to register net, err=%d", err);
-			kfree(net);
+			put_device(&net->dev);
 			goto cleanup;
 		}
 	}
-- 
2.25.1


