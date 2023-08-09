Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C3B775D0D
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbjHILdV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbjHILdV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:33:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D03173A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:33:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57ECA63445
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6856BC433C8;
        Wed,  9 Aug 2023 11:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580799;
        bh=Yz7ZkxljlRSc4Nzsq5B0rzk2A5SrO/KItKKYqrfWLlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ijKCo4r6YppTGO5FxDYEVVbOc28D+QoCuoAftayN330Zcsj6BY3JygGL4+2yCTif9
         r6f5+4GOmsphRG7cJuxOdyo3RZ905+qWXw3TB9kEXaa9jCWca6QchafHYzOnHaL6cg
         vdeI2P/X5FhPRTr9uLmoKZFQd7yTRvDCg7asfk04=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stephen Rothwell <sfr@canb.auug.org.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5.4 154/154] Revert "driver core: Annotate dev_err_probe() with __must_check"
Date:   Wed,  9 Aug 2023 12:43:05 +0200
Message-ID: <20230809103641.927763946@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit f601e8f37c2c1c52f2923fffc48204a7f7dc023d upstream.

This reverts commit e1f82a0dcf388d98bcc7ad195c03bd812405e6b2 as it's
already starting to cause build warnings in linux-next for things that
are "obviously correct".

It's up to driver authors do "do the right thing" here with this
function, and if they don't want to call it as the last line of a
function, that's up to them, otherwise code that looks like:
	ret = dev_err_probe(..., ret, ...);
does look really "odd".

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Fixes: e1f82a0dcf38 ("driver core: Annotate dev_err_probe() with __must_check")
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/device.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1872,7 +1872,7 @@ do {									\
 			dev_driver_string(dev), dev_name(dev), ## arg)
 
 extern __printf(3, 4)
-int __must_check dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
+int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
 
 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \


