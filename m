Return-Path: <stable+bounces-172353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6CDB31475
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 11:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DDE4BA24B5
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 09:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9348F2F90DC;
	Fri, 22 Aug 2025 09:49:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m21467.qiye.163.com (mail-m21467.qiye.163.com [117.135.214.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A72219A81;
	Fri, 22 Aug 2025 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856166; cv=none; b=GBCuyWak4AMaJdb3hAQq77E9/EtZqvt/auHOXhJDMdjulF8vr8rv4xCotJjeXLuJv1bOUkmUlZ3shQe8k9eOCO/aI7Ga5zOpbHNXOHKuzMf7dTsBPfvf43azSYnKLGnIriolSvsGsVfIkJJeFNCDL+lVdGpPjTEro1K8JLIGltk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856166; c=relaxed/simple;
	bh=UsaScT3prD5L7v11HZ+e3Ah6A4bsb/cIXgEzSWdRiBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ozY/6TM2y9baPli4YB+JJU/HtlW41AAJ6k0Aty+7P0J8BLr3ezHWZFlnN9aAi+ecl3VsmvGgPqFhf6wZMRHvonqyd9uoWc/u+HVj1zcYLtQmQRkCvya4O9Cank4zOTtWRpCyTyb+3T7VGbUi50tUU4Yutx9/vezy9xTQqwFuFBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=117.135.214.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id f067151b;
	Fri, 22 Aug 2025 16:33:39 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: mario.limonciello@amd.com,
	perry.yuan@amd.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86/amd: hfi: Fix pcct_tbl leak in amd_hfi_metadata_parser()
Date: Fri, 22 Aug 2025 16:33:29 +0800
Message-Id: <20250822083329.710857-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98d0e97ab50229kunm047ea2e9e3589f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSBpJVkJIThkdTkJLHkpDS1YVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

Fix a permanent ACPI table memory leak when amd_hfi_metadata_parser()
fails due to invalid PCCT table length or memory allocation errors.

Fixes: d4e95ea7a78e ("platform/x86: hfi: Parse CPU core ranking data from shared memory")
Cc: stable@vger.kernel.org
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 drivers/platform/x86/amd/hfi/hfi.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 4f56149b3774..a465ac6f607e 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -385,12 +385,16 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
 	amd_hfi_data->pcct_entry = pcct_entry;
 	pcct_ext = (struct acpi_pcct_ext_pcc_slave *)pcct_entry;
 
-	if (pcct_ext->length <= 0)
-		return -EINVAL;
+	if (pcct_ext->length <= 0) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	amd_hfi_data->shmem = devm_kzalloc(amd_hfi_data->dev, pcct_ext->length, GFP_KERNEL);
-	if (!amd_hfi_data->shmem)
-		return -ENOMEM;
+	if (!amd_hfi_data->shmem) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	pcc_chan->shmem_base_addr = pcct_ext->base_address;
 	pcc_chan->shmem_size = pcct_ext->length;
@@ -398,6 +402,8 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
 	/* parse the shared memory info from the PCCT table */
 	ret = amd_hfi_fill_metadata(amd_hfi_data);
 
+out:
+	/* Don't leak any ACPI memory */
 	acpi_put_table(pcct_tbl);
 
 	return ret;
-- 
2.20.1


