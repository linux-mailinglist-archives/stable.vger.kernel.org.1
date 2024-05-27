Return-Path: <stable+bounces-50071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90B1901CDF
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 10:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AF8BB24575
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 08:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8AC58210;
	Mon, 10 Jun 2024 08:23:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783E56F2E0
	for <stable@vger.kernel.org>; Mon, 10 Jun 2024 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718007799; cv=none; b=iH+05U3WmMECbdC6uoEa23W/3d5ze05gZXTkTfCw+VvC1ULSZmCCK8rZfE67rxb/3oHtdBKURyCmgYk96be0OS4Aou3TBW5ZMdSIcyJSkgOsH9jzUZ9o/rKyxLRwxJNB58NptbjRu3odYqS3rhGIWsqI/Yqr+mvcHSdsjayOKxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718007799; c=relaxed/simple;
	bh=mjfcBUsHR0ot/pUSc8l/UI/WDg0murBb+WIqBHhFaT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:To:Cc:Message-Id; b=RgxHuR/9lDTu8pTgd00QKayvDrym3HL9LT07AN8XR9GttSQQ8RLEDU4B89Eb30nzyvX0rpvZOCk4lrn8EDRiPlbg9NkDKU7MPqaO71Akwviquv50DL/cPvDnt5fr5WY3EEhVKoaakP0NqLCZSqDAvVgp1kvNWJZJr18et84zpKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1sGaJ8-0000nn-1Q;
	Mon, 10 Jun 2024 08:23:14 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Mon, 27 May 2024 09:33:56 +0000
Subject: [git:media_stage/master] media: mgb4: Fix double debugfs remove
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: linuxtv-commits@linuxtv.org
Cc: stable@vger.kernel.org, Martin Tůma <martin.tuma@digiteqautomotive.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1sGaJ8-0000nn-1Q@linuxtv.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: mgb4: Fix double debugfs remove
Author:  Martin Tůma <martin.tuma@digiteqautomotive.com>
Date:    Tue May 21 18:22:54 2024 +0200

Fixes an error where debugfs_remove_recursive() is called first on a parent
directory and then again on a child which causes a kernel panic.

Signed-off-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Fixes: 0ab13674a9bd ("media: pci: mgb4: Added Digiteq Automotive MGB4 driver")
Cc: <stable@vger.kernel.org>
[hverkuil: added Fixes/Cc tags]

 drivers/media/pci/mgb4/mgb4_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

---

diff --git a/drivers/media/pci/mgb4/mgb4_core.c b/drivers/media/pci/mgb4/mgb4_core.c
index 60498a5abebf..ab4f07e2e560 100644
--- a/drivers/media/pci/mgb4/mgb4_core.c
+++ b/drivers/media/pci/mgb4/mgb4_core.c
@@ -642,9 +642,6 @@ static void mgb4_remove(struct pci_dev *pdev)
 	struct mgb4_dev *mgbdev = pci_get_drvdata(pdev);
 	int i;
 
-#ifdef CONFIG_DEBUG_FS
-	debugfs_remove_recursive(mgbdev->debugfs);
-#endif
 #if IS_REACHABLE(CONFIG_HWMON)
 	hwmon_device_unregister(mgbdev->hwmon_dev);
 #endif
@@ -659,6 +656,10 @@ static void mgb4_remove(struct pci_dev *pdev)
 		if (mgbdev->vin[i])
 			mgb4_vin_free(mgbdev->vin[i]);
 
+#ifdef CONFIG_DEBUG_FS
+	debugfs_remove_recursive(mgbdev->debugfs);
+#endif
+
 	device_remove_groups(&mgbdev->pdev->dev, mgb4_pci_groups);
 	free_spi(mgbdev);
 	free_i2c(mgbdev);

