Return-Path: <stable+bounces-91865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB249C1018
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 21:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32502B235C2
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 20:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C57A218335;
	Thu,  7 Nov 2024 20:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="Ju5j/IjL"
X-Original-To: stable@vger.kernel.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B652322E
	for <stable@vger.kernel.org>; Thu,  7 Nov 2024 20:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012618; cv=none; b=oyf5GUrfNI+YZybClnhTX3auCgDX0zKhRbTh0wHXa9UZ17MMAkqHNJaur7uJw7CWP8Kv2DJYp/Ynb3d+prQFlBnOfmZikc7pn/QaJYAC0ChxqxQ11vUl8h0U0gAPnW+VLlJSyfS32+V+UG0jDnhdVtIachlliz/IwWTzCNjkZfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012618; c=relaxed/simple;
	bh=XA8ytG5Btrx5ToFaFPbZhHY197rAlWz2s8TtR+S1TQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m53E71ki6ELCUtNNzFOM/8Gh08HgeR8JNw5dZVXVQeGd+8YLdUzakCKXP8HjjugA4nQAYFcNbAdOEfKpFGxlYbTuQrpRmM01PfFl5lQi9NPCq96vRSM0M6PbGbI7sA+fh9OkEf5pBdz/KQwPdi4PbgWViDW141XQ9uP69LfuN9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=Ju5j/IjL; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20241107203958aca469383adde12687
        for <stable@vger.kernel.org>;
        Thu, 07 Nov 2024 21:39:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=fytcx9+5LjgzP3RSEwhtTB02382uHm/r8QYjk2LvJ1I=;
 b=Ju5j/IjLEaqnq5YEtBL02a26yzFANIXbtqkFdbDhKC34BoJm0r0UIW9aukD3hEx6o6pa3a
 g+Fx01hWhiAFKDgD+MZaylvOJDAZkYpvhkXbdEsC2vGx8unfips8GfaQkb2ZbFu7BM9hU1dO
 BJwrIcM430cz1BWYhDoPeVsOs/3sOV1ZkpSy0GAda38PC/xJRSBYKkODGqoOMTl820WjBS+B
 O3zd5zfcFttUuudfOQ/uBKt9nmoC9NQpH91vLnVVkR8vbZLNmVBgbgbYE6HZjuJsdc30pUIW
 Hwg/YxBKALGVS5MknW7GHYBexMed71J0GBgPd/nCIRzn+jMCuL2Zd3xw==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-watchdog@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Judith Mendez <jm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <t-kristo@ti.com>,
	stable@vger.kernel.org
Subject: [PATCH] watchdog: rti: of: honor timeout-sec property
Date: Thu,  7 Nov 2024 21:38:28 +0100
Message-ID: <20241107203830.1068456-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Currently "timeout-sec" Device Tree property is being silently ignored:
even though watchdog_init_timeout() is being used, the driver always passes
"heartbeat" == DEFAULT_HEARTBEAT == 60 as argument.

Fix this by setting struct watchdog_device::timeout to DEFAULT_HEARTBEAT
and passing real module parameter value to watchdog_init_timeout() (which
may now be 0 if not specified).

Cc: stable@vger.kernel.org
Fixes: 2d63908bdbfb ("watchdog: Add K3 RTI watchdog support")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/watchdog/rti_wdt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
index f410b6e39fb6f..58c9445c0f885 100644
--- a/drivers/watchdog/rti_wdt.c
+++ b/drivers/watchdog/rti_wdt.c
@@ -61,7 +61,7 @@
 
 #define MAX_HW_ERROR		250
 
-static int heartbeat = DEFAULT_HEARTBEAT;
+static int heartbeat;
 
 /*
  * struct to hold data for each WDT device
@@ -252,6 +252,7 @@ static int rti_wdt_probe(struct platform_device *pdev)
 	wdd->min_timeout = 1;
 	wdd->max_hw_heartbeat_ms = (WDT_PRELOAD_MAX << WDT_PRELOAD_SHIFT) /
 		wdt->freq * 1000;
+	wdd->timeout = DEFAULT_HEARTBEAT;
 	wdd->parent = dev;
 
 	watchdog_set_drvdata(wdd, wdt);
-- 
2.47.0


