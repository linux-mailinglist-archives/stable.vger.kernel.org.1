Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC82C7759F5
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjHILED (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbjHILD7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:03:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71091724
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:03:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B23D63146
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E38AC433D9;
        Wed,  9 Aug 2023 11:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579037;
        bh=NSemcfF+T+vWspJCw6NSuP15szqedYPEtMMKSgYSML4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hO+duYU8bMv2ylqp3OxITdmCTagb0SIYedIR3jeXPweMMAejHcUqTI0NkzRV6L7nz
         LUHROEYoiqUXpThkS/xneEr8kGnykRUY9rVKaLS3Ys6nSOH+sjq/GpTrajN1JSZNwu
         OLgQuyXEg7kx9hGlmXUEGmMEF52hiUnNhsWaTVhU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 053/204] modpost: fix off by one in is_executable_section()
Date:   Wed,  9 Aug 2023 12:39:51 +0200
Message-ID: <20230809103644.372744013@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 3a3f1e573a105328a2cca45a7cfbebabbf5e3192 ]

The > comparison should be >= to prevent an out of bounds array
access.

Fixes: 52dc0595d540 ("modpost: handle relocations mismatch in __ex_table.")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/mod/modpost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 88f4586c35762..9e177b5531127 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1582,7 +1582,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 
 static int is_executable_section(struct elf_info* elf, unsigned int section_index)
 {
-	if (section_index > elf->num_sections)
+	if (section_index >= elf->num_sections)
 		fatal("section_index is outside elf->num_sections!\n");
 
 	return ((elf->sechdrs[section_index].sh_flags & SHF_EXECINSTR) == SHF_EXECINSTR);
-- 
2.39.2



