Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78CB703B92
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244947AbjEOSES (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244939AbjEOSD6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:03:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28CF186D0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:01:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B9B46305B
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06877C433EF;
        Mon, 15 May 2023 18:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173689;
        bh=TNYe2Su8mh+dp+Dqh9F+hsRaAOU/pr1ebMl3hWBDjkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FIt8eQu7iOh8d48x6FoQAtntjdJ3ui4Wd9IOrsIpVY239Ly08jnRnA8xEHFi+iIEl
         ISTgd2snd91Y6QC6wG+j/kGWG51+cYiYx568Jt8TzOpBM+29sQfbXOItiMSMxjxabE
         U9dcniCrBmaFp2c+PEtfCVMA7A6vNIax7kWc+wgM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Zhang <markzhang@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 176/282] RDMA/mlx5: Use correct device num_ports when modify DC
Date:   Mon, 15 May 2023 18:29:14 +0200
Message-Id: <20230515161727.555565687@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

[ Upstream commit 746aa3c8cb1a650ff2583497ac646e505831b9b9 ]

Just like other QP types, when modify DC, the port_num should be compared
with dev->num_ports, instead of HCA_CAP.num_ports.  Otherwise Multi-port
vHCA on DC may not work.

Fixes: 776a3906b692 ("IB/mlx5: Add support for DC target QP")
Link: https://lore.kernel.org/r/20230420013906.1244185-1-markzhang@nvidia.com
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 6edd30c92156e..51623431b879a 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3821,7 +3821,7 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 			return -EINVAL;
 
 		if (attr->port_num == 0 ||
-		    attr->port_num > MLX5_CAP_GEN(dev->mdev, num_ports)) {
+		    attr->port_num > dev->num_ports) {
 			mlx5_ib_dbg(dev, "invalid port number %d. number of ports is %d\n",
 				    attr->port_num, dev->num_ports);
 			return -EINVAL;
-- 
2.39.2



