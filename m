Return-Path: <stable+bounces-92970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C29049C8142
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 04:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E4A283296
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 03:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795CC1EABC1;
	Thu, 14 Nov 2024 03:00:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E261EABB7;
	Thu, 14 Nov 2024 03:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731553247; cv=none; b=s3EUzEDoJPpzPlkvDYH+jtoyZDWrhzWIjnKfBPFHAznL4fM6IjUDTSjgSuSxCL3P/+L4Oenv0BLfSjcYosNWIyBxmNBABCuRleQCMrtWVpYt4yf2NfNrLbKj4PIMuT6cP7yFbD5xxYjjuZjU7TJm4LREblluBBRxiELGQmpiC4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731553247; c=relaxed/simple;
	bh=6xkrHO7VCOoVirTQCd0B7V1Tb31zZhXrsXrtfdvcg+o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EIWpPw6y8AXqiKpYpXoRY6VnO5CwBCD8XXbB/HYbJzdWuWIgdczvKMtmP+9r9PXw4YgBcqnrucIVJceMQFt8u84uh3Nfx2yTRmFOx6s1ZLuXfiIfJDR670wIIxMmJdaUHVP1rhgRPzBuRmu1vUkGdT7gw/GM4mhfKtI2bvGO2Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XplFv2j5nz1V3dH;
	Thu, 14 Nov 2024 10:58:11 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 5973D1400DC;
	Thu, 14 Nov 2024 11:00:41 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Nov 2024 11:00:40 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <gregkh@linuxfoundation.org>, <tiantao6@hisilicon.com>
CC: <rafael@kernel.org>, <Jonathan.Cameron@huawei.com>, <baohua@kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<lihuafei1@huawei.com>
Subject: [PATCH v2] topology: Keep the cpumask unchanged when printing cpumap
Date: Thu, 14 Nov 2024 19:01:41 +0800
Message-ID: <20241114110141.94725-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf500004.china.huawei.com (7.202.181.242)

During fuzz testing, the following warning was discovered:

 different return values (15 and 11) from vsnprintf("%*pbl
 ", ...)

 test:keyward is WARNING in kvasprintf
 WARNING: CPU: 55 PID: 1168477 at lib/kasprintf.c:30 kvasprintf+0x121/0x130
 Call Trace:
  kvasprintf+0x121/0x130
  kasprintf+0xa6/0xe0
  bitmap_print_to_buf+0x89/0x100
  core_siblings_list_read+0x7e/0xb0
  kernfs_file_read_iter+0x15b/0x270
  new_sync_read+0x153/0x260
  vfs_read+0x215/0x290
  ksys_read+0xb9/0x160
  do_syscall_64+0x56/0x100
  entry_SYSCALL_64_after_hwframe+0x78/0xe2

The call trace shows that kvasprintf() reported this warning during the
printing of core_siblings_list. kvasprintf() has several steps:

 (1) First, calculate the length of the resulting formatted string.

 (2) Allocate a buffer based on the returned length.

 (3) Then, perform the actual string formatting.

 (4) Check whether the lengths of the formatted strings returned in
     steps (1) and (2) are consistent.

If the core_cpumask is modified between steps (1) and (3), the lengths
obtained in these two steps may not match. Indeed our test includes cpu
hotplugging, which should modify core_cpumask while printing.

To fix this issue, cache the cpumask into a temporary variable before
calling cpumap_print_{list, cpumask}_to_buf(), to keep it unchanged
during the printing process.

Fixes: bb9ec13d156e ("topology: use bin_attribute to break the size limitation of cpumap ABI")
Cc: stable@vger.kernel.org
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
Changes in v2:
 - Return an error when calling alloc_cpumask_var() fails instead of
   returning a size of 0. 
 - Add Cc (to stable) tag.
---
 drivers/base/topology.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 89f98be5c5b9..d293cbd253e4 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -27,9 +27,17 @@ static ssize_t name##_read(struct file *file, struct kobject *kobj,		\
 			   loff_t off, size_t count)				\
 {										\
 	struct device *dev = kobj_to_dev(kobj);                                 \
+	cpumask_var_t mask;							\
+	ssize_t n;								\
 										\
-	return cpumap_print_bitmask_to_buf(buf, topology_##mask(dev->id),	\
-					   off, count);                         \
+	if (!alloc_cpumask_var(&mask, GFP_KERNEL))				\
+		return -ENOMEM;							\
+										\
+	cpumask_copy(mask, topology_##mask(dev->id));				\
+	n = cpumap_print_bitmask_to_buf(buf, mask, off, count);			\
+	free_cpumask_var(mask);							\
+										\
+	return n;								\
 }										\
 										\
 static ssize_t name##_list_read(struct file *file, struct kobject *kobj,	\
@@ -37,9 +45,17 @@ static ssize_t name##_list_read(struct file *file, struct kobject *kobj,	\
 				loff_t off, size_t count)			\
 {										\
 	struct device *dev = kobj_to_dev(kobj);					\
+	cpumask_var_t mask;							\
+	ssize_t n;								\
+										\
+	if (!alloc_cpumask_var(&mask, GFP_KERNEL))				\
+		return -ENOMEM;							\
+										\
+	cpumask_copy(mask, topology_##mask(dev->id));				\
+	n = cpumap_print_list_to_buf(buf, mask, off, count);			\
+	free_cpumask_var(mask);							\
 										\
-	return cpumap_print_list_to_buf(buf, topology_##mask(dev->id),		\
-					off, count);				\
+	return n;								\
 }
 
 define_id_show_func(physical_package_id, "%d");
-- 
2.25.1


