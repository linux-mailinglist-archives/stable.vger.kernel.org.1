Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F0D79B77E
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359603AbjIKWSG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240614AbjIKOsv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:48:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0972E40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:48:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB5DC433C7;
        Mon, 11 Sep 2023 14:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443727;
        bh=CFzigmSOutKZAdPBrgmL+HTVbqArP6IEaaHy0gkOXzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vr8/gtn49M3HrJYaI4XzypBC4aQLrgWc/DzR/Vzk54CrgZInVGKsnTHbifRScaFH2
         lP4KR1i27XMu4hQwZ9s+gIidBNi/wwGkxGvvX4AV2eXROiHmWehI2J1ZTfahFXLumm
         d3YtMVmpTd/FnUQSJt1x1FIdAHvjoDlnp90LUDng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Minjie Du <duminjie@vivo.com>,
        Alok Prasad <palok@marvell.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 479/737] RDMA/qedr: Remove a duplicate assignment in irdma_query_ah()
Date:   Mon, 11 Sep 2023 15:45:38 +0200
Message-ID: <20230911134703.957719504@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

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
index eaa12c1245982..8f9378767f307 100644
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



