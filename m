Return-Path: <stable+bounces-163318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58484B099C2
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 04:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2E4C567F7C
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 02:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC2C1A23B9;
	Fri, 18 Jul 2025 02:30:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3223B7A8;
	Fri, 18 Jul 2025 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752805812; cv=none; b=Gmg5cpNHv8mhCEhiOU3DAlB8aPCzElBsD0KmJ/7PbM7G9c6EH2r2MuzFFIrnNM/Z2DWQIog8ADHqEGPj+zVP6VFyGCdWv8FP4zN/zgLxPbkKSp3TEXevszCk8duQJRzCact1C+7k2bxxYSkfwEh016UyngfIC2QzFDKqOUuaoyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752805812; c=relaxed/simple;
	bh=HOMcPasnzSidNrBnIyvuMBKorMhvBQvbHP88kZYZI54=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LO28IWDC+5LwJZlIh1hfUh75COa1hvORIwtTQn58dcyWYWI17wkyUAJ+PH+eiAKbDClaxvPjYtu/S/OOFNWj9yQprEdcJcCWC8weAP3/xFobmYhhPbkueHPQMpxxV8QfrssviKTsVWkAb6JJr+cZRgCf80TRFul1wUbGtLfaq/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [211.71.28.34])
	by APP-05 (Coremail) with SMTP id zQCowACHGVqVsXloxIL+BA--.29413S2;
	Fri, 18 Jul 2025 10:29:53 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com,
	bwidawsk@kernel.org
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] cxl/region: Fix potential double free of region device in delete_region_store
Date: Fri, 18 Jul 2025 10:29:40 +0800
Message-Id: <20250718022940.3387882-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACHGVqVsXloxIL+BA--.29413S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4xJryxXFWrWr4ktr4DXFb_yoW8Wry7p3
	yUCa4aqrWrG34I9rn8ZrWkZr98uF4qy34rCrs7Gw10krs5XryFyrW8ta4UtFy5A3s7Ar1U
	X343trWrCay5A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1FAp5UU
	UUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

cxl_find_region_by_name() uses device_find_child_by_name() to locate a
region device by name. This function implicitly increments the
device's reference count before returning the pointer by calling
device_find_child(). However, in delete_region_store(), after calling
devm_release_action() which synchronously executes
unregister_region(), an additional explicit put_device() is invoked.
The unregister_region() callback already contains a put_device() call
to decrement the reference count. This results in two consecutive
decrements of the same device's reference count. First decrement
occurs in unregister_region() via its put_device() call. Second
decrement occurs in delete_region_store() via the explicit
put_device(). We should remove the additional put_device().

As comment of device_find_child() says, 'NOTE: you will need to drop
the reference with put_device() after use'.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/cxl/core/region.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6e5e1460068d..eacf726cf463 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2672,7 +2672,6 @@ static ssize_t delete_region_store(struct device *dev,
 		return PTR_ERR(cxlr);
 
 	devm_release_action(port->uport_dev, unregister_region, cxlr);
-	put_device(&cxlr->dev);
 
 	return len;
 }
-- 
2.25.1


