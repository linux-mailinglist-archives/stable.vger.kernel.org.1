Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB38726C6C
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjFGUdg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbjFGUdc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:33:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA262130
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:33:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACA6E64538
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DB9C433EF;
        Wed,  7 Jun 2023 20:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170009;
        bh=CvPiZLHIyoNTvXl2vg2Dknh4qKsvF/niha4S+dEweUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PxUoSPN6GaI3wzfsusslc75NcTPfQ2Og211E4x9ZRIZnB+wWN/RPJN1F2z6JXk8q3
         WCRd6KL2a4Fbz5GiBUpdvOor1Hh5aBYtvVwpXjgnecdjgEbz9HUvx1XJ9uRv1PYf/S
         mB2vYKQvyXAdCL5Sz1sGAcJ+iwwTcGK7OA9kVr+Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shay Drory <shayd@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 11/88] net/mlx5: fw_tracer, Fix event handling
Date:   Wed,  7 Jun 2023 22:15:28 +0200
Message-ID: <20230607200857.940704346@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200854.030202132@linuxfoundation.org>
References: <20230607200854.030202132@linuxfoundation.org>
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

From: Shay Drory <shayd@nvidia.com>

[ Upstream commit 341a80de2468f481b1f771683709b5649cbfe513 ]

mlx5 driver needs to parse traces with event_id inside the range of
first_string_trace and num_string_trace. However, mlx5 is parsing all
events with event_id >= first_string_trace.

Fix it by checking for the correct range.

Fixes: c71ad41ccb0c ("net/mlx5: FW tracer, events handling")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
index 5a2feadd80f08..97e6b06b1bff3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
@@ -466,7 +466,7 @@ static void poll_trace(struct mlx5_fw_tracer *tracer,
 				(u64)timestamp_low;
 		break;
 	default:
-		if (tracer_event->event_id >= tracer->str_db.first_string_trace ||
+		if (tracer_event->event_id >= tracer->str_db.first_string_trace &&
 		    tracer_event->event_id <= tracer->str_db.first_string_trace +
 					      tracer->str_db.num_string_trace) {
 			tracer_event->type = TRACER_EVENT_TYPE_STRING;
-- 
2.39.2



