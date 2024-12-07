Return-Path: <stable+bounces-100013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E23769E7D50
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 01:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40C7281E20
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 00:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFD810F4;
	Sat,  7 Dec 2024 00:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rnFhX+/s"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35E04A07;
	Sat,  7 Dec 2024 00:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733530363; cv=none; b=nZEoSH4cRrNVZjZ6ZxAnUu7jnqisAQMlYjzUt9xfYPIT3LeIxsy8dGuB3FU/1EDlPkBMh5lRfFIJM1XhNFcBfX/o1NQ4/aLA9q7aOBH1uGvC092egxe7MVAins6bYrC7xg+WK491DJKsnm39DGgVSmcKdeSsk5ExlfMRmx8w/Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733530363; c=relaxed/simple;
	bh=B0SF8tpB9EeLvhzrBh4i+p6/dp1JQVTjTUX48mccYpg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sQVNuqIE+VdVNvk3/VvSjSoo2ZWh4PuFcJoTRf8db2Kz7eISI7d2vvWP60XURTKFoPbfHt48Ho6Ak/lO3FCaNcCZNLunBSZNz7Ide6ln2NwRyCPBSGCeMygcBkluVicNBRWzucpziL+J5IPZisOBRvU2/EwW6XWHHTc9uohBNdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rnFhX+/s; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from hwang4-ThinkPad-T14s-Gen-2a.. (unknown [183.155.67.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id AA2943F1C8;
	Sat,  7 Dec 2024 00:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733530359;
	bh=QRUAQ1ZVncxN0VUq3nC73X4ELlJn2+9laQ5RSsdxalM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=rnFhX+/sBmc9A7wixK4bjjKzOnLRz/XeZ/Pv2cVECXalJYmiCTEuMdcR67peImlc+
	 eyBzefSoB5gya4J5YuO2qnUheICWmNGZXNiQTVekcSJV+BSmkJoMOzv+Ker6mntbVN
	 YCIdNvWkyhCkLnG5ijt9k1U+S3GAY0eR2mzKuQjfBvpVdt+xqGWbqlG10IrmOZOp4P
	 nMJGxqJrFnRy8NnLW6VRRVKaSFo2JL3PvUgtloIuHIfLR/U+xz847YL6PM+ki2Y8jz
	 xv6GVsOqtVXVUevP2oFf6cPPSM3fNER7ZOUT/sDCQ/fTF/eEBolu+S9EOrJKwJsN/o
	 qzyLE8WHRgAUQ==
From: Hui Wang <hui.wang@canonical.com>
To: stable@vger.kernel.org,
	linux-serial@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: hvilleneuve@dimonoff.com,
	hui.wang@canonical.com
Subject: [stable-kernel-only][5.15.y][5.10.y][PATCH] serial: sc16is7xx: the reg needs to shift in regmap_noinc
Date: Sat,  7 Dec 2024 08:12:25 +0800
Message-Id: <20241207001225.203262-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently we found the fifo_read() and fifo_write() are broken in our
5.15 and 5.4 kernels after cherry-pick the commit e635f652696e
("serial: sc16is7xx: convert from _raw_ to _noinc_ regmap functions
for FIFO"), that is because the reg needs to shift if we don't
cherry-pick a prerequiste commit 3837a0379533 ("serial: sc16is7xx:
improve regmap debugfs by using one regmap per port").

Here fix it by shifting the reg as regmap_volatile() does.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 drivers/tty/serial/sc16is7xx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index d274a847c6ab..87e34099f369 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -487,7 +487,14 @@ static bool sc16is7xx_regmap_precious(struct device *dev, unsigned int reg)
 
 static bool sc16is7xx_regmap_noinc(struct device *dev, unsigned int reg)
 {
-	return reg == SC16IS7XX_RHR_REG;
+	switch (reg >> SC16IS7XX_REG_SHIFT) {
+	case SC16IS7XX_RHR_REG:
+		return true;
+	default:
+		break;
+	}
+
+	return false;
 }
 
 /*
-- 
2.34.1


