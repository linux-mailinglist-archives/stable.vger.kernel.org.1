Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58148726B44
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbjFGUYQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbjFGUXv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:23:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5C6270C
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:23:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DF066440A
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5AEC433EF;
        Wed,  7 Jun 2023 20:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169397;
        bh=8iaHfVs8HFRAl1w/FO/EflbQD0KUfmgPT7hju30DLb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KfbzBdXj+GzoVlgfwUj0zc4E7bH2hkBzEn9IIzQbR4ZKb8VjrzGUNJzKnhhA9aXpa
         vd2mOYhcRAV7y1KIp0D44VdakltYLe/a0kKGRtZhGq/C5NzaYEX8pvyPTHv0zXG2f6
         HbIKzQOaPYUS0vgpo0VZ3ZwyTKPiQSBcbzIdpU68=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 064/286] sfc: fix error unwinds in TC offload
Date:   Wed,  7 Jun 2023 22:12:43 +0200
Message-ID: <20230607200925.158013565@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Edward Cree <ecree.xilinx@gmail.com>

[ Upstream commit 622ab656344a288acf4fb03d628c3bb5dd241f34 ]

Failure ladders weren't exactly unwinding what the function had done up
 to that point; most seriously, when we encountered an already offloaded
 rule, the failure path tried to remove the new rule from the hashtable,
 which would in fact remove the already-present 'old' rule (since it has
 the same key) from the table, and leak its resources.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202305200745.xmIlkqjH-lkp@intel.com/
Fixes: d902e1a737d4 ("sfc: bare bones TC offload on EF100")
Fixes: 17654d84b47c ("sfc: add offloading of 'foreign' TC (decap) rules")
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/20230530202527.53115-1-edward.cree@amd.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/sfc/tc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index deeaab9ee761d..217f3876af722 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -379,9 +379,9 @@ static int efx_tc_flower_replace(struct efx_nic *efx,
 	if (old) {
 		netif_dbg(efx, drv, efx->net_dev,
 			  "Already offloaded rule (cookie %lx)\n", tc->cookie);
-		rc = -EEXIST;
 		NL_SET_ERR_MSG_MOD(extack, "Rule already offloaded");
-		goto release;
+		kfree(rule);
+		return -EEXIST;
 	}
 
 	/* Parse actions */
-- 
2.39.2



