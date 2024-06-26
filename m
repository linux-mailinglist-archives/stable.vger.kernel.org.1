Return-Path: <stable+bounces-55847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E9B91827E
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 15:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6681F211C5
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 13:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E88E1836ED;
	Wed, 26 Jun 2024 13:32:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EA717FABF
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408772; cv=none; b=l0BVVMslKT5LH26pA++MpKN2CuG10cq8iP8MtqrZyBq7pJC6efkJNxCDQIh4jvlpHLFgCbwlJyh1pJBXtAHV94KMZPqCXhmpeSiUj1Tn/j6vd9t6vx2ctUReDUDY/SWcKJ7UQKLqJgaXY4GHxMAW/WLyTn8gy5TiDPD558B0tlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408772; c=relaxed/simple;
	bh=qTpY4ndpBom4/4F18EcvdViXdrKt35LKS/zR70a3gGI=;
	h=From:Date:Subject:To:Cc:Message-Id; b=EK2lqG7o8uEXxzWmTatfkL8GqPW75/rzp+s4uQgOsaWYXAsrB0HgjW8KKC62/DpU4lDdRfVd3TLb5J1LFtbb/rWYIRYLUFMQDzzRi4esaCuU29jnpbPrbthqv+81Y/jfDCb9+MdxtczCcytA1fguL9YVEnxjMgM0HmCl88P38tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1sMSlV-0008Bl-1K;
	Wed, 26 Jun 2024 13:32:49 +0000
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 26 Jun 2024 06:14:02 +0000
Subject: [git:media_stage/master] media: i2c: Kconfig: Fix missing firmware upload config select
To: linuxtv-commits@linuxtv.org
Cc: Paul Elder <paul.elder@ideasonboard.com>, stable@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1sMSlV-0008Bl-1K@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: i2c: Kconfig: Fix missing firmware upload config select
Author:  Kory Maincent <kory.maincent@bootlin.com>
Date:    Thu Jun 20 12:25:43 2024 +0200

FW_LOADER config only selects the firmware loader API, but we also need
the sysfs_upload symbols for firmware_upload_unregister() and
firmware_upload_register() to function properly.

Fixes: 7a52ab415b43 ("media: i2c: Add driver for THine THP7312")
Cc: stable@vger.kernel.org
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Paul Elder <paul.elder@ideasonboard.com>
Link: https://lore.kernel.org/r/20240620102544.1918105-1-kory.maincent@bootlin.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

 drivers/media/i2c/Kconfig | 1 +
 1 file changed, 1 insertion(+)

---

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 8aac41513b59..8ba096b8ebca 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -710,6 +710,7 @@ config VIDEO_THP7312
 	tristate "THine THP7312 support"
 	depends on I2C
 	select FW_LOADER
+	select FW_UPLOAD
 	select MEDIA_CONTROLLER
 	select V4L2_CCI_I2C
 	select V4L2_FWNODE

