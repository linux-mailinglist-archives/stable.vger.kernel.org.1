Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5104735351
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjFSKoX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjFSKnr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:43:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880E119A6
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:43:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DD6F60670
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3480CC433C0;
        Mon, 19 Jun 2023 10:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171406;
        bh=2k+zdiZWNOwDHqTPh7WgCTfO7D/fSThIEoX5B/c8VGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TkdPMbD0j0piHRX3Xzhf/g5fF/3RsIJPqmm9SmXRlOhXywcQjd3x9Py0aXcR43TgI
         Sq3LTQywmMDrlk5jWzroH0VGLg231ZmtRAptWosvbAzahkx4n6nWRw+DFwl2diO3lZ
         XXR/cS8HOEFVe9sHx2rtD3QOVqrk6G28nNEl2Xsc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 002/166] test_firmware: Use kstrtobool() instead of strtobool()
Date:   Mon, 19 Jun 2023 12:27:59 +0200
Message-ID: <20230619102154.721816289@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit f7d85515bd21902b218370a1a6301f76e4e636ff ]

strtobool() is the same as kstrtobool().
However, the latter is more used within the kernel.

In order to remove strtobool() and slightly simplify kstrtox.h, switch to
the other function name.

While at it, include the corresponding header file (<linux/kstrtox.h>)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Link: https://lore.kernel.org/r/34f04735d20e0138695dd4070651bd860a36b81c.1673688120.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 4acfe3dfde68 ("test_firmware: prevent race conditions by a correct implementation of locking")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/test_firmware.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 7f165c517338a..6ef3e6926da8a 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/delay.h>
+#include <linux/kstrtox.h>
 #include <linux/kthread.h>
 #include <linux/vmalloc.h>
 #include <linux/efi_embedded_fw.h>
@@ -365,7 +366,7 @@ static int test_dev_config_update_bool(const char *buf, size_t size,
 	int ret;
 
 	mutex_lock(&test_fw_mutex);
-	if (strtobool(buf, cfg) < 0)
+	if (kstrtobool(buf, cfg) < 0)
 		ret = -EINVAL;
 	else
 		ret = size;
-- 
2.39.2



