Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A20A713FD8
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjE1Ttm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjE1Ttl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:49:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E68A3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:49:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 219336202D
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB4FC433D2;
        Sun, 28 May 2023 19:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303379;
        bh=OiqgmmoKGeIpwUQOxSkPbImyeKfldOXENrafUqEd5oM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KbqDYQTxg/wEyEpSJ/yMce7EvK83DMEqtKB1Ci7L1iSllQONyzgF82IyChw2zro49
         KX+yNmjcwVvQGxsSExX6CCmbFi3sy5BvCkyGtXCYjrm+6SNeNS+mIh1LECbDZsv+JM
         o0iNvgtkD8f4hUZ4RLKLFe86YGq5bjldEtoYj1CQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 5.15 53/69] coresight: Fix signedness bug in tmc_etr_buf_insert_barrier_packet()
Date:   Sun, 28 May 2023 20:12:13 +0100
Message-Id: <20230528190830.348276224@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190828.358612414@linuxfoundation.org>
References: <20230528190828.358612414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

commit f67bc15e526bb9920683ad6c1891ff9e08981335 upstream.

This code generates a Smatch warning:

    drivers/hwtracing/coresight/coresight-tmc-etr.c:947 tmc_etr_buf_insert_barrier_packet()
    error: uninitialized symbol 'bufp'.

The problem is that if tmc_sg_table_get_data() returns -EINVAL, then
when we test if "len < CORESIGHT_BARRIER_PKT_SIZE", the negative "len"
value is type promoted to a high unsigned long value which is greater
than CORESIGHT_BARRIER_PKT_SIZE.  Fix this bug by adding an explicit
check for error codes.

Fixes: 75f4e3619fe2 ("coresight: tmc-etr: Add transparent buffer management")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/7d33e244-d8b9-4c27-9653-883a13534b01@kili.mountain
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -926,7 +926,7 @@ tmc_etr_buf_insert_barrier_packet(struct
 
 	len = tmc_etr_buf_get_data(etr_buf, offset,
 				   CORESIGHT_BARRIER_PKT_SIZE, &bufp);
-	if (WARN_ON(len < CORESIGHT_BARRIER_PKT_SIZE))
+	if (WARN_ON(len < 0 || len < CORESIGHT_BARRIER_PKT_SIZE))
 		return -EINVAL;
 	coresight_insert_barrier_packet(bufp);
 	return offset + CORESIGHT_BARRIER_PKT_SIZE;


