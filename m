Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EF578AC8F
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjH1KlD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjH1Kkf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:40:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6110912F
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:40:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F400D64067
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD2EC433C7;
        Mon, 28 Aug 2023 10:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219229;
        bh=gGmZjDCJA+KkXstFZgdZF2trry+xjW6VmT9ApTsXJ30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WH0GqoUvNvr9USW7WoWyq2RfPdVHwkYXFDJmBrQMVdwEvGXjvxIHtibwhyGS8A8vv
         hlSnNLAQTHLpQj/W4i2a09dd8nvhl1p7B5hhhhlhbZNYYslfsMusGwXYzX5Ww2I6vY
         7qhuZ59kxPfSWW8Ot46Yfh/Kgkz+3GKWk/Jvc0wM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hariprasad Kelam <hkelam@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 119/158] octeontx2-af: SDP: fix receive link config
Date:   Mon, 28 Aug 2023 12:13:36 +0200
Message-ID: <20230828101201.356595002@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hariprasad Kelam <hkelam@marvell.com>

[ Upstream commit 05f3d5bc23524bed6f043dfe6b44da687584f9fb ]

On SDP interfaces, frame oversize and undersize errors are
observed as driver is not considering packet sizes of all
subscribers of the link before updating the link config.

This patch fixes the same.

Fixes: 9b7dd87ac071 ("octeontx2-af: Support to modify min/max allowed packet lengths")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Link: https://lore.kernel.org/r/20230817063006.10366-1-hkelam@marvell.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 4a7609fd6dd07..5bc54ba68c831 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -2430,9 +2430,10 @@ int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
 	if (link < 0)
 		return NIX_AF_ERR_RX_LINK_INVALID;
 
-	nix_find_link_frs(rvu, req, pcifunc);
 
 linkcfg:
+	nix_find_link_frs(rvu, req, pcifunc);
+
 	cfg = rvu_read64(rvu, blkaddr, NIX_AF_RX_LINKX_CFG(link));
 	cfg = (cfg & ~(0xFFFFULL << 16)) | ((u64)req->maxlen << 16);
 	if (req->update_minlen)
-- 
2.40.1



