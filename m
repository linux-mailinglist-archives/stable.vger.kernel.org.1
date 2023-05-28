Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFF6713E37
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjE1TdU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjE1TdU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:33:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C3FA3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:33:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8754D61DBC
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58F0C433D2;
        Sun, 28 May 2023 19:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302398;
        bh=O/nfokxhGiRfmbxJvWMR67JXBTJAIl2jqAV6KaJEGXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t2CZwd+2TLYqT+35lz8rjf9HSAS0oqiYCpr7MiK8+5aijFGpx4nZhAQTtolg0qfje
         KHgFnq/KyIVWOgeO3X6rDTTVVxRjAPMY6tdAjziOLafFQyd+QLVgznuCG3Wj1RsoYs
         h5uZa/pyiqijh/wwNyL/hqho8Ikb5TZpwCeTKQfk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Itamar Gozlan <igozlan@nvidia.com>,
        Yevgeny Kliteynik <kliteyn@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH 6.3 114/127] net/mlx5: DR, Check force-loopback RC QP capability independently from RoCE
Date:   Sun, 28 May 2023 20:11:30 +0100
Message-Id: <20230528190839.963226138@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

commit c7dd225bc224726c22db08e680bf787f60ebdee3 upstream.

SW Steering uses RC QP for writing STEs to ICM. This writingis done in LB
(loopback), and FL (force-loopback) QP is preferred for performance. FL is
available when RoCE is enabled or disabled based on RoCE caps.
This patch adds reading of FL capability from HCA caps in addition to the
existing reading from RoCE caps, thus fixing the case where we didn't
have loopback enabled when RoCE was disabled.

Fixes: 7304d603a57a ("net/mlx5: DR, Add support for force-loopback QP")
Signed-off-by: Itamar Gozlan <igozlan@nvidia.com>
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c |    4 +++-
 include/linux/mlx5/mlx5_ifc.h                             |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
@@ -117,6 +117,8 @@ int mlx5dr_cmd_query_device(struct mlx5_
 	caps->gvmi		= MLX5_CAP_GEN(mdev, vhca_id);
 	caps->flex_protocols	= MLX5_CAP_GEN(mdev, flex_parser_protocols);
 	caps->sw_format_ver	= MLX5_CAP_GEN(mdev, steering_format_version);
+	caps->roce_caps.fl_rc_qp_when_roce_disabled =
+		MLX5_CAP_GEN(mdev, fl_rc_qp_when_roce_disabled);
 
 	if (MLX5_CAP_GEN(mdev, roce)) {
 		err = dr_cmd_query_nic_vport_roce_en(mdev, 0, &roce_en);
@@ -124,7 +126,7 @@ int mlx5dr_cmd_query_device(struct mlx5_
 			return err;
 
 		caps->roce_caps.roce_en = roce_en;
-		caps->roce_caps.fl_rc_qp_when_roce_disabled =
+		caps->roce_caps.fl_rc_qp_when_roce_disabled |=
 			MLX5_CAP_ROCE(mdev, fl_rc_qp_when_roce_disabled);
 		caps->roce_caps.fl_rc_qp_when_roce_enabled =
 			MLX5_CAP_ROCE(mdev, fl_rc_qp_when_roce_enabled);
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1679,7 +1679,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         rc[0x1];
 
 	u8         uar_4k[0x1];
-	u8         reserved_at_241[0x9];
+	u8         reserved_at_241[0x7];
+	u8         fl_rc_qp_when_roce_disabled[0x1];
+	u8         regexp_params[0x1];
 	u8         uar_sz[0x6];
 	u8         port_selection_cap[0x1];
 	u8         reserved_at_248[0x1];


