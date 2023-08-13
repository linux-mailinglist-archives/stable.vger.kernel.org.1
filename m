Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3565177ACDC
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjHMVh5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjHMVh5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:37:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8787210DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:37:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D1A7634D1
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:37:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D65C433C8;
        Sun, 13 Aug 2023 21:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962678;
        bh=k5ugLlfZRSmCR9LajVGptlVNUxgulYTw2yzMtVVeGLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wkYAX4KRMfCXNmXIDMCrl8hepXSM8VBGccoF/tTYEUib/UIB7kdAaatlZQxTEhO/H
         j5/O3TvSaeLKnnbekJDMNSVP00BudSqC1hPYwZvmh9wt9AnJwpfarK9dZpqFOhjFgY
         YgDFp7A0Sfy8WCM8F+xSb4AikX4Md3nSFJXu7PJ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Jurgens <danielj@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH 6.1 116/149] net/mlx5: Allow 0 for total host VFs
Date:   Sun, 13 Aug 2023 23:19:21 +0200
Message-ID: <20230813211722.214973637@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Daniel Jurgens <danielj@nvidia.com>

commit 2dc2b3922d3c0f52d3a792d15dcacfbc4cc76b8f upstream.

When querying eswitch functions 0 is a valid number of host VFs. After
introducing ARM SRIOV falling through to getting the max value from PCI
results in using the total VFs allowed on the ARM for the host.

Fixes: 86eec50beaf3 ("net/mlx5: Support querying max VFs from device");
Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/sriov.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
@@ -264,8 +264,7 @@ static u16 mlx5_get_max_vfs(struct mlx5_
 		host_total_vfs = MLX5_GET(query_esw_functions_out, out,
 					  host_params_context.host_total_vfs);
 		kvfree(out);
-		if (host_total_vfs)
-			return host_total_vfs;
+		return host_total_vfs;
 	}
 
 done:


