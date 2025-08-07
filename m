Return-Path: <stable+bounces-166780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8618B1D8AC
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 15:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E342316E609
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 13:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8808259CA7;
	Thu,  7 Aug 2025 13:12:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m15574.qiye.163.com (mail-m15574.qiye.163.com [101.71.155.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A09B22758F;
	Thu,  7 Aug 2025 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754572372; cv=none; b=OiucSpOdzjF84aobWIumRzI7vh7Yf7R41v6ToeTFrpDkv0qy2J8a1i2KtQeojfnPl+hkOs/JVgC6s9VGDFqzwVZTu5dn9zdxBiAA+1TAd16QNr/CimT6Fw/8Uvdbf/V9WY8O6mPBPQoOq7Kx3Gzcpx1Y+GkJR6YZIfwPq4IuY1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754572372; c=relaxed/simple;
	bh=E9CM1gdsdNNvFGym82rUExgzzHmizJ9mMNm4AHhRmqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LOxu3Exwna9mHbY/d/jIzkEzyDz9eiVBVNmBrwZWAFkHqTTlSeq+QaE2aZCou2AHYGxN57sI4zaYpt6F5Z3IY7Dya0RgosHwfXQ93BgPOt8rtQCJJjWLtIBK+aXFc6Ywhlu/N2XL+6Kz8LbQ4yjzNeSTvc6hlHmoBZ4zbkON61I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=101.71.155.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id e4a7289f;
	Thu, 7 Aug 2025 19:57:06 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: rafael@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: APEI: EINJ: Fix einj_tab memleak in einj_probe()
Date: Thu,  7 Aug 2025 19:56:57 +0800
Message-Id: <20250807115657.503189-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9884645c850229kunmf26da22296b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZS0oYVkhIHRoZHUJNGEoeGVYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

Fixes a permanent ACPI table memory leak when einj_probe() return 0 by
adding acpi_put_table().
Remove the assignment rc = -ENOMEM to allow the function to propagate
the actual return value.

Fixes: e40213450b53 ("ACPI, APEI, EINJ support")
Cc: stable@vger.kernel.org
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 drivers/acpi/apei/einj-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index bf8dc92a373a..919caa819cf8 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -990,7 +990,7 @@ static bool setup_einjv2_component_files(void)
 
 static int __init einj_probe(struct faux_device *fdev)
 {
-	int rc;
+	int rc = 0;
 	acpi_status status;
 	struct apei_exec_context ctx;
 
@@ -1015,7 +1015,6 @@ static int __init einj_probe(struct faux_device *fdev)
 	if (rc)
 		goto err_put_table;
 
-	rc = -ENOMEM;
 	einj_debug_dir = debugfs_create_dir("einj", apei_get_debugfs_dir());
 
 	debugfs_create_file("available_error_type", S_IRUSR, einj_debug_dir,
@@ -1078,7 +1077,7 @@ static int __init einj_probe(struct faux_device *fdev)
 
 	pr_info("Error INJection is initialized.\n");
 
-	return 0;
+	goto err_put_table;
 
 err_release:
 	apei_resources_release(&einj_resources);
-- 
2.20.1


