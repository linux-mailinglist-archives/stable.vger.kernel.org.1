Return-Path: <stable+bounces-37967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B63D189F3CD
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 15:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7088828E027
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 13:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC88D15E5CC;
	Wed, 10 Apr 2024 13:16:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532F915CD69
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754960; cv=none; b=sblITwMisLpS0H3Hbi1K3tzkLcDcuKwYUWthTtu8pxmEYrAbgGY+uKhEEOwArVpMqpn7C+GOBGTX/9sP0UEptw+J+/66v+q+yQkUG0Z7Nlh69s4NbjnemFQLft3ajxPu0pmAojmSW6mIh9B9QHsXs4QRqjdhGBHpUrdfBWPX9d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754960; c=relaxed/simple;
	bh=HkW8YMikfYDrChwNfpwN1rswe6SHxdbSNb/wcqdpiEg=;
	h=From:Date:Subject:To:Cc:Message-Id; b=tu8iyq6G6zrLkB47rWdw0+kuC3nSwqsWp7ZgvOTfejsFSTopeNQoyZe/wbygMMa1EZ3w96Q94U89e7ZQ3CIS+GuibKCl/As+xLVPI5gjkKw7xOiNJgbctZ5SeHtdRZ9L3UAFUCV2O/5lIsmLZ1lgjGwSyu5kStBFmGxAJC4p6fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1ruXny-0001Ey-28;
	Wed, 10 Apr 2024 13:15:58 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Wed, 10 Apr 2024 13:15:30 +0000
Subject: [git:media_stage/master] media: ov2680: Allow probing if link-frequencies is absent
To: linuxtv-commits@linuxtv.org
Cc: Fabio Estevam <festevam@denx.de>, stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Sakari Ailus <sakari.ailus@linux.intel.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1ruXny-0001Ey-28@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: ov2680: Allow probing if link-frequencies is absent
Author:  Fabio Estevam <festevam@denx.de>
Date:    Thu Mar 28 19:44:13 2024 -0300

Since commit 63b0cd30b78e ("media: ov2680: Add bus-cfg / endpoint
property verification") the ov2680 no longer probes on a imx7s-warp7:

ov2680 1-0036: error -EINVAL: supported link freq 330000000 not found
ov2680 1-0036: probe with driver ov2680 failed with error -22

As the 'link-frequencies' property is not mandatory, allow the probe
to succeed by skipping the link-frequency verification when the
property is absent.

Cc: stable@vger.kernel.org
Fixes: 63b0cd30b78e ("media: ov2680: Add bus-cfg / endpoint property verification")
Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/i2c/ov2680.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

---

diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
index 3e3b7c2b492c..a857763c7984 100644
--- a/drivers/media/i2c/ov2680.c
+++ b/drivers/media/i2c/ov2680.c
@@ -1123,18 +1123,23 @@ static int ov2680_parse_dt(struct ov2680_dev *sensor)
 		goto out_free_bus_cfg;
 	}
 
+	if (!bus_cfg.nr_of_link_frequencies) {
+		dev_warn(dev, "Consider passing 'link-frequencies' in DT\n");
+		goto skip_link_freq_validation;
+	}
+
 	for (i = 0; i < bus_cfg.nr_of_link_frequencies; i++)
 		if (bus_cfg.link_frequencies[i] == sensor->link_freq[0])
 			break;
 
-	if (bus_cfg.nr_of_link_frequencies == 0 ||
-	    bus_cfg.nr_of_link_frequencies == i) {
+	if (bus_cfg.nr_of_link_frequencies == i) {
 		ret = dev_err_probe(dev, -EINVAL,
 				    "supported link freq %lld not found\n",
 				    sensor->link_freq[0]);
 		goto out_free_bus_cfg;
 	}
 
+skip_link_freq_validation:
 	ret = 0;
 out_free_bus_cfg:
 	v4l2_fwnode_endpoint_free(&bus_cfg);

