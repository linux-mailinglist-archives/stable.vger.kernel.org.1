Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EEB713E3A
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjE1Td1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjE1Td1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:33:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A6FB1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:33:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1C50612E6
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0627C433D2;
        Sun, 28 May 2023 19:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302405;
        bh=Bsp0O2B4jKw3NxeXx7hewBA8JjuxP6RtkNDGOwycr+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=APdSgqOpMQCV7k7AezlaiGiwZjvR/Cmu9UP8cJ3Ot3hFKM8D9ASFDRmG1OnC5tnYN
         knxCVTRLk892M7+KZT+Z5p/o80Z4WynIiC0aq4c/Ri6KYJmv9m4TYnrelJBhouQmNJ
         zCxzQbomES7bgU+HSfKOAb7WJsZrTdKRBMx+Nn78=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shay Drory <shayd@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH 6.3 117/127] net/mlx5: Devcom, fix error flow in mlx5_devcom_register_device
Date:   Sun, 28 May 2023 20:11:33 +0100
Message-Id: <20230528190840.053109616@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Shay Drory <shayd@nvidia.com>

commit af87194352cad882d787d06fb7efa714acd95427 upstream.

In case devcom allocation is failed, mlx5 is always freeing the priv.
However, this priv might have been allocated by a different thread,
and freeing it might lead to use-after-free bugs.
Fix it by freeing the priv only in case it was allocated by the
running thread.

Fixes: fadd59fc50d0 ("net/mlx5: Introduce inter-device communication mechanism")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
@@ -112,7 +112,8 @@ struct mlx5_devcom *mlx5_devcom_register
 	priv->devs[idx] = dev;
 	devcom = mlx5_devcom_alloc(priv, idx);
 	if (!devcom) {
-		kfree(priv);
+		if (new_priv)
+			kfree(priv);
 		return ERR_PTR(-ENOMEM);
 	}
 


