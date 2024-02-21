Return-Path: <stable+bounces-23181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7677585DFAD
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D971F2490E
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF297CF2D;
	Wed, 21 Feb 2024 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="fFq/tAUQ"
X-Original-To: stable@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36F644377
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525842; cv=none; b=seVY/XagUrz7pSGuZ1F+Mez4CgmKAzcg+9tmMzz1atbDqWDAK1kc9QXJGO8yvc2hV8R/vwzfvxy7FOyRUgSdi/lDGnG7lNkIigBZODZyyw0A5Zauf0v9PzhSGTvqtVH/nSVu6xomatZPlSJA9hRMFMuuURWKamBpilzW2A8ilYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525842; c=relaxed/simple;
	bh=GrxON3lYNCAufVUexAxR/Gp6ZPDPCKxndYGM/vP6fyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vr42tDGOoLKsVslpiZ/75vNob72nr6+OTQY/JeDv1U/fnFBeGs9Vz+sbpBonaUYBHbcRTZma7+ZbM1EBaJ7JkWJgF59ngQ2yIYgON8LmCVqRLOaEhBMcFPovXRux9reLH1EX1rBkyaDpdQc2KJShIwFuetvAsPIXvEOXItWEPyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=fFq/tAUQ; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240221143030851898b67a726f480b
        for <stable@vger.kernel.org>;
        Wed, 21 Feb 2024 15:30:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=WD5sp0uEiG8G/0YYO+dG4YqOi0XkzyajJD2J/jfY3c4=;
 b=fFq/tAUQ+oYgNPMLW2f5fBEmJQ1PKMaHRI170KiT2rYs4goB+kFWJ+riOlAje8ruXayh9K
 /D+hYJNERjToUeWrmY1wC546mOzW+gh8IJmk5bSMkhKgCTA7p58mlFUuQ6+v0wtnsBQlyLDl
 actetFqLMOa2tMZjDS8nbRzvrFm0I=;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Lee Jones <lee@kernel.org>,
	Andreas Kemnade <andreas@kemnade.info>,
	stable@vger.kernel.org
Subject: [PATCH] mfd: twl: select MFD_CORE
Date: Wed, 21 Feb 2024 15:30:18 +0100
Message-ID: <20240221143021.3542736-1-alexander.sverdlin@siemens.com>
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

Fix link error:
ld.bfd: drivers/mfd/twl-core.o: in function `twl_probe':
git/drivers/mfd/twl-core.c:846: undefined reference to `devm_mfd_add_devices'

Cc: <stable@vger.kernel.org>
Fixes: 63416320419e ("mfd: twl-core: Add a clock subdevice for the TWL6032")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 90ce58fd629e5..1195a27c881e4 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1772,6 +1772,7 @@ config TWL4030_CORE
 	bool "TI TWL4030/TWL5030/TWL6030/TPS659x0 Support"
 	depends on I2C=y
 	select IRQ_DOMAIN
+	select MFD_CORE
 	select REGMAP_I2C
 	help
 	  Say yes here if you have TWL4030 / TWL6030 family chip on your board.
-- 
2.43.0


