Return-Path: <stable+bounces-46009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68CE8CDC42
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 23:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81DF328772F
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 21:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1AB127E0E;
	Thu, 23 May 2024 21:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PtWAKfEA"
X-Original-To: stable@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C723823AF;
	Thu, 23 May 2024 21:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716500737; cv=none; b=pDV/8WpozLWIcwz8XOIDNoHVH+njyovFHG0SxFAB9oD+jt0Y4+uF67YuKZ3sx92ssJNW5f8lxuUHAmbYgVmDX62tNhledtUzOJJYr9UGWRTfkio3K/nExJ4AYAParQL56lQYKerkVyIR0NCxrKKKHWfBf8MrRjjK4YfVasomLzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716500737; c=relaxed/simple;
	bh=sh70DTywu3wqQXotgAFqRS5mApT9pgQ+LLx20K47w5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cqvn9f74IP1G8SGvjcVeofmK+gOXYV3IbrHDkJENSNX2Q9u8UhxrA4pexC0yzWALUpO0CukuKXg/jN/A8mZyviPmyYJdwaCQTSayjHPE3aQ49WW3KtTxSAlZLGld/rxuICEbeTx3Lq9zUnRwEERQgx3f4wyAAWHPRo5NVOFMdv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PtWAKfEA; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 15637C0000F4;
	Thu, 23 May 2024 14:45:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 15637C0000F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1716500728;
	bh=sh70DTywu3wqQXotgAFqRS5mApT9pgQ+LLx20K47w5Y=;
	h=From:To:Cc:Subject:Date:From;
	b=PtWAKfEAWQTYtBkTrGaAK6XdygzsTl8sMasludkhyg+1uzTJepGxqLsrM/Sg2QX1S
	 Qxiipgt7r7mjBxJ8iKxlJZNM4CXDJarAoXvl2odcHawB7ketrFfGHUkpjL02hcJZxI
	 aASDeyIRnRmD4G5pwMBzhYcai8yBZvMI+NjKw1zk=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 12B9018041CAC4;
	Thu, 23 May 2024 14:45:26 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Jorge Ramirez-Ortiz <jorge@foundries.io>,
	Avri Altman <avri.altman@wdc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND...),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH stable 4.19] mmc: core: Do not force a retune before RPMB switch
Date: Thu, 23 May 2024 14:45:20 -0700
Message-Id: <20240523214525.200347-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jorge Ramirez-Ortiz <jorge@foundries.io>

commit 67380251e8bbd3302c64fea07f95c31971b91c22 upstream

Requesting a retune before switching to the RPMB partition has been
observed to cause CRC errors on the RPMB reads (-EILSEQ).

Since RPMB reads can not be retried, the clients would be directly
affected by the errors.

This commit disables the retune request prior to switching to the RPMB
partition: mmc_retune_pause() no longer triggers a retune before the
pause period begins.

This was verified with the sdhci-of-arasan driver (ZynqMP) configured
for HS200 using two separate eMMC cards (DG4064 and 064GB2). In both
cases, the error was easy to reproduce triggering every few tenths of
reads.

With this commit, systems that were utilizing OP-TEE to access RPMB
variables will experience an enhanced performance. Specifically, when
OP-TEE is configured to employ RPMB as a secure storage solution, it not
only writes the data but also the secure filesystem within the
partition. As a result, retrieving any variable involves multiple RPMB
reads, typically around five.

For context, on ZynqMP, each retune request consumed approximately
8ms. Consequently, reading any RPMB variable used to take at the very
minimum 40ms.

After droping the need to retune before switching to the RPMB partition,
this is no longer the case.

Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
Acked-by: Avri Altman <avri.altman@wdc.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20240103112911.2954632-1-jorge@foundries.io
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/mmc/core/host.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 3e94401c0eb3..23d95d2bdf05 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -68,13 +68,12 @@ void mmc_retune_enable(struct mmc_host *host)
 
 /*
  * Pause re-tuning for a small set of operations.  The pause begins after the
- * next command and after first doing re-tuning.
+ * next command.
  */
 void mmc_retune_pause(struct mmc_host *host)
 {
 	if (!host->retune_paused) {
 		host->retune_paused = 1;
-		mmc_retune_needed(host);
 		mmc_retune_hold(host);
 	}
 }
-- 
2.34.1


