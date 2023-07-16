Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E996755342
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjGPURG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjGPURG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:17:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FB890
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:17:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8CF860EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8111C433C7;
        Sun, 16 Jul 2023 20:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538624;
        bh=+fHDIzySRnnHmFJzKNYfD4czu+DrzCi+Gq8FpGBTcOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HfZ/pTNZY3EpwqE5G5r5uy6i8dPhVgMzhPmAAgGeSrUvvLZEyIxEq34zqZA7KP6YZ
         nVqNqZvtHGKnSHLcQsAf1iPgJWoQkm4q40wf0LkGzrmZwoOfXmHFR0pW8/LN1Gz0N9
         wcs51RKdFg8hYw1mN8EepXW3kIO8fTQpmR/91tt4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tarun Sahu <tsahu@linux.ibm.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 517/800] dax/kmem: Pass valid argument to memory_group_register_static
Date:   Sun, 16 Jul 2023 21:46:10 +0200
Message-ID: <20230716195001.098269234@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 7b36db6f1cbdc..898ca95057547 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -99,7 +99,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	if (!data->res_name)
 		goto err_res_name;
 
-	rc = memory_group_register_static(numa_node, total_len);
+	rc = memory_group_register_static(numa_node, PFN_UP(total_len));
 	if (rc < 0)
 		goto err_reg_mgid;
 	data->mgid = rc;
-- 
2.39.2



