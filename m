Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941E97553D9
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjGPUXi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjGPUXi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:23:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE8DBC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:23:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA3E560EBB
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9297C433C8;
        Sun, 16 Jul 2023 20:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539016;
        bh=56XUQ/F3ZtbkENU8tp0iF+/lDWSpEwS+Fd4XFlq8/Nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l9EvNlRlayczB2pe5WkStXEewlW8X6zXcQk0wz7scVEmVg+6iWANq309ZBaBJsBOz
         j4zVvW5V+V3ORq8L0iQCzma+YdKAY1M/E84GKS7McxBq9Ci8tqycSFspx6KDZ822zH
         ZV+Sc3UkMaajXL1hFwYjtf7C60xekJ9ry4n7fGtc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 627/800] drivers: fwnode: fix fwnode_irq_get[_byname]()
Date:   Sun, 16 Jul 2023 21:48:00 +0200
Message-ID: <20230716195003.675050913@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Matti Vaittinen <mazziesaccount@gmail.com>

[ Upstream commit 39d422555e43379516d4d13f5b7162a3dee6e646 ]

The fwnode_irq_get() and the fwnode_irq_get_byname() return 0 upon
device-tree IRQ mapping failure. This is contradicting the
fwnode_irq_get_byname() function documentation and can potentially be a
source of errors like:

int probe(...) {
	...

	irq = fwnode_irq_get_byname();
	if (irq <= 0)
		return irq;

	...
}

Here we do correctly check the return value from fwnode_irq_get_byname()
but the driver probe will now return success. (There was already one
such user in-tree).

Change the fwnode_irq_get_byname() to work as documented and make also the
fwnode_irq_get() follow same common convention returning a negative errno
upon failure.

Fixes: ca0acb511c21 ("device property: Add fwnode_irq_get_byname")
Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Message-ID: <3e64fe592dc99e27ef9a0b247fc49fa26b6b8a58.1685340157.git.mazziesaccount@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/property.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index f6117ec9805c4..8c40abed78524 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -987,12 +987,18 @@ EXPORT_SYMBOL(fwnode_iomap);
  * @fwnode:	Pointer to the firmware node
  * @index:	Zero-based index of the IRQ
  *
- * Return: Linux IRQ number on success. Other values are determined
- * according to acpi_irq_get() or of_irq_get() operation.
+ * Return: Linux IRQ number on success. Negative errno on failure.
  */
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
 {
-	return fwnode_call_int_op(fwnode, irq_get, index);
+	int ret;
+
+	ret = fwnode_call_int_op(fwnode, irq_get, index);
+	/* We treat mapping errors as invalid case */
+	if (ret == 0)
+		return -EINVAL;
+
+	return ret;
 }
 EXPORT_SYMBOL(fwnode_irq_get);
 
-- 
2.39.2



