Return-Path: <stable+bounces-55846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DFD91827D
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 15:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85F41F25CEF
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 13:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C0016190C;
	Wed, 26 Jun 2024 13:32:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A3017C7CD
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408771; cv=none; b=DiQ6vjuG88bnZ5pDlK6WdjdEpswLY1tXtYpaGRLuZjTC/PGLevJt7KGcWEsagXA2fVy1boY12lGZUhz6pwXImaG3BgCXh1dCEn1+jeDc2DnKbqs7XqUB8bYt/6ZMrR0sFdrECirROfjRado08NCO65iLn/ZdqyPmOEeG9IBMjUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408771; c=relaxed/simple;
	bh=KPXTLFeHBIPS/fvadPTIOJXtoGjmqv+hc0kyhwehAbI=;
	h=From:Date:Subject:To:Cc:Message-Id; b=AZ4ZN6QzF1crrWEklgNdKBDdLa3+F2oQBipFpYfZX8uj+ztk6CPs9UTTi4jHJJKTP7q04F1Oxu8jSIupUTYyzbs6U6n70HgPoNcysNp/mn5avwCtyasv6B3RKGKIUnyNwJ4u9MZeUDz2xCUmWIltvizmnVAR3j5rjlcq20DXbMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1sMSlV-0008C5-1k;
	Wed, 26 Jun 2024 13:32:49 +0000
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 26 Jun 2024 06:14:02 +0000
Subject: [git:media_stage/master] media: imx-pxp: Fix ERR_PTR dereference in pxp_probe()
To: linuxtv-commits@linuxtv.org
Cc: stable@vger.kernel.org, Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1sMSlV-0008C5-1k@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: imx-pxp: Fix ERR_PTR dereference in pxp_probe()
Author:  Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Date:    Tue May 14 02:50:38 2024 -0700

devm_regmap_init_mmio() can fail, add a check and bail out in case of
error.

Fixes: 4e5bd3fdbeb3 ("media: imx-pxp: convert to regmap")
Cc: stable@vger.kernel.org
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/20240514095038.3464191-1-harshit.m.mogalapalli@oracle.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

 drivers/media/platform/nxp/imx-pxp.c | 3 +++
 1 file changed, 3 insertions(+)

---

diff --git a/drivers/media/platform/nxp/imx-pxp.c b/drivers/media/platform/nxp/imx-pxp.c
index e62dc5c1a4ae..e4427e6487fb 100644
--- a/drivers/media/platform/nxp/imx-pxp.c
+++ b/drivers/media/platform/nxp/imx-pxp.c
@@ -1805,6 +1805,9 @@ static int pxp_probe(struct platform_device *pdev)
 		return PTR_ERR(mmio);
 	dev->regmap = devm_regmap_init_mmio(&pdev->dev, mmio,
 					    &pxp_regmap_config);
+	if (IS_ERR(dev->regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(dev->regmap),
+				     "Failed to init regmap\n");
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)

