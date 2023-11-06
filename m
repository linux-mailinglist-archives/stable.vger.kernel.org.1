Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164977E22C7
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjKFNFc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjKFNFa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:05:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A356F3
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:05:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C389C433B7;
        Mon,  6 Nov 2023 13:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699275927;
        bh=84OuQ/P5g7gmIqsoSHLPyvosR9beepmDu/Toa6fVX1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E371+bgJls+75S//yr2kNZzZMzWznyGTE0sbi3LcVyh1DkxSAlz+4o3VjY7+ZWY9N
         r4HoF1aWHzCVPmV1lTiMUPFMh9prHpQwYFMpFJQ+VEXp+7gCLCj3a8/5qvPRNjJNez
         qSpzraRyw+hr/LMRxHO+gmQZnaoZ1Dk8Ngihz8H0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Herve Codina <herve.codina@bootlin.com>,
        Peter Rosin <peda@axentia.se>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH 4.14 11/48] i2c: muxes: i2c-mux-gpmux: Use of_get_i2c_adapter_by_node()
Date:   Mon,  6 Nov 2023 14:03:02 +0100
Message-ID: <20231106130258.238048496@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130257.862199836@linuxfoundation.org>
References: <20231106130257.862199836@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -55,7 +55,7 @@ static struct i2c_adapter *mux_parent_ad
 		dev_err(dev, "Cannot parse i2c-parent\n");
 		return ERR_PTR(-ENODEV);
 	}
-	parent = of_find_i2c_adapter_by_node(parent_np);
+	parent = of_get_i2c_adapter_by_node(parent_np);
 	of_node_put(parent_np);
 	if (!parent)
 		return ERR_PTR(-EPROBE_DEFER);


