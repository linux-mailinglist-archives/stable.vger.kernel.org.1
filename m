Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7252F78EBB6
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 13:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbjHaLMy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 07:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238930AbjHaLMx (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 07:12:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0152E53
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 04:12:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1FF663C70
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 11:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13ACC433C8;
        Thu, 31 Aug 2023 11:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693480350;
        bh=e7By6PCirEq/N4xa1fhWYCGAfFavDX6qlwyObKPq3Jo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2MTGOZRrN/Voz5GbiC78bz8WBpg7mjIL2ne1J1bvtsPRfCONdTBNTJaO70zW0Bnyx
         tNcxOBnDlOPIhzzMgDG0hcGJ9hMiVUm14VfFbv2diXY9as+0vWc8Re8GdfVcDthfvJ
         aROvc37R8bVONFaSlNVG7TKLACNFWgs2gFufidKs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.4 4/9] arm64: module-plts: inline linux/moduleloader.h
Date:   Thu, 31 Aug 2023 13:11:31 +0200
Message-ID: <20230831111127.868099664@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230831111127.667900990@linuxfoundation.org>
References: <20230831111127.667900990@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 60a0aab7463ee69296692d980b96510ccce3934e upstream.

module_frob_arch_sections() is declared in moduleloader.h, but
that is not included before the definition:

arch/arm64/kernel/module-plts.c:286:5: error: no previous prototype for 'module_frob_arch_sections' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20230516160642.523862-11-arnd@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/module-plts.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -7,6 +7,7 @@
 #include <linux/ftrace.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/moduleloader.h>
 #include <linux/sort.h>
 
 static struct plt_entry __get_adrp_add_pair(u64 dst, u64 pc,


