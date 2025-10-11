Return-Path: <stable+bounces-184058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB7CBCF227
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 10:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5547542668C
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 08:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97E32367CF;
	Sat, 11 Oct 2025 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TTmvfZe5"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182AB2045B7;
	Sat, 11 Oct 2025 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760171111; cv=none; b=uBrAF+sSaFb+bTJ3oyK4PahmJqCow3E6J6UDu5Fj7HMh7e5+BKveTilfqkHJccChN7xrxhYDZmv8CjXhbFyF03uHV3SK1LpSFO+SRGfgYr1mJzmP9dBpjx3po5FTIsSrjI7fOXj3gEOhvLwqX1GKMaEZNzfrtaHMxAcFmEN2/eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760171111; c=relaxed/simple;
	bh=7+Y8h6gXG2SuDe1E/iknJtQNKxJeFP7rvXWOL/4bjjU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CYFYZwcMCp7EX4weOJ8KPtvRyQnq7G3KjoYwPnKS8zrCTbptp69VdhVPbM4U3U0OutO2LQY9hJ8GzhlTUz+COIvtbOVjjOu3vuPgdKgkNlnyV6sC3LvoDSoV56CPi6E160MnJPaR+G8hCtrifvdUgtc3unoJzShDhRrFXzauCdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TTmvfZe5; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=wn
	raGndEW17agKJvHcNVi4M70SQfTkop2yVtlgiy4zk=; b=TTmvfZe5vFrGqWjPPP
	ELwdz9pu/oOgs2t0HSNCQMELhKRKajV2qFF9EBGlb5gCqYhato781FcnS/42o/lH
	/mqz64gBl1y8b/hkxHB4baqp+fEMeFHKKUg7oBcY70LxHzLMHi2SMGSRgWDaLi/4
	AmIta4PDZx2BdcZO37KzCJvqk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3LyUxFOpojB64DQ--.7680S2;
	Sat, 11 Oct 2025 16:24:17 +0800 (CST)
From: yicongsrfy@163.com
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	oneukum@suse.com
Cc: horms@kernel.org,
	kuba@kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Yi Cong <yicong@kylinos.cn>
Subject: [PATCH net v3] r8152: add error handling in rtl8152_driver_init
Date: Sat, 11 Oct 2025 16:24:15 +0800
Message-Id: <20251011082415.580740-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3LyUxFOpojB64DQ--.7680S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFWrGFWfur1UXr1fJw43Wrg_yoWkuwbEkr
	y0ga43Xr1DuFW5Kr15Wr4avrySkan0vFn3Zr1xt3sIgwnrXrn5Gr15Zr9xXw4UWryfZF9x
	Ca1UGFyxCr129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8xwIDUUUUU==
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/1tbixwTj22jqDAYbEgABs7

From: Yi Cong <yicong@kylinos.cn>

rtl8152_driver_init missing error handling.
If cannot register rtl8152_driver, rtl8152_cfgselector_driver
should be deregistered.

Fixes: ec51fbd1b8a2 ("r8152: add USB device driver for config selection")
Cc: stable@vger.kernel.org
Signed-off-by: Yi Cong <yicong@kylinos.cn>
Reviewed-by: Simon Horman <horms@kernel.org>

---
v2: replacing return 0 with return ret and adding Cc stable
v3: delete the redundant return ret
---
 drivers/net/usb/r8152.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 44cba7acfe7d..a22d4bb2cf3b 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10122,7 +10122,12 @@ static int __init rtl8152_driver_init(void)
 	ret = usb_register_device_driver(&rtl8152_cfgselector_driver, THIS_MODULE);
 	if (ret)
 		return ret;
-	return usb_register(&rtl8152_driver);
+
+	ret = usb_register(&rtl8152_driver);
+	if (ret)
+		usb_deregister_device_driver(&rtl8152_cfgselector_driver);
+
+	return ret;
 }
 
 static void __exit rtl8152_driver_exit(void)
-- 
2.25.1


