Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351FC775790
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjHIKrb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjHIKra (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:47:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E101999
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:47:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B07ED6283F
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C448AC433C8;
        Wed,  9 Aug 2023 10:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578049;
        bh=k5GvgFSBRFg9FOfphDpohELqQvflHGlywHSB04rntLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UZcrMS1bkbt+kC5NA7fIeRgHhuexQS2J6Z5Cs3giiOyfZStpprqssTAadnL1aYVDs
         b7I1gvDwppjL8kQUoy/gkllob+60FH+KUVhzBSVWGNxNePh8p+mHX6ZW2xyaLGCg9r
         w7sxg340GLt1jrRHUcDGQv0M5qAL6gw8oHP578oc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Leon Romanovsky <leonro@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 087/165] net/mlx5e: Set proper IPsec source port in L4 selector
Date:   Wed,  9 Aug 2023 12:40:18 +0200
Message-ID: <20230809103645.655725901@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

[ Upstream commit 62da08331f1a2bef9d0148613133ce8e640a2f8d ]

Fix typo in setup_fte_upper_proto_match() where destination UDP port
was used instead of source port.

Fixes: a7385187a386 ("net/mlx5e: IPsec, support upper protocol selector field offload")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Link: https://lore.kernel.org/r/ffc024a4d192113103f392b0502688366ca88c1f.1690803944.git.leonro@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index dbe87bf89c0dd..832d36be4a17b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -808,9 +808,9 @@ static void setup_fte_upper_proto_match(struct mlx5_flow_spec *spec, struct upsp
 	}
 
 	if (upspec->sport) {
-		MLX5_SET(fte_match_set_lyr_2_4, spec->match_criteria, udp_dport,
+		MLX5_SET(fte_match_set_lyr_2_4, spec->match_criteria, udp_sport,
 			 upspec->sport_mask);
-		MLX5_SET(fte_match_set_lyr_2_4, spec->match_value, udp_dport, upspec->sport);
+		MLX5_SET(fte_match_set_lyr_2_4, spec->match_value, udp_sport, upspec->sport);
 	}
 }
 
-- 
2.40.1



