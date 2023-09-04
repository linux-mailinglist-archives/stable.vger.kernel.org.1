Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D325791CEE
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238935AbjIDSdN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244882AbjIDSdL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:33:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BC8CCB
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:33:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5EC96198C
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC783C433C9;
        Mon,  4 Sep 2023 18:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852387;
        bh=TWy+9qx96cpQUL6iqMBGOPqkB+CebY3lzUuTQB+/BBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ufu4cERK5sTY7hckT3PIvB4twppCbrm35YAjTkby0QLCY+kgM7VG6jhxi3Tyoe1tn
         vK7gWX0cfhfZmwQn0A/UCRy8KLewU1zExCFSh2C4OLPZLMpYz7E3yhUlrjx3nQaM1f
         FAqHZPlTdxkWsMyMd5uh0qLt3kkZxl5Ou70/m1zs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Luke Lu <luke.lu@libre.computer>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 6.4 14/32] usb: dwc3: meson-g12a: do post init to fix broken usb after resumption
Date:   Mon,  4 Sep 2023 19:30:12 +0100
Message-ID: <20230904182948.554007106@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182947.899158313@linuxfoundation.org>
References: <20230904182947.899158313@linuxfoundation.org>
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

From: Luke Lu <luke.lu@libre.computer>

commit 1fa206bb764f37d2ab4bf671e483153ef0659b34 upstream.

Device connected to usb otg port of GXL-based boards can not be
recognised after resumption, doesn't recover even if disconnect and
reconnect the device. dmesg shows it disconnects during resumption.

[   41.492911] usb 1-2: USB disconnect, device number 3
[   41.499346] usb 1-2: unregistering device
[   41.511939] usb 1-2: unregistering interface 1-2:1.0

Calling usb_post_init() will fix this issue, and it's tested and
verified on libretech's aml-s905x-cc board.

Cc: stable@vger.kernel.org # v5.8+
Fixes: c99993376f72 ("usb: dwc3: Add Amlogic G12A DWC3 glue")
Signed-off-by: Luke Lu <luke.lu@libre.computer>
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20230809212911.18903-1-luke.lu@libre.computer
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -938,6 +938,12 @@ static int __maybe_unused dwc3_meson_g12
 			return ret;
 	}
 
+	if (priv->drvdata->usb_post_init) {
+		ret = priv->drvdata->usb_post_init(priv);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 


