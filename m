Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA5375D414
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjGUTRj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjGUTRh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:17:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC1F30EF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:17:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19F1C61D70
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29341C433C8;
        Fri, 21 Jul 2023 19:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967052;
        bh=ACj0LKtOXM9UF51BatyewBRGZC6YeE+ghIg8iWszAgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J6k4j4stAKnr3X1QyV64p6cuQYfOY+bFTaenaGrvMBsByiV4tlOqfzjdD4OcGmQDX
         DKJlIr8GLCLPY81c/lDaUTAAkVPn3BrUKOLWG3skg/ruvqoqR6eQ6pTMZt+q0GMrrG
         3vL+8JlCoCjVNcxDHhc5C55HR2d7IO1ktwLHiHtI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Junfeng Guo <junfeng.guo@intel.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 028/223] gve: Set default duplex configuration to full
Date:   Fri, 21 Jul 2023 18:04:41 +0200
Message-ID: <20230721160522.070390625@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Junfeng Guo <junfeng.guo@intel.com>

[ Upstream commit 0503efeadbf6bb8bf24397613a73b67e665eac5f ]

Current duplex mode was unset in the driver, resulting in the default
parameter being set to 0, which corresponds to half duplex. It might
mislead users to have incorrect expectation about the driver's
transmission capabilities.
Set the default duplex configuration to full, as the driver runs in
full duplex mode at this point.

Fixes: 7e074d5a76ca ("gve: Enable Link Speed Reporting in the driver.")
Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Message-ID: <20230706044128.2726747-1-junfeng.guo@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/google/gve/gve_ethtool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 38df602f2869c..033f17cb96be0 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -541,6 +541,9 @@ static int gve_get_link_ksettings(struct net_device *netdev,
 		err = gve_adminq_report_link_speed(priv);
 
 	cmd->base.speed = priv->link_speed;
+
+	cmd->base.duplex = DUPLEX_FULL;
+
 	return err;
 }
 
-- 
2.39.2



