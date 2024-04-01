Return-Path: <stable+bounces-34874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B14C894141
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ABA91C21373
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0A73F8F4;
	Mon,  1 Apr 2024 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zX2rR5iT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD941E86C;
	Mon,  1 Apr 2024 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989588; cv=none; b=d8AMGb31U4tDMhIgtzYQFvs813wo5ZlQhwK9cS5fYWXw/rrWiMxxq9rJ18O8VVpqKbWZ/9oVsJo+/O/Xty2IQXFMU7qb4LKHcrjXJHtVb6MWlQZDg2TVLrBFGW+zZbh2ISBOBBda4I/1i9M7VeJFWCi9Njuf7U0fdA5B4wHH2Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989588; c=relaxed/simple;
	bh=iIAkceeLCKE9PgboPfOsF/RcjE5XgALdrugUocIJitc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofTqnaiX6zVOdo43dgH4S/XMT+c3z80yoUPz8YJ4x+B9TVpKKLo6OpYj1TPueJnnW2BwwDnyaRsMc701Oii32MOTwqx6BTXAbAnQ6jZWA/448RJdz0grytOCmLOqoB9TJHAqopyFd45rIkWu8aWWhwGQsL3S0a4ut3nNF05w8SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zX2rR5iT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21B7C433F1;
	Mon,  1 Apr 2024 16:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989588;
	bh=iIAkceeLCKE9PgboPfOsF/RcjE5XgALdrugUocIJitc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zX2rR5iTk4zJcvSQ3EpTc0fYRG7jUspDqHHR4YG1yPY4zXNDPT52TI1V/ErM2n8cm
	 /kIu4RF5f/QWznLpGAzJgxAWCW0CoyM0B6Z9ujNGQNuK0ve9EcWU1E42Hyn3feWwkr
	 /tbgy7/97JeZNOpxoLLUqM0/14rYhxFFFS9I+7Ho=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Roger Quadros <rogerq@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 086/396] usb: dwc3-am62: fix module unload/reload behavior
Date: Mon,  1 Apr 2024 17:42:15 +0200
Message-ID: <20240401152550.481740932@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roger Quadros <rogerq@kernel.org>

[ Upstream commit 6661befe41009c210efa2c1bcd16a5cc4cff8a06 ]

As runtime PM is enabled, the module can be runtime
suspended when .remove() is called.

Do a pm_runtime_get_sync() to make sure module is active
before doing any register operations.

Doing a pm_runtime_put_sync() should disable the refclk
so no need to disable it again.

Fixes the below warning at module removel.

[   39.705310] ------------[ cut here ]------------
[   39.710004] clk:162:3 already disabled
[   39.713941] WARNING: CPU: 0 PID: 921 at drivers/clk/clk.c:1090 clk_core_disable+0xb0/0xb8

We called of_platform_populate() in .probe() so call the
cleanup function of_platform_depopulate() in .remove().
Get rid of the now unnnecessary dwc3_ti_remove_core().
Without this, module re-load doesn't work properly.

Fixes: e8784c0aec03 ("drivers: usb: dwc3: Add AM62 USB wrapper driver")
Cc: stable@vger.kernel.org # v5.19+
Signed-off-by: Roger Quadros <rogerq@kernel.org>
Link: https://lore.kernel.org/r/20240227-for-v6-9-am62-usb-errata-3-0-v4-1-0ada8ddb0767@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-am62.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 90a587bc29b74..f85603b7f7c5e 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -267,21 +267,14 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int dwc3_ti_remove_core(struct device *dev, void *c)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-
-	platform_device_unregister(pdev);
-	return 0;
-}
-
 static void dwc3_ti_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dwc3_am62 *am62 = platform_get_drvdata(pdev);
 	u32 reg;
 
-	device_for_each_child(dev, NULL, dwc3_ti_remove_core);
+	pm_runtime_get_sync(dev);
+	of_platform_depopulate(dev);
 
 	/* Clear mode valid bit */
 	reg = dwc3_ti_readl(am62, USBSS_MODE_CONTROL);
@@ -289,7 +282,6 @@ static void dwc3_ti_remove(struct platform_device *pdev)
 	dwc3_ti_writel(am62, USBSS_MODE_CONTROL, reg);
 
 	pm_runtime_put_sync(dev);
-	clk_disable_unprepare(am62->usb2_refclk);
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
 }
-- 
2.43.0




