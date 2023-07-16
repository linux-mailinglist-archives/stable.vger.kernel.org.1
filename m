Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B0E755337
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjGPUQs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjGPUQp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:16:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B40710C8
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:16:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD95F60EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB093C433C7;
        Sun, 16 Jul 2023 20:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538596;
        bh=55MlKVHnya296cV1+lYw8sR53d7+M8mZC6uC9jNb/ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v7ri0yuCFcKJS+7mQrEv/mnDZ6GBKiE/dlHAbMa5iuPIRtF0zdLmpQPY34pvNgRIi
         LogwQdZRhZKSNwy+rjoemM6Vvw14TtKX1JydKFP7tKDBYWabBfYClm616W2pr/nkyH
         QCPQZyRizQ1GsRoszoy6m1VwhH4Dwkkftiet+DVk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 508/800] modpost: fix off by one in is_executable_section()
Date:   Sun, 16 Jul 2023 21:46:01 +0200
Message-ID: <20230716195000.892535883@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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
index d97cbd753d2c3..d8baa9b9ae6d8 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1290,7 +1290,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 
 static int is_executable_section(struct elf_info* elf, unsigned int section_index)
 {
-	if (section_index > elf->num_sections)
+	if (section_index >= elf->num_sections)
 		fatal("section_index is outside elf->num_sections!\n");
 
 	return ((elf->sechdrs[section_index].sh_flags & SHF_EXECINSTR) == SHF_EXECINSTR);
-- 
2.39.2



