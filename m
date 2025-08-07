Return-Path: <stable+bounces-166757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FC3B1D130
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 05:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82A5583D7B
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 03:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC27E18BBB9;
	Thu,  7 Aug 2025 03:18:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m49218.qiye.163.com (mail-m49218.qiye.163.com [45.254.49.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635EF189;
	Thu,  7 Aug 2025 03:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754536680; cv=none; b=Gea0Mc/8b2ghmBfxdX6OzWh6CaVpSYFgVxMVxeNSFNs1qFMN79vuwZiwX/YV+p37DDA5sS0VD0bpUkmkgD49/dU52MAeRtaTwIWbAr/Jz2Jcke6G5G+rSzh6LRSOiuAM/tqKQQQ04UvBzZ9egZbRDYdWDfJfQS4iFCiquM2/HuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754536680; c=relaxed/simple;
	bh=NrAAULTbUGrcBeLEENrwD2qDSx9oCRI/90MAU0LbqUE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WTB/HUDvMAM/XWuYU+vzJh5er4k8MaKtvJfWd3BkYTHgon+9w1aJiNDgKQqFjDdVwWSSdau0+BeZTfF5NP3tnkpY4b4wJUqrBFJA50tOYFMX5RYUcDLd67wUUs69KZ5fUxSQutX1KQzLBftpHK0ykTQBb14poC/GxA7vqiURcLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=45.254.49.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id e438fb18;
	Thu, 7 Aug 2025 11:12:37 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: tables: FPDT: Fix memory leak in acpi_init_fpdt()
Date: Thu,  7 Aug 2025 11:12:29 +0800
Message-Id: <20250807031229.449657-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9882842cc20229kunmd5671b45730dd0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHkhCVhodH0kYSkkZHUIfQ1YVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

acpi_put_table() is only called when kobject_create_and_add() or
fpdt_process_subtable() fails, but not on the success path. This causes
a memory leak if initialization succeeds.

Ensure acpi_put_table() is called in all cases by adding a put_table
label and routing both success and failure paths through it. Drop the
err_subtable label since kobject_put() is only needed when
fpdt_process_subtable() fails.

Fixes: d1eb86e59be0 ("ACPI: tables: introduce support for FPDT table")
Cc: stable@vger.kernel.org
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 drivers/acpi/acpi_fpdt.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
index 271092f2700a..c8aea5bb187c 100644
--- a/drivers/acpi/acpi_fpdt.c
+++ b/drivers/acpi/acpi_fpdt.c
@@ -275,7 +275,7 @@ static int __init acpi_init_fpdt(void)
 	struct acpi_table_header *header;
 	struct fpdt_subtable_entry *subtable;
 	u32 offset = sizeof(*header);
-	int result;
+	int result = 0;
 
 	status = acpi_get_table(ACPI_SIG_FPDT, 0, &header);
 
@@ -285,7 +285,7 @@ static int __init acpi_init_fpdt(void)
 	fpdt_kobj = kobject_create_and_add("fpdt", acpi_kobj);
 	if (!fpdt_kobj) {
 		result = -ENOMEM;
-		goto err_nomem;
+		goto put_table;
 	}
 
 	while (offset < header->length) {
@@ -295,8 +295,10 @@ static int __init acpi_init_fpdt(void)
 		case SUBTABLE_S3PT:
 			result = fpdt_process_subtable(subtable->address,
 					      subtable->type);
-			if (result)
-				goto err_subtable;
+			if (result) {
+				kobject_put(fpdt_kobj);
+				goto put_table;
+			}
 			break;
 		default:
 			/* Other types are reserved in ACPI 6.4 spec. */
@@ -304,11 +306,8 @@ static int __init acpi_init_fpdt(void)
 		}
 		offset += sizeof(*subtable);
 	}
-	return 0;
-err_subtable:
-	kobject_put(fpdt_kobj);
 
-err_nomem:
+put_table:
 	acpi_put_table(header);
 	return result;
 }
-- 
2.20.1


