Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263207BDF2B
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376753AbjJIN1I (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376720AbjJIN1H (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:27:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54D2B7
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:27:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AE2C433C8;
        Mon,  9 Oct 2023 13:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858026;
        bh=yZwx1X9BKM8PYl5+bp1f34kujASFUr1EtaXyNnrHuww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q2Qz7YNrjWApY3W1/UqmbbwIYUAPONgsERQJqiW9wS/CfwJh1Njgi45HacGnWxbYO
         nfqPjxAeaqjLVqaQ1VIGeGvueY3GYisaReqfx9FieoFHQ+Mv9oGMSD/BfCyByAXiCd
         wb7D0HkHGqFCt5S6oTSpY5g1wC0lpjxOfxOp3Kcs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Zhang <markzhang@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 5.15 69/75] RDMA/cma: Initialize ib_sa_multicast structure to 0 when join
Date:   Mon,  9 Oct 2023 15:02:31 +0200
Message-ID: <20231009130113.673356588@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.200710898@linuxfoundation.org>
References: <20231009130111.200710898@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Zhang <markzhang@nvidia.com>

commit e0fe97efdb00f0f32b038a4836406a82886aec9c upstream.

Initialize the structure to 0 so that it's fields won't have random
values. For example fields like rec.traffic_class (as well as
rec.flow_label and rec.sl) is used to generate the user AH through:
  cma_iboe_join_multicast
    cma_make_mc_event
      ib_init_ah_from_mcmember

And a random traffic_class causes a random IP DSCP in RoCEv2.

Fixes: b5de0c60cc30 ("RDMA/cma: Fix use after free race in roce multicast join")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Link: https://lore.kernel.org/r/20230927090511.603595-1-markzhang@nvidia.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/cma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4751,7 +4751,7 @@ static int cma_iboe_join_multicast(struc
 	int err = 0;
 	struct sockaddr *addr = (struct sockaddr *)&mc->addr;
 	struct net_device *ndev = NULL;
-	struct ib_sa_multicast ib;
+	struct ib_sa_multicast ib = {};
 	enum ib_gid_type gid_type;
 	bool send_only;
 


