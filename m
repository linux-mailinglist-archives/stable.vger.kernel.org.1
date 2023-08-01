Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F7776AD90
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjHAJaV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjHAJ3x (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:29:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771401FD6
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:28:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 109D8614FC
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC54C433C8;
        Tue,  1 Aug 2023 09:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882124;
        bh=SIB7ydeiWri4MKb1u8CeMa2Ib2hMQYlNUBiGLUiRWMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FBQLEuqzE9A6bzKPuRFzMvaud3oOHmu3VkkV8Uo8xQESFt7d+FguwOoMl+jZRVw9b
         7I50hUScZImXcIs4gpf9B2Pp7dZ1lRR2d1ZZB+NZztyqOdukwML31o7wRXj2iCBcsQ
         0PGioKYW0NxSqup7cc8oFw8kdq0IhMqaauH9v9bE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        stable <stable@kernel.org>
Subject: [PATCH 5.15 121/155] Revert "usb: xhci: tegra: Fix error check"
Date:   Tue,  1 Aug 2023 11:20:33 +0200
Message-ID: <20230801091914.528467407@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

commit 288b4fa1798e3637a9304c6e90a93d900e02369c upstream.

This reverts commit 18fc7c435be3f17ea26a21b2e2312fcb9088e01f.

The reverted commit was based on static analysis and a misunderstanding
of how PTR_ERR() and NULLs are supposed to work.  When a function
returns both pointer errors and NULL then normally the NULL means
"continue operating without a feature because it was deliberately
turned off".  The NULL should not be treated as a failure.  If a driver
cannot work when that feature is disabled then the KConfig should
enforce that the function cannot return NULL.  We should not need to
test for it.

In this code, the patch means that certain tegra_xusb_probe() will
fail if the firmware supports power-domains but CONFIG_PM is disabled.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: 18fc7c435be3 ("usb: xhci: tegra: Fix error check")
Cc: stable <stable@kernel.org>
Link: https://lore.kernel.org/r/8baace8d-fb4b-41a4-ad5f-848ae643a23b@moroto.mountain
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-tegra.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1010,15 +1010,15 @@ static int tegra_xusb_powerdomain_init(s
 	int err;
 
 	tegra->genpd_dev_host = dev_pm_domain_attach_by_name(dev, "xusb_host");
-	if (IS_ERR_OR_NULL(tegra->genpd_dev_host)) {
-		err = PTR_ERR(tegra->genpd_dev_host) ? : -ENODATA;
+	if (IS_ERR(tegra->genpd_dev_host)) {
+		err = PTR_ERR(tegra->genpd_dev_host);
 		dev_err(dev, "failed to get host pm-domain: %d\n", err);
 		return err;
 	}
 
 	tegra->genpd_dev_ss = dev_pm_domain_attach_by_name(dev, "xusb_ss");
-	if (IS_ERR_OR_NULL(tegra->genpd_dev_ss)) {
-		err = PTR_ERR(tegra->genpd_dev_ss) ? : -ENODATA;
+	if (IS_ERR(tegra->genpd_dev_ss)) {
+		err = PTR_ERR(tegra->genpd_dev_ss);
 		dev_err(dev, "failed to get superspeed pm-domain: %d\n", err);
 		return err;
 	}


