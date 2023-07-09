Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BCD74C21A
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjGILQx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjGILQw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:16:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7426130
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:16:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D4E060BCA
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B52AC433C7;
        Sun,  9 Jul 2023 11:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901409;
        bh=NnW+CSPdz5l/g8gIeBXAk5L6kXTHROrX+7vJitTNmlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eMEwlF2iYa/C8OQz0YzK1wE0OYvDLxs2BdfxlGgkMDxrJJY3P3wLuSwe3xQ3Rz5vY
         UUGEH9T6CjVfiWWIADHG64HxjAIBPA6tcsY3zzMJRNTUHF4JUdzxn88vbXoYUrl/bn
         foJAZR7UjJApD1+/PZ899PSTbT5jVc8RLFMZdRdw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 011/431] virt: sevguest: Add CONFIG_CRYPTO dependency
Date:   Sun,  9 Jul 2023 13:09:19 +0200
Message-ID: <20230709111451.372471122@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 84b9b44b99780d35fe72ac63c4724f158771e898 ]

This driver fails to link when CRYPTO is disabled, or in a loadable
module:

  WARNING: unmet direct dependencies detected for CRYPTO_GCM
  WARNING: unmet direct dependencies detected for CRYPTO_AEAD2
    Depends on [m]: CRYPTO [=m]
    Selected by [y]:
    - SEV_GUEST [=y] && VIRT_DRIVERS [=y] && AMD_MEM_ENCRYPT [=y]

x86_64-linux-ld: crypto/aead.o: in function `crypto_register_aeads':

Fixes: fce96cf04430 ("virt: Add SEV-SNP guest driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230117171416.2715125-1-arnd@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virt/coco/sev-guest/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virt/coco/sev-guest/Kconfig b/drivers/virt/coco/sev-guest/Kconfig
index f9db0799ae67c..da2d7ca531f0f 100644
--- a/drivers/virt/coco/sev-guest/Kconfig
+++ b/drivers/virt/coco/sev-guest/Kconfig
@@ -2,6 +2,7 @@ config SEV_GUEST
 	tristate "AMD SEV Guest driver"
 	default m
 	depends on AMD_MEM_ENCRYPT
+	select CRYPTO
 	select CRYPTO_AEAD2
 	select CRYPTO_GCM
 	help
-- 
2.39.2



