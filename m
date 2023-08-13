Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C3877ACDD
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjHMViA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjHMViA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:38:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F86D10DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:38:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8DDD634D1
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9C5C433C7;
        Sun, 13 Aug 2023 21:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962681;
        bh=aONwVCsQWoq0pud0HYosuJGYJFqj17q6C3rSVRNixIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YfRvRh1yEfZTW9hjRGziMctznZauokN8U1g2N7rP5NGNyKHzr3cUGUkS0kXU/BzCP
         K/kkajHEaOdmj1ZMKCeDUX4MMB8byi7cPMfquYu8+/cqSfk6aIVgDonUjZLLhfMCHl
         1yJ5q9mciDnk7DW60wNAFyBr6seRLXIB9kSkaLv4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shay Drory <shayd@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH 6.1 117/149] net/mlx5: LAG, Check correct bucket when modifying LAG
Date:   Sun, 13 Aug 2023 23:19:22 +0200
Message-ID: <20230813211722.244086384@linuxfoundation.org>
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

From: Shay Drory <shayd@nvidia.com>

commit 86ed7b773c01ba71617538b3b107c33fd9cf90b8 upstream.

Cited patch introduced buckets in hash mode, but missed to update
the ports/bucket check when modifying LAG.
Fix the check.

Fixes: 352899f384d4 ("net/mlx5: Lag, use buckets in hash mode")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
@@ -574,7 +574,7 @@ static int __mlx5_lag_modify_definers_de
 	for (i = 0; i < ldev->ports; i++) {
 		for (j = 0; j < ldev->buckets; j++) {
 			idx = i * ldev->buckets + j;
-			if (ldev->v2p_map[i] == ports[i])
+			if (ldev->v2p_map[idx] == ports[idx])
 				continue;
 
 			dest.vport.vhca_id = MLX5_CAP_GEN(ldev->pf[ports[idx] - 1].dev,


