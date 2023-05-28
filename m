Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8D2713FE5
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjE1TuP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjE1TuO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:50:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339239C
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC7356204A
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31F8C433D2;
        Sun, 28 May 2023 19:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303413;
        bh=x/t6kxFrk9c+yKlNWGjQh4NjV3nAae/I54aV7FCNWIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lOJ1b8wLSsLDyFKzCN0z08AI+57eJBG6a6JPcdl9sjKUl9iGc+gITRYIYeX/2HkM4
         XefeNSilSmx4DE2dA1Yf0glLEoPXF5PiX/lh1Wq5baTSLpTX2KllPhNYJXll2sYRK8
         a46f5JApdzwHWxcMVcqLZzPIUd0O0miYvN9KAYUI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shay Drory <shayd@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH 5.15 64/69] net/mlx5: Devcom, fix error flow in mlx5_devcom_register_device
Date:   Sun, 28 May 2023 20:12:24 +0100
Message-Id: <20230528190830.783111136@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190828.358612414@linuxfoundation.org>
References: <20230528190828.358612414@linuxfoundation.org>
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
@@ -110,7 +110,8 @@ struct mlx5_devcom *mlx5_devcom_register
 	priv->devs[idx] = dev;
 	devcom = mlx5_devcom_alloc(priv, idx);
 	if (!devcom) {
-		kfree(priv);
+		if (new_priv)
+			kfree(priv);
 		return ERR_PTR(-ENOMEM);
 	}
 


