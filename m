Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A3C78AB74
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjH1Kax (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjH1Kaa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:30:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CCEAB
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:30:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04A9D63CB8
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15099C433C7;
        Mon, 28 Aug 2023 10:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218626;
        bh=EPA5f3y/WJdc4NXun6Q3xvNAVUGRtQ+h9CkJa96eLj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sraZ3C7up9fMCGmDXlVjvdsndzjNT+uyyJ75KZLQMsnih8J0xAmwgxRWvN++QuIuL
         +2fbBh3gAOK75/C0OPiEqOg/MMZzVSUp0L1jPX/snXjttZtcaDGKjNLUyomEe7afox
         p70n8G/vdG5jKTHFDG0gnoGI6xk07/JwVz3OGIcw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hariprasad Kelam <hkelam@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 026/122] octeontx2-af: SDP: fix receive link config
Date:   Mon, 28 Aug 2023 12:12:21 +0200
Message-ID: <20230828101157.302782251@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 705325431dec3..5541e284cd3f0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -4005,9 +4005,10 @@ int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
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



