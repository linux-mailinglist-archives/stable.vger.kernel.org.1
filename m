Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A3E755377
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjGPUTV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjGPUTU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:19:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D87126
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:19:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ECBE60DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31853C433C8;
        Sun, 16 Jul 2023 20:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538758;
        bh=lt5HWPIjcvCctemT5STo5edq6WnYIWwxJ4lMFRWcoJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EP8AwPOLXBUY31PlmhN7BlcgWoYuZEcAlG6MrYWzeXMqa0sgZ0Hv6NiSCLPmM11LQ
         m7y/8C3oXCFsnU8qBfp/SmqPpDed5mlX8kJyGrP+yWNj4/5w8Rqtsis7ei2z5fd06H
         hqEHEoZXui1zY2nV2pxxzdiOUHx1hsPUPc0JvtNQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 536/800] cxl/region: Fix state transitions after reset failure
Date:   Sun, 16 Jul 2023 21:46:29 +0200
Message-ID: <20230716195001.544142915@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

[ Upstream commit adfe19738b71a893da62cb2e30bd6bdb4299ea67 ]

Jonathan reports that failed attempts to reset a region (teardown its
HDM decoder configuration) mistakenly advance the state of the region
to "not committed". Revert to the previous state of the region on reset
failure so that the reset can be re-attempted.

Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Closes: http://lore.kernel.org/r/20230316171441.0000205b@Huawei.com
Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/168696507968.3590522.14484000711718573626.stgit@dwillia2-xfh.jf.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/region.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index fa29bd2ec3227..bfdd424d68970 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -296,9 +296,11 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
 	if (rc)
 		return rc;
 
-	if (commit)
+	if (commit) {
 		rc = cxl_region_decode_commit(cxlr);
-	else {
+		if (rc == 0)
+			p->state = CXL_CONFIG_COMMIT;
+	} else {
 		p->state = CXL_CONFIG_RESET_PENDING;
 		up_write(&cxl_region_rwsem);
 		device_release_driver(&cxlr->dev);
@@ -308,18 +310,20 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
 		 * The lock was dropped, so need to revalidate that the reset is
 		 * still pending.
 		 */
-		if (p->state == CXL_CONFIG_RESET_PENDING)
+		if (p->state == CXL_CONFIG_RESET_PENDING) {
 			rc = cxl_region_decode_reset(cxlr, p->interleave_ways);
+			/*
+			 * Revert to committed since there may still be active
+			 * decoders associated with this region, or move forward
+			 * to active to mark the reset successful
+			 */
+			if (rc)
+				p->state = CXL_CONFIG_COMMIT;
+			else
+				p->state = CXL_CONFIG_ACTIVE;
+		}
 	}
 
-	if (rc)
-		goto out;
-
-	if (commit)
-		p->state = CXL_CONFIG_COMMIT;
-	else if (p->state == CXL_CONFIG_RESET_PENDING)
-		p->state = CXL_CONFIG_ACTIVE;
-
 out:
 	up_write(&cxl_region_rwsem);
 
-- 
2.39.2



