Return-Path: <stable+bounces-179229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD421B5269C
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 04:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF821C80B2A
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 02:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95615218EBA;
	Thu, 11 Sep 2025 02:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSwqbJEs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0136E1F237A
	for <stable@vger.kernel.org>; Thu, 11 Sep 2025 02:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757558469; cv=none; b=o+BVqwLfYE3KoQWRm17mgFsbG74Hsw4m5cq2Eg6Wfjh3K0bZnAmo32UsvPhu3QnR41JN3V3vg/VHMGwIVkPqOS4tqi7wmS0/kY09vjrEOO4KgTmPojKlz7JMkieUDhx++gf0bWjrSrhUk6aTpdYnK3gjEfTt1Tjf48akKKjvCD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757558469; c=relaxed/simple;
	bh=VsYWhLysJJnmTbPsbRPKH4Te9fqitjPi8iJYc9rGN40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKyiB6tz86anIKCtTAklMC6u217hmG25FFP021hulRI55Fa2MJ9eiojeyzlwH5HsKO8ufun8HPM7F/9eoKdoPLPvbPK5Tz9PxM+0BsRP5QfK99XbdU94FRA+fBSN1LkTlBtNaY3T5KIGgqlqMwXVdTdSFJmLP56mMZBiQkdEQWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSwqbJEs; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7725fb32e1bso248825b3a.1
        for <stable@vger.kernel.org>; Wed, 10 Sep 2025 19:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757558467; x=1758163267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RotDBc4nduTqvm+cZpyUmQgQq6+4XUNjDl6/pxCSap0=;
        b=PSwqbJEs8IsyVx25IvEs2eQ5yGdI84ayDb6vA8xsHkmFYCC3vr3ce98EQPAj+HlOtx
         zCVyQ9/xTjpIqIAc6R/GTjXmiFctXRLd0OOmu174wvrkFSr1IS5iXJ6nbAA6FPJY/lBD
         owVnRRM9OwCwD90zFKCSkXqdHKVZIOe0LF5r8VR9g+eHK/4dtTzCrMDUvdVRPHF8Snli
         fdWn/dDOLXgLuBGzQDs6NIjD49xXhEDwaVLU/WkBcBrWXbfZY8QhjVO+xT28g2AUCEUw
         WS+iHE9+r5z274UAIMDC1PrXW2aMRlyrELcnt5sqEn5zoCcEVHsWRnoX7fRTHhGXZgpi
         9bgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757558467; x=1758163267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RotDBc4nduTqvm+cZpyUmQgQq6+4XUNjDl6/pxCSap0=;
        b=SE078ddxJ8chxrgoYfiiwfnvtxDEBIJIZOK/pkpBcoH6L/V6NF42yMf1JJfe74NX66
         vdOH7blW3HywV5WolbqVjz4CFB9B52vkfdcVFvFyTt2xkA/5gcwQm8h1ssyJ3HvlVgwv
         2no2J4X7I7Nov/M7FAJrt9a41Qh1vlUg4NYdABMcGMf/vp9hrtAcQxI4xzdxKfn5cwS0
         zl37hsIZtMDzCBdeL683mulkUD9KwtnDyJZku8ZkP33Rl+OAUgJzOgDNjZZyKUwen6+m
         c977kMKzCQ7YEvUmzAmRJsgJo8IPWl4SlhqIgzipsEFV2CAZ5YrAT/09NEiGT47f1Sdu
         mVww==
X-Forwarded-Encrypted: i=1; AJvYcCXboQVHn25Bl5jMCKCAVz6RzDSvF8tcjCoDNAHYIAMHrMHNA7t1e3Skb0VNJVsqY4If9Opiezs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJrHgwsQI3Otm/NLSzvHSLy6/P7UGWsAfd2DYYidefCSSYmFJ0
	S1WFY1/kUsAB0qxoTw+PNYktqics2rzNoIlU9berMc9lW4xlkL7FoUd9
X-Gm-Gg: ASbGncvX1ZXrorBhsnrxh+nV8PqT10Wnj8iB/cP9WVgXH0NHkwGKrV2VJ1T30Tv++tR
	5Y526rJ5dshn8TIoSY4sfrzkDtgv59WbNfdH5736qVsB6D2nDarAgI2Hmm+TIglGdCU5tAZJSss
	KOXuixKfE7cDc3jy/w41xH9LCrsAtykrHAnLNAxLPW7dyitgOYZ8ZnTf8f935smXRbxCztYejzW
	R0ivEz5M8+g8jTm97O7Q8IwT0/8nodPP/ebUsWWXa85lSJsKbjvHvuS2s4Iyu6Bf3SYOBSWFfu9
	YT5VFRm6bWPp76jMU+2QMwiUIzkJ1L5HqwS+aiz7/gPTURiz0NmIV/UipZjf+yN+MTpuAqeAJAQ
	3xUP+phzDyT7mR+oa4Sr2LhNmY3Fgu0rMO8vVzOd2ywTn7NQ1Up57ZTBxkU7zGjsrX7PzyAtW5p
	5D9eEoIXbXC0cIOH6juPrY7IwXGSQN
X-Google-Smtp-Source: AGHT+IF6DEdmkzIwhlwOvXdHfSRwOtFEwFUfp7ZMeoL357UAoG42oyov+M9vvQIIxvaPMU5TR0IIAA==
X-Received: by 2002:a05:6a00:17a7:b0:772:398a:7655 with SMTP id d2e1a72fcca58-7742df033a2mr22466192b3a.23.1757558467212;
        Wed, 10 Sep 2025 19:41:07 -0700 (PDT)
Received: from arch-pc.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b17e23sm292579b3a.55.2025.09.10.19.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 19:41:06 -0700 (PDT)
From: Ben Chuang <benchuanggli@gmail.com>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org
Cc: victor.shih@genesyslogic.com.tw,
	ben.chuang@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	SeanHY.Chen@genesyslogic.com.tw,
	benchuanggli@gmail.com,
	victorshihgli@gmail.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 2/3] mmc: sdhci-uhs2: Fix calling incorrect sdhci_set_clock() function
Date: Thu, 11 Sep 2025 10:41:01 +0800
Message-ID: <6ac048c1a709e473f885c513b970fe355848484d.1757557996.git.benchuanggli@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <736d7edd2d361f2a8fc01b112802f7c4dd68b7d6.1757557996.git.benchuanggli@gmail.com>
References: <736d7edd2d361f2a8fc01b112802f7c4dd68b7d6.1757557996.git.benchuanggli@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Fix calling incorrect sdhci_set_clock() in __sdhci_uhs2_set_ios() when the
vendor defines its own sdhci_set_clock().

Fixes: 10c8298a052b ("mmc: sdhci-uhs2: add set_ios()")
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
v3:
 * kepp "host->clock = ios->clock;" to part1.

v2:
 * remove the "if (host->ops->set_clock)" statement
 * add "host->clock = ios->clock;"

v1:
 * https://lore.kernel.org/all/20250901094046.3903-1-benchuanggli@gmail.com/
---
 drivers/mmc/host/sdhci-uhs2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 18fb6ee5b96a..c459a08d01da 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -295,7 +295,7 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
 
-	sdhci_set_clock(host, ios->clock);
+	host->ops->set_clock(host, ios->clock);
 	host->clock = ios->clock;
 }
 
-- 
2.51.0


