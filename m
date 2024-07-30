Return-Path: <stable+bounces-66040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CF994BE66
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 15:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E15E28D452
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 13:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D6A18E042;
	Thu,  8 Aug 2024 13:16:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D0918E021
	for <stable@vger.kernel.org>; Thu,  8 Aug 2024 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123012; cv=none; b=hZI4b15rRI/ibkkhqy7SRVj/+R0hZGXsTCUXVuaztQiHUfHHnFgn75kvzUGlIYxajBK6o8IMRWsbBA6xBfPt/S24GOKBm4nGIq9gmcIYgzQBw41AMcZdSnQyJ23DAEMnoS+P4ZPhsF9A+MAo7Ptgh/EiGnkq89T/wVKfmUlePMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123012; c=relaxed/simple;
	bh=N2+iCGDYJfTdiEpdWHRP0smTrjMquasS56upJlS2lF0=;
	h=From:Date:Subject:To:Cc:Message-Id; b=c0ghotaQq7UIMUbc8kCsMfbrQpBNOgHvL2ZdPQ59+5B4eLkhrHZX6SuOoFJvnPapWXNXmyUYQ5AfTg8YvkIT9eAnUT3SUgnPcXZGe01xqUGp9f6zxCBXNht56sFrINYCybKO+qiRaeI4/mNiayVZZyrWrV9QUqGIxw2xm6T0qoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from mchehab by linuxtv.org with local (Exim 4.96)
	(envelope-from <mchehab@linuxtv.org>)
	id 1sc30a-0003Nn-2i;
	Thu, 08 Aug 2024 13:16:48 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Tue, 30 Jul 2024 06:36:29 +0000
Subject: [git:media_tree/master] media: ipu-bridge: fix ipu6 Kconfig dependencies
To: linuxtv-commits@linuxtv.org
Cc: Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1sc30a-0003Nn-2i@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: ipu-bridge: fix ipu6 Kconfig dependencies
Author:  Arnd Bergmann <arnd@arndb.de>
Date:    Fri Jul 19 11:53:50 2024 +0200

Commit 4670c8c3fb04 ("media: ipu-bridge: Fix Kconfig dependencies") changed
how IPU_BRIDGE dependencies are handled for all drivers, but the IPU6
variant was added the old way, which causes build time warnings when I2C is
turned off:

WARNING: unmet direct dependencies detected for IPU_BRIDGE
  Depends on [n]: MEDIA_SUPPORT [=m] && PCI [=y] && MEDIA_PCI_SUPPORT [=y] && (ACPI [=y] || COMPILE_TEST [=y]) && I2C [=n]
  Selected by [m]:
  - VIDEO_INTEL_IPU6 [=m] && MEDIA_SUPPORT [=m] && PCI [=y] && MEDIA_PCI_SUPPORT [=y] && (ACPI [=y] || COMPILE_TEST [=y]) && VIDEO_DEV [=m] && X86 [=y] && X86_64 [=y] && HAS_DMA [=y]

To make it consistent with the other IPU drivers as well as avoid this
warning, change the 'select' into 'depends on'.

Fixes: c70281cc83d6 ("media: intel/ipu6: add Kconfig and Makefile")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[Sakari Ailus: Alternatively depend on !IPU_BRIDGE.]
Cc: stable@vger.kernel.org # for v6.10
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/pci/intel/ipu6/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---

diff --git a/drivers/media/pci/intel/ipu6/Kconfig b/drivers/media/pci/intel/ipu6/Kconfig
index 154343080c82..b7ab24b89836 100644
--- a/drivers/media/pci/intel/ipu6/Kconfig
+++ b/drivers/media/pci/intel/ipu6/Kconfig
@@ -3,13 +3,13 @@ config VIDEO_INTEL_IPU6
 	depends on ACPI || COMPILE_TEST
 	depends on VIDEO_DEV
 	depends on X86 && X86_64 && HAS_DMA
+	depends on IPU_BRIDGE || !IPU_BRIDGE
 	select DMA_OPS
 	select IOMMU_IOVA
 	select VIDEO_V4L2_SUBDEV_API
 	select MEDIA_CONTROLLER
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_FWNODE
-	select IPU_BRIDGE
 	help
 	  This is the 6th Gen Intel Image Processing Unit, found in Intel SoCs
 	  and used for capturing images and video from camera sensors.

