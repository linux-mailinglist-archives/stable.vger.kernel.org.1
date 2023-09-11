Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A03E79BD6A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbjIKUvs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241973AbjIKPTZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:19:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0220FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:19:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC22C433C7;
        Mon, 11 Sep 2023 15:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445561;
        bh=4z0zfPBijPXiWDCFo2cFUAjeJ/Q3HhybdAFasyUaTZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TpgxiRQYXdFN64lPyI0IxSZZvMaXGq3oylIp+wTSBF3H2o7YI5SKzXzzzA4WZCtty
         LXwHG7RA0fK0NKdp+pZUl4Mhh6IELg6juOh7GJJfiF+9O2165sLjc1DwyyC2j1GnKr
         fgZVZcjrSs4jQpE2eG8KzebeHQSvdFMiWXKhXAx8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Minjie Du <duminjie@vivo.com>,
        Alok Prasad <palok@marvell.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 390/600] RDMA/qedr: Remove a duplicate assignment in irdma_query_ah()
Date:   Mon, 11 Sep 2023 15:47:03 +0200
Message-ID: <20230911134645.191112833@linuxfoundation.org>
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
index 6a8bb6ed4bf43..5962261f1b156 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -4354,7 +4354,6 @@ static int irdma_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr)
 		ah_attr->grh.traffic_class = ah->sc_ah.ah_info.tc_tos;
 		ah_attr->grh.hop_limit = ah->sc_ah.ah_info.hop_ttl;
 		ah_attr->grh.sgid_index = ah->sgid_index;
-		ah_attr->grh.sgid_index = ah->sgid_index;
 		memcpy(&ah_attr->grh.dgid, &ah->dgid,
 		       sizeof(ah_attr->grh.dgid));
 	}
-- 
2.40.1



