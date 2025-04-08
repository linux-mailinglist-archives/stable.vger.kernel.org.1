Return-Path: <stable+bounces-130663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49153A805A7
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10ED4A4C7E
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1380E269CE8;
	Tue,  8 Apr 2025 12:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O10pWNhU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45F02690FA;
	Tue,  8 Apr 2025 12:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114314; cv=none; b=ZwrzcXamk3goSPaG3sFo8BlSc39LJVczPWoz0RO71I+GBHgrpslPfKj2m7kbJNjQWIvBpPlE2BoB8Mywrhbl0ERzHgr+IpBpO46pTZypuvr1dwFJyJosiLesEM8CVE7KqBLusavv3TYM59L1C+YKQ76yRyGWC5mHpCxEH3ZJrDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114314; c=relaxed/simple;
	bh=euBEaNod13PyZlAB8SKXf1vo4MAR4BRo3lzqkNrc1u4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmemhyLIYByMVJs3O7PlQ39+cVN5sYUY/EpPOY2GUxB9pcIgGE3fQJmD6TYB+hHie4Eo1+2k0rXPWYb+fjaZc706Bj6KKpsPly+sivTF+MRuNtHTohs84dTmXvc9fEkMULCeApoj7LiIzAb8/ozPFhfRW1P1tAycpEVqLF5jpzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O10pWNhU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D6FC4CEE5;
	Tue,  8 Apr 2025 12:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114314;
	bh=euBEaNod13PyZlAB8SKXf1vo4MAR4BRo3lzqkNrc1u4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O10pWNhUFod3g9etPQ1VxsW/Tn9BqJPg3MvR+fI6PbJ3nsXAlToRPY5YRFtTUbnc7
	 ZJYD4eiP0WASVdd0rpySQRJe9TsrGpzuBMpGP7WNfIxUenz5QPUVWhibOdc1wUEeTa
	 oNaSBU7/3N01OqhnznEb2mgQl8VAzTqMGBIt5o10=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 061/499] drm/ssd130x: Set SPI .id_table to prevent an SPI core warning
Date: Tue,  8 Apr 2025 12:44:33 +0200
Message-ID: <20250408104852.756152639@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Javier Martinez Canillas <javierm@redhat.com>

[ Upstream commit 5d40d4fae6f2fb789f48207a9d4772bbee970b5c ]

The only reason for the ssd130x-spi driver to have an spi_device_id table
is that the SPI core always reports an "spi:" MODALIAS, even when the SPI
device has been registered via a Device Tree Blob.

Without spi_device_id table information in the module's metadata, module
autoloading would not work because there won't be an alias that matches
the MODALIAS reported by the SPI core.

This spi_device_id table is not needed for device matching though, since
the of_device_id table is always used in this case. For this reason, the
struct spi_driver .id_table member is currently not set in the SPI driver.

Because the spi_device_id table is always required for module autoloading,
the SPI core checks during driver registration that both an of_device_id
table and a spi_device_id table are present and that they contain the same
entries for all the SPI devices.

Not setting the .id_table member in the driver then confuses the core and
leads to the following warning when the ssd130x-spi driver is registered:

  [   41.091198] SPI driver ssd130x-spi has no spi_device_id for sinowealth,sh1106
  [   41.098614] SPI driver ssd130x-spi has no spi_device_id for solomon,ssd1305
  [   41.105862] SPI driver ssd130x-spi has no spi_device_id for solomon,ssd1306
  [   41.113062] SPI driver ssd130x-spi has no spi_device_id for solomon,ssd1307
  [   41.120247] SPI driver ssd130x-spi has no spi_device_id for solomon,ssd1309
  [   41.127449] SPI driver ssd130x-spi has no spi_device_id for solomon,ssd1322
  [   41.134627] SPI driver ssd130x-spi has no spi_device_id for solomon,ssd1325
  [   41.141784] SPI driver ssd130x-spi has no spi_device_id for solomon,ssd1327
  [   41.149021] SPI driver ssd130x-spi has no spi_device_id for solomon,ssd1331

To prevent the warning, set the .id_table even though it's not necessary.

Since the check is done even for built-in drivers, drop the condition to
only define the ID table when the driver is built as a module. Finally,
rename the variable to use the "_spi_id" convention used for ID tables.

Fixes: 74373977d2ca ("drm/solomon: Add SSD130x OLED displays SPI support")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20241231114516.2063201-1-javierm@redhat.com
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/solomon/ssd130x-spi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x-spi.c b/drivers/gpu/drm/solomon/ssd130x-spi.c
index 08334be386946..7c935870f7d2a 100644
--- a/drivers/gpu/drm/solomon/ssd130x-spi.c
+++ b/drivers/gpu/drm/solomon/ssd130x-spi.c
@@ -151,7 +151,6 @@ static const struct of_device_id ssd130x_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ssd130x_of_match);
 
-#if IS_MODULE(CONFIG_DRM_SSD130X_SPI)
 /*
  * The SPI core always reports a MODALIAS uevent of the form "spi:<dev>", even
  * if the device was registered via OF. This means that the module will not be
@@ -160,7 +159,7 @@ MODULE_DEVICE_TABLE(of, ssd130x_of_match);
  * To workaround this issue, add a SPI device ID table. Even when this should
  * not be needed for this driver to match the registered SPI devices.
  */
-static const struct spi_device_id ssd130x_spi_table[] = {
+static const struct spi_device_id ssd130x_spi_id[] = {
 	/* ssd130x family */
 	{ "sh1106",  SH1106_ID },
 	{ "ssd1305", SSD1305_ID },
@@ -175,14 +174,14 @@ static const struct spi_device_id ssd130x_spi_table[] = {
 	{ "ssd1331", SSD1331_ID },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(spi, ssd130x_spi_table);
-#endif
+MODULE_DEVICE_TABLE(spi, ssd130x_spi_id);
 
 static struct spi_driver ssd130x_spi_driver = {
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = ssd130x_of_match,
 	},
+	.id_table = ssd130x_spi_id,
 	.probe = ssd130x_spi_probe,
 	.remove = ssd130x_spi_remove,
 	.shutdown = ssd130x_spi_shutdown,
-- 
2.39.5




