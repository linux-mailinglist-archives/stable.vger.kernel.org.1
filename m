Return-Path: <stable+bounces-201132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9525CC0B33
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 04:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4D4E3009AB5
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 03:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ACC1531C8;
	Tue, 16 Dec 2025 03:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="uBHtHfcu"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCCD3B8D4C
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 03:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765855006; cv=none; b=Jt+KxBVNU7yccQWiYF1Em/JMnGtrdBVu2CJKoXNg+GMKm53qcqCrSBhWUAvTVtxFSPb7ZSRDfR3j2Q2IPqBradtj/eMpS9ERrV75fYn4BQPj5HPZhDKlI9FVEjGKLEzQ+T8W2ogPpKSa+TOXE9bY7OwXjkl3Je1JCBpzmL0pBwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765855006; c=relaxed/simple;
	bh=g0UrYk7nfCIOLwUbZm7Hb+f81XOBwZ0oOTV309ggENo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q+CVANE4ENAOS3U1nLUEC8RCNS9Let+AjBzucYH1BWrPjUy9mLqtrRJDZuF692FioyaBcvBuCxoJkphDLnE9M1L3R/Z3vX6rMLqEcY7E8IsBnKZJEI4pvfwpLmYCA6UJFSmXADsWG1gm7Rt3UYH7CICAfJQ0lxXwJqSLLxq4xtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=uBHtHfcu; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=uBHtHfcuBWbkomPazcMDii5lGW0EKI1V8NKomdUYmvH/P++CP75fvFazp8Gx8XyBDNWXCGiuc/gbj
	 4qocTKak2cqovBz+PmaQrY/ildJaFvKhQniU+kIgNQhd4jLOp4cjmJp4KtmLbED8gdtzgfVVrvyONW
	 oiKcdBxPElM92Tzk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from ubuntu24.. (unknown[120.244.194.57])
	by rmsmtp-lg-appmail-08-12086 (RichMail) with SMTP id 2f366940ce4d5cd-b0132;
	Tue, 16 Dec 2025 11:13:21 +0800 (CST)
X-RM-TRANSID:2f366940ce4d5cd-b0132
From: lanbincn@139.com
To: stable@vger.kernel.org
Cc: Yi Sun <yi.sun@intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Bin Lan <lanbincn@139.com>
Subject: [PATCH 6.1.y] dmaengine: idxd: Remove improper idxd_free
Date: Tue, 16 Dec 2025 03:13:13 +0000
Message-ID: <20251216031313.4853-1-lanbincn@139.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yi Sun <yi.sun@intel.com>

[ Upstream commit f41c538881eec4dcf5961a242097d447f848cda6 ]

The call to idxd_free() introduces a duplicate put_device() leading to a
reference count underflow:
refcount_t: underflow; use-after-free.
WARNING: CPU: 15 PID: 4428 at lib/refcount.c:28 refcount_warn_saturate+0xbe/0x110
...
Call Trace:
 <TASK>
  idxd_remove+0xe4/0x120 [idxd]
  pci_device_remove+0x3f/0xb0
  device_release_driver_internal+0x197/0x200
  driver_detach+0x48/0x90
  bus_remove_driver+0x74/0xf0
  pci_unregister_driver+0x2e/0xb0
  idxd_exit_module+0x34/0x7a0 [idxd]
  __do_sys_delete_module.constprop.0+0x183/0x280
  do_syscall_64+0x54/0xd70
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

The idxd_unregister_devices() which is invoked at the very beginning of
idxd_remove(), already takes care of the necessary put_device() through the
following call path:
idxd_unregister_devices() -> device_unregister() -> put_device()

In addition, when CONFIG_DEBUG_KOBJECT_RELEASE is enabled, put_device() may
trigger asynchronous cleanup via schedule_delayed_work(). If idxd_free() is
called immediately after, it can result in a use-after-free.

Remove the improper idxd_free() to avoid both the refcount underflow and
potential memory corruption during module unload.

Fixes: d5449ff1b04d ("dmaengine: idxd: Add missing idxd cleanup to fix memory leak in remove call")
Signed-off-by: Yi Sun <yi.sun@intel.com>
Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Link: https://lore.kernel.org/r/20250729150313.1934101-2-yi.sun@intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[ Slightly adjust the context. ]
Signed-off-by: Bin Lan <lanbincn@139.com>
---
Without this patch, this issue can be reproduced in Linux-6.1.y 
when the idxd module is removed.
---
 drivers/dma/idxd/init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 127a6a302a5b..6059ffc08eac 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -816,7 +816,6 @@ static void idxd_remove(struct pci_dev *pdev)
 	destroy_workqueue(idxd->wq);
 	perfmon_pmu_remove(idxd);
 	put_device(idxd_confdev(idxd));
-	idxd_free(idxd);
 }
 
 static struct pci_driver idxd_pci_driver = {
-- 
2.43.0



