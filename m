Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B2A75D2B0
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjGUTCe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjGUTCd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:02:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7467130CA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:02:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 067E361D85
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16376C433C8;
        Fri, 21 Jul 2023 19:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966151;
        bh=FYU0MNpM/rgyRv+42rM3FhUGN3zMHK1k5paAcndi6SM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r2EzffK149DWhLy/zGm5L9NWgAQAB1kIeHiLM7nuqioQ1Ed35C7eS8tCguyY/r/yb
         4pWp/qUCO8WrrZQ6WzMQdhliItYnlPs8N45XO36/lW0JIaLgb19TfB/B9ll1BhV3oI
         BPU8Hwf8InLGCX4jC9KEdlFfPrTG9FAK8CKODvfw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tarun Sahu <tsahu@linux.ibm.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 242/532] dax/kmem: Pass valid argument to memory_group_register_static
Date:   Fri, 21 Jul 2023 18:02:26 +0200
Message-ID: <20230721160627.482116933@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tarun Sahu <tsahu@linux.ibm.com>

[ Upstream commit 46e66dab8565f742374e9cc4ff7d35f344d774e2 ]

memory_group_register_static takes maximum number of pages as the argument
while dev_dax_kmem_probe passes total_len (in bytes) as the argument.

IIUC, I don't see any crash/panic impact as such. As,
memory_group_register_static just set the max_pages limit which is used in
auto_movable_zone_for_pfn to determine the zone.

which might cause these condition to behave differently,

This will be true always so jump will happen to kernel_zone
    ...
    if (!auto_movable_can_online_movable(NUMA_NO_NODE, group, nr_pages))
        goto kernel_zone;

    ...
    kernel_zone:
        return default_kernel_zone_for_pfn(nid, pfn, nr_pages);

Here, In below, zone_intersects compare range will be larger as nr_pages
will be higher (derived from total_len passed in dev_dax_kmem_probe).

    ...
    static struct zone *default_kernel_zone_for_pfn(int nid, unsigned long start_pfn,
    		unsigned long nr_pages)
    {
    	struct pglist_data *pgdat = NODE_DATA(nid);
    	int zid;

    	for (zid = 0; zid < ZONE_NORMAL; zid++) {
    		struct zone *zone = &pgdat->node_zones[zid];

    		if (zone_intersects(zone, start_pfn, nr_pages))
    			return zone;
    	}

    	return &pgdat->node_zones[ZONE_NORMAL];
    }

Incorrect zone will be returned here, which in later time might cause bigger
problem.

Fixes: eedf634aac3b ("dax/kmem: use a single static memory group for a single probed unit")
Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
Link: https://lore.kernel.org/r/20230621155025.370672-1-tsahu@linux.ibm.com
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dax/kmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 04f85f16720c8..97723ee15bc68 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -88,7 +88,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	if (!data->res_name)
 		goto err_res_name;
 
-	rc = memory_group_register_static(numa_node, total_len);
+	rc = memory_group_register_static(numa_node, PFN_UP(total_len));
 	if (rc < 0)
 		goto err_reg_mgid;
 	data->mgid = rc;
-- 
2.39.2



