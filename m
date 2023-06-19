Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4317353E2
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjFSKtU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjFSKs7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:48:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D156FF4
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:48:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 677B260A50
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B766C433C8;
        Mon, 19 Jun 2023 10:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171737;
        bh=xV/vVn+zaHl4NmWcakdrziwPiLp+l6vwCV1yF6ZQkbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ZXhGzQbNBQsh5z49F19FkJP+YI6Yd1My34RR0YBP7ZuTuuIrhmzlVRVDHjeiI/NS
         f4bLOcqyCi1VxNmRCIbw/GdkDdp3/ILUCAoenHOYh8MHyGUWJeQmEbzRyNcYkuEKlr
         yl+zE5hEOLJJnpafdx6KCbr+jumw3vhANkTgHJeg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Satha Rao <skoteshwar@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Naveen Mamindlapalli <naveenm@marvell.com>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 114/166] octeontx2-af: fixed resource availability check
Date:   Mon, 19 Jun 2023 12:29:51 +0200
Message-ID: <20230619102200.372377373@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Satha Rao <skoteshwar@marvell.com>

[ Upstream commit 4e635f9d86165e47f5440196f2ebdb258efb8341 ]

txschq_alloc response have two different arrays to store continuous
and non-continuous schedulers of each level. Requested count should
be checked for each array separately.

Fixes: 5d9b976d4480 ("octeontx2-af: Support fixed transmit scheduler topology")
Signed-off-by: Satha Rao <skoteshwar@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 84f2ba53b8b68..506c67dd6cd40 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -1878,7 +1878,8 @@ static int nix_check_txschq_alloc_req(struct rvu *rvu, int lvl, u16 pcifunc,
 		free_cnt = rvu_rsrc_free_count(&txsch->schq);
 	}
 
-	if (free_cnt < req_schq || req_schq > MAX_TXSCHQ_PER_FUNC)
+	if (free_cnt < req_schq || req->schq[lvl] > MAX_TXSCHQ_PER_FUNC ||
+	    req->schq_contig[lvl] > MAX_TXSCHQ_PER_FUNC)
 		return NIX_AF_ERR_TLX_ALLOC_FAIL;
 
 	/* If contiguous queues are needed, check for availability */
-- 
2.39.2



