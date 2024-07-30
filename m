Return-Path: <stable+bounces-65363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91970947536
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 08:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C00B1F220BB
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 06:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FB21442EA;
	Mon,  5 Aug 2024 06:26:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC32A13C9D3
	for <stable@vger.kernel.org>; Mon,  5 Aug 2024 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722839196; cv=none; b=JKgi337iUDPsj1PKBCvVMbGLGc8L6+l4MkDbT85hWwieSdSa9evllwn6LTfFpknkI/wvd8JBCzLYmHrEsH3DX9bxdKA2K3iuCdlJx3MvN4D3r9qp2V9KJU4/0NpsqUYouSj77ET+kNsZtWRA40bnE/ap+5MnEWgMtL0NUSXamq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722839196; c=relaxed/simple;
	bh=N2+iCGDYJfTdiEpdWHRP0smTrjMquasS56upJlS2lF0=;
	h=From:Date:Subject:To:Cc:Message-Id; b=KvMRgzzQPonWnKgLoUwTU5df2msH8ycEGCNRXtWrengcFX1K7AzE89dmZnsipzVVbUU4b2VdUYSl79j9eTHxeXJ61QZLzv/pv+0qtdD/tir0RSa7N1qvwcLd3AH3plCUkNwVd/PQSb7mhMuY+njYRxK7Y6fDWf44FKMYX7hhFW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from mchehab by linuxtv.org with local (Exim 4.96)
	(envelope-from <mchehab@linuxtv.org>)
	id 1sarAv-0000fl-1J;
	Mon, 05 Aug 2024 06:26:33 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Tue, 30 Jul 2024 06:36:29 +0000
Subject: [git:media_stage/master] media: ipu-bridge: fix ipu6 Kconfig dependencies
To: linuxtv-commits@linuxtv.org
Cc: Arnd Bergmann <arnd@arndb.de>, Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1sarAv-0000fl-1J@linuxtv.org>
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

