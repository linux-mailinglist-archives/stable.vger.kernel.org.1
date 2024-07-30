Return-Path: <stable+bounces-65361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C534947534
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 08:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA082815C0
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 06:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8A11428E3;
	Mon,  5 Aug 2024 06:26:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFF11DFF7
	for <stable@vger.kernel.org>; Mon,  5 Aug 2024 06:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722839196; cv=none; b=OI7xInmYRPaboG6pZ+4KzQIF5NIiEJ/atoXJ5YKiSV0YpvdzUG5Ei2MnxZ36zcfjfQeOBj8VByli/fP+ww0IKsT0pH+g5EzydREqvfDvIOLC25Z0X7DLfG7gpI6AR5c3n7rfXnUcA/2VM5O8VikC6tMEWCWf4P1cy21d6OyqIDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722839196; c=relaxed/simple;
	bh=TXzEy75fc27ks3aqJAdaiuo5tSvQLbajFAv7VOAt+28=;
	h=From:Date:Subject:To:Cc:Message-Id; b=MYIUaKLyYkrJo0asZvzJN1S4OyKnxpKjkCdxOyyeW4YPWGne583ajlH+IZIQFpkPbbxjYs4olbxExrw7+uVpaBNBIbIvo412VUjPv84nO8sKa1b3Sf8uM3xy8H0UrbAEMnvWNqlPjcbMsFvxxXwfHKwcZPgRNPiX27y2Pp3nX9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from mchehab by linuxtv.org with local (Exim 4.96)
	(envelope-from <mchehab@linuxtv.org>)
	id 1sarAu-0000fH-1W;
	Mon, 05 Aug 2024 06:26:32 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Tue, 30 Jul 2024 06:36:29 +0000
Subject: [git:media_stage/master] media: intel/ipu6: select AUXILIARY_BUS in Kconfig
To: linuxtv-commits@linuxtv.org
Cc: stable@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, Bingbu Cao <bingbu.cao@intel.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1sarAu-0000fH-1W@linuxtv.org>
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

