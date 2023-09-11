Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD1179AE1A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjIKWtE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239126AbjIKOM3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:12:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34138CE5
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:12:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8FFC433C8;
        Mon, 11 Sep 2023 14:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441544;
        bh=/QVysCKtoRJRInlUMPhH06714XrKlyxzvS8pxfHc4Zs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jLB1Dt/1Knn+CiVtiMMf+VxUmIXYTDXg2S5hguth3Qq9MNmt3UXP1EtlOgidojJv0
         XKLrg9pCbp7YjL2BqmdcqD1mNtYD22GOHhlXckvnhyU8Fn8HKVENkSgE836zPop6nb
         8cxQF3F9Oq9Y/ahS//vFXvLTB+WX1MXPcec1Ub8o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Minjie Du <duminjie@vivo.com>,
        Alok Prasad <palok@marvell.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 450/739] RDMA/qedr: Remove a duplicate assignment in irdma_query_ah()
Date:   Mon, 11 Sep 2023 15:44:09 +0200
Message-ID: <20230911134703.731696592@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Minjie Du <duminjie@vivo.com>

[ Upstream commit 65e02e840847158c7ee48ca8e6e91062b0f78662 ]

Delete a duplicate statement from this function implementation.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Minjie Du <duminjie@vivo.com>
Acked-by: Alok Prasad <palok@marvell.com>
Link: https://lore.kernel.org/r/20230706022704.1260-1-duminjie@vivo.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/verbs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 9c4fe4fa90018..a8326a95d186c 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -4424,7 +4424,6 @@ static int irdma_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr)
 		ah_attr->grh.traffic_class = ah->sc_ah.ah_info.tc_tos;
 		ah_attr->grh.hop_limit = ah->sc_ah.ah_info.hop_ttl;
 		ah_attr->grh.sgid_index = ah->sgid_index;
-		ah_attr->grh.sgid_index = ah->sgid_index;
 		memcpy(&ah_attr->grh.dgid, &ah->dgid,
 		       sizeof(ah_attr->grh.dgid));
 	}
-- 
2.40.1



