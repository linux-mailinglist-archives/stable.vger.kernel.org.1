Return-Path: <stable+bounces-104446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D24E19F456C
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 08:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCE81887E96
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 07:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC40915624D;
	Tue, 17 Dec 2024 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hRhpjsdg"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8DC15DBAB;
	Tue, 17 Dec 2024 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734421546; cv=none; b=D+pHTNQWUxg5RLxHKVTXv06yzBVdqxH7QRpxQ/5KMGsJ3fcHsGOMN/uPrYZ808yKjg+MRC92O63rW6AwHVm/c+WR/fcCofcKknL05yjjJvDJDxKjoZMdcb5/r4qeq380Z4SLA39YDc/3MVCWJJ3KiPn1ANk0T8Q3sAO0Hbm+Lto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734421546; c=relaxed/simple;
	bh=K82UHOux3hacbEhV+14iXgn4wi9VECeVfkXAko1fE1U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QURioRfBOQ2q+m8qa3mLC321yrxzKXfcWlZim3pVPTQ/FLPSxbJddV40391aeRo5ojWF72KRszEnhZ/t4vCLgDhKIOBxbpTdfCNy7u7/jAd8fosoU587GxP9d9SLsVF5QF2JGD/lrHvA57rfqDsKG67J2Nzq7Lgw69mUo9NRMFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hRhpjsdg; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=SNECs
	J0XKp8vy5JU0Zqz2v1x01Madw93zTND8IbZ038=; b=hRhpjsdg5OkoVnR0WKaEL
	JBWLl5dmD080kRNjcv/z36HN6RRatBjNCG63NvR03oGH2PKeyy7l0bzTWe4G5XG+
	a8qmPIrvKxfmUUBpYBq/1NVNR3jnw6oxxDcjVZBUC0F6DpX0roTi6hLkYiA6O1Wy
	l87C8NqMq11LRAbPx6hYpU=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wC3P7_6K2FnmKuTBA--.3033S4;
	Tue, 17 Dec 2024 15:45:07 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: jckuo@nvidia.com,
	vkoul@kernel.org,
	kishon@kernel.org,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com
Cc: linux-phy@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] phy: Fix error handling in tegra_xusb_port_init
Date: Tue, 17 Dec 2024 15:44:57 +0800
Message-Id: <20241217074457.2909598-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3P7_6K2FnmKuTBA--.3033S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr15JF48GryxJFy3Zr1UKFg_yoWkXrgEkr
	nYv3s3WrWvga1kCr15Crn3ZryIkF42qFyIqr4IqF93AayrXrs2vryDWrZxZr47Wws8ur1U
	Ga45ur48Zr1SgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNtxhDUUUUU==
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBXx+4C2dhH7fIsgABsm

The reference count of the device incremented in device_initialize() is
not decremented when device_add() fails. Add a put_device() call before
returning from the function to decrement reference count for cleanup.
Or it could cause memory leak.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 53d2a715c240 ("phy: Add Tegra XUSB pad controller support")
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/phy/tegra/xusb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 79d4814d758d..c89df95aa6ca 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -548,16 +548,16 @@ static int tegra_xusb_port_init(struct tegra_xusb_port *port,
 
 	err = dev_set_name(&port->dev, "%s-%u", name, index);
 	if (err < 0)
-		goto unregister;
+		goto put_device;
 
 	err = device_add(&port->dev);
 	if (err < 0)
-		goto unregister;
+		goto put_device;
 
 	return 0;
 
-unregister:
-	device_unregister(&port->dev);
+put_device:
+	put_device(&port->dev);
 	return err;
 }
 
-- 
2.25.1


