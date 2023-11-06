Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665207E2472
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjKFNWB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjKFNWA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:22:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2473FA9
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:21:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66ADBC433C9;
        Mon,  6 Nov 2023 13:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276916;
        bh=pHcL38GxGJh0Ib8gA8xusiRKWME/vSs3Kzn7c4cB8vQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sVckLCrCVQd2ms4LQZSwJvuy4vjxwHtXoFX3POxHBYtGgLUaClIgYXiA6Azcp3Hgz
         GcvtvHlqGfycY+DTSlWeFU3gofzZiyLEKs+xGfCbpEHZ8FChJM3jtor0nobY2by2ME
         5MLYSjXSq+jnAVLDgQGsz3Z5ou9ByqkF0DJCxJBo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Herve Codina <herve.codina@bootlin.com>,
        Peter Rosin <peda@axentia.se>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH 5.4 21/74] i2c: muxes: i2c-mux-pinctrl: Use of_get_i2c_adapter_by_node()
Date:   Mon,  6 Nov 2023 14:03:41 +0100
Message-ID: <20231106130302.444437826@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.687882731@linuxfoundation.org>
References: <20231106130301.687882731@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herve Codina <herve.codina@bootlin.com>

commit 3171d37b58a76e1febbf3f4af2d06234a98cf88b upstream.

i2c-mux-pinctrl uses the pair of_find_i2c_adapter_by_node() /
i2c_put_adapter(). These pair alone is not correct to properly lock the
I2C parent adapter.

Indeed, i2c_put_adapter() decrements the module refcount while
of_find_i2c_adapter_by_node() does not increment it. This leads to an
underflow of the parent module refcount.

Use the dedicated function, of_get_i2c_adapter_by_node(), to handle
correctly the module refcount.

Fixes: c4aee3e1b0de ("i2c: mux: pinctrl: remove platform_data")
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Cc: stable@vger.kernel.org
Acked-by: Peter Rosin <peda@axentia.se>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/muxes/i2c-mux-pinctrl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
@@ -62,7 +62,7 @@ static struct i2c_adapter *i2c_mux_pinct
 		dev_err(dev, "Cannot parse i2c-parent\n");
 		return ERR_PTR(-ENODEV);
 	}
-	parent = of_find_i2c_adapter_by_node(parent_np);
+	parent = of_get_i2c_adapter_by_node(parent_np);
 	of_node_put(parent_np);
 	if (!parent)
 		return ERR_PTR(-EPROBE_DEFER);


