Return-Path: <stable+bounces-14264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D981838039
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F7E1F2C8CA
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B6664CEB;
	Tue, 23 Jan 2024 00:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S11q+rrA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AAF64CE7;
	Tue, 23 Jan 2024 00:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971599; cv=none; b=dzZaeviYjc+5yCqGGLOvPCpfeDjt8pgcz56iH5Yx68m+0R0tc4dR9HjlP4y2l35xHUUFVQLwxTuKmBIOPKTV3RBBNRIPjmhCPkP6+prSXn8LnEC7qBe888Nzh1/TBXu5X39BqpqDWxm9SLOIhHhQgxv2drhqdqXrtQV9ERUM2oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971599; c=relaxed/simple;
	bh=bfAl/aRwiUuJitp+hPZXoBikc3SYRbE0yWS3vEz5c+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubAhQ5moefuFv5Uq5P+rPXD1aAJPULDJUxR/lTx0zCDVaVZ/oJnwfHYuwvDNv4Rs9njIRhgMx41jzAmSmeLgSr/SjZmE6AqoI4Z2golF+XduvUwj6ZS1p8QLQyikJ5huoe/HO2FEcuCyHYzIqoxOcRvu1i6XQwfIpmfCYJftnEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S11q+rrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B0AC433C7;
	Tue, 23 Jan 2024 00:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971599;
	bh=bfAl/aRwiUuJitp+hPZXoBikc3SYRbE0yWS3vEz5c+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S11q+rrAXSs+0bJXdtIgaEtrGULYc3P1do1axFAkt1gqHOroGeUMy36nY2h3iq1uy
	 U3IuI0dWeQdWLrtyjaJbtvZ1rzGdKPWFR4PuLvMfq4/OOFPxJX50f9UNpmGBJKsog+
	 xWquNwxj7rcyWL90Cuae9vlY2uYtu430o9O0eu2U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan Wahren <wahrenst@gmx.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 184/286] watchdog: bcm2835_wdt: Fix WDIOC_SETTIMEOUT handling
Date: Mon, 22 Jan 2024 15:58:10 -0800
Message-ID: <20240122235739.233392214@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235732.009174833@linuxfoundation.org>
References: <20240122235732.009174833@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Wahren <wahrenst@gmx.net>

[ Upstream commit f33f5b1fd1be5f5106d16f831309648cb0f1c31d ]

Users report about the unexpected behavior for setting timeouts above
15 sec on Raspberry Pi. According to watchdog-api.rst the ioctl
WDIOC_SETTIMEOUT shouldn't fail because of hardware limitations.
But looking at the code shows that max_timeout based on the
register value PM_WDOG_TIME_SET, which is the maximum.

Since 664a39236e71 ("watchdog: Introduce hardware maximum heartbeat
in watchdog core") the watchdog core is able to handle this problem.

This fix has been tested with watchdog-test from selftests.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217374
Fixes: 664a39236e71 ("watchdog: Introduce hardware maximum heartbeat in watchdog core")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20231112173251.4827-1-wahrenst@gmx.net
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/bcm2835_wdt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index dec6ca019bea..3a8dec05b591 100644
--- a/drivers/watchdog/bcm2835_wdt.c
+++ b/drivers/watchdog/bcm2835_wdt.c
@@ -42,6 +42,7 @@
 
 #define SECS_TO_WDOG_TICKS(x) ((x) << 16)
 #define WDOG_TICKS_TO_SECS(x) ((x) >> 16)
+#define WDOG_TICKS_TO_MSECS(x) ((x) * 1000 >> 16)
 
 struct bcm2835_wdt {
 	void __iomem		*base;
@@ -140,7 +141,7 @@ static struct watchdog_device bcm2835_wdt_wdd = {
 	.info =		&bcm2835_wdt_info,
 	.ops =		&bcm2835_wdt_ops,
 	.min_timeout =	1,
-	.max_timeout =	WDOG_TICKS_TO_SECS(PM_WDOG_TIME_SET),
+	.max_hw_heartbeat_ms =	WDOG_TICKS_TO_MSECS(PM_WDOG_TIME_SET),
 	.timeout =	WDOG_TICKS_TO_SECS(PM_WDOG_TIME_SET),
 };
 
-- 
2.43.0




