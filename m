Return-Path: <stable+bounces-76143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA8B9791E3
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 17:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2562F1C21722
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 15:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D4F1D0967;
	Sat, 14 Sep 2024 15:46:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D836749A;
	Sat, 14 Sep 2024 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726328778; cv=none; b=LMbi9J4PtvsuRfD7otxXG3EY1zpL2dgYFIqQdICPNde39citMJzkfs3DLq40HdeyzkPsFWRr2K5Y1g3+hkAeSBkjhvD+9UK3YKIeyhD5nxdyRq1f/YppcbgFvDlFfIVM6RL2Z6FpxVUwvhr9wbQ92a+vWfD9MmU/7I4bUqxSrTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726328778; c=relaxed/simple;
	bh=20+yhgT9p/xQ8QoCmoOGZLzO+I0VmtTVue4TDZWkL4g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q6dOc95BCqYsVwEU2cFFKbI5vSfFxFsdk2HbeNH3WYVs/5FcwppzodeER7bta2/G2lKuo0orIHZFOjrJgEWMJY64aWD1mnbVkPSqvqSaBjfIhseXiL80OtQyIKgRcyRUpgbi6NDm2R13d2gUEQPnxgL3J2SirDOg4eR9D+cd/G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
X-QQ-mid: bizesmtpip3t1726328721td2rd4i
X-QQ-Originating-IP: C+8UI1lNAvQxIkMuI2KqnBuNs/WHZRtwxSlHtl4LGQ4=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 14 Sep 2024 23:45:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6681894478682742638
From: Kaixin Wang <kxwang23@m.fudan.edu.cn>
To: miquel.raynal@bootlin.com
Cc: 21210240012@m.fudan.edu.cn,
	21302010073@m.fudan.edu.cn,
	conor.culhane@silvaco.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	frank.li@nxp.com,
	stable@vger.kernel.org,
	Kaixin Wang <kxwang23@m.fudan.edu.cn>
Subject: [PATCH v2] i3c: master: svc: Fix use after free vulnerability in svc_i3c_master Driver Due to Race Condition
Date: Sat, 14 Sep 2024 23:40:32 +0800
Message-Id: <20240914154030.180-1-kxwang23@m.fudan.edu.cn>
X-Mailer: git-send-email 2.39.1.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:m.fudan.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0

In the svc_i3c_master_probe function, &master->hj_work is bound with
svc_i3c_master_hj_work, &master->ibi_work is bound with
svc_i3c_master_ibi_work. And svc_i3c_master_ibi_work  can start the
hj_work, svc_i3c_master_irq_handler can start the ibi_work.

If we remove the module which will call svc_i3c_master_remove to
make cleanup, it will free master->base through i3c_master_unregister
while the work mentioned above will be used. The sequence of operations
that may lead to a UAF bug is as follows:

CPU0                                         CPU1

                                    | svc_i3c_master_hj_work
svc_i3c_master_remove               |
i3c_master_unregister(&master->base)|
device_unregister(&master->dev)     |
device_release                      |
//free master->base                 |
                                    | i3c_master_do_daa(&master->base)
                                    | //use master->base

Fix it by ensuring that the work is canceled before proceeding with the
cleanup in svc_i3c_master_remove.

Fixes: 0f74f8b6675c ("i3c: Make i3c_master_unregister() return void")
Signed-off-by: Kaixin Wang <kxwang23@m.fudan.edu.cn>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

---
v2:
- add fixes tag and cc stable, suggested by Frank
- add Reviewed-by label from Miquel
- Link to v1: https://lore.kernel.org/r/20240911150135.839946-1-kxwang23@m.fudan.edu.cn
---
 drivers/i3c/master/svc-i3c-master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 0a68fd1b81d4..e084ba648b4a 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1775,6 +1775,7 @@ static void svc_i3c_master_remove(struct platform_device *pdev)
 {
 	struct svc_i3c_master *master = platform_get_drvdata(pdev);
 
+	cancel_work_sync(&master->hj_work);
 	i3c_master_unregister(&master->base);
 
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
-- 
2.39.1.windows.1


