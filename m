Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5217ED0DE
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbjKOT6H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbjKOT6F (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:58:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F00B1B5
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:58:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBB0C433C9;
        Wed, 15 Nov 2023 19:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078281;
        bh=jsyUMc0BAVcRpq41fSKuQcaIUWVLqqsVxRAlmbY6ee0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dddgETw9b8RQewg5xJGkTfI9kSOmWla9ZSfT0zus/P0ry9iLcpJgSxwALa77oIin7
         +quAnPti2oWzpGiRAXKDS8SycGXWJh7N3mMxzO7o27X6Hbpq5A4ZXOOk16GL57Qvmb
         rmUzcxhZg7oUxe+YPF9lNi5NP0yxkq9X3bSYyKk0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Patrisious Haddad <phaddad@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 217/379] IB/mlx5: Fix rdma counter binding for RAW QP
Date:   Wed, 15 Nov 2023 14:24:52 -0500
Message-ID: <20231115192657.952709687@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Patrisious Haddad <phaddad@nvidia.com>

[ Upstream commit c1336bb4aa5e809a622a87d74311275514086596 ]

Previously when we had a RAW QP, we bound a counter to it when it moved
to INIT state, using the counter context inside RQC.

But when we try to modify that counter later in RTS state we used
modify QP which tries to change the counter inside QPC instead of RQC.

Now we correctly modify the counter set_id inside of RQC instead of QPC
for the RAW QP.

Fixes: d14133dd4161 ("IB/mlx5: Support set qp counter")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Link: https://lore.kernel.org/r/2e5ab6713784a8fe997d19c508187a0dfecf2dfc.1696847964.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/qp.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index ac53ed79ca64c..e0df3017e241a 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3960,6 +3960,30 @@ static unsigned int get_tx_affinity(struct ib_qp *qp,
 	return tx_affinity;
 }
 
+static int __mlx5_ib_qp_set_raw_qp_counter(struct mlx5_ib_qp *qp, u32 set_id,
+					   struct mlx5_core_dev *mdev)
+{
+	struct mlx5_ib_raw_packet_qp *raw_packet_qp = &qp->raw_packet_qp;
+	struct mlx5_ib_rq *rq = &raw_packet_qp->rq;
+	u32 in[MLX5_ST_SZ_DW(modify_rq_in)] = {};
+	void *rqc;
+
+	if (!qp->rq.wqe_cnt)
+		return 0;
+
+	MLX5_SET(modify_rq_in, in, rq_state, rq->state);
+	MLX5_SET(modify_rq_in, in, uid, to_mpd(qp->ibqp.pd)->uid);
+
+	rqc = MLX5_ADDR_OF(modify_rq_in, in, ctx);
+	MLX5_SET(rqc, rqc, state, MLX5_RQC_STATE_RDY);
+
+	MLX5_SET64(modify_rq_in, in, modify_bitmask,
+		   MLX5_MODIFY_RQ_IN_MODIFY_BITMASK_RQ_COUNTER_SET_ID);
+	MLX5_SET(rqc, rqc, counter_set_id, set_id);
+
+	return mlx5_core_modify_rq(mdev, rq->base.mqp.qpn, in);
+}
+
 static int __mlx5_ib_qp_set_counter(struct ib_qp *qp,
 				    struct rdma_counter *counter)
 {
@@ -3975,6 +3999,9 @@ static int __mlx5_ib_qp_set_counter(struct ib_qp *qp,
 	else
 		set_id = mlx5_ib_get_counters_id(dev, mqp->port - 1);
 
+	if (mqp->type == IB_QPT_RAW_PACKET)
+		return __mlx5_ib_qp_set_raw_qp_counter(mqp, set_id, dev->mdev);
+
 	base = &mqp->trans_qp.base;
 	MLX5_SET(rts2rts_qp_in, in, opcode, MLX5_CMD_OP_RTS2RTS_QP);
 	MLX5_SET(rts2rts_qp_in, in, qpn, base->mqp.qpn);
-- 
2.42.0



