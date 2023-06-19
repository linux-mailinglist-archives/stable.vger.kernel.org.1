Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC667353D9
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjFSKtK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjFSKsg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:48:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82B710D9
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:48:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5206160B5B
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63809C433C8;
        Mon, 19 Jun 2023 10:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171704;
        bh=9Q/Qb7ZYPRmqdEB/QUXDxCQOT5kQDYXPzIN7sSovbWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wfOG/gMcS9uMDIPLjBvNEM/2ourU2Nc/BYhTZZezROSCyjXW56I5qYNR8DGRGQii1
         fNGDKADoGt3y6/BmWA+H6K+x9MdqEcXf/gRM2TWXB+03fzAt24qN2EDV8pLe5uo+3n
         1n6tg8xQ10MpUEu6Ks8E6PmrPotF08EX7biTVjAg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 109/166] wifi: cfg80211: fix link del callback to call correct handler
Date:   Mon, 19 Jun 2023 12:29:46 +0200
Message-ID: <20230619102200.114554493@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
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

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit 1ff56684fa8682bdfbbce4e12cf67ab23cb1db05 ]

The wrapper function was incorrectly calling the add handler instead of
the del handler. This had no negative side effect as the default
handlers are essentially identical.

Fixes: f2a0290b2df2 ("wifi: cfg80211: add optional link add/remove callbacks")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230608163202.ebd00e000459.Iaff7dc8d1cdecf77f53ea47a0e5080caa36ea02a@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/rdev-ops.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 13b209a8db287..ee853a14a02de 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -2,7 +2,7 @@
 /*
  * Portions of this file
  * Copyright(c) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2018, 2021-2022 Intel Corporation
+ * Copyright (C) 2018, 2021-2023 Intel Corporation
  */
 #ifndef __CFG80211_RDEV_OPS
 #define __CFG80211_RDEV_OPS
@@ -1441,8 +1441,8 @@ rdev_del_intf_link(struct cfg80211_registered_device *rdev,
 		   unsigned int link_id)
 {
 	trace_rdev_del_intf_link(&rdev->wiphy, wdev, link_id);
-	if (rdev->ops->add_intf_link)
-		rdev->ops->add_intf_link(&rdev->wiphy, wdev, link_id);
+	if (rdev->ops->del_intf_link)
+		rdev->ops->del_intf_link(&rdev->wiphy, wdev, link_id);
 	trace_rdev_return_void(&rdev->wiphy);
 }
 
-- 
2.39.2



