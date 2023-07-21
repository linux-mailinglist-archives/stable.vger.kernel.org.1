Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEB275D2C1
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjGUTDR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjGUTDQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:03:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2523F30D6
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:03:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B84361D84
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD07C433C8;
        Fri, 21 Jul 2023 19:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966194;
        bh=ckNveTtXFt4/P5uHTFJy+WNMLw28kF0ApSIgi06/4lA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pn3GokMDd4bpP2IxPiPu4fGRQpas1UJgmN1okokZTNlpWFY4od14hXVMjB4NCH0hM
         N/RxeabuoBINWEag7JFqRdJA2/wpOltE6YCua2gTRuhgcXCSXT4iN1SLSLcNOEc4hZ
         lncGzbUXobcL76dMPrJU8MAS9HL/mpmlGq9Eb+kE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 229/532] modpost: fix off by one in is_executable_section()
Date:   Fri, 21 Jul 2023 18:02:13 +0200
Message-ID: <20230721160626.802367884@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 78859ef4e03ad..c6e655e0ed988 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1610,7 +1610,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 
 static int is_executable_section(struct elf_info* elf, unsigned int section_index)
 {
-	if (section_index > elf->num_sections)
+	if (section_index >= elf->num_sections)
 		fatal("section_index is outside elf->num_sections!\n");
 
 	return ((elf->sechdrs[section_index].sh_flags & SHF_EXECINSTR) == SHF_EXECINSTR);
-- 
2.39.2



