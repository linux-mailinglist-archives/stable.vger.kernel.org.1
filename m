Return-Path: <stable+bounces-202995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD85ACCC41E
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 15:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B48330BB0D9
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 14:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2386C285073;
	Thu, 18 Dec 2025 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqzAzGZg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C822825CC6C;
	Thu, 18 Dec 2025 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067646; cv=none; b=N2RQ3gfJ6IAOXQBKewa3WdJ+cARO7HaMuVUxwpwaH7LmaB99+3sjPyyceacfOHi3kPeo+4Vhog4jvzU61YOWKRf8OV6gXdYQRB9PGwKeuVseZF+UI+e2lKCscw+OCGnfWi6D0BymXFUShx+ksuFmtOdwV4nFhcYPwkwtJohtaeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067646; c=relaxed/simple;
	bh=QG3lO4v3c5APo1lagsAKwB1p/Va6baGw435WlXG9FN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJzqeab7MTaeRb3YGkiRoVYiK0oN/vUMVAzNoQprLBejIOTeNM+B2+i7R8gP6xZisqVjSP1+jgRLVy/zGxmPMNp0yiV3MRWN/Nq7rERAxzbsS9m23BGdhMCU6I8ynVy29bGYmiVkDD5I9ShmPkOVQguFsy1X0iL1Yxl23ovSRlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqzAzGZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877EEC116D0;
	Thu, 18 Dec 2025 14:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766067646;
	bh=QG3lO4v3c5APo1lagsAKwB1p/Va6baGw435WlXG9FN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DqzAzGZg4faHk1d3cWaNjbVUbxcVcCGJUCZMDqVqesOGcJH9RHRq0pYt/ThQ55pVN
	 3ApJdLgc1KjhF9VG+BeWjM0fUjbN4PeRtqGfgSw8Iy15QY+EpBNP/Psb51hoSEVnxB
	 ifktCGYO/UO0ddiUsCV+fJaQfx3ppdLpVTiQkfnuGRVlQIztQoM7HSjNzNhMlekEns
	 6Wmc9wnom+uuWxdJWZAYS4MrVV8uAcDHiRXUwhcy7EsB4xu3+in5SWySyfRrcw1r4s
	 3memAMC2ncwATMQfYeGWm/XgHK3kxTo1WeGWkWvYPNz3ZrPCQJK1lB55lUrYR/YOEz
	 tU1k0aosRW+kA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vWEs0-000000001YI-3HvT;
	Thu, 18 Dec 2025 15:20:44 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Ma Ke <make24@iscas.ac.cn>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/5] usb: phy: isp1301: fix non-OF device reference imbalance
Date: Thu, 18 Dec 2025 15:19:42 +0100
Message-ID: <20251218141945.5884-3-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251218141945.5884-1-johan@kernel.org>
References: <20251218141945.5884-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent change fixing a device reference leak in a UDC driver
introduced a potential use-after-free in the non-OF case as the
isp1301_get_client() helper only increases the reference count for the
returned I2C device in the OF case.

Increment the reference count also for non-OF so that the caller can
decrement it unconditionally.

Note that this is inherently racy just as using the returned I2C device
is since nothing is preventing the PHY driver from being unbound while
in use.

Fixes: c84117912bdd ("USB: lpc32xx_udc: Fix error handling in probe")
Cc: stable@vger.kernel.org
Cc: Ma Ke <make24@iscas.ac.cn>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/phy/phy-isp1301.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy-isp1301.c b/drivers/usb/phy/phy-isp1301.c
index f9b5c411aee4..2940f0c84e1b 100644
--- a/drivers/usb/phy/phy-isp1301.c
+++ b/drivers/usb/phy/phy-isp1301.c
@@ -149,7 +149,12 @@ struct i2c_client *isp1301_get_client(struct device_node *node)
 		return client;
 
 	/* non-DT: only one ISP1301 chip supported */
-	return isp1301_i2c_client;
+	if (isp1301_i2c_client) {
+		get_device(&isp1301_i2c_client->dev);
+		return isp1301_i2c_client;
+	}
+
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(isp1301_get_client);
 
-- 
2.51.2


