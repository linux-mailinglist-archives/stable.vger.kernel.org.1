Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEAB7A3B78
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240687AbjIQUSL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240690AbjIQURo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:17:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D98F4
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:17:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B39AC433CB;
        Sun, 17 Sep 2023 20:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981859;
        bh=PaiwCa8YASqUgRZoQ6FR+7Iuuy7XSjYUnbQvHj9uvzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oS7zkKlle9eJUZGUGeViI96haVLo7kUCiuQjaYnTubUrtLlvzOlszWu5PvXbhEbCU
         OqFkZgjZ4sMTFaobfqFgd1PiUzFa/tH4k4HVOzLYX3cNSso6CzjlXt9KnhHCfgyDbK
         G4mys0Wa/3RhtcOtHjtWnbJdckQBQXHYVXvZHyWE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wang Ming <machel@vivo.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 116/511] wifi: ath9k: use IS_ERR() with debugfs_create_dir()
Date:   Sun, 17 Sep 2023 21:09:03 +0200
Message-ID: <20230917191116.677276287@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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



