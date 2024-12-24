Return-Path: <stable+bounces-106058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF389FBA4A
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 08:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F43F164250
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 07:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDD5187FEC;
	Tue, 24 Dec 2024 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jOi5IPjr"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFB68F66;
	Tue, 24 Dec 2024 07:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735026728; cv=none; b=j/CX9j5d0LwEhOqEuIXvrZKo63x9s/hacBNQiriRqTOHkPU0ks1jBd6DHeZmfHnZv7pIJXk5mzjhgKKjNj08KA1Ueh0u7n6DLYmlI1Wt7XxEbycwWhollZ3v6OEz2oTl+nLGuh8FBhad5oO9v0iYBN2rtklyivIvib3si0deKvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735026728; c=relaxed/simple;
	bh=K82UHOux3hacbEhV+14iXgn4wi9VECeVfkXAko1fE1U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o/L0av5z6hTcxiiFaFFtHoj8VNNQSNVS+FyzRiZfngP9G3A4jXbawkrEJPuysjkyxLwpwzoGrgw37oCL7/PBPcg1V5I5XQXaLS6P6wkygizc91eNj76z1mEMEBR4vAA6UDNKQNXtwW06bv0SsSEpUoXF01R26LZnDv60cYysFEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jOi5IPjr; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=SNECs
	J0XKp8vy5JU0Zqz2v1x01Madw93zTND8IbZ038=; b=jOi5IPjrssH7Kc5ew7L5k
	SwIi84doG3BrbNg/yhbzl60++ya+LLIWdhNaJW5M900tWlfetN3UkSzwnpNwL5pd
	jkdpyRb7xnxhSA+Urr6Rel+Vp2GN8KNvEUIDesB9RvIMiNtmk6DYjeWoqecHAT6D
	qx1KlMpUnAlN6DbnhLOzGQ=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBnofntZ2pnyb0QBQ--.44335S4;
	Tue, 24 Dec 2024 15:51:17 +0800 (CST)
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
Subject: [PATCH RESEND] phy: Fix error handling in tegra_xusb_port_init
Date: Tue, 24 Dec 2024 15:51:08 +0800
Message-Id: <20241224075108.3770055-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnofntZ2pnyb0QBQ--.44335S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr15JF48GryxJFy3Zr1UKFg_yoWkXrgEkr
	nYv3s3WrWvga1kCr15Crn3ZryIkF42qFyIqr4IqF93AayrXrs2vryDWrZxZr47Wws8ur1U
	Ga45ur48Zr1SgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRM0eHDUUUUU==
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFRG-C2dqZf4oZQAAsr

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


