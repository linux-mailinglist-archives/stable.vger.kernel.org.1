Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF60719DFC
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbjFAN2J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbjFAN1z (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:27:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C3DE77
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:27:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 592B4644DD
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FF1C4339B;
        Thu,  1 Jun 2023 13:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626053;
        bh=5oM24HllQOFmwuOKRwqWlkMqXTA6vgapnVIE0BLxjJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sAdMMb9nOqk6CydWL0kUKMfJUaMHZaOtUcwZRYkaip+3Qn2ko8X7jl1EVeEj6/tzX
         L2bkDjAekZU3SLcSZt5n+g09eAKQO/U9mDTNPRwCnN3QEyyKbCaFuzoTwjhmH6Nofw
         tjctxDORT1ZRRw50FRi4phjAoX9OYbThV7RhWwH0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 03/42] firmware: arm_ffa: Fix usage of partition info get count flag
Date:   Thu,  1 Jun 2023 14:21:12 +0100
Message-Id: <20230601131939.207108422@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131939.051934720@linuxfoundation.org>
References: <20230601131939.051934720@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit c6e045361a27ecd4fac6413164e0d091d80eee99 ]

Commit bb1be7498500 ("firmware: arm_ffa: Add v1.1 get_partition_info support")
adds support to discovery the UUIDs of the partitions or just fetch the
partition count using the PARTITION_INFO_GET_RETURN_COUNT_ONLY flag.

However the commit doesn't handle the fact that the older version doesn't
understand the flag and must be MBZ which results in firmware returning
invalid parameter error. That results in the failure of the driver probe
which is in correct.

Limit the usage of the PARTITION_INFO_GET_RETURN_COUNT_ONLY flag for the
versions above v1.0(i.e v1.1 and onwards) which fixes the issue.

Fixes: bb1be7498500 ("firmware: arm_ffa: Add v1.1 get_partition_info support")
Reported-by: Jens Wiklander <jens.wiklander@linaro.org>
Reported-by: Marc Bonnici <marc.bonnici@arm.com>
Tested-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
Link: https://lore.kernel.org/r/20230419-ffa_fixes_6-4-v2-2-d9108e43a176@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_ffa/driver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 737f36e7a9035..5904a679d3512 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -274,7 +274,8 @@ __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
 	int idx, count, flags = 0, sz, buf_sz;
 	ffa_value_t partition_info;
 
-	if (!buffer || !num_partitions) /* Just get the count for now */
+	if (drv_info->version > FFA_VERSION_1_0 &&
+	    (!buffer || !num_partitions)) /* Just get the count for now */
 		flags = PARTITION_INFO_GET_RETURN_COUNT_ONLY;
 
 	mutex_lock(&drv_info->rx_lock);
-- 
2.39.2



