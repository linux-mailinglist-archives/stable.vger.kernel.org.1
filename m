Return-Path: <stable+bounces-33960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D930A893D16
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8651F22AA3
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 15:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842AC4778B;
	Mon,  1 Apr 2024 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VJSXFwBJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429393FE2D;
	Mon,  1 Apr 2024 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711986556; cv=none; b=IgZVFrqy3s81y0PpltaWrRnZVKDAztjjf1/tQGv6Ea7R8RhPQ1yoxfsts8JsxAjniKXbUVDyI3jnNa7XUC4RwDDBHvcD0sF0sM5bfEDDP4DEFMYrxJonxRJkQxh4PEtyCVMPePGMolj3r7S8ir99dIfg5M9D7pCno+IB2tantOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711986556; c=relaxed/simple;
	bh=uxMxO9nd0v3oP/ILlIue2CZfp1Bq8C0kSINuaH1s8zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0g9pC9bC/3/OxYZXZJuH7URL2G2XugtTEea3RFfJGkWsQ83pbYp3lBc1Sat+mT2Hh9YtBV9J2yMwg9WCiqLXCIm9Kdd+78ARUfBHdHYxRLO4mUQxsRhdKX2Bhqh9MZo6Em2xxuN6UCXQya6xjvsNJGrekEEpPGpKbyvSGUpcr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VJSXFwBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3C7C433C7;
	Mon,  1 Apr 2024 15:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711986555;
	bh=uxMxO9nd0v3oP/ILlIue2CZfp1Bq8C0kSINuaH1s8zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJSXFwBJj4YT2OmrTz4SRvZOUYh7Ax3hFgsja7V7e6mhDK4uhbAoEgsBg/O+8UI3N
	 WtgMtGa6rTDECJnJmuo6qcV5jkmMFiHm6FBu0JMtSBHkW5fs5f6nCiv3j5qXM7pp/B
	 bSSm9yMgEr7S2CYFUV/W/m6hcWea+Y4awSRcZXII=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 013/399] serial: max310x: fix NULL pointer dereference in I2C instantiation
Date: Mon,  1 Apr 2024 17:39:39 +0200
Message-ID: <20240401152549.544588640@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

[ Upstream commit 0d27056c24efd3d63a03f3edfbcfc4827086b110 ]

When trying to instantiate a max14830 device from userspace:

    echo max14830 0x60 > /sys/bus/i2c/devices/i2c-2/new_device

we get the following error:

    Unable to handle kernel NULL pointer dereference at virtual address...
    ...
    Call trace:
        max310x_i2c_probe+0x48/0x170 [max310x]
        i2c_device_probe+0x150/0x2a0
    ...

Add check for validity of devtype to prevent the error, and abort probe
with a meaningful error message.

Fixes: 2e1f2d9a9bdb ("serial: max310x: implement I2C support")
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20240118152213.2644269-2-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/max310x.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index f70e2c277ab7e..198413df091b4 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1635,13 +1635,16 @@ static unsigned short max310x_i2c_slave_addr(unsigned short addr,
 
 static int max310x_i2c_probe(struct i2c_client *client)
 {
-	const struct max310x_devtype *devtype =
-			device_get_match_data(&client->dev);
+	const struct max310x_devtype *devtype;
 	struct i2c_client *port_client;
 	struct regmap *regmaps[4];
 	unsigned int i;
 	u8 port_addr;
 
+	devtype = device_get_match_data(&client->dev);
+	if (!devtype)
+		return dev_err_probe(&client->dev, -ENODEV, "Failed to match device\n");
+
 	if (client->addr < devtype->slave_addr.min ||
 		client->addr > devtype->slave_addr.max)
 		return dev_err_probe(&client->dev, -EINVAL,
-- 
2.43.0




