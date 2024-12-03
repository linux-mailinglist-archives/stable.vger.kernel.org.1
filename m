Return-Path: <stable+bounces-96871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 394789E220A
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6DF167D40
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1261F8AC1;
	Tue,  3 Dec 2024 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oO2N8p5G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE38A1F893B;
	Tue,  3 Dec 2024 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238839; cv=none; b=SL2nkTPw1MQTQX/y+xHKvBXS5vC0RDFndYkjfcuep2Q9oglH34zX8H4FeBsH3Bsse7R/R+5utuJ/YCMYc2bXJKJDg+hQdBLhKRRT6LhHrWjcd4I0Lkxbu3+U+3uzdLPvk+ZrJE+4PIMCJ8NuLrJlX/JYkNQp6OFmvi9ST08uuXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238839; c=relaxed/simple;
	bh=1d6aBCRAsLl9TN0rvC1ZIzZWYaXvMMW9Dd3UgP3qizU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmEv5rGoDqlnHA0xJavKGaJ9iX0OrVitL0J9iAKvdRoBhzMCP87S08FAMONZoTPeu3788UKvxxZRfPtAu64IMQsl74y0sfLQyDD573P3sAe4wtp9bOPGi5wmhc12RddFCpyXkTuX1X5yQfFz/Yjr6xZyFq0XjvSkmwlCSUzAbvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oO2N8p5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4780BC4CECF;
	Tue,  3 Dec 2024 15:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733238839;
	bh=1d6aBCRAsLl9TN0rvC1ZIzZWYaXvMMW9Dd3UgP3qizU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oO2N8p5GW6LJWV8jtIg6jaK8K4ZyRuvEyTEghe7Uw1p2CWV/Kxk5cHvSQZKvUZXO/
	 owTC5/WBqkFRZlz9YFUiigWnD3VyDTm/nUg8bJrE+CbFDBGBjA2NtPNPJt3krWDTyb
	 XTJXybh959VzdVzQCSIW7lHVJ/xVXytiX6tlFU/o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuyu Li <liyuyu6@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 415/817] RDMA/hns: Modify debugfs name
Date: Tue,  3 Dec 2024 15:39:47 +0100
Message-ID: <20241203144012.078909914@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuyu Li <liyuyu6@huawei.com>

[ Upstream commit 370a9351bf84afc5a56a3f02ba3805bbfcb53c32 ]

The sub-directory of hns_roce debugfs is named after the device's
kernel name currently, but it will be inconvenient to use when
the device is renamed.

Modify the name to pci name as users can always easily find the
correspondence between an RDMA device and its pci name.

Fixes: eb7854d63db5 ("RDMA/hns: Support SW stats with debugfs")
Signed-off-by: Yuyu Li <liyuyu6@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://patch.msgid.link/20241024124000.2931869-4-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_debugfs.c b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
index e8febb40f6450..b869cdc541189 100644
--- a/drivers/infiniband/hw/hns/hns_roce_debugfs.c
+++ b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
@@ -5,6 +5,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/device.h>
+#include <linux/pci.h>
 
 #include "hns_roce_device.h"
 
@@ -86,7 +87,7 @@ void hns_roce_register_debugfs(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_dev_debugfs *dbgfs = &hr_dev->dbgfs;
 
-	dbgfs->root = debugfs_create_dir(dev_name(&hr_dev->ib_dev.dev),
+	dbgfs->root = debugfs_create_dir(pci_name(hr_dev->pci_dev),
 					 hns_roce_dbgfs_root);
 
 	create_sw_stat_debugfs(hr_dev, dbgfs->root);
-- 
2.43.0




