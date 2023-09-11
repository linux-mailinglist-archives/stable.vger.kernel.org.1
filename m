Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955FD79B993
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355382AbjIKV56 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240805AbjIKOyX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:54:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B4FE40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:54:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C00CC433C7;
        Mon, 11 Sep 2023 14:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444058;
        bh=HbURyQnB4JPBtSAl18ujYVLq/35jh8Uf2rYPkBHvJ3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=otSk2nZfm7Zy9m55jN3NqQhsjOyf60FqFszF1SaQKSMmXF8mqgbP2qMzooAsb1Ad0
         yphp182xN4qrLjxMjUwuEt7WVXE/YkQ/JbpZnuccq5Pn1SkrP/6AY9DKXJoGZvYGb/
         KsBfu03l6DyXiuPiNpY0iZj425io2taYw+iQFWyw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 596/737] nvmem: core: Return NULL when no nvmem layout is found
Date:   Mon, 11 Sep 2023 15:47:35 +0200
Message-ID: <20230911134707.187982641@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit 81e1d9a39569d315f747c2af19ce502cd08645ed ]

Currently, of_nvmem_layout_get_container() returns NULL on error, or an
error pointer if either CONFIG_NVMEM or CONFIG_OF is turned off. We
should likely avoid this kind of mix for two reasons: to clarify the
intend and anyway fix the !CONFIG_OF which will likely always if we use
this helper somewhere else. Let's just return NULL when no layout is
found, we don't need an error value here.

Link: https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/
Fixes: 266570f496b9 ("nvmem: core: introduce NVMEM layouts")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202308030002.DnSFOrMB-lkp@intel.com/
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Michael Walle <michael@walle.cc>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20230823132744.350618-21-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/nvmem-consumer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index fa030d93b768e..27373024856dc 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -256,7 +256,7 @@ static inline struct nvmem_device *of_nvmem_device_get(struct device_node *np,
 static inline struct device_node *
 of_nvmem_layout_get_container(struct nvmem_device *nvmem)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return NULL;
 }
 #endif /* CONFIG_NVMEM && CONFIG_OF */
 
-- 
2.40.1



