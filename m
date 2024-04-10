Return-Path: <stable+bounces-37972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BC089F3D2
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 15:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588921F21CEE
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 13:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7014A15E80D;
	Wed, 10 Apr 2024 13:16:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB91015B576
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754962; cv=none; b=J53n70utATaRhsydNx5kHQIbvJzDx18a+aSWB5ML/3+XpJj9ht7cM868E9t/jm/ak6p1JdjaCzJilCEBgXFgQWAdQgqrGrWVuumCup5uugxAOtP3Pqo9sNf5lM2Aa22xSZCZ3H0WU0Z4fhIIep34RCnQCMX+QxM2o58CCnAoH0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754962; c=relaxed/simple;
	bh=T7LLVEX1SK/bEz8ourWopESak3os/t8HWx9obCCOEFg=;
	h=From:Date:Subject:To:Cc:Message-Id; b=Mstdz0L7KYolP9EfCXVdohLSkkpNREvPkeyzAmq3U+9rOz0iRY86iac2uchLwDurlTAIkJG7vpeYsxbxnXc7C5JV9If1C+VY8Eu+J4mrFFxk9w2hA/GT9btKqRcomLQjh7MDJtpJDr2htBvq/kd5VALTC2rHcBArHHMzyic+bJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1ruXny-0001FJ-2U;
	Wed, 10 Apr 2024 13:15:58 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Wed, 10 Apr 2024 13:15:30 +0000
Subject: [git:media_stage/master] media: ov2680: Clear the 'ret' variable on success
To: linuxtv-commits@linuxtv.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1ruXny-0001FJ-2U@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: ov2680: Clear the 'ret' variable on success
Author:  Fabio Estevam <festevam@denx.de>
Date:    Thu Mar 28 19:44:12 2024 -0300

Since commit 63b0cd30b78e ("media: ov2680: Add bus-cfg / endpoint
property verification") even when the correct 'link-frequencies'
property is passed in the devicetree, the driver fails to probe:

ov2680 1-0036: probe with driver ov2680 failed with error -22

The reason is that the variable 'ret' may contain the -EINVAL value
from a previous assignment:

ret = fwnode_property_read_u32(dev_fwnode(dev), "clock-frequency",
			       &rate);

Fix the problem by clearing 'ret' on the successful path.

Tested on imx7s-warp board with the following devicetree:

port {
	ov2680_to_mipi: endpoint {
		remote-endpoint = <&mipi_from_sensor>;
		clock-lanes = <0>;
		data-lanes = <1>;
		link-frequencies = /bits/ 64 <330000000>;
	};
};

Cc: stable@vger.kernel.org
Fixes: 63b0cd30b78e ("media: ov2680: Add bus-cfg / endpoint property verification")
Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/i2c/ov2680.c | 1 +
 1 file changed, 1 insertion(+)

---

diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
index 39d321e2b7f9..3e3b7c2b492c 100644
--- a/drivers/media/i2c/ov2680.c
+++ b/drivers/media/i2c/ov2680.c
@@ -1135,6 +1135,7 @@ static int ov2680_parse_dt(struct ov2680_dev *sensor)
 		goto out_free_bus_cfg;
 	}
 
+	ret = 0;
 out_free_bus_cfg:
 	v4l2_fwnode_endpoint_free(&bus_cfg);
 	return ret;

