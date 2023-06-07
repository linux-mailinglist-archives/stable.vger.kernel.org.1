Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EA4726CF6
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbjFGUiH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbjFGUiF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:38:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BC62685
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:37:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AAE7645AF
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:37:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31126C433EF;
        Wed,  7 Jun 2023 20:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170263;
        bh=j9HJQ6BZXzJR3hsPDMRkfVQtfJckkWh2L4mEfnDuf+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=grbjD8NU9nsFi/vDqCaBAQtvMKm6NRjfC2hPsSm77I5BygnNOyXWBuSoLh0AQXdfM
         XwA704JcTRo8gkL5JQHnnLusrIXa8tIy5YdY/CjKjmCN5I3DkQGCLPRu5UDyzSriGQ
         bsFPGEjwl25Atcf+793ybRzbVBMI+GuNLcn6mx3Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shay Drory <shayd@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 019/225] net/mlx5: fw_tracer, Fix event handling
Date:   Wed,  7 Jun 2023 22:13:32 +0200
Message-ID: <20230607200914.923071913@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
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
index d7b2ee5de1158..c4e40834e3ff9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
@@ -483,7 +483,7 @@ static void poll_trace(struct mlx5_fw_tracer *tracer,
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



