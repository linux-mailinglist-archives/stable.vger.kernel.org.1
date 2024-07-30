Return-Path: <stable+bounces-66039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5528594BE65
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 15:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7901F23D63
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 13:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD4B18E039;
	Thu,  8 Aug 2024 13:16:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E80D18B475
	for <stable@vger.kernel.org>; Thu,  8 Aug 2024 13:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123012; cv=none; b=IUyWfTQEft6z5Gz8izLhJmYRmaYgRmMDKu7GIEhXbfducpj1RftFEchaIZbV15hlWyyNIRksgX/uE7yMSKXcKOUVqctZgBlmlJiNySrakuBd9E7JU2BdQ8VDKJKc+P3rdIDbdDFHldRPoDpjXhzGq7cjBp5J7Ey8toFLl3svXzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123012; c=relaxed/simple;
	bh=TXzEy75fc27ks3aqJAdaiuo5tSvQLbajFAv7VOAt+28=;
	h=From:Date:Subject:To:Cc:Message-Id; b=kZL/7swo8kj8Mb4Sywl8VMGcdEJI7T0CtsyUYzgevvbHG3MbQIrZV8Ou9QY5cmXExg0tZK29lASwp40e2sPHKesqb72E3F8oKpoX8n8XHCK6sAEfF5v34yUnBxKroh91l++2thhRG1Bdz77WrsBFD7Ki2JaVXKauGh30XZH5ztg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from mchehab by linuxtv.org with local (Exim 4.96)
	(envelope-from <mchehab@linuxtv.org>)
	id 1sc30a-0003NV-27;
	Thu, 08 Aug 2024 13:16:48 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Tue, 30 Jul 2024 06:36:29 +0000
Subject: [git:media_tree/master] media: intel/ipu6: select AUXILIARY_BUS in Kconfig
To: linuxtv-commits@linuxtv.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Bingbu Cao <bingbu.cao@intel.com>, stable@vger.kernel.org
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1sc30a-0003NV-27@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: intel/ipu6: select AUXILIARY_BUS in Kconfig
Author:  Bingbu Cao <bingbu.cao@intel.com>
Date:    Wed Jul 17 15:40:50 2024 +0800

Intel IPU6 PCI driver need register its devices on auxiliary
bus, so it needs to select the AUXILIARY_BUS in Kconfig.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407161833.7BEFXejx-lkp@intel.com/
Fixes: c70281cc83d6 ("media: intel/ipu6: add Kconfig and Makefile")
Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
Cc: stable@vger.kernel.org # for v6.10
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/pci/intel/ipu6/Kconfig | 1 +
 1 file changed, 1 insertion(+)

---

diff --git a/drivers/media/pci/intel/ipu6/Kconfig b/drivers/media/pci/intel/ipu6/Kconfig
index b7ab24b89836..40e20f0aa5ae 100644
--- a/drivers/media/pci/intel/ipu6/Kconfig
+++ b/drivers/media/pci/intel/ipu6/Kconfig
@@ -4,6 +4,7 @@ config VIDEO_INTEL_IPU6
 	depends on VIDEO_DEV
 	depends on X86 && X86_64 && HAS_DMA
 	depends on IPU_BRIDGE || !IPU_BRIDGE
+	select AUXILIARY_BUS
 	select DMA_OPS
 	select IOMMU_IOVA
 	select VIDEO_V4L2_SUBDEV_API

