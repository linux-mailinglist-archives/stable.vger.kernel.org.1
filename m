Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD73775D58
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjHILg3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbjHILg2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:36:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6713F1BFF
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:36:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07BD763529
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C0FC433C7;
        Wed,  9 Aug 2023 11:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580985;
        bh=B6kdf/sxv/SWBwuB2sur8vob7OUKtMYMmOUag1KDMX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s06DbIR91GxbLTDmll0B/rNosAzDGtC216lJDJWFfIzYmwUEm9NiEzOxV+ouIR8+7
         IeDIB4nUHIW0v2gaxY2hOHHF1vV0hmlMeY89eaeEbWlDqZr7vbes1ObqHZba4wbMsf
         dlfmoE5KNAqJEo2LSrssdeefXMgdpz7sN1Bi9qpo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        stable <stable@kernel.org>
Subject: [PATCH 5.10 065/201] Revert "usb: gadget: tegra-xudc: Fix error check in tegra_xudc_powerdomain_init()"
Date:   Wed,  9 Aug 2023 12:41:07 +0200
Message-ID: <20230809103646.004423059@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

commit a8291be6b5dd465c22af229483dbac543a91e24e upstream.

This reverts commit f08aa7c80dac27ee00fa6827f447597d2fba5465.

The reverted commit was based on static analysis and a misunderstanding
of how PTR_ERR() and NULLs are supposed to work.  When a function
returns both pointer errors and NULL then normally the NULL means
"continue operating without a feature because it was deliberately
turned off".  The NULL should not be treated as a failure.  If a driver
cannot work when that feature is disabled then the KConfig should
enforce that the function cannot return NULL.  We should not need to
test for it.

In this driver, the bug means that probe cannot succeed when CONFIG_PM
is disabled.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: f08aa7c80dac ("usb: gadget: tegra-xudc: Fix error check in tegra_xudc_powerdomain_init()")
Cc: stable <stable@kernel.org>
Link: https://lore.kernel.org/r/ZKQoBa84U/ykEh3C@moroto
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/tegra-xudc.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -3693,15 +3693,15 @@ static int tegra_xudc_powerdomain_init(s
 	int err;
 
 	xudc->genpd_dev_device = dev_pm_domain_attach_by_name(dev, "dev");
-	if (IS_ERR_OR_NULL(xudc->genpd_dev_device)) {
-		err = PTR_ERR(xudc->genpd_dev_device) ? : -ENODATA;
+	if (IS_ERR(xudc->genpd_dev_device)) {
+		err = PTR_ERR(xudc->genpd_dev_device);
 		dev_err(dev, "failed to get device power domain: %d\n", err);
 		return err;
 	}
 
 	xudc->genpd_dev_ss = dev_pm_domain_attach_by_name(dev, "ss");
-	if (IS_ERR_OR_NULL(xudc->genpd_dev_ss)) {
-		err = PTR_ERR(xudc->genpd_dev_ss) ? : -ENODATA;
+	if (IS_ERR(xudc->genpd_dev_ss)) {
+		err = PTR_ERR(xudc->genpd_dev_ss);
 		dev_err(dev, "failed to get SuperSpeed power domain: %d\n", err);
 		return err;
 	}


