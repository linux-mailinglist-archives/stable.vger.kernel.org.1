Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1704F6FAB20
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjEHLKP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbjEHLJw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:09:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47F535D93
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:09:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 341CB62B1B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC02C433EF;
        Mon,  8 May 2023 11:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544166;
        bh=F0FsaCKcql9qQl1zFvpVCq+1UA1FFBNPS1A6ZvrFTu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jMdI6YZ5GAxuW0VAFkRflgg2LKISqLy3ONCmWt9yTn/Yj8wwwKOqg9SIJ2m/ssJxq
         yp7On1HLKf5L/6QVo7AnYBAfYV9FPl0y0Gej85LInhlCSJvZxQwbT02/suigUzFjau
         +jely4QmpXR8j0YSMMaYEqxUvEaY7UM1h3tzxnVs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <error27@gmail.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 323/694] wifi: ath12k: use kfree_skb() instead of kfree()
Date:   Mon,  8 May 2023 11:42:38 +0200
Message-Id: <20230508094442.839281493@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Dan Carpenter <error27@gmail.com>

[ Upstream commit 8c464d16809fa02982f6341ea598ec5d07457f19 ]

Sk_buffs are supposed to be freed with kfree_skb().

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/Y+4ejiYakhEvEw7c@kili
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 95294f35155c4..fd8d850f9818f 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -270,7 +270,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
 					  skb_ext_desc->len, DMA_TO_DEVICE);
 		ret = dma_mapping_error(ab->dev, ti.paddr);
 		if (ret) {
-			kfree(skb_ext_desc);
+			kfree_skb(skb_ext_desc);
 			goto fail_unmap_dma;
 		}
 
-- 
2.39.2



