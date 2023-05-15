Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0247035F1
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243386AbjEORFO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243441AbjEOREf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:04:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32C593C2
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:03:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECEB462AA9
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B153CC433D2;
        Mon, 15 May 2023 17:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170155;
        bh=9rT+Y6aXRDPTKiDPkTYJnkAxv0bUZFtppkSXbIrdG60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vyK3VCCQ5qvD/fzDfV3Lao+TSaQLcO7czZMV0PUrCmqX9fYHjivnEMgIM22VEBy1N
         oX1X2alJuJSq6wwWr+8UlrbgHVdoCy+6pcMTP8OehLVaDBm7X15pYnBV/1n22Qx4zE
         /PN0dtjbPrcTLqJCnQFZlp6RjxEgNs2Dqnen3sVA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Subbaraya Sundeep <sbhatta@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 041/239] octeontx2-pf: mcs: Clear stats before freeing resource
Date:   Mon, 15 May 2023 18:25:04 +0200
Message-Id: <20230515161722.944950111@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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

From: Subbaraya Sundeep <sbhatta@marvell.com>

[ Upstream commit 815debbbf7b52026462c37eea3be70d6377a7a9a ]

When freeing MCS hardware resources like SecY, SC and
SA the corresponding stats needs to be cleared. Otherwise
previous stats are shown in newly created macsec interfaces.

Fixes: c54ffc73601c ("octeontx2-pf: mcs: Introduce MACSEC hardware offloading")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c    | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
index f699209978fef..13faca9add9f4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
@@ -150,11 +150,20 @@ static void cn10k_mcs_free_rsrc(struct otx2_nic *pfvf, enum mcs_direction dir,
 				enum mcs_rsrc_type type, u16 hw_rsrc_id,
 				bool all)
 {
+	struct mcs_clear_stats *clear_req;
 	struct mbox *mbox = &pfvf->mbox;
 	struct mcs_free_rsrc_req *req;
 
 	mutex_lock(&mbox->lock);
 
+	clear_req = otx2_mbox_alloc_msg_mcs_clear_stats(mbox);
+	if (!clear_req)
+		goto fail;
+
+	clear_req->id = hw_rsrc_id;
+	clear_req->type = type;
+	clear_req->dir = dir;
+
 	req = otx2_mbox_alloc_msg_mcs_free_resources(mbox);
 	if (!req)
 		goto fail;
-- 
2.39.2



