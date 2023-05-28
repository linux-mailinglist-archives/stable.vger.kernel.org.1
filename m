Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC47B713E38
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjE1TdX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjE1TdW (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:33:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F963B1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:33:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05468612E6
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2134DC433D2;
        Sun, 28 May 2023 19:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302400;
        bh=vhcjdOECIurm4PRP//+Q5Vqw3os3EMYhnh+bb2GMNNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aCMuLPQr5ANqVptl/bS6BNciBaYH3hb9ms+MrHjG4PScCcGcEReOwh/yCz/cNlDPE
         p1UR3HE67JAMyVij+/iC3OmIRsgdA7b4q2yCgdmcU5Ffvn7067PmLj8+Jo6aBsrAhC
         MIdE8hQ3AgNy/M4qs+Aw4/Xwflos6Ud6K735+mXQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Roi Dayan <roid@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH 6.3 115/127] net/mlx5: Fix error message when failing to allocate device memory
Date:   Sun, 28 May 2023 20:11:31 +0100
Message-Id: <20230528190839.990429376@linuxfoundation.org>
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

From: Roi Dayan <roid@nvidia.com>

commit a65735148e0328f80c0f72f9f8d2f609bfcf4aff upstream.

Fix spacing for the error and also the correct error code pointer.

Fixes: c9b9dcb430b3 ("net/mlx5: Move device memory management to mlx5_core")
Signed-off-by: Roi Dayan <roid@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1041,7 +1041,7 @@ static int mlx5_init_once(struct mlx5_co
 
 	dev->dm = mlx5_dm_create(dev);
 	if (IS_ERR(dev->dm))
-		mlx5_core_warn(dev, "Failed to init device memory%d\n", err);
+		mlx5_core_warn(dev, "Failed to init device memory %ld\n", PTR_ERR(dev->dm));
 
 	dev->tracer = mlx5_fw_tracer_create(dev);
 	dev->hv_vhca = mlx5_hv_vhca_create(dev);


