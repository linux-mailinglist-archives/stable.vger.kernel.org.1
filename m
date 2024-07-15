Return-Path: <stable+bounces-59264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B38930CDF
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 04:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF4C1C20D2E
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 02:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242338F47;
	Mon, 15 Jul 2024 02:55:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382DCB64E;
	Mon, 15 Jul 2024 02:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721012109; cv=none; b=pzbwY/yMz9irNeexD+qMIphIhlzdonlwVTfPv+f77syHO7gB/z33JWBHEPpgvcnycbIpg9EeYSdP9hX2LpQ2iI7tHVky1dvW+KbnMfbGgVfVf3U6OQtq/TUd9eSZvUcUcH7JcXiK530NZ8I0wslDtv/YUdxiUgHtZ2TU7FAXHWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721012109; c=relaxed/simple;
	bh=/ez42frQCtT6kQJneykkNLRbmMfDnxtHh6OLFtt3OTU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b2Xec9P+TWxlV+re9Ije6z0KX2VhGjLeKzlnAhrTrqZLgMG2kSLxfk2rMESL7C5O9swf2Gfi0PGY2G40zpw0qhQEM/9/e1OycqqpeCPTfrUaMnjPeKmlN2p7eUVLqPQI1yEuxoywoTN/hlMMIKJZS5v829MN3K7s+Hyg+Xe1KFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowAB3mCVzj5Rm64nOFQ--.12171S2;
	Mon, 15 Jul 2024 10:54:50 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: fbarrat@linux.ibm.com,
	ajd@linux.ibm.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	mpe@ellerman.id.au,
	manoj@linux.vnet.ibm.com,
	imunsie@au1.ibm.com,
	clombard@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v4] cxl: Fix possible null pointer dereference in read_handle()
Date: Mon, 15 Jul 2024 10:54:42 +0800
Message-Id: <20240715025442.3229209-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAB3mCVzj5Rm64nOFQ--.12171S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJry7Gr18tF4rKFyxGr4fAFb_yoW8GF1UpF
	Z7GFWjyFyDJanFyF4kXa18ZFyaka4rKFWYgFy09w1fZws8XrWrZa43Ca4F9a4jyrW8t3W0
	va1DtF1avrWUZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In read_handle(), of_get_address() may return NULL if getting address and
size of the node failed. When of_read_number() uses prop to handle
conversions between different byte orders, it could lead to a null pointer
dereference. Add NULL check to fix potential issue.

Found by static analysis.

Cc: stable@vger.kernel.org
Fixes: 14baf4d9c739 ("cxl: Add guest-specific code")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v4:
- modified vulnerability description according to suggestions, making the 
process of static analysis of vulnerabilities clearer. No active research 
on developer behavior.
Changes in v3:
- fixed up the changelog text as suggestions.
Changes in v2:
- added an explanation of how the potential vulnerability was discovered,
but not meet the description specification requirements.
---
 drivers/misc/cxl/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/of.c b/drivers/misc/cxl/of.c
index bcc005dff1c0..d8dbb3723951 100644
--- a/drivers/misc/cxl/of.c
+++ b/drivers/misc/cxl/of.c
@@ -58,7 +58,7 @@ static int read_handle(struct device_node *np, u64 *handle)
 
 	/* Get address and size of the node */
 	prop = of_get_address(np, 0, &size, NULL);
-	if (size)
+	if (!prop || size)
 		return -EINVAL;
 
 	/* Helper to read a big number; size is in cells (not bytes) */
-- 
2.25.1


