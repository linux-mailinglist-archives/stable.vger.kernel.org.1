Return-Path: <stable+bounces-166759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0CCB1D136
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 05:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E5A582415
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 03:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D711B3925;
	Thu,  7 Aug 2025 03:28:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m1973185.qiye.163.com (mail-m1973185.qiye.163.com [220.197.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C5F189;
	Thu,  7 Aug 2025 03:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754537335; cv=none; b=UhcwFbB5sOwQ9jBEcd+JLYklZMkrKRYk1eR+2ZjS07SUthLTYWNBPSCwQJGC98SQEjp0FO8wkGgIx0ronLxom+iUin2Hce1tWI14Xd6F8+vQWM7BgR4m1vgsl5uDMKm6wA3GSMER2iFRekrs24ZW60TDOfEAzNIQnkCS4RSinPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754537335; c=relaxed/simple;
	bh=joX9Rft8lA6tlKiAX3uOHsmPB6vlm1mjB7sZ/GaK4mU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fub45+mtisHq1W+Rc4u8TEg/34m65WAwGBV6jzSEZDHHzAyCFNwx7ZMcUIXpZQd/eHshH2Rh3eDggqlyGHEX/7DIYxsQJ2uHtd8KLXBH+bVAwz3o0aGPkxTYOJays+FNZPPmKXMXdNBmdNqli/jNuM0tYNVibVEfFB4oLcEJWBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=220.197.31.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id e43c2145;
	Thu, 7 Aug 2025 11:28:39 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: sudeep.holla@arm.com,
	jassisinghbrar@gmail.com
Cc: linux-acpi@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>,
	stable@vger.kernel.org
Subject: [PATCH v5] mailbox: pcc: Add missed acpi_put_table() to fix memory leak
Date: Thu,  7 Aug 2025 11:28:31 +0800
Message-Id: <20250807032831.451863-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250805034829.168187-1-zhen.ni@easystack.cn>
References: <20250805034829.168187-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a988292ddc80229kunmffa02a95735091
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGElKVk5MTx5IShpLQhoaTFYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09LVUpLS1
	VLWQY+

Fixes a permanent ACPI memory leak in the success path by adding
acpi_put_table().

Fixes: ce028702ddbc ("mailbox: pcc: Move bulk of PCCT parsing into pcc_mbox_probe")
Cc: stable@vger.kernel.org
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
Changes in v5:
- Discard err label modification
Changes in v4:
- Change goto target from err to put_table.
- Remove goto tatget err_nomem
- Update commit msg
Changes in v3:
- Add goto label err_nomem, keep the err label.
- Update commit msg
Changes in v2:
- Add tags of 'Fixes' and 'Cc'
- Change goto target from out_put_pcct to e_nomem
---
 drivers/mailbox/pcc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index f6714c233f5a..70d47f8759eb 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -827,8 +827,6 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 	rc = mbox_controller_register(pcc_mbox_ctrl);
 	if (rc)
 		pr_err("Err registering PCC as Mailbox controller: %d\n", rc);
-	else
-		return 0;
 err:
 	acpi_put_table(pcct_tbl);
 	return rc;
-- 
2.20.1


