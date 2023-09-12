Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C05B79AD7E
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjIKWrO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240684AbjIKOvI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:51:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F87C118
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:51:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88AAFC433C8;
        Mon, 11 Sep 2023 14:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443863;
        bh=VDHD27MMPcPd1oOXN9AXKu/beBeFc6/R7HFAiZrwvoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AZ+JXpQ25cWC4Fr623kydUjabCrToMqD7MthHXOn8bRyC5oGrec2kQPJiLEd0kzOV
         wHjFd71LyWliWF5TagowjB4d6zEEeBtCIW5QHv3ymo5OgfLtObpP8bgQtAspcQ3lej
         FSJt3qKs2lizI+FaWvLAc3Hnyn+AqvMymjJPemyg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ruidong Tian <tianruidong@linux.alibaba.com>,
        James Clark <james.clark@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 528/737] coresight: tmc: Explicit type conversions to prevent integer overflow
Date:   Mon, 11 Sep 2023 15:46:27 +0200
Message-ID: <20230911134705.327016209@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ruidong Tian <tianruidong@linux.alibaba.com>

[ Upstream commit fd380097cdb305582b7a1f9476391330299d2c59 ]

Perf cs_etm session executed unexpectedly when AUX buffer > 1G.

  perf record -C 0 -m ,2G -e cs_etm// -- <workload>
  [ perf record: Captured and wrote 2.615 MB perf.data ]

Perf only collect about 2M perf data rather than 2G. This is becasuse
the operation, "nr_pages << PAGE_SHIFT", in coresight tmc driver, will
overflow when nr_pages >= 0x80000(correspond to 1G AUX buffer). The
overflow cause buffer allocation to fail, and TMC driver will alloc
minimal buffer size(1M). You can just get about 2M perf data(1M AUX
buffer + perf data header) at least.

Explicit convert nr_pages to 64 bit to avoid overflow.

Fixes: 22f429f19c41 ("coresight: etm-perf: Add support for ETR backend")
Fixes: 99443ea19e8b ("coresight: Add generic TMC sg table framework")
Fixes: 2e499bbc1a92 ("coresight: tmc: implementing TMC-ETF AUX space API")
Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20230804081514.120171-2-tianruidong@linux.alibaba.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 5 +++--
 drivers/hwtracing/coresight/coresight-tmc.h     | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 0ab1f73c2d06a..e374b02d98be3 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -450,7 +450,7 @@ static int tmc_set_etf_buffer(struct coresight_device *csdev,
 		return -EINVAL;
 
 	/* wrap head around to the amount of space we have */
-	head = handle->head & ((buf->nr_pages << PAGE_SHIFT) - 1);
+	head = handle->head & (((unsigned long)buf->nr_pages << PAGE_SHIFT) - 1);
 
 	/* find the page to write to */
 	buf->cur = head / PAGE_SIZE;
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index eaa296ced1678..8ef4a2a13427e 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -45,7 +45,8 @@ struct etr_perf_buffer {
 };
 
 /* Convert the perf index to an offset within the ETR buffer */
-#define PERF_IDX2OFF(idx, buf)	((idx) % ((buf)->nr_pages << PAGE_SHIFT))
+#define PERF_IDX2OFF(idx, buf)		\
+		((idx) % ((unsigned long)(buf)->nr_pages << PAGE_SHIFT))
 
 /* Lower limit for ETR hardware buffer */
 #define TMC_ETR_PERF_MIN_BUF_SIZE	SZ_1M
@@ -1262,7 +1263,7 @@ alloc_etr_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
 	 * than the size requested via sysfs.
 	 */
 	if ((nr_pages << PAGE_SHIFT) > drvdata->size) {
-		etr_buf = tmc_alloc_etr_buf(drvdata, (nr_pages << PAGE_SHIFT),
+		etr_buf = tmc_alloc_etr_buf(drvdata, ((ssize_t)nr_pages << PAGE_SHIFT),
 					    0, node, NULL);
 		if (!IS_ERR(etr_buf))
 			goto done;
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 01c0382a29c0a..26e6356261c11 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -325,7 +325,7 @@ ssize_t tmc_sg_table_get_data(struct tmc_sg_table *sg_table,
 static inline unsigned long
 tmc_sg_table_buf_size(struct tmc_sg_table *sg_table)
 {
-	return sg_table->data_pages.nr_pages << PAGE_SHIFT;
+	return (unsigned long)sg_table->data_pages.nr_pages << PAGE_SHIFT;
 }
 
 struct coresight_device *tmc_etr_get_catu_device(struct tmc_drvdata *drvdata);
-- 
2.40.1



