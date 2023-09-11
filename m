Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719F079B04C
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358474AbjIKWLR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242063AbjIKPVY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:21:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D2ECC
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:21:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704AFC433C8;
        Mon, 11 Sep 2023 15:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445679;
        bh=BdUGKkTCPF//ccSDLWQJirwu/X5Gnoe3+ryc0CTiuGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JkESrKExg3Cqjs94zFq45wK0KCktbRzGlqvUxsToiwtaBz2vXlsA6nZh5esjs+gd4
         OpAAWE8D7JktDMET+Vqxf2yD1OMVVhhR1W3cCzpXMtxvn7Wl2nMi5qTmkHJmA8M6TT
         uqmSfLohpYWMRXH2naC1NwFYACpN8ZbOPRSszf9Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ruidong Tian <tianruidong@linux.alibaba.com>,
        James Clark <james.clark@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 434/600] coresight: tmc: Explicit type conversions to prevent integer overflow
Date:   Mon, 11 Sep 2023 15:47:47 +0200
Message-ID: <20230911134646.468195071@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 4c4cbd1f72584..3f207999377f0 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -428,7 +428,7 @@ static int tmc_set_etf_buffer(struct coresight_device *csdev,
 		return -EINVAL;
 
 	/* wrap head around to the amount of space we have */
-	head = handle->head & ((buf->nr_pages << PAGE_SHIFT) - 1);
+	head = handle->head & (((unsigned long)buf->nr_pages << PAGE_SHIFT) - 1);
 
 	/* find the page to write to */
 	buf->cur = head / PAGE_SIZE;
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 368f2e5a86278..1be0e5e0e80b2 100644
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
@@ -1249,7 +1250,7 @@ alloc_etr_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
 	 * than the size requested via sysfs.
 	 */
 	if ((nr_pages << PAGE_SHIFT) > drvdata->size) {
-		etr_buf = tmc_alloc_etr_buf(drvdata, (nr_pages << PAGE_SHIFT),
+		etr_buf = tmc_alloc_etr_buf(drvdata, ((ssize_t)nr_pages << PAGE_SHIFT),
 					    0, node, NULL);
 		if (!IS_ERR(etr_buf))
 			goto done;
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 66959557cf398..946aab12f9807 100644
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



