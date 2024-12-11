Return-Path: <stable+bounces-100512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF37F9EC246
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 03:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75A3167261
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 02:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98D21ABEA5;
	Wed, 11 Dec 2024 02:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="H1QHUjf3"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162E7C148;
	Wed, 11 Dec 2024 02:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733884487; cv=none; b=PdtWaR7vUQiI0xPzB/RBiyLJ9RTd+59r2BYwau2oTVUg2vpKoF2AELFng8QtcNLOvvtmd8WCvwPK1hxrZc8JXZFIHRUgbcln6Qq/uxXsClKzAkiYDyMnU3GKIh8JNA1BnbNxvEZx2RuwZWqkGQh2oAMEoA6KmPFDWZ72iRLRApQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733884487; c=relaxed/simple;
	bh=s0Bs64y7FoyD6L6Sh39cziYAn9mVQUwKgqGRObQRdSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uM587zU5Oa5L26wK4b4twFrPXpHvU0WK6iLbz6l4RFWU7LTp+O8ncigGopPgsw+valqMONARz5BzK5H+RKHQvvf+3LlMSPnUVafaIhbmNFJYwfU1N0NmfcfBNPIwvtra0tces5H+tab3LFBrEDRzjOY3C2LJrLumsBj9VMxlkF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=H1QHUjf3; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=zFGk1
	X8bslnZ8rtCSbiUTceJnb+BrvDhUTUUtZ9FewE=; b=H1QHUjf3zppP6vktDrpeS
	9AJmZSLVvQK6/MWBP9go64kKIAKfT0ihlUS34dfGvfxpPNpObKLImigoa7fzfOcI
	2lIYu01uDtt8tbPRG9DaL6C4l+AgNVbdilC9hy8dkRnpE8RKiKkSVkXeTThhwsjh
	J9yCHBtZ/fHAXhYwjpyLB8=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBXqEwf+lhnQvH4CA--.29221S4;
	Wed, 11 Dec 2024 10:34:12 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	jic23@kernel.org,
	punitagrawal@gmail.com
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] hwmon: Check dev_set_name() return value
Date: Wed, 11 Dec 2024 10:34:04 +0800
Message-Id: <20241211023404.2174629-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBXqEwf+lhnQvH4CA--.29221S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFy8GryUZFW5Ww1fKFyxAFb_yoWftrcEgr
	409ry3GrnrJFnIyrnrArZ3ZryjyF48GF4fZF1Iy393ArZ5Wrn8Xr1vvFsxJa4Uu3s8GFy8
	Zw42qw4fAr4UCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRirgWJUUUUU==
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFRCyC2dY9FefogAAsd

It's possible that dev_set_name() returns -ENOMEM. We could catch and
handle it by adding dev_set_name() return value check.

Cc: stable@vger.kernel.org
Fixes: d560168b5d0f ("hwmon: (core) New hwmon registration API")
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/hwmon/hwmon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index bbb9cc44e29f..8b9bdb28650d 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -955,7 +955,10 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 	hdev->of_node = tdev ? tdev->of_node : NULL;
 	hwdev->chip = chip;
 	dev_set_drvdata(hdev, drvdata);
-	dev_set_name(hdev, HWMON_ID_FORMAT, id);
+	err = dev_set_name(hdev, HWMON_ID_FORMAT, id);
+	if (err)
+		goto free_hwmon;
+
 	err = device_register(hdev);
 	if (err) {
 		put_device(hdev);
-- 
2.25.1


