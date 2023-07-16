Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8EC75567A
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjGPUu4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbjGPUuy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:50:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48462E1
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:50:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB02660EA2
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF8AC433C8;
        Sun, 16 Jul 2023 20:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540652;
        bh=lC0vgdu+RR9Fgb2u7+nRwnWXVmhCFRi3N5AXzIwjtpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kkGTsmr6wySVUHTZAnKN/UyAZPRJ6630+QjB/NlEfLXXAZYJ+M6xoyOKta0yNcQod
         CawPp8fcxuy3F6yvewKTvZP5smG7/GP0kK4kg+6n//W/xtrIbXlKutaug3S8aqo+f1
         FvS2BEHUI2bnzbh0ROQxJRt0VPJfvS6U7kgNbrFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 440/591] device property: Fix documentation for fwnode_get_next_parent()
Date:   Sun, 16 Jul 2023 21:49:39 +0200
Message-ID: <20230716194935.294360634@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit f18caf261398a7f2de4fa3f600deb87072fe7b8d ]

Use fwnode_handle_put() on the node pointer to release the refcount.
Change fwnode_handle_node() to fwnode_handle_put().

Fixes: 233872585de1 ("device property: Add fwnode_get_next_parent()")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Daniel Scally <djrscally@gmail.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Link: https://lore.kernel.org/r/20221207112219.2652411-1-linmq006@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 39d422555e43 ("drivers: fwnode: fix fwnode_irq_get[_byname]()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 7f338cb4fb7b8..f2f7829ad36b9 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -601,7 +601,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_parent);
  * node's parents.
  *
  * Returns a node pointer with refcount incremented, use
- * fwnode_handle_node() on it when done.
+ * fwnode_handle_put() on it when done.
  */
 struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
 {
-- 
2.39.2



