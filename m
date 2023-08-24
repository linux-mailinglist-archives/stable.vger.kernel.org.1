Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4027872E6
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241924AbjHXO6W (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241950AbjHXO56 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:57:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56F9C7
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:57:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 527C566FBA
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCA3C433C7;
        Thu, 24 Aug 2023 14:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692889075;
        bh=6pqmm8jqOqfxen75NH+tVBsm7a1n6zaAlPEIKgYbxKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jEsTmJSvqOQiow1muZo8HUtpGH91KpT+Zxl4XWnjJ/1eqgxctsVwp8ITj6P3j+vDA
         82J7PH1fL0lrVCbVYxra2A+eLEktKRL+dLDxeK2zIVXu5a0OKHvJTeccSc/+GhgNF+
         +c8zU5e+mVAQMCPICAmTI9t6H/YN7/Z9qXrzJr7Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 106/139] soc: aspeed: socinfo: Add kfree for kstrdup
Date:   Thu, 24 Aug 2023 16:50:29 +0200
Message-ID: <20230824145028.145688308@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit 6e6d847a8ce18ab2fbec4f579f682486a82d2c6b ]

Add kfree() in the later error handling in order to avoid memory leak.

Fixes: e0218dca5787 ("soc: aspeed: Add soc info driver")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Link: https://lore.kernel.org/r/20230707021625.7727-1-jiasheng@iscas.ac.cn
Signed-off-by: Joel Stanley <joel@jms.id.au>
Link: https://lore.kernel.org/r/20230810123104.231167-1-joel@jms.id.au
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/aspeed/aspeed-socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/aspeed/aspeed-socinfo.c b/drivers/soc/aspeed/aspeed-socinfo.c
index 1ca140356a084..3f759121dc00a 100644
--- a/drivers/soc/aspeed/aspeed-socinfo.c
+++ b/drivers/soc/aspeed/aspeed-socinfo.c
@@ -137,6 +137,7 @@ static int __init aspeed_socinfo_init(void)
 
 	soc_dev = soc_device_register(attrs);
 	if (IS_ERR(soc_dev)) {
+		kfree(attrs->machine);
 		kfree(attrs->soc_id);
 		kfree(attrs->serial_number);
 		kfree(attrs);
-- 
2.40.1



