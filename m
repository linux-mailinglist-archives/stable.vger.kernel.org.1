Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED3576ADC4
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjHAJdk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjHAJcn (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:32:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82636E63
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:30:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B11261509
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2493CC433CB;
        Tue,  1 Aug 2023 09:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882250;
        bh=uIsY3qB5y7J/YErIoaxKxt45A82bLthalDtnSBT7pI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w5OLeLw4GRx72KJeUA4aL/X2154HG+K8yfprxsGx4mv3wRIUxIZ7YeCxM0H7lQFER
         a/GeYmhOZXCbz1qKeLbHDbDosOwpWlzxXaIeXRTV+IcprrJGbDADn1xHRXO9QT9PF7
         fKXxUqnvq6tWVb9nSc0UWjoh789rEc67kbgrdz/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Markus Elfring <elfring@users.sourceforge.net>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 021/228] i2c: Improve size determinations
Date:   Tue,  1 Aug 2023 11:17:59 +0200
Message-ID: <20230801091923.628935798@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>

[ Upstream commit 06e989578232da33a7fe96b04191b862af8b2cec ]

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding
size determination a bit safer according to the Linux coding style
convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Stable-dep-of: 05f933d5f731 ("i2c: nomadik: Remove a useless call in the remove function")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-nomadik.c | 2 +-
 drivers/i2c/busses/i2c-sh7760.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 05eaae5aeb180..5004b9dd98563 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -970,7 +970,7 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 	struct i2c_vendor_data *vendor = id->data;
 	u32 max_fifo_threshold = (vendor->fifodepth / 2) - 1;
 
-	dev = devm_kzalloc(&adev->dev, sizeof(struct nmk_i2c_dev), GFP_KERNEL);
+	dev = devm_kzalloc(&adev->dev, sizeof(*dev), GFP_KERNEL);
 	if (!dev) {
 		ret = -ENOMEM;
 		goto err_no_mem;
diff --git a/drivers/i2c/busses/i2c-sh7760.c b/drivers/i2c/busses/i2c-sh7760.c
index a0ccc5d009874..051b904cb35f6 100644
--- a/drivers/i2c/busses/i2c-sh7760.c
+++ b/drivers/i2c/busses/i2c-sh7760.c
@@ -443,7 +443,7 @@ static int sh7760_i2c_probe(struct platform_device *pdev)
 		goto out0;
 	}
 
-	id = kzalloc(sizeof(struct cami2c), GFP_KERNEL);
+	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
 		ret = -ENOMEM;
 		goto out0;
-- 
2.39.2



