Return-Path: <stable+bounces-187502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D75FBEA55D
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 629845A33D4
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B36120C00A;
	Fri, 17 Oct 2025 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wmyoy7KG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E983B217722;
	Fri, 17 Oct 2025 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716256; cv=none; b=oR34NVWTJYeVjmbfDcKqxDw02C8sIi7pVgsJrlWk5kNIp7ViLc25rsAXFa+f5u5H4hhuGkD+Y+Lu2L2pKNb8+KdC92yHaL7WPKM010UrV/anRphi7VpGRF3X0hsE6h8P1I13YYZge2mW9N1Ihv4WX4mxvv0+ms3Oq1kLcj2XEwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716256; c=relaxed/simple;
	bh=zN7AwgoNfCy9DzoXkSxn31TnzqHn+QvrY06DLxPA0d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXbFOLA/H/zVtEOz2wgScpTolOGQTmqxWaWEz+JG49Orwhhm1NFNOYc2+CEsHS7NiZukM9XPofnArp5FXYsG9FfiNHF0g/D3wae6hFHXMEW83l0IfIBFOljMNC9cyeO/HiIY2qwu40mpOr/UhAPcms4ZQgzp3ff+X5DJ6vT2wvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wmyoy7KG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7005CC4CEE7;
	Fri, 17 Oct 2025 15:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760716255;
	bh=zN7AwgoNfCy9DzoXkSxn31TnzqHn+QvrY06DLxPA0d4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wmyoy7KGfDOx2sOvc3GnMWMS8DYrKCzrIwPqIHqpz7S+Cpdx/LyWjcB1fKj6ZhJGW
	 CEZVNcE9skY8p6maBkW87LkmM2G5cRnaBPBzlR9qXR33sG6eCtDGAR1688HrJ9huBI
	 WPXv366jW1WdpPf9Fc3yc9/UAo7Vz+rUXufIs5PI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 127/276] rtc: x1205: Fix Xicor X1205 vendor prefix
Date: Fri, 17 Oct 2025 16:53:40 +0200
Message-ID: <20251017145147.117298894@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
References: <20251017145142.382145055@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Herring (Arm) <robh@kernel.org>

[ Upstream commit 606d19ee37de3a72f1b6e95a4ea544f6f20dbb46 ]

The vendor for the X1205 RTC is not Xircom, but Xicor which was acquired
by Intersil. Since the I2C subsystem drops the vendor prefix for driver
matching, the vendor prefix hasn't mattered.

Fixes: 6875404fdb44 ("rtc: x1205: Add DT probing support")
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20250821215703.869628-2-robh@kernel.org
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-x1205.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-x1205.c b/drivers/rtc/rtc-x1205.c
index d1d5a44d9122a..3b3aaa7d8283c 100644
--- a/drivers/rtc/rtc-x1205.c
+++ b/drivers/rtc/rtc-x1205.c
@@ -671,7 +671,7 @@ static const struct i2c_device_id x1205_id[] = {
 MODULE_DEVICE_TABLE(i2c, x1205_id);
 
 static const struct of_device_id x1205_dt_ids[] = {
-	{ .compatible = "xircom,x1205", },
+	{ .compatible = "xicor,x1205", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, x1205_dt_ids);
-- 
2.51.0




