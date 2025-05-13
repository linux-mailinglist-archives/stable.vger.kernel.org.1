Return-Path: <stable+bounces-144134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 422CDAB4E30
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 10:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC19119E076E
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 08:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0598C20766E;
	Tue, 13 May 2025 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="f/cgcOnW"
X-Original-To: stable@vger.kernel.org
Received: from forward200b.mail.yandex.net (forward200b.mail.yandex.net [178.154.239.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F0C4C6C;
	Tue, 13 May 2025 08:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747125292; cv=none; b=QhCZBHXbflr+cTMWCfAVZUgqCzvYuxGC3XWCRwD9B3j0zSS+BfixL1Y8JY0I7ZbIdysSJQ2eOEtxJN9nZgns1VAp+PnwyzS2hB5xAzCL6e0iBtRyWaS0RJnGnPNFyCuBRg0p74JsPSOkve3a6KZzm/KeSmQ4PUDfwVuXx8JMdQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747125292; c=relaxed/simple;
	bh=hYEZhT0rjcfx1YSa8YgQAEFvxp+4UDB6FPkUh10hD3A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DtmdGSfmWfQ/LLALgnbZh3BcHoiU+PdrxrPw8NZinSZVBzuLlKL0YKNSdZXl5NOddd4v1xhj1mZn4Lld6gjwo+fAdO2nzj9DQ7afcyD94ICp7miGxlqaJPZDkdEhHnNbB93IgBiUDvRY3nNb5lleGOi6SHvE6hODeSKCE1SRSwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=f/cgcOnW; arc=none smtp.client-ip=178.154.239.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward200b.mail.yandex.net (Yandex) with ESMTPS id 216B066598;
	Tue, 13 May 2025 11:28:27 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:740a:0:640:fb7d:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 1CCE260A0A;
	Tue, 13 May 2025 11:28:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 7SBqoZ6LmmI0-j95Imxz2;
	Tue, 13 May 2025 11:28:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1747124898; bh=YFLJIFdIz7AuJegxGHvHpBo2JpT7LU7z0UDvryUuXSo=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=f/cgcOnWejOAKW6GXfioWsqdE7yvQ9yaBEDtW/2wWGZ4UCbhmIBoV82GSuXTU2Z5S
	 sStQIilXLiDNT2qo8X5REHZpxlv1S3GPMtgHPMVHUHLPgT325fTaItLfzlTEnHi17r
	 gQ3VNIIEzjmUw6YFimADs3eW2imAkc8vdKMtGuII=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Andrey Tsygunka <aitsygunka@yandex.ru>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrey Tsygunka <aitsygunka@yandex.ru>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v3] misc: sram: Fix NULL pointer dereference in sram_probe
Date: Tue, 13 May 2025 11:27:57 +0300
Message-Id: <20250513082757.1323953-1-aitsygunka@yandex.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a check for the return value from platform_get_resource() call
to be NULL.

If the passed device-tree contains a node for sram-device
without a specified '<reg>' property value, for example:

    sram: sram@5c0000000 {
        compatible = "nvidia,tegra186-sysram";
    };

and the of_device_id[] '.data' element contains a sram_config*
with '.map_only_reserved = true' property, we get the error:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.96 #1
Hardware name: linux,dummy-virt (DT)
Call trace:
  sram_probe+0x134/0xd30
  platform_probe+0x94/0x130
  really_probe+0x124/0x580
  __driver_probe_device+0xd0/0x1f0
  driver_probe_device+0x50/0x1c0
  __device_attach_driver+0x140/0x220
  bus_for_each_drv+0xbc/0x130
  __device_attach+0xec/0x2c0
  device_initial_probe+0x24/0x40
  bus_probe_device+0xd8/0xe0
  device_add+0x67c/0xc80
  of_device_add+0x58/0x80
  of_platform_device_create_pdata+0xd0/0x1b0
  of_platform_bus_create+0x27c/0x6f0
  of_platform_populate+0xac/0x1d0
  of_platform_default_populate_init+0x10c/0x130
  do_one_initcall+0xdc/0x510
  kernel_init_freeable+0x43c/0x4d8
  kernel_init+0x2c/0x1e0
  ret_from_fork+0x10/0x20

Fixes: 444b0111f3bc ("misc: sram: use devm_platform_ioremap_resource_wc()")
Signed-off-by: Andrey Tsygunka <aitsygunka@yandex.ru>
---
v3: Removed unnecessary 'unlikely()'.
https://lore.kernel.org/lkml/2025041528-garment-senior-1c71@gregkh/
v2: Description changed based on comments from Markus Elfring
at https://lore.kernel.org/linux-kernel/84969aba-67ba-4990-9065-6b55ce26ff92@web.de/,
added tag 'Fixes', removed useless information from backtrace.

 drivers/misc/sram.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index e5069882457e..f308bfc56645 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -410,8 +410,13 @@ static int sram_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	ret = sram_reserve_regions(sram,
-			platform_get_resource(pdev, IORESOURCE_MEM, 0));
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "invalid resource\n");
+		return -EINVAL;
+	}
+
+	ret = sram_reserve_regions(sram, res);
 	if (ret)
 		return ret;
 
-- 
2.25.1


