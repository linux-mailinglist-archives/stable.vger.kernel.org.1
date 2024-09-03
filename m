Return-Path: <stable+bounces-72833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABC3969E05
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 14:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCF66B24383
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33821D6C7E;
	Tue,  3 Sep 2024 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="RpQsetTt"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10021801.me.com (pv50p00im-ztdg10021801.me.com [17.58.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28701D094E
	for <stable@vger.kernel.org>; Tue,  3 Sep 2024 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367448; cv=none; b=X+F8SEPvACKuflUQ0lzeJjdJZy10IzrDvPcgMft+StIkCHywZIMS30Uyh7k1Z1YplmikgxJygRrjl6fIHy8RXy0GmyN4ghRO1754r0B9zTNcteF/v4flpvztLejZGBrO8Kr4aqVjHd0PzDTlFvXqV0pJUZO3Kxvu46xyGSOn9XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367448; c=relaxed/simple;
	bh=NCxLoS7pJBA/A6sZejri9a3QzwC1XvakjDQEyT5H520=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h0Ac5AnKVIOubbxQf8MklkUf/AB3n6ShTjbbD39K2UswFOOJ85nnxyqaQtu+oNvS1IGYBMzsQdz8I/zOSfxN2DmcVEvdq16dRRQLigYjIAJlrfqU7qP6LoN+X1qaW9PijnDlGlz+2P0cfBZHy4NRx3vyIhgR021P6T3HiVyZicU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=RpQsetTt; arc=none smtp.client-ip=17.58.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725367446;
	bh=tEfTAfNjlVglE6qtj9e61J5uaCFS+zpjP4F6IfurRvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=RpQsetTtpYAcAZDJdo5WBAxLsuubUbh2IDwdNMXXN88kD0LbyDCyEwOdSEFZlRZE+
	 8vUdzYeglDnnmaBRdYIBj+eGfeDBOe951MCx+SZbJwIoR7/H/VihtKIvqg3NZIAh9G
	 Ok8iXN4hck/ImVBlr3YnRNuxOln/Kcaw+egEtGwC4WpA0jJpc3T/iQtwlq1WlQjqBm
	 jRTmAcOLoSq76MXcH5CwkvG2Y1+NsZ1e+QB6iHbV8fGjVlBuBd2XDJ2ipusSKtL0yT
	 I1stCPSCs2HhWa3CZIezd6R1UIknc45Y1nGIxsSsXnvxPMxx0onU6R6sG+iRqpE2ge
	 kuPtzMPCwWUEw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id 2DDC220102BD;
	Tue,  3 Sep 2024 12:43:59 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 03 Sep 2024 20:41:44 +0800
Subject: [PATCH] cxl/region: Fix logic for finding a free cxl decoder
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-fix_cxld-v1-1-61acba7198ae@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAcE12YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwNj3bTMivjkipwUXZM0M1Nz00RLAzNDSyWg8oKiVKAc2Kjo2NpaAOd
 52OZaAAAA
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, Ben Widawsky <bwidawsk@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Zijun Hu <zijun_hu@icloud.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: hjGKpDrPx5TerylKFjNZHA9BMEHdaUxu
X-Proofpoint-ORIG-GUID: hjGKpDrPx5TerylKFjNZHA9BMEHdaUxu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 clxscore=1011 mlxlogscore=999 phishscore=0 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409030103
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

match_free_decoder()'s logic for finding a free cxl decoder depends on
a prerequisite that all child decoders are sorted by ID in ascending order
but the prerequisite may not be guaranteed, fix by finding a free cxl
decoder with minimal ID.

Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
Closes: https://lore.kernel.org/all/cdfc6f98-1aa0-4cb5-bd7d-93256552c39b@icloud.com/
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/cxl/core/region.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 21ad5f242875..b9607b4fc40b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -797,21 +797,26 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
 static int match_free_decoder(struct device *dev, void *data)
 {
 	struct cxl_decoder *cxld;
-	int *id = data;
+	struct cxl_decoder *target_cxld;
+	struct device **target_device = data;
 
 	if (!is_switch_decoder(dev))
 		return 0;
 
 	cxld = to_cxl_decoder(dev);
-
-	/* enforce ordered allocation */
-	if (cxld->id != *id)
+	if (cxld->region)
 		return 0;
 
-	if (!cxld->region)
-		return 1;
-
-	(*id)++;
+	if (!*target_device) {
+		*target_device = get_device(dev);
+		return 0;
+	}
+	/* enforce ordered allocation */
+	target_cxld = to_cxl_decoder(*target_device);
+	if (cxld->id < target_cxld->id) {
+		put_device(*target_device);
+		*target_device = get_device(dev);
+	}
 
 	return 0;
 }
@@ -839,8 +844,7 @@ cxl_region_find_decoder(struct cxl_port *port,
 			struct cxl_endpoint_decoder *cxled,
 			struct cxl_region *cxlr)
 {
-	struct device *dev;
-	int id = 0;
+	struct device *dev = NULL;
 
 	if (port == cxled_to_port(cxled))
 		return &cxled->cxld;
@@ -849,7 +853,8 @@ cxl_region_find_decoder(struct cxl_port *port,
 		dev = device_find_child(&port->dev, &cxlr->params,
 					match_auto_decoder);
 	else
-		dev = device_find_child(&port->dev, &id, match_free_decoder);
+		/* Need to put_device(@dev) after use */
+		device_for_each_child(&port->dev, &dev, match_free_decoder);
 	if (!dev)
 		return NULL;
 	/*

---
base-commit: 67784a74e258a467225f0e68335df77acd67b7ab
change-id: 20240903-fix_cxld-4f6575a90619

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


