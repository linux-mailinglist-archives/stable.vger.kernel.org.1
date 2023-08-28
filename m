Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E3478AAA7
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjH1KX4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjH1KXi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:23:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A015F122
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:23:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35AA463999
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3A8C433C8;
        Mon, 28 Aug 2023 10:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218214;
        bh=ni2g2cF3CJwm3D3JEsJs5x/KZzUzW1e4LvUn15GyHPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MmbP5zLhyiOeYOpXCNSXNnCo7X6RNIweIcqlGhDMgCKI8g+PSHnLRgT+O0UMwx7xX
         COuXiK1o72QUuhnaPp5dIV9bFDOBIkF6QAoZC+et4g0RH0XHmph03v/JigSxjhRYCD
         7F0OpaCESujvsxnBUGY/7TXRusbRDI4Exq5oCJGA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Matt Roper <matthew.d.roper@intel.com>,
        Gustavo Sousa <gustavo.sousa@intel.com>
Subject: [PATCH 6.4 110/129] drm/i915: Fix error handling if driver creation fails during probe
Date:   Mon, 28 Aug 2023 12:13:09 +0200
Message-ID: <20230828101201.022287634@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Roper <matthew.d.roper@intel.com>

commit 718551bbed3ca5308a9f9429305dd074727e8d46 upstream.

If i915_driver_create() fails to create a valid 'i915' object, we
should just disable the PCI device and return immediately without trying
to call i915_probe_error() that relies on a valid i915 pointer.

Fixes: 12e6f6dc78e4 ("drm/i915/display: Handle GMD_ID identification in display code")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/55236f93-dcc5-481e-b788-9f7e95b129d8@kili.mountain/
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Reviewed-by: Gustavo Sousa <gustavo.sousa@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230601173804.557756-1-matthew.d.roper@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/i915_driver.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -747,8 +747,8 @@ int i915_driver_probe(struct pci_dev *pd
 
 	i915 = i915_driver_create(pdev, ent);
 	if (IS_ERR(i915)) {
-		ret = PTR_ERR(i915);
-		goto out_pci_disable;
+		pci_disable_device(pdev);
+		return PTR_ERR(i915);
 	}
 
 	ret = i915_driver_early_probe(i915);


