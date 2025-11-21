Return-Path: <stable+bounces-195494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 991F4C78932
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 11:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 5AB4C241A0
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 10:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB6D3431E4;
	Fri, 21 Nov 2025 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z33DhX8G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F5B338918;
	Fri, 21 Nov 2025 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763722276; cv=none; b=RD5m0XOph+9tnjHlaQgHs2c+HITwdk0o0fWsENLJUS6+W2ark9xsWbBuKY4zZTS/cMaxZFruPfIAqe0DdOgYodcJY1nFFGjfzNj3q6nnCHHpmgZ0BuBo/y6bRJGq6mKP1Iyuw6P4GFVQnl62zZ3iTeA4ZVXpPUhy4jW6UgD2+C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763722276; c=relaxed/simple;
	bh=mUQ79EgFWQ3qxvQut5oXT7nQ0ISBwtGd1kd3Tu0r0/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iygnjd/oOCFRC88ORk07nSyiQGrr4rN7ibVJNa+ApJ6p51m1H2oE2sxuSLZZBIDaGNcp2vYcNIqC4v0Wh9k04pSv7eEwt2/Hc7PhfyTedOnEHsWzFofo/q60y9njd/8gqdPPbbNBNS8e5IXGmmxDKNODpPpsmvsyA0RBhMnrxyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z33DhX8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C35C4CEF1;
	Fri, 21 Nov 2025 10:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763722276;
	bh=mUQ79EgFWQ3qxvQut5oXT7nQ0ISBwtGd1kd3Tu0r0/k=;
	h=From:To:Cc:Subject:Date:From;
	b=Z33DhX8G+ZlxpysicEN/4Oq/KwNmaKXmhIXv9yUZ7JkSHhp+acZ/mGABH1PjJGmss
	 gio2JhxDsbvTMUZePl0pE+wz35xE9bGWEpa/k7p75gk0ukWEoLrCM2AevP6c6cgyN2
	 qYDsNp3JDBfhvcN1aFA7kZT53ZAHXkSA0YRF3hRCbbd7xNV2VCsjsb6JljZXkzAOhM
	 hpYQ9Oa5v4yS4dPkbIzeuUafV6uQSRbHcw2Nbk9CDQkIzhCet1u1lubRhyplNJyQoP
	 PurtCNLANIs2Dw75pt4V1apovGEu4Hf6kwH4ZFOPuh3A/eoshwq7eZzuP1BvyObmSZ
	 v+LgFHRJfgX5g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vMOjT-000000007eX-35fO;
	Fri, 21 Nov 2025 11:51:16 +0100
From: Johan Hovold <johan@kernel.org>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] intel_th: fix device leak on output open()
Date: Fri, 21 Nov 2025 11:51:05 +0100
Message-ID: <20251121105105.29403-1-johan@kernel.org>
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
 drivers/hwtracing/intel_th/core.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 47d9e6c3bac0..ddc51de2d775 100644
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
 
@@ -827,11 +834,26 @@ static int intel_th_output_open(struct inode *inode, struct file *file)
 		return err;
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


