Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA4A7DD557
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376514AbjJaRtf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376525AbjJaRte (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:49:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEFC92
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:49:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183ACC433C8;
        Tue, 31 Oct 2023 17:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774571;
        bh=FwOEorAwXZjg7UhKnd6bLZr3KUjkWX9kOkpurX6+ZC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iWDh7GVAqHs0psMMJRvPfPHA58jqYHbJNw5BiAlZlGYUum32ypvYIq6xEjIfnZZUB
         SOAG80syEenJM0s/25VPs6nEG1PM01E1VG1qASf6cLyxjiz1I3SxcBmdD1Xip0QeUT
         pY18pUeSQ4yKajFDWfK/1voZQAlMfR2G5klfN/dE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Herve Codina <herve.codina@bootlin.com>,
        Peter Rosin <peda@axentia.se>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH 6.5 090/112] i2c: muxes: i2c-demux-pinctrl: Use of_get_i2c_adapter_by_node()
Date:   Tue, 31 Oct 2023 18:01:31 +0100
Message-ID: <20231031165904.150838718@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herve Codina <herve.codina@bootlin.com>

commit 0fb118de5003028ad092a4e66fc6d07b86c3bc94 upstream.

i2c-demux-pinctrl uses the pair of_find_i2c_adapter_by_node() /
i2c_put_adapter(). These pair alone is not correct to properly lock the
I2C parent adapter.

Indeed, i2c_put_adapter() decrements the module refcount while
of_find_i2c_adapter_by_node() does not increment it. This leads to an
underflow of the parent module refcount.

Use the	dedicated function, of_get_i2c_adapter_by_node(), to handle
correctly the module refcount.

Fixes: 50a5ba876908 ("i2c: mux: demux-pinctrl: add driver")
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Cc: stable@vger.kernel.org
Acked-by: Peter Rosin <peda@axentia.se>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/muxes/i2c-demux-pinctrl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -61,7 +61,7 @@ static int i2c_demux_activate_master(str
 	if (ret)
 		goto err;
 
-	adap = of_find_i2c_adapter_by_node(priv->chan[new_chan].parent_np);
+	adap = of_get_i2c_adapter_by_node(priv->chan[new_chan].parent_np);
 	if (!adap) {
 		ret = -ENODEV;
 		goto err_with_revert;


