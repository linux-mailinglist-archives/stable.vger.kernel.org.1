Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5BC726CFF
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbjFGUiZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjFGUiU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:38:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225721FD5
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:38:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEA6860DCB
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:38:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10468C433EF;
        Wed,  7 Jun 2023 20:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170280;
        bh=xXM5ZrgPjRBlBfiNn8kEXJ6MP+r0zm+THGST18FYaEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PC5oI6vMDjL9MANGd6g2CGLalBluRiXWZXS8dLUxz9r4Q4AWmF+kT5Jd+pynQVY/M
         Ln1uW9a0XCrFBurVGgMUsWC4ENCWwhDCKmPcuWdnorb871RH+FZdpvsLUZ2HOlIyLi
         Iy8IRGGXUPGWl7pmT0POG1ZjY+xZZbh+4LqAyoVA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yangyang Li <liyangyang20@huawei.com>,
        Junxian Huang <huangjunxian6@hisilicon.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 006/225] RDMA/hns: Modify the value of long message loopback slice
Date:   Wed,  7 Jun 2023 22:13:19 +0200
Message-ID: <20230607200913.547595146@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

[ Upstream commit 56518a603fd2bf74762d176ac980572db84a3e14 ]

Long message loopback slice is used for achieving traffic balance between
QPs. It prevents the problem that QPs with large traffic occupying the
hardware pipeline for a long time and QPs with small traffic cannot be
scheduled.

Currently, its maximum value is set to 16K, which means only after a QP
sends 16K will the second QP be scheduled. This value is too large, which
will lead to unbalanced traffic scheduling, and thus it needs to be
modified.

The setting range of the long message loopback slice is modified to be
from 1024 (the lower limit supported by hardware) to mtu. Actual testing
shows that this value can significantly reduce error in hardware traffic
scheduling.

This solution is compatible with both HIP08 and HIP09. The modified
lp_pktn_ini has a maximum value of 2 (when mtu is 256), so the range
checking code for lp_pktn_ini is no longer necessary and needs to be
deleted.

Fixes: 0e60778efb07 ("RDMA/hns: Modify the value of MAX_LP_MSG_LEN to meet hardware compatibility")
Link: https://lore.kernel.org/r/20230512092245.344442-4-huangjunxian6@hisilicon.com
Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 7a5bfe6a9115f..34a270b6891a9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4728,11 +4728,9 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	mtu = ib_mtu_enum_to_int(ib_mtu);
 	if (WARN_ON(mtu <= 0))
 		return -EINVAL;
-#define MAX_LP_MSG_LEN 16384
-	/* MTU * (2 ^ LP_PKTN_INI) shouldn't be bigger than 16KB */
-	lp_pktn_ini = ilog2(MAX_LP_MSG_LEN / mtu);
-	if (WARN_ON(lp_pktn_ini >= 0xF))
-		return -EINVAL;
+#define MIN_LP_MSG_LEN 1024
+	/* mtu * (2 ^ lp_pktn_ini) should be in the range of 1024 to mtu */
+	lp_pktn_ini = ilog2(max(mtu, MIN_LP_MSG_LEN) / mtu);
 
 	if (attr_mask & IB_QP_PATH_MTU) {
 		hr_reg_write(context, QPC_MTU, ib_mtu);
-- 
2.39.2



