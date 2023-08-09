Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58306775D16
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbjHILdl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbjHILdk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:33:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C9F1FD7
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:33:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07F3F63462
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195DAC433C8;
        Wed,  9 Aug 2023 11:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580819;
        bh=s8u8dyQQwuhWxeLoWM4J+lN0kjVzfsJzRqc/4VxNzkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KV6NkAdfYK17R+8leKAY/E+uHQpzxsLNnaAzjUPLKuMzo5TxTVTx7rtg65eb35ewb
         lSbEz+sjvcDE0a5IEMix4skG4m2pUAT9RfUWWjMgy9KbQiltnc4htjArxZIqif88Ni
         CdXYJWWgiOCokwwdj6noHD2WNwpPZhPwXNcMnK7M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5.4 151/154] driver core: Annotate dev_err_probe() with __must_check
Date:   Wed,  9 Aug 2023 12:43:02 +0200
Message-ID: <20230809103641.838614095@linuxfoundation.org>
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit e1f82a0dcf388d98bcc7ad195c03bd812405e6b2 upstream.

We have got already new users of this API which interpret it differently
and miss the opportunity to optimize their code.

In order to avoid similar cases in the future, annotate dev_err_probe()
with __must_check.

Fixes: a787e5400a1c ("driver core: add device probe log helper")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20200826104459.81979-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/device.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1872,7 +1872,7 @@ do {									\
 			dev_driver_string(dev), dev_name(dev), ## arg)
 
 extern __printf(3, 4)
-int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
+int __must_check dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
 
 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \


