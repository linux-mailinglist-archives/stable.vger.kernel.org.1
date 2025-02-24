Return-Path: <stable+bounces-119265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91067A42588
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DB0C19C5B8F
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A0123BD1A;
	Mon, 24 Feb 2025 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tQrh6nqG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3713254849;
	Mon, 24 Feb 2025 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408875; cv=none; b=aM5cU6j5SsVzXmLX+NUEUakODYjtl5jRCdZoXt8YvJ/DWjE1svpUaQzGseWj8Cs3jQS4m14k9eaa54kSqdP2QKWW5oAZNMAnHybAkHhc9t5S43t8S8jSdMWIEUAsCFTGFXZnUHP3JBHjXBjrhORsNyR0jeR9hpe03bQr35YxLKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408875; c=relaxed/simple;
	bh=q0fdf0tcqEiWlMVWIL38NQ8QNddob6HkH3Y2svCQqII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWvBnBHtuYX3ZGWfI2YIBTtjjmQKsv42/YZtNJ/KErOKCACRiqRvZLFpMmiu/0c/nJ8fMJOStB1IzUxP/SaW3cqdK3EHGXLMh/TGInJ7QAalanJ8jqN+STImQrFIF+MyX7ke9NSYJXYG1LvUZG+4ZoNS3+c/esb2u99fXGzGWvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tQrh6nqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7BFC4CEE6;
	Mon, 24 Feb 2025 14:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740408875;
	bh=q0fdf0tcqEiWlMVWIL38NQ8QNddob6HkH3Y2svCQqII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tQrh6nqGFzxdfH124PMUes5Z2lSa80X8qBNK+00w3ak1jBonHRD0g2TUQ1ePE/rFb
	 Thtx5+yXZ9YNTCcGEWqpWnajeJR6ON1JC5Auibduj2muv7g8nzDtjhvScSXHRDKyfc
	 KT8L5tsjNOybnj9e/EkVrbaPFLBVrajMJw1ua3dk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexandra Winter <wintera@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 032/138] s390/ism: add release function for struct device
Date: Mon, 24 Feb 2025 15:34:22 +0100
Message-ID: <20250224142605.731558447@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142604.442289573@linuxfoundation.org>
References: <20250224142604.442289573@linuxfoundation.org>
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

From: Julian Ruess <julianr@linux.ibm.com>

[ Upstream commit 915e34d5ad35a6a9e56113f852ade4a730fb88f0 ]

According to device_release() in /drivers/base/core.c,
a device without a release function is a broken device
and must be fixed.

The current code directly frees the device after calling device_add()
without waiting for other kernel parts to release their references.
Thus, a reference could still be held to a struct device,
e.g., by sysfs, leading to potential use-after-free
issues if a proper release function is not set.

Fixes: 8c81ba20349d ("net/smc: De-tangle ism and smc device initialization")
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250214120137.563409-1-wintera@linux.ibm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/ism_drv.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index e36e3ea165d3b..2f34761e64135 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -588,6 +588,15 @@ static int ism_dev_init(struct ism_dev *ism)
 	return ret;
 }
 
+static void ism_dev_release(struct device *dev)
+{
+	struct ism_dev *ism;
+
+	ism = container_of(dev, struct ism_dev, dev);
+
+	kfree(ism);
+}
+
 static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct ism_dev *ism;
@@ -601,6 +610,7 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev_set_drvdata(&pdev->dev, ism);
 	ism->pdev = pdev;
 	ism->dev.parent = &pdev->dev;
+	ism->dev.release = ism_dev_release;
 	device_initialize(&ism->dev);
 	dev_set_name(&ism->dev, dev_name(&pdev->dev));
 	ret = device_add(&ism->dev);
@@ -637,7 +647,7 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	device_del(&ism->dev);
 err_dev:
 	dev_set_drvdata(&pdev->dev, NULL);
-	kfree(ism);
+	put_device(&ism->dev);
 
 	return ret;
 }
@@ -682,7 +692,7 @@ static void ism_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 	device_del(&ism->dev);
 	dev_set_drvdata(&pdev->dev, NULL);
-	kfree(ism);
+	put_device(&ism->dev);
 }
 
 static struct pci_driver ism_driver = {
-- 
2.39.5




