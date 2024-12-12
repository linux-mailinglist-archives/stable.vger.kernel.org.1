Return-Path: <stable+bounces-101536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DA09EED0E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A58BF1666CB
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31EA217F28;
	Thu, 12 Dec 2024 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ddTSQlwz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA652135C1;
	Thu, 12 Dec 2024 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017901; cv=none; b=UvxK0FexKKjcfGCxG9/wobsvWdPnuiS+21kNu4s+CUU21RfszjqzFV9hXDCQNd5+9GruobPi5OupQI8HK8AesV76yT/2lKp5JLrGSY8hCbzlr+BL/8vv04JgrRUVcNJTi4s78J1MFbLrdPd2AYMwrtttgVfvwFhqqIxHpjgTj6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017901; c=relaxed/simple;
	bh=Tv4fYvDcbPcstNKkQQgEPoUgEsOKRLZRCneMU2tThrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtjiRFNq2fencBl2y8Nw9njWWSO7PVxdCeRX1CCg+cjfEUl3llpalt1KLEdZ0oyYogH97zeu/RGhe8WnS4g0JIBoVxqqZcekftWJ+d9pqFreMqCdpx+v9huUracZFd+iIFNzOTUjc8yIgahjpLbbYrHtD+CZCDfTjHNKAs7RvUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ddTSQlwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6D5C4CECE;
	Thu, 12 Dec 2024 15:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734017901;
	bh=Tv4fYvDcbPcstNKkQQgEPoUgEsOKRLZRCneMU2tThrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ddTSQlwzdyMhvZ+3PUBk2EtLFiQdsR2VMxBYy1ckspQecDgcscmMsNNbPsEFAubQC
	 5X7PAYWR2L1TPysmYB2xSLGivkzXLB7/+jyLVjba7v3Z6sDmbRRy79GT3Jg0yPS30A
	 wZ6NSztECaf6MYeUYMMdPIIy+iA6eWzzli1+43cU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: [PATCH 6.6 143/356] watchdog: rti: of: honor timeout-sec property
Date: Thu, 12 Dec 2024 15:57:42 +0100
Message-ID: <20241212144250.293038825@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
References: <20241212144244.601729511@linuxfoundation.org>
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

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

commit 4962ee045d8f06638714d801ab0fb72f89c16690 upstream.

Currently "timeout-sec" Device Tree property is being silently ignored:
even though watchdog_init_timeout() is being used, the driver always passes
"heartbeat" == DEFAULT_HEARTBEAT == 60 as argument.

Fix this by setting struct watchdog_device::timeout to DEFAULT_HEARTBEAT
and passing real module parameter value to watchdog_init_timeout() (which
may now be 0 if not specified).

Cc: stable@vger.kernel.org
Fixes: 2d63908bdbfb ("watchdog: Add K3 RTI watchdog support")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20241107203830.1068456-1-alexander.sverdlin@siemens.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/watchdog/rti_wdt.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/watchdog/rti_wdt.c
+++ b/drivers/watchdog/rti_wdt.c
@@ -61,7 +61,7 @@
 
 #define MAX_HW_ERROR		250
 
-static int heartbeat = DEFAULT_HEARTBEAT;
+static int heartbeat;
 
 /*
  * struct to hold data for each WDT device
@@ -252,6 +252,7 @@ static int rti_wdt_probe(struct platform
 	wdd->min_timeout = 1;
 	wdd->max_hw_heartbeat_ms = (WDT_PRELOAD_MAX << WDT_PRELOAD_SHIFT) /
 		wdt->freq * 1000;
+	wdd->timeout = DEFAULT_HEARTBEAT;
 	wdd->parent = dev;
 
 	watchdog_set_drvdata(wdd, wdt);



