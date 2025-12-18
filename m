Return-Path: <stable+bounces-203004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE81CCCD1B
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 17:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFC9B3034ED5
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 16:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B75E34F473;
	Thu, 18 Dec 2025 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqJBFnQt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CF534F253;
	Thu, 18 Dec 2025 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766072244; cv=none; b=GPihLR0t6xYZdcG+iSSB5uzZAqdft8l5RwI3Ad9B3a+WPRc9cuCLWfB37FwAvW0fB/mnjxw3+LsUzOA2DePEiI2DnngMmjaCEcyyxDB+dZaL1hGyGh+JRMKpg1lSM1UR23VfUYiUVCpC7leLD2rUWECAg36UKycNwEqF+/eU6DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766072244; c=relaxed/simple;
	bh=QG3lO4v3c5APo1lagsAKwB1p/Va6baGw435WlXG9FN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovTazVcSMmkWBZS0fYjd64Htiv+uRLRyO1LUS8GJSapJ5ZZksFwBywcqkw2/HL1TkcoDzyxdtoIksZqFNiz5k4BFDPFOWfpK4gcbvqSnthc7CWADlrKvjf/pOdk9vY8Q9NTeuoKc/5mEmHLFDsa+CTSuTu/ro+rKabQoVBM/tQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqJBFnQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A48C116C6;
	Thu, 18 Dec 2025 15:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766072244;
	bh=QG3lO4v3c5APo1lagsAKwB1p/Va6baGw435WlXG9FN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YqJBFnQtn1R46lfrqM1RigXo6fVaYT8HfBwrzgmfWUAT1w+8iaIRfL4F1DGQ15G9v
	 gIiDMYi9HjdowC8hjlUCqLiB27d3EmQdD22LV5Fz0DSYIzvJ+VZv2yI90pk2DjvWIo
	 4dQsPmvost6TQZsVNMzaezJIcqMWGsB4qTuod9Y1B5yP0vcUWAXKe8cFJpX2hIL6y7
	 qyCN2BIHgEi9c1JR9PhnBEtSCmVZkAfglcmV4C+shs4PfOWElfLlx3WVe4Az3SJ890
	 T8WAH5ijLoNO836aouWFqD7zgL7vTj4yWt0zbGqVryjt+iCWuClGASwOS1NRsd4m5a
	 xraN90xe+uthg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vWG4B-00000000569-0IkR;
	Thu, 18 Dec 2025 16:37:23 +0100
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
Subject: [PATCH v2 2/5] usb: phy: isp1301: fix non-OF device reference imbalance
Date: Thu, 18 Dec 2025 16:35:16 +0100
Message-ID: <20251218153519.19453-3-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251218153519.19453-1-johan@kernel.org>
References: <20251218153519.19453-1-johan@kernel.org>
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


