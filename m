Return-Path: <stable+bounces-73599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41A996D9A3
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 15:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F76228173B
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 13:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CB719B5BB;
	Thu,  5 Sep 2024 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="EdBfqLfJ"
X-Original-To: stable@vger.kernel.org
Received: from ci74p00im-qukt09090102.me.com (ci74p00im-qukt09090102.me.com [17.57.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C1619992C
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725541390; cv=none; b=JXT4l48pRCcI//S/CzwsO1rz9Y3Bb7VM6TFMo4guu3iE+dludz3Ssk/RfTwY+ZLf4SCQY0TFluKJrG7ceI4Ytv07K+1Yk83/TiStkBetteOUEMOTs6NOq02EhroitorM81/x4K73bK1k4h39bczcfC5CGEuAIKlvFrcYScuExBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725541390; c=relaxed/simple;
	bh=Gy5mWK6LxwI/0NuTLhsqYHhodN9ViqHz2JElQa0aLvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=stv7lpe1xG4Qx802bYtwG7qRRyEL3FJZ0kwnNEnngbNStJzM9DBGq0jhTtwGk/N8pCjQGlkc2ztypnoqVxQC8lsbQoe9tVCs83cp+Y1RCtMp5lpWEKCuUXBfSmxA16dJ5jVjdMsaiLpZiOdBNUn4WEdi1BEexLLpSIkGnYdbpqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=EdBfqLfJ; arc=none smtp.client-ip=17.57.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725541388;
	bh=bnoOmXI6avdPPfQGkv4d4OEelImbpwyUa/01maOEGrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=EdBfqLfJDL/kB4k/t/HptlQdVZBgOM3oGW1YVVvvLhgkxGhtj1REsdr0NRaSUAKXd
	 GxWLulyMYM1q+Mtajp8WgNTczyJzBqG6OO7CYezoBg+OX4ELROWQIv6PkSu6epVwTa
	 cunfnb4J8ArtJgVUpQoXj7mMfcYK91RR9s5spzMSC4H3PGcbkQUgseIpQabyrxuvlg
	 +rQnNUPGsQxahFSo+EEPYTaUKmYHGjrBwn8oCmKfg9AbWQECNy9XHjbuCgNmkTM6it
	 JT2X3ybQ9GNg0+qGoxmSZdZnNKr/+JMX+X83cmJz9ppY3g1f1/c3sKdgKdnL0uHL3f
	 vfRt2RhJZHK3w==
Received: from [192.168.1.26] (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09090102.me.com (Postfix) with ESMTPSA id AFAE13C00487;
	Thu,  5 Sep 2024 13:03:01 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 05 Sep 2024 21:02:27 +0800
Subject: [PATCH v2] cxl/region: Fix bad logic for finding a free switch cxl
 decoder
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-fix_cxld-v2-1-51a520a709e4@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOKr2WYC/22MQQ7CIBBFr9LMWgxgS8WV9zCNwenUTqJUQUlNw
 93Frl2+/1/eApECU4RDtUCgxJEnX0BvKsDR+SsJ7guDlrqWVu7EwPMZ51sv6sE0beOsNMpC0R+
 ByremTl3hkeNrCp+1nNRv/RNJSihhlMOLa5XdOzo+34zscYvTHbqc8xdaVL+WogAAAA==
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
X-Proofpoint-ORIG-GUID: 9Lw1bpLcfH68NP7i-aWjwUNHGk-gs2Gr
X-Proofpoint-GUID: 9Lw1bpLcfH68NP7i-aWjwUNHGk-gs2Gr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_08,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 mlxscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409050096
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

It is bad for current match_free_decoder()'s logic to find a free switch
cxl decoder as explained below:

 - If all child decoders are sorted by ID in ascending order, then
   current logic can be simplified as below one:

   static int match_free_decoder(struct device *dev, void *data)
   {
	struct cxl_decoder *cxld;

	if (!is_switch_decoder(dev))
		return 0;

	cxld = to_cxl_decoder(dev);
	return cxld->region ? 0 : 1;
   }
   dev = device_find_child(&port->dev, NULL, match_free_decoder);

   which does not also need to modify device_find_child()'s match data.

 - If all child decoders are NOT sorted by ID in ascending order, then
   current logic are wrong as explained below:

   F: free, (cxld->region == NULL)    B: busy, (cxld->region != NULL)
   S(n)F : State of switch cxl_decoder with ID n is Free
   S(n)B : State of switch cxl_decoder with ID n is Busy

   Provided there are 2 child decoders: S(1)F -> S(0)B, then current logic
   will fail to find a free decoder even if there are a free one with ID 1

Anyway, current logic is not good, fixed by finding a free switch cxl
decoder with minimal ID.

Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
Closes: https://lore.kernel.org/all/cdfc6f98-1aa0-4cb5-bd7d-93256552c39b@icloud.com/
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Correct title and commit message
- Link to v1: https://lore.kernel.org/r/20240903-fix_cxld-v1-1-61acba7198ae@quicinc.com
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


