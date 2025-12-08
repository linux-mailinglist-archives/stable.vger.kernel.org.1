Return-Path: <stable+bounces-200365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3290CAD9AC
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 16:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3B733037519
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 15:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F18267B02;
	Mon,  8 Dec 2025 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwMMglPO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D567257827;
	Mon,  8 Dec 2025 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765208016; cv=none; b=HCS3cKnrS/9Ma0+SqwI+M+nZVvlkSbakfLfrZK5Z4IhH8HlhLg1wuapZbUYqHDTgbMH/kqqXL1Y8w21Pqag2ydcLTID5ereFD1BXFSJpOTcmrDc1LPvrIZqKjJAHv/Eg2ekND6uBbLiLi20TLek8i2QM/i9Kx5hpJEl3wxs7CPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765208016; c=relaxed/simple;
	bh=JzChizaMptQuaUyxIHNbpeOYb3WcBEBXbOT1HudJBKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijmCFheSJGYyyjosmmoLa+7Y8S5QDmGjC+41mN1KTdGsmLXtE/4OTusjTWWexALOzytnG+ZRY6yc5sRRKeCOeOwn5r99r1S4j0rFGkXAyOCyTRzH1h0AvdOduPP+T3GOFRPA+39t7nlV2S6tpJVoDNOSaSd8xhLevqRWEUxSCME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwMMglPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42488C116B1;
	Mon,  8 Dec 2025 15:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765208016;
	bh=JzChizaMptQuaUyxIHNbpeOYb3WcBEBXbOT1HudJBKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dwMMglPO9Vz53jgqIjAUKPAMNezFK0TkGFszcIR5hKCrbN/U6H6UMlZIpjO2z5ZCH
	 pWaLAGcaj4iDwkd6SRts+JTFHaFXrQQ+QfEiypHWJcIl2ldT8YsT/nPTWF2tT1bntJ
	 bS4vMJ4RHNFBpB3csVIAbfR4K2RFjvJK8eUsG/rMAxQ7fruBmkYymj/IZNkIQC/A2k
	 FIhMqtg1CxJgxwMqUwfxw/OxdDfNjnQy916ParFY9Erm8F4RCOXawL37MezNoo3v/B
	 8ax2alwX8QhZP7d0148rnFr+6IMtp+8b1hD2qQGC7mQ+zE/zu599/ZXSQRYeK6AArG
	 CHjDnr6rgy4WQ==
Received: from johan by theta with local (Exim 4.99)
	(envelope-from <johan@kernel.org>)
	id 1vSdGx-00000000HrX-1Qxu;
	Mon, 08 Dec 2025 16:35:35 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH v3 1/2] intel_th: fix device leak on output open()
Date: Mon,  8 Dec 2025 16:35:23 +0100
Message-ID: <20251208153524.68637-2-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251208153524.68637-1-johan@kernel.org>
References: <20251208153524.68637-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken when looking up the th device
during output device open() on errors and on close().

Note that a recent commit fixed the leak in a couple of open() error
paths but not all of them, and the reference is still leaking on
successful open().

Fixes: 39f4034693b7 ("intel_th: Add driver infrastructure for Intel(R) Trace Hub devices")
Fixes: 6d5925b667e4 ("intel_th: Fix error handling in intel_th_output_open")
Cc: stable@vger.kernel.org	# 4.4: 6d5925b667e4
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ma Ke <make24@iscas.ac.cn>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/hwtracing/intel_th/core.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 591b7c12aae5..d9c17214d3dc 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -810,9 +810,12 @@ static int intel_th_output_open(struct inode *inode, struct file *file)
 	int err;
 
 	dev = bus_find_device_by_devt(&intel_th_bus, inode->i_rdev);
-	if (!dev || !dev->driver) {
+	if (!dev)
+		return -ENODEV;
+
+	if (!dev->driver) {
 		err = -ENODEV;
-		goto out_no_device;
+		goto out_put_device;
 	}
 
 	thdrv = to_intel_th_driver(dev->driver);
@@ -836,12 +839,22 @@ static int intel_th_output_open(struct inode *inode, struct file *file)
 
 out_put_device:
 	put_device(dev);
-out_no_device:
+
 	return err;
 }
 
+static int intel_th_output_release(struct inode *inode, struct file *file)
+{
+	struct intel_th_device *thdev = file->private_data;
+
+	put_device(&thdev->dev);
+
+	return 0;
+}
+
 static const struct file_operations intel_th_output_fops = {
 	.open	= intel_th_output_open,
+	.release = intel_th_output_release,
 	.llseek	= noop_llseek,
 };
 
-- 
2.52.0


