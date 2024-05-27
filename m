Return-Path: <stable+bounces-46286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9558F8CFD1B
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 11:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29931B22DCF
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 09:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F16E13D25E;
	Mon, 27 May 2024 09:35:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B8813C9CA
	for <stable@vger.kernel.org>; Mon, 27 May 2024 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802511; cv=none; b=EkzCXJuvJOJ4NKDB2Gn5gdfiUrVFncoYEnp4NdRljaG62wkM8AWIUPDs+OpYrjeBwwT7cGRx8QFWX2AVQTRNG16AY7PhY6lAEa1TITBzjJI866DEP/W3sfGoX9A+L/YMnsgYIJ6TjMZTnNbS72Gkgzh7Y7v5AkSq9sl5T7yuBao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802511; c=relaxed/simple;
	bh=mjfcBUsHR0ot/pUSc8l/UI/WDg0murBb+WIqBHhFaT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:To:Cc:Message-Id; b=T4TRM6R2o1taxzwTeEZ4LKKQPRXjxObmk1ozQ8mCztGhfu2KLfov1XCBI/kP+17NqTvQKviGK96P6hX8h2cPcbsxBZe8OzyK6wsctNO1NSln1lbK9vXx4BEB+reHPBGQ/JxKUJZp6gOJIkJH97wwHnGkWc64ELIiM1/VPHX2EVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1sBWl1-00061W-0I;
	Mon, 27 May 2024 09:35:07 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Mon, 27 May 2024 09:33:56 +0000
Subject: [git:media_stage/fixes] media: mgb4: Fix double debugfs remove
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
Message-Id: <E1sBWl1-00061W-0I@linuxtv.org>

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

