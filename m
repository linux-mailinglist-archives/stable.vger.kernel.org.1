Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BA57E24CA
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjKFNZU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjKFNZT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:25:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAEB10A
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:25:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42ACBC433C7;
        Mon,  6 Nov 2023 13:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277115;
        bh=HIMqgLGZNcCQfbSNbD2PpCgrknutmxTeA/qlRE2QSP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o98G+U6vh64TrY9Dd39ORy+KFCIQgfxQKaZqUYZX01Cv1HuxYlzXNbx3WyB/gicWd
         zhGoMkbDx2HcneE/h/yRLRqURTHGAZFKorm3win1A9TFms1/ZKGJ+bC1lnOYpV/k5e
         By5Syc0dW71RuqXDWE6u7wtkuveail4CVvZDm0tI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Herve Codina <herve.codina@bootlin.com>,
        Peter Rosin <peda@axentia.se>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH 5.15 044/128] i2c: muxes: i2c-mux-gpmux: Use of_get_i2c_adapter_by_node()
Date:   Mon,  6 Nov 2023 14:03:24 +0100
Message-ID: <20231106130311.133312647@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herve Codina <herve.codina@bootlin.com>

commit 3dc0ec46f6e7511fc4fdf6b6cda439382bc957f1 upstream.

i2c-mux-gpmux uses the pair of_find_i2c_adapter_by_node() /
i2c_put_adapter(). These pair alone is not correct to properly lock the
I2C parent adapter.

Indeed, i2c_put_adapter() decrements the module refcount while
of_find_i2c_adapter_by_node() does not increment it. This leads to an
underflow of the parent module refcount.

Use the dedicated function, of_get_i2c_adapter_by_node(), to handle
correctly the module refcount.

Fixes: ac8498f0ce53 ("i2c: i2c-mux-gpmux: new driver")
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Cc: stable@vger.kernel.org
Acked-by: Peter Rosin <peda@axentia.se>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/muxes/i2c-mux-gpmux.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/i2c/muxes/i2c-mux-gpmux.c
+++ b/drivers/i2c/muxes/i2c-mux-gpmux.c
@@ -52,7 +52,7 @@ static struct i2c_adapter *mux_parent_ad
 		dev_err(dev, "Cannot parse i2c-parent\n");
 		return ERR_PTR(-ENODEV);
 	}
-	parent = of_find_i2c_adapter_by_node(parent_np);
+	parent = of_get_i2c_adapter_by_node(parent_np);
 	of_node_put(parent_np);
 	if (!parent)
 		return ERR_PTR(-EPROBE_DEFER);


