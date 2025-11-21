Return-Path: <stable+bounces-195495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B4FC7894A
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 11:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7D488346069
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 10:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7A5346A01;
	Fri, 21 Nov 2025 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyIBHvit"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9363469F3;
	Fri, 21 Nov 2025 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763722584; cv=none; b=SEu7/IIZsimPm7rwv7rb2UeqUmugXsT9PShWPvSqCcVTY9hsP9WPQoNs9PRp0uCjG1TORbo+22I9K721lsdQwY8SfshnA70Nj5O59SeBm8ox3SZuVwSMVjqYIOr3k3cxl6Yy/EphCVkRbnA6x/uMVExrP8uW6UAxMmmIHawwxk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763722584; c=relaxed/simple;
	bh=3PdZEHZJIsoZgazDyJX/UvoaW9hS03UfAoFLlgp8ynI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aSy6aBcUv/vtJNR0QX/fksaNpnsHhDgb7ZxlQYJyT4EMrXzbBt1uAwM+EwttleCUL8i3WSEXgHYxMBLs7fmIbs8/2fOFuwnbr3plKsGLR4t4lJ0pL/g9x5k3xoPZJlKvEIFhJa5QHaZh2ONkUb6IdcGaKwOGKt9mXRnxqdMWACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyIBHvit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFF1C4CEF1;
	Fri, 21 Nov 2025 10:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763722583;
	bh=3PdZEHZJIsoZgazDyJX/UvoaW9hS03UfAoFLlgp8ynI=;
	h=From:To:Cc:Subject:Date:From;
	b=IyIBHvit3llyJ24QinV6i2JLDFv1TlxRTVwLfaQ8ZC8m67rcRugKtQlthncrvoG0Q
	 FX8rA3yI3kgTv4gB5y9pIj7lxnm+s7hNofbkNG6c/y9/tPAxVfFKpEdlgoCwHnntXn
	 ggh2SBVI4ZvPzxgx3wOyLBtdOCICwkxEUSludJWY49Mkr21KZI1TZwb56kR8ybCRB5
	 25P1vmFoMa7hEeLwnQNk2prOqeieCOoDaBCypowCl/diYTehKJhJjBcJnceiCUCHqV
	 0W2XlEPPZ7nxcFCUR9NJvalblUkyIKOWwj7/4OSSQwqZ9TAbF19HlwFu2IZ0b57wyz
	 XiOCjl+qsNlSw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vMOoR-000000008WO-1opl;
	Fri, 21 Nov 2025 11:56:23 +0100
From: Johan Hovold <johan@kernel.org>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] intel_th: fix device leak on output open()
Date: Fri, 21 Nov 2025 11:55:55 +0100
Message-ID: <20251121105555.32725-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken when looking up the th device
during output device open() on errors and on close().

Fixes: 39f4034693b7 ("intel_th: Add driver infrastructure for Intel(R) Trace Hub devices")
Cc: stable@vger.kernel.org	# 4.4
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---

Hit send too soon...

Changes in v2:
 - drop reference also on the last error path


 drivers/hwtracing/intel_th/core.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 47d9e6c3bac0..bc38814e6802 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -810,13 +810,20 @@ static int intel_th_output_open(struct inode *inode, struct file *file)
 	int err;
 
 	dev = bus_find_device_by_devt(&intel_th_bus, inode->i_rdev);
-	if (!dev || !dev->driver)
+	if (!dev)
 		return -ENODEV;
 
+	if (!dev->driver) {
+		err = -ENODEV;
+		goto err_put_dev;
+	}
+
 	thdrv = to_intel_th_driver(dev->driver);
 	fops = fops_get(thdrv->fops);
-	if (!fops)
-		return -ENODEV;
+	if (!fops) {
+		err = -ENODEV;
+		goto err_put_dev;
+	}
 
 	replace_fops(file, fops);
 
@@ -824,14 +831,29 @@ static int intel_th_output_open(struct inode *inode, struct file *file)
 
 	if (file->f_op->open) {
 		err = file->f_op->open(inode, file);
-		return err;
+		goto err_put_dev;
 	}
 
+	return 0;
+
+err_put_dev:
+	put_device(dev);
+
+	return err;
+}
+
+static int intel_th_output_release(struct inode *inode, struct file *file)
+{
+	struct intel_th_device *thdev = file->private_data;
+
+	put_device(&thdev->dev);
+
 	return 0;
 }
 
 static const struct file_operations intel_th_output_fops = {
 	.open	= intel_th_output_open,
+	.release = intel_th_output_release,
 	.llseek	= noop_llseek,
 };
 
-- 
2.51.2


