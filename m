Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79FD78EB81
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 13:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345805AbjHaLLB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 07:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345708AbjHaLLA (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 07:11:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79596E64
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 04:10:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E784BB82218
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 11:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE59C433C8;
        Thu, 31 Aug 2023 11:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693480221;
        bh=Y42TQKGNVXsLlWjN8531LhC8l0CK9d4ka9VqYqeP8c4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MWjqwapVtulNSGaHpcZaNCsqWuVOq9k9pVUjsDluSmSzUqP+zmIlyi3XQmUR8W26v
         FDM+cd1xpg3nHwGXP7ckDZSFT5WadHxALwICkARkpSLKSs9IQB3hRIc2+brZUfVrIY
         erjtW05ZBteDyrXM2l0rWE9Fc6/bpPa7wIn6SKdM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 5.10 02/11] arm64: module-plts: inline linux/moduleloader.h
Date:   Thu, 31 Aug 2023 13:09:54 +0200
Message-ID: <20230831110830.552941530@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230831110830.455765526@linuxfoundation.org>
References: <20230831110830.455765526@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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


