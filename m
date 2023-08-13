Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F0477AC4D
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjHMVcI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjHMVcI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:32:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6C51730
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:31:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 138DD62B64
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16514C433C7;
        Sun, 13 Aug 2023 21:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962286;
        bh=pjfQf6Fajl/wmswnw31HV7Q0igLas9B8mGMqTzwdd5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P+lssU2gmuyld1Qr0rNPt+TzYEgsKVCslNEVVnV5nVqGQHbxNislYbGy0G2kmFTcr
         0vUQpdlpfW82BWNMkYydtGqyiF8fqFv3CrxfrXABnzzfm4NPEjQuynIGcn+D+GxVP5
         xcYzvr/OqzH7JiQetkiMRJCirpU+tIlint7UUWBU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Paul Demetrotion <pdemetrotion@winsystems.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 6.4 180/206] gpio: ws16c48: Fix off-by-one error in WS16C48 resource region extent
Date:   Sun, 13 Aug 2023 23:19:10 +0200
Message-ID: <20230813211730.174597259@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: William Breathitt Gray <william.gray@linaro.org>

commit 33f83d13ded164cd49ce2a3bd2770115abc64e6f upstream.

The WinSystems WS16C48 I/O address region spans offsets 0x0 through 0xA,
which is a total of 11 bytes. Fix the WS16C48_EXTENT define to the
correct value of 11 so that access to necessary device registers is
properly requested in the ws16c48_probe() callback by the
devm_request_region() function call.

Fixes: 2c05a0f29f41 ("gpio: ws16c48: Implement and utilize register structures")
Cc: stable@vger.kernel.org
Cc: Paul Demetrotion <pdemetrotion@winsystems.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-ws16c48.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpio/gpio-ws16c48.c
+++ b/drivers/gpio/gpio-ws16c48.c
@@ -18,7 +18,7 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
-#define WS16C48_EXTENT 10
+#define WS16C48_EXTENT 11
 #define MAX_NUM_WS16C48 max_num_isa_dev(WS16C48_EXTENT)
 
 static unsigned int base[MAX_NUM_WS16C48];


