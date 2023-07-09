Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A4F74C3C3
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjGILgB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbjGILgB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:36:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFA795
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:36:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B007F60BB7
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C234FC433C7;
        Sun,  9 Jul 2023 11:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902559;
        bh=sRfrhtjUrDzQyuUPi/UEr5RUE433+OW6s7VVsxy7PiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PXVxyA261MhRCL5n6Enis+PO8tfShtQMZlAt4oIHY73JLdh1T+uL45acOEK8fynrm
         Aj1KLmF/lhB07AobcKjHFMlG0mp2SIu1fnclySzWAiD/3fflDLqhFh+BCphV91mcAU
         DZS9HOYF4EEohMBluYAO+Q2v+WMXX5XpOcdY3i9Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 419/431] cxl/region: Flag partially torn down regions as unusable
Date:   Sun,  9 Jul 2023 13:16:07 +0200
Message-ID: <20230709111501.009966224@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

[ Upstream commit 2ab47045ac96a605e3037d479a7d5854570ee5bf ]

cxl_region_decode_reset() walks all the decoders associated with a given
region and disables them. Due to decoder ordering rules it is possible
that a switch in the topology notices that a given decoder can not be
shutdown before another region with a higher HPA is shutdown first. That
can leave the region in a partially committed state.

Capture that state in a new CXL_REGION_F_NEEDS_RESET flag and require
that a successful cxl_region_decode_reset() attempt must be completed
before cxl_region_probe() accepts the region.

This is a corollary for the bug that Jonathan identified in "CXL/region
:  commit reset of out of order region appears to succeed." [1].

Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Link: http://lore.kernel.org/r/20230316171441.0000205b@Huawei.com [1]
Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/168696507423.3590522.16254212607926684429.stgit@dwillia2-xfh.jf.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/region.c | 12 ++++++++++++
 drivers/cxl/cxl.h         |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3b3bbd98e99d5..c1422167ab02b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -182,14 +182,19 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
 				rc = cxld->reset(cxld);
 			if (rc)
 				return rc;
+			set_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
 		}
 
 endpoint_reset:
 		rc = cxled->cxld.reset(&cxled->cxld);
 		if (rc)
 			return rc;
+		set_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
 	}
 
+	/* all decoders associated with this region have been torn down */
+	clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
+
 	return 0;
 }
 
@@ -2740,6 +2745,13 @@ static int cxl_region_probe(struct device *dev)
 		goto out;
 	}
 
+	if (test_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags)) {
+		dev_err(&cxlr->dev,
+			"failed to activate, re-commit region and retry\n");
+		rc = -ENXIO;
+		goto out;
+	}
+
 	/*
 	 * From this point on any path that changes the region's state away from
 	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 70ab8fcd0377c..dcebe48bb5bb5 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -469,6 +469,14 @@ struct cxl_region_params {
  */
 #define CXL_REGION_F_AUTO 0
 
+/*
+ * Require that a committed region successfully complete a teardown once
+ * any of its associated decoders have been torn down. This maintains
+ * the commit state for the region since there are committed decoders,
+ * but blocks cxl_region_probe().
+ */
+#define CXL_REGION_F_NEEDS_RESET 1
+
 /**
  * struct cxl_region - CXL region
  * @dev: This region's device
-- 
2.39.2



