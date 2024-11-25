Return-Path: <stable+bounces-95376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BE49D8567
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 13:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9E31639BF
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 12:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3209019CC0A;
	Mon, 25 Nov 2024 12:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MfjBV2tJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320331552E3
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 12:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732537500; cv=none; b=BDlrZ2r4akvi73M9et8ttxX93T8cBoZHX0Y+raGXM9H1tBChQFDIaSY9ShBKaYjDhd4a6I7quIb/LrtgWOi49XCQq5dY/DCbbY7f98jCoBVOeBHQZY1kJIGkD6dQ2TMetevnEqMpy46UM6ahsYy9L5+2T/2btV2nsX02tMOj5bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732537500; c=relaxed/simple;
	bh=1MIhac942bYqThQhO2fYakc1q0gsOhjIRGIpfC6gHDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GhyYQcCrTiFJ/QeUVeu49zb3FZiearLTAIVRXxjaKRcRkkeBXY5rP0bIb1gYNvvqgz61/NOaNm0+/EJRtLtgP9eLiM6NZcbFXRyB2Ud8n4ds5uSClORLSjjwVAEnl6WhWqziAtRfMIpGPg7ZwGXQlCWTVJn7IpYp/j+LoFc2RX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MfjBV2tJ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53dd0cb9ce3so3975579e87.3
        for <stable@vger.kernel.org>; Mon, 25 Nov 2024 04:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732537495; x=1733142295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IPJcH/pZUFwQXY8dj6Du6OSGV2ZbBkDCGcyY6tthZEM=;
        b=MfjBV2tJCcZ/e5Om7TBlnrg/Od9lllBBinNNlTs1vgaYudCbwsqkK6UpY8iyzxgXY6
         R58Ci37+2jHeK4lxnF4NnFLJkKOSqoMM95VC2BZl1NPgrXcH3xhr5vQHGKLI2iwqffn6
         +PoeDavpDHnMjcIAMJKmTQ4XATrePHjElrRMKyCaaSlmUCkb6l95oU3oTm/GKvoUVGfh
         DIlloYRFGSaQm0O2C+tUHGPFCIW0j4gwwxGTMl5l7f1O2um1epGbh5/Tk/EgBNeXH6+s
         b8K1PWcFcA2hW/CBVV6fdsLyeqAwRrse8FwMZtjqIB4OVCLL7on4+A5URfHJKnsWNHLk
         W4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732537495; x=1733142295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPJcH/pZUFwQXY8dj6Du6OSGV2ZbBkDCGcyY6tthZEM=;
        b=DjFjpXXx0IRRSYiB5m83Koo+zckIQWi3yOWQ0M2VRiTWw/Aqcdz0ERrC2HVRXgxL9O
         7wxS2WH/p9mxnp4KvAm6gmrqaDy1LpgIflUra9DcwExLbO08JKEcYYOrlNwtXjEogQWF
         Apwxg4rH+iFCEt2ELMWmNcndvdkdMgD+Br+N/PAOt1ZDdM2wO42pIVOBVbJ1jNCF/RUT
         fwfm+GFkHUmdncJkgdgUeo9TM8bvNBoAKr2/wKdaR/Sitm0Us4mzV9DCccLHDX4oVsTN
         omJlu3VAYace0RozWwO/c8bw0GhlU2J12NFhr11L4Ha3SRVxR1J3yKJ4Nbje3usM2AT1
         2oKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcPQk5BnXF+3zxLj0oyyln9Stlp8UpNep1C4Zh8y2i8GwXrz3vciyM9GbRhCwZ3jQGcUrIKyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhHCPNhFJKncdVrov1gYaGUEzZw8ngqvcnP8jc9XXlC5BFT/CF
	Ki8Yhb8xyY/2nmMmX2I5i5B+TfjLVr3ivuW2gJXkNDBFOHgWdrU2VgNpfT/anlQ=
X-Gm-Gg: ASbGncuPqAsu5vLlZXiRrOYCfbtcpWgc7MzSCKQsAXhnvmsmV9JeYsod5gTqw9j582a
	GmDt7MWD12nhYCpoY6leSxSfdRMbmAh+VJuUtmVrKC6D1p6cI4/8J/A+AE72iNJcQSBmCeGwVwM
	1BXFstFpV5BBRMLZ76lNLn0zV8BFYbLEIdonBZxzj5DvxQ1noofx59htB5dKOz0ljyCg9IChvvS
	Jf7fzryfshAu56nbg1LqMkM2PxrlnVU1VFJIl0hlM71r/l0c0uozQ2A9eOQMx1cFKmkq9vvE7bA
	8ErCg+U8Z68QC37NiwL1RdM/
X-Google-Smtp-Source: AGHT+IFlVjwEQfSEHD92mmB7kec/o4wkAJx7J1K/QCuKDC+tc1kL8fPqTnY1+jYN1nta3srV5ZSvBw==
X-Received: by 2002:a05:6512:3e1b:b0:53d:a122:dd0f with SMTP id 2adb3069b0e04-53dd389e353mr5547727e87.28.1732537495333;
        Mon, 25 Nov 2024 04:24:55 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd24457d4sm1655255e87.54.2024.11.25.04.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 04:24:53 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Anthony Pighin <anthony.pighin@nokia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mmc: core: Further prevent card detect during shutdown
Date: Mon, 25 Nov 2024 13:24:46 +0100
Message-ID: <20241125122446.18684-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disabling card detect from the host's ->shutdown_pre() callback turned out
to not be the complete solution. More precisely, beyond the point when the
mmc_bus->shutdown() has been called, to gracefully power off the card, we
need to prevent card detect. Otherwise the mmc_rescan work may poll for the
card with a CMD13, to see if it's still alive, which then will fail and
hang as the card has already been powered off.

To fix this problem, let's disable mmc_rescan prior to power off the card
during shutdown.

Reported-by: Anthony Pighin <anthony.pighin@nokia.com>
Fixes: 66c915d09b94 ("mmc: core: Disable card detect during shutdown")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/bus.c  | 2 ++
 drivers/mmc/core/core.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 9283b28bc69f..1cf64e0952fb 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -149,6 +149,8 @@ static void mmc_bus_shutdown(struct device *dev)
 	if (dev->driver && drv->shutdown)
 		drv->shutdown(card);
 
+	__mmc_stop_host(host);
+
 	if (host->bus_ops->shutdown) {
 		ret = host->bus_ops->shutdown(host);
 		if (ret)
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index a499f3c59de5..d996d39c0d6f 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2335,6 +2335,9 @@ void mmc_start_host(struct mmc_host *host)
 
 void __mmc_stop_host(struct mmc_host *host)
 {
+	if (host->rescan_disable)
+		return;
+
 	if (host->slot.cd_irq >= 0) {
 		mmc_gpio_set_cd_wake(host, false);
 		disable_irq(host->slot.cd_irq);
-- 
2.43.0


