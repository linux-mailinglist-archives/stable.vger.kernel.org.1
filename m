Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C30F7BDDC1
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376561AbjJINNH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376917AbjJINMz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:12:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE5FD7D
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:11:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C078C433C9;
        Mon,  9 Oct 2023 13:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857110;
        bh=jvc2TY9kWX5ivxJ5A8Eg5Zq7BgMZMfBRhGObfoBIcqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J0r3+cSeOHNokoig+bah8qPWR/AWfDdCNGHj4Y7uEKxGL/NfRkaS4j07GOnHBe+rW
         R8xuBIGlB8o+kmezbYM+5WE+IPcjAzB9SCiVrnqQ+Xjq8T9IauM3QpU97xgXS6ftfq
         hvXdxuoy76aSvNjJlKNnEZO8f+ROYpMaJauD0mII=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mauricio Faria de Oliveira <mfo@canonical.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 100/163] modpost: add missing else to the "of" check
Date:   Mon,  9 Oct 2023 15:01:04 +0200
Message-ID: <20231009130126.793512810@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauricio Faria de Oliveira <mfo@canonical.com>

[ Upstream commit cbc3d00cf88fda95dbcafee3b38655b7a8f2650a ]

Without this 'else' statement, an "usb" name goes into two handlers:
the first/previous 'if' statement _AND_ the for-loop over 'devtable',
but the latter is useless as it has no 'usb' device_id entry anyway.

Tested with allmodconfig before/after patch; no changes to *.mod.c:

    git checkout v6.6-rc3
    make -j$(nproc) allmodconfig
    make -j$(nproc) olddefconfig

    make -j$(nproc)
    find . -name '*.mod.c' | cpio -pd /tmp/before

    # apply patch

    make -j$(nproc)
    find . -name '*.mod.c' | cpio -pd /tmp/after

    diff -r /tmp/before/ /tmp/after/
    # no difference

Fixes: acbef7b76629 ("modpost: fix module autoloading for OF devices with generic compatible property")
Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/mod/file2alias.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 38120f932b0dc..7056751c29b1f 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1604,7 +1604,7 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
 	/* First handle the "special" cases */
 	if (sym_is(name, namelen, "usb"))
 		do_usb_table(symval, sym->st_size, mod);
-	if (sym_is(name, namelen, "of"))
+	else if (sym_is(name, namelen, "of"))
 		do_of_table(symval, sym->st_size, mod);
 	else if (sym_is(name, namelen, "pnp"))
 		do_pnp_device_entry(symval, sym->st_size, mod);
-- 
2.40.1



