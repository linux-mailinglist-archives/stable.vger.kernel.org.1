Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF097D346D
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbjJWLjj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbjJWLji (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:39:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAEAE8
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:39:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A5EC433C7;
        Mon, 23 Oct 2023 11:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061175;
        bh=5C+IAq2jHYFe5YdXhzVqDp9X5/wCGXuTk+KylFKZrFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RqsrMn1SYwFvcRjLShnHsnFVKXy3OBCPxQqrB9YgDYlSGGJgXyBfY0+iilPUSO/Mh
         maXA2pMKw6jW2IUCrv/LeN5H04CC/aFkhvEFbkWieDTJcqIoR9rotQbzy3JwXFB4x4
         LwrGXlphHV6TA0WU0TuZXqHuW5ISJu23rEx5RSf8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maher Sanalla <msanalla@nvidia.com>,
        Shay Drory <shayd@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 097/137] net/mlx5: Handle fw tracer change ownership event based on MTRC
Date:   Mon, 23 Oct 2023 12:57:34 +0200
Message-ID: <20231023104824.145766293@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
References: <20231023104820.849461819@linuxfoundation.org>
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

From: Maher Sanalla <msanalla@nvidia.com>

[ Upstream commit 92fd39634541eb0a11bf1bafbc8ba92d6ddb8dba ]

Currently, whenever fw issues a change ownership event, the PF that owns
the fw tracer drops its ownership directly and the other PFs try to pick
up the ownership via what MTRC register suggests.

In some cases, driver releases the ownership of the tracer and reacquires
it later on. Whenever the driver releases ownership of the tracer, fw
issues a change ownership event. This event can be delayed and come after
driver has reacquired ownership of the tracer. Thus the late event will
trigger the tracer owner PF to release the ownership again and lead to a
scenario where no PF is owning the tracer.

To prevent the scenario described above, when handling a change
ownership event, do not drop ownership of the tracer directly, instead
read the fw MTRC register to retrieve the up-to-date owner of the tracer
and set it accordingly in driver level.

Fixes: f53aaa31cce7 ("net/mlx5: FW tracer, implement tracer logic")
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
index 958cdb9755598..b69ab30ecf03b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
@@ -821,7 +821,7 @@ static void mlx5_fw_tracer_ownership_change(struct work_struct *work)
 
 	mlx5_core_dbg(tracer->dev, "FWTracer: ownership changed, current=(%d)\n", tracer->owner);
 	if (tracer->owner) {
-		tracer->owner = false;
+		mlx5_fw_tracer_ownership_acquire(tracer);
 		return;
 	}
 
-- 
2.40.1



