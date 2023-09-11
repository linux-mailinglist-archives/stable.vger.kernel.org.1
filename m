Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB3F79BF47
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbjIKWml (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241514AbjIKPKZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:10:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7947FFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:10:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C1EC433C8;
        Mon, 11 Sep 2023 15:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445021;
        bh=zj4V7N69lKSCG4lncdW1ipuwTLj/WGoLP5RpCLzd5qA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NqqwA2K+BptyVshy0d0j+xpakWjOGOkfENFNeEM/LcSt2IQG5HjMP1RECwMz7Cwj8
         3lRyFh+Dg5m6WMvCLFSGydCrj8PFwLOJPJJ0Zaup01uOc08+6+7OpRVrM/54atD78O
         0knTzjDP1oM+YyxjVyJRjMQpgo5HQYcR7XWdtBAg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wang Ming <machel@vivo.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 198/600] wifi: ath9k: use IS_ERR() with debugfs_create_dir()
Date:   Mon, 11 Sep 2023 15:43:51 +0200
Message-ID: <20230911134639.462405681@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Ming <machel@vivo.com>

[ Upstream commit 1e4134610d93271535ecf900a676e1f094e9944c ]

The debugfs_create_dir() function returns error pointers,
it never returns NULL. Most incorrect error checks were fixed,
but the one in ath9k_htc_init_debug() was forgotten.

Fix the remaining error check.

Fixes: e5facc75fa91 ("ath9k_htc: Cleanup HTC debugfs")
Signed-off-by: Wang Ming <machel@vivo.com>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230713030358.12379-1-machel@vivo.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
index b3ed65e5c4da8..c55aab01fff5d 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
@@ -491,7 +491,7 @@ int ath9k_htc_init_debug(struct ath_hw *ah)
 
 	priv->debug.debugfs_phy = debugfs_create_dir(KBUILD_MODNAME,
 					     priv->hw->wiphy->debugfsdir);
-	if (!priv->debug.debugfs_phy)
+	if (IS_ERR(priv->debug.debugfs_phy))
 		return -ENOMEM;
 
 	ath9k_cmn_spectral_init_debug(&priv->spec_priv, priv->debug.debugfs_phy);
-- 
2.40.1



