Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC147A3A1B
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240284AbjIQT65 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240249AbjIQT60 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:58:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8C4F3
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:58:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC34C433C9;
        Sun, 17 Sep 2023 19:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980701;
        bh=396Usfqb6spM58Heu613Zmm2csdqkDElzqnCdX43Gss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=09gP5U7PWrJH/BPmk1mf8lW57tOGOIs4hO8xoXi02PdgGXZGkKDab/603b7Dxjnc8
         e2G4uQYHofwYCdMCkZlHt0463+xd/6Me7kyq0wSgPY9C4D9iopC0zmlVnzEMBbWDSn
         GvJq7ozmxLEgrUz92++I6yTVlJr5SO8NHHZ+m+KE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Shravan Kumar Ramani <shravankr@nvidia.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 269/285] platform/mellanox: mlxbf-pmc: Fix potential buffer overflows
Date:   Sun, 17 Sep 2023 21:14:29 +0200
Message-ID: <20230917191100.501249157@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shravan Kumar Ramani <shravankr@nvidia.com>

[ Upstream commit 80ccd40568bcd3655b0fd0be1e9b3379fd6e1056 ]

Replace sprintf with sysfs_emit where possible.
Size check in mlxbf_pmc_event_list_show should account for "\0".

Fixes: 1a218d312e65 ("platform/mellanox: mlxbf-pmc: Add Mellanox BlueField PMC driver")
Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
Link: https://lore.kernel.org/r/bef39ef32319a31b32f999065911f61b0d3b17c3.1693917738.git.shravankr@nvidia.com
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/mellanox/mlxbf-pmc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index be967d797c28e..95afcae7b9fa9 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -1008,7 +1008,7 @@ static ssize_t mlxbf_pmc_counter_show(struct device *dev,
 	} else
 		return -EINVAL;
 
-	return sprintf(buf, "0x%llx\n", value);
+	return sysfs_emit(buf, "0x%llx\n", value);
 }
 
 /* Store function for "counter" sysfs files */
@@ -1078,13 +1078,13 @@ static ssize_t mlxbf_pmc_event_show(struct device *dev,
 
 	err = mlxbf_pmc_read_event(blk_num, cnt_num, is_l3, &evt_num);
 	if (err)
-		return sprintf(buf, "No event being monitored\n");
+		return sysfs_emit(buf, "No event being monitored\n");
 
 	evt_name = mlxbf_pmc_get_event_name(pmc->block_name[blk_num], evt_num);
 	if (!evt_name)
 		return -EINVAL;
 
-	return sprintf(buf, "0x%llx: %s\n", evt_num, evt_name);
+	return sysfs_emit(buf, "0x%llx: %s\n", evt_num, evt_name);
 }
 
 /* Store function for "event" sysfs files */
@@ -1139,9 +1139,9 @@ static ssize_t mlxbf_pmc_event_list_show(struct device *dev,
 		return -EINVAL;
 
 	for (i = 0, buf[0] = '\0'; i < size; ++i) {
-		len += sprintf(e_info, "0x%x: %s\n", events[i].evt_num,
-			       events[i].evt_name);
-		if (len > PAGE_SIZE)
+		len += snprintf(e_info, sizeof(e_info), "0x%x: %s\n",
+				events[i].evt_num, events[i].evt_name);
+		if (len >= PAGE_SIZE)
 			break;
 		strcat(buf, e_info);
 		ret = len;
@@ -1168,7 +1168,7 @@ static ssize_t mlxbf_pmc_enable_show(struct device *dev,
 
 	value = FIELD_GET(MLXBF_PMC_L3C_PERF_CNT_CFG_EN, perfcnt_cfg);
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 /* Store function for "enable" sysfs files - only for l3cache */
-- 
2.40.1



