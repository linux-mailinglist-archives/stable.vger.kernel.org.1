Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306FD703759
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243909AbjEORUS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244025AbjEORTk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:19:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5FC6E9B
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:17:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC87462C08
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70FFC433EF;
        Mon, 15 May 2023 17:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171065;
        bh=H3PJ97UIqhYgE98H7eQpHHZOD7UbXBI7Zb84rMxFOhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BJHiP4F7kYZh8cDTMlQm2ithC9Qavyuf6APIu+VNe8JxSrMQhb1vfiWh3gnaHWOjj
         USLphQX81A1datwzvVYMxixo2IfJkqvhlk1ZzrPFSFSEynxBeb19YnPf6Fc8cFbN+h
         sZ451/js7SfleDvfRwvI4kiAuIJ1nBFxnrb/ra1g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wei Fang <wei.fang@nxp.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 090/242] net: enetc: check the index of the SFI rather than the handle
Date:   Mon, 15 May 2023 18:26:56 +0200
Message-Id: <20230515161724.595700480@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wei Fang <wei.fang@nxp.com>

[ Upstream commit 299efdc2380aac588557f4d0b2ce7bee05bd0cf2 ]

We should check whether the current SFI (Stream Filter Instance) table
is full before creating a new SFI entry. However, the previous logic
checks the handle by mistake and might lead to unpredictable behavior.

Fixes: 888ae5a3952b ("net: enetc: add tc flower psfp offload driver")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/enetc/enetc_qos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_qos.c b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
index fcebb54224c09..a8539a8554a13 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_qos.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
@@ -1255,7 +1255,7 @@ static int enetc_psfp_parse_clsflower(struct enetc_ndev_priv *priv,
 		int index;
 
 		index = enetc_get_free_index(priv);
-		if (sfi->handle < 0) {
+		if (index < 0) {
 			NL_SET_ERR_MSG_MOD(extack, "No Stream Filter resource!");
 			err = -ENOSPC;
 			goto free_fmi;
-- 
2.39.2



