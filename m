Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7286D7BE106
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377592AbjJINqe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377534AbjJINqJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:46:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA6D1B3
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:46:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26544C433C8;
        Mon,  9 Oct 2023 13:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859162;
        bh=7/dM4L7JmdsascfAGbvqW4UDud4khwi0JCeGp1fTkdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NXBxLaxYHzHuhgWdSolhDmRXrql0+zQ5ZyL5ACtn7Q/laPzS3+IV34Pi+e5jMqW8r
         xozXAhTc0LJQQpcgi599UJ6etYnoqPDRp3tR5P98B2E7q/UuOVW0GibK8RdjTgLHJm
         wZq3B7Ik1VS3a9PztpPlpoCmdjWkZNyrb8eLIpKU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Zhang <markzhang@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 5.10 219/226] RDMA/cma: Initialize ib_sa_multicast structure to 0 when join
Date:   Mon,  9 Oct 2023 15:03:00 +0200
Message-ID: <20231009130132.250339773@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4723,7 +4723,7 @@ static int cma_iboe_join_multicast(struc
 	int err = 0;
 	struct sockaddr *addr = (struct sockaddr *)&mc->addr;
 	struct net_device *ndev = NULL;
-	struct ib_sa_multicast ib;
+	struct ib_sa_multicast ib = {};
 	enum ib_gid_type gid_type;
 	bool send_only;
 


