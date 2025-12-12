Return-Path: <stable+bounces-200879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A72CB83B1
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 09:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF977300CEBA
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 08:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C485B2EBDFA;
	Fri, 12 Dec 2025 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b="pEpGvb+1"
X-Original-To: stable@vger.kernel.org
Received: from r3-19.sinamail.sina.com.cn (r3-19.sinamail.sina.com.cn [202.108.3.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0DB28FFF6
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765527629; cv=none; b=Yam01JH7DktfI55UGm795PcDJPLmg+UQsUew+owpqgUi/eobQhuUFeR+DVnjiFi5aXB/UX3+TdSROAeeJJui3PfVgaEe8s3ztC5epXSKQxbCrcojDnbbQ2TQ9Uu83Keiao+19ryqFGSuBrVh1f9g2OR3BO5geVPS0QBle2EBy70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765527629; c=relaxed/simple;
	bh=8rccHUfiXvP2tOulXglJjm3LCvvqst1i5+KKiNewQJY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=jPKGUKZwMG/X/Bfz9rwjE7qzzZebUzcHwI7Iau7CJNmJUN/1upvBMbIKTUOACsiAxKje7oKrQylZiL/Nlrba4mb4WHx8+5IbhjLmfFk8DmBx1rxLt8dzVvUawHEDFgktJqXQsZLNiLSjZUxCQfY7LawosYhx9v5Vegd8YYqmtiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn; spf=pass smtp.mailfrom=sina.cn; dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b=pEpGvb+1; arc=none smtp.client-ip=202.108.3.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.cn; s=201208; t=1765527622;
	bh=zipljFZAy8zy0iS6kyy/fHUrDHJeN2WF/6PaPyE70ek=;
	h=From:Subject:Date:Message-Id;
	b=pEpGvb+1IOCp8/W7mt27vtTJe4Mp/MQ4De+z+h7aFfMAvLryBh3uaUFxgBJDZFuKx
	 IE46Gt/rPebhJOo5NtFO0K+HyXzjOEO1NeYHj4I1quV6AYq/poQlQK+DkicCJ6fuOY
	 rKCQkmOS915Pb2ScBu5T6MQFaws8mij/iM9BDuT8=
X-SMAIL-HELO: sina-kernel-team
Received: from unknown (HELO sina-kernel-team)([183.241.245.185])
	by sina.cn (10.54.253.32) with ESMTP
	id 693BD03400003B3E; Fri, 12 Dec 2025 16:20:12 +0800 (CST)
X-Sender: xnguchen@sina.cn
X-Auth-ID: xnguchen@sina.cn
Authentication-Results: sina.cn;
	 spf=none smtp.mailfrom=xnguchen@sina.cn;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=xnguchen@sina.cn
X-SMAIL-MID: 261514456874
X-SMAIL-UIID: C639D9B7919F4ED891BD0FD1291918D7-20251212-162012-1
From: Chen Yu <xnguchen@sina.cn>
To: s.shtylyov@omp.ru,
	ulf.hansson@linaro.org
Cc: stable@vger.kernel.org
Subject: [PATCH 5.15.y] mmc: core: use sysfs_emit() instead of sprintf()
Date: Fri, 12 Dec 2025 16:19:59 +0800
Message-Id: <20251212081959.5633-1-xnguchen@sina.cn>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Sergey Shtylyov <s.shtylyov@omp.ru>

[ Upstream commit f5d8a5fe77ce933f53eb8f2e22bb7a1a2019ea11 ]

sprintf() (still used in the MMC core for the sysfs output) is vulnerable
to the buffer overflow.  Use the new-fangled sysfs_emit() instead.

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/717729b2-d65b-c72e-9fac-471d28d00b5a@omp.ru
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Chen Yu <xnguchen@sina.cn>
---
 drivers/mmc/core/bus.c      |  9 +++++----
 drivers/mmc/core/bus.h      |  3 ++-
 drivers/mmc/core/mmc.c      | 16 ++++++++--------
 drivers/mmc/core/sd.c       | 25 ++++++++++++-------------
 drivers/mmc/core/sdio.c     |  5 +++--
 drivers/mmc/core/sdio_bus.c |  7 ++++---
 6 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index c25c58473a91..c80d61780ea9 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -15,6 +15,7 @@
 #include <linux/stat.h>
 #include <linux/of.h>
 #include <linux/pm_runtime.h>
+#include <linux/sysfs.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -34,13 +35,13 @@ static ssize_t type_show(struct device *dev,
 
 	switch (card->type) {
 	case MMC_TYPE_MMC:
-		return sprintf(buf, "MMC\n");
+		return sysfs_emit(buf, "MMC\n");
 	case MMC_TYPE_SD:
-		return sprintf(buf, "SD\n");
+		return sysfs_emit(buf, "SD\n");
 	case MMC_TYPE_SDIO:
-		return sprintf(buf, "SDIO\n");
+		return sysfs_emit(buf, "SDIO\n");
 	case MMC_TYPE_SD_COMBO:
-		return sprintf(buf, "SDcombo\n");
+		return sysfs_emit(buf, "SDcombo\n");
 	default:
 		return -EFAULT;
 	}
diff --git a/drivers/mmc/core/bus.h b/drivers/mmc/core/bus.h
index 8105852c4b62..3996b191b68d 100644
--- a/drivers/mmc/core/bus.h
+++ b/drivers/mmc/core/bus.h
@@ -9,6 +9,7 @@
 #define _MMC_CORE_BUS_H
 
 #include <linux/device.h>
+#include <linux/sysfs.h>
 
 struct mmc_host;
 struct mmc_card;
@@ -17,7 +18,7 @@ struct mmc_card;
 static ssize_t mmc_##name##_show (struct device *dev, struct device_attribute *attr, char *buf)	\
 {										\
 	struct mmc_card *card = mmc_dev_to_card(dev);				\
-	return sprintf(buf, fmt, args);						\
+	return sysfs_emit(buf, fmt, args);					\
 }										\
 static DEVICE_ATTR(name, S_IRUGO, mmc_##name##_show, NULL)
 
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index a56906633ddf..958bd901a136 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/pm_runtime.h>
+#include <linux/sysfs.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -812,12 +813,11 @@ static ssize_t mmc_fwrev_show(struct device *dev,
 {
 	struct mmc_card *card = mmc_dev_to_card(dev);
 
-	if (card->ext_csd.rev < 7) {
-		return sprintf(buf, "0x%x\n", card->cid.fwrev);
-	} else {
-		return sprintf(buf, "0x%*phN\n", MMC_FIRMWARE_LEN,
-			       card->ext_csd.fwrev);
-	}
+	if (card->ext_csd.rev < 7)
+		return sysfs_emit(buf, "0x%x\n", card->cid.fwrev);
+	else
+		return sysfs_emit(buf, "0x%*phN\n", MMC_FIRMWARE_LEN,
+				  card->ext_csd.fwrev);
 }
 
 static DEVICE_ATTR(fwrev, S_IRUGO, mmc_fwrev_show, NULL);
@@ -830,10 +830,10 @@ static ssize_t mmc_dsr_show(struct device *dev,
 	struct mmc_host *host = card->host;
 
 	if (card->csd.dsr_imp && host->dsr_req)
-		return sprintf(buf, "0x%x\n", host->dsr);
+		return sysfs_emit(buf, "0x%x\n", host->dsr);
 	else
 		/* return default DSR value */
-		return sprintf(buf, "0x%x\n", 0x404);
+		return sysfs_emit(buf, "0x%x\n", 0x404);
 }
 
 static DEVICE_ATTR(dsr, S_IRUGO, mmc_dsr_show, NULL);
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 592166e53dce..46ca73c17c4c 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/pm_runtime.h>
+#include <linux/sysfs.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -707,18 +708,16 @@ MMC_DEV_ATTR(ocr, "0x%08x\n", card->ocr);
 MMC_DEV_ATTR(rca, "0x%04x\n", card->rca);
 
 
-static ssize_t mmc_dsr_show(struct device *dev,
-                           struct device_attribute *attr,
-                           char *buf)
+static ssize_t mmc_dsr_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
 {
-       struct mmc_card *card = mmc_dev_to_card(dev);
-       struct mmc_host *host = card->host;
-
-       if (card->csd.dsr_imp && host->dsr_req)
-               return sprintf(buf, "0x%x\n", host->dsr);
-       else
-               /* return default DSR value */
-               return sprintf(buf, "0x%x\n", 0x404);
+	struct mmc_card *card = mmc_dev_to_card(dev);
+	struct mmc_host *host = card->host;
+
+	if (card->csd.dsr_imp && host->dsr_req)
+		return sysfs_emit(buf, "0x%x\n", host->dsr);
+	/* return default DSR value */
+	return sysfs_emit(buf, "0x%x\n", 0x404);
 }
 
 static DEVICE_ATTR(dsr, S_IRUGO, mmc_dsr_show, NULL);
@@ -734,9 +733,9 @@ static ssize_t info##num##_show(struct device *dev, struct device_attribute *att
 												\
 	if (num > card->num_info)								\
 		return -ENODATA;								\
-	if (!card->info[num-1][0])								\
+	if (!card->info[num - 1][0])								\
 		return 0;									\
-	return sprintf(buf, "%s\n", card->info[num-1]);						\
+	return sysfs_emit(buf, "%s\n", card->info[num - 1]);					\
 }												\
 static DEVICE_ATTR_RO(info##num)
 
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index cbc9ca0dd56e..53c8f71af966 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -7,6 +7,7 @@
 
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
+#include <linux/sysfs.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -40,9 +41,9 @@ static ssize_t info##num##_show(struct device *dev, struct device_attribute *att
 												\
 	if (num > card->num_info)								\
 		return -ENODATA;								\
-	if (!card->info[num-1][0])								\
+	if (!card->info[num - 1][0])								\
 		return 0;									\
-	return sprintf(buf, "%s\n", card->info[num-1]);						\
+	return sysfs_emit(buf, "%s\n", card->info[num - 1]);					\
 }												\
 static DEVICE_ATTR_RO(info##num)
 
diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index f6cdec00e97e..f191a2a76f3b 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -14,6 +14,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/pm_domain.h>
 #include <linux/acpi.h>
+#include <linux/sysfs.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -35,7 +36,7 @@ field##_show(struct device *dev, struct device_attribute *attr, char *buf)				\
 	struct sdio_func *func;						\
 									\
 	func = dev_to_sdio_func (dev);					\
-	return sprintf(buf, format_string, args);			\
+	return sysfs_emit(buf, format_string, args);			\
 }									\
 static DEVICE_ATTR_RO(field)
 
@@ -52,9 +53,9 @@ static ssize_t info##num##_show(struct device *dev, struct device_attribute *att
 												\
 	if (num > func->num_info)								\
 		return -ENODATA;								\
-	if (!func->info[num-1][0])								\
+	if (!func->info[num - 1][0])								\
 		return 0;									\
-	return sprintf(buf, "%s\n", func->info[num-1]);						\
+	return sysfs_emit(buf, "%s\n", func->info[num - 1]);					\
 }												\
 static DEVICE_ATTR_RO(info##num)
 
-- 
2.17.1


