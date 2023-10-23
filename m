Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BBD7D31C7
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjJWLNH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjJWLNG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:13:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD08DC
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:13:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8F7C433C7;
        Mon, 23 Oct 2023 11:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059583;
        bh=6Dw5BG2MM9vLMPYWU5F08h4DKgB7DqY1F/yyqIWg8Ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eqFAp0PTcEl3DUv63vJa3E1r/RPaVlACrs0NO3pzKa6G9ue1sk4DExzguGzH6q8DF
         PNvNw/xj5+U0LZQ/Xrg8e28vgYsIRxuvakYWxAXS9Jx7ALtkNO46juRNzO4Nl5e8Ya
         gSq8AuVFsefdTOwLzxGM14HoNI3+ZyIS5BJ8cYGA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 225/241] rust: docs: fix logo replacement
Date:   Mon, 23 Oct 2023 12:56:51 +0200
Message-ID: <20231023104839.351899680@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

From: Miguel Ojeda <ojeda@kernel.org>

[ Upstream commit cfd96726e61136e68a168813cedc4084f626208b ]

The static files placement by `rustdoc` changed in Rust 1.67.0 [1],
but the custom code we have to replace the logo in the generated
HTML files did not get updated.

Thus update it to have the Linux logo again in the output.

Hopefully `rustdoc` will eventually support a custom logo from
a local file [2], so that we do not need to maintain this hack
on our side.

Link: https://github.com/rust-lang/rust/pull/101702 [1]
Link: https://github.com/rust-lang/rfcs/pull/3226 [2]
Fixes: 3ed03f4da06e ("rust: upgrade to Rust 1.68.2")
Cc: stable@vger.kernel.org
Tested-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
Link: https://lore.kernel.org/r/20231018155527.1015059-1-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/Makefile | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index b9acbe5a7a5d5..467f50a752dbd 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -85,15 +85,14 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
 # and then retouch the generated files.
 rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins \
     rustdoc-alloc rustdoc-kernel
-	$(Q)cp $(srctree)/Documentation/images/logo.svg $(rustdoc_output)
-	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(rustdoc_output)
+	$(Q)cp $(srctree)/Documentation/images/logo.svg $(rustdoc_output)/static.files/
+	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(rustdoc_output)/static.files/
 	$(Q)find $(rustdoc_output) -name '*.html' -type f -print0 | xargs -0 sed -Ei \
-		-e 's:rust-logo\.svg:logo.svg:g' \
-		-e 's:rust-logo\.png:logo.svg:g' \
-		-e 's:favicon\.svg:logo.svg:g' \
-		-e 's:<link rel="alternate icon" type="image/png" href="[./]*favicon-(16x16|32x32)\.png">::g'
-	$(Q)echo '.logo-container > img { object-fit: contain; }' \
-		>> $(rustdoc_output)/rustdoc.css
+		-e 's:rust-logo-[0-9a-f]+\.svg:logo.svg:g' \
+		-e 's:favicon-[0-9a-f]+\.svg:logo.svg:g' \
+		-e 's:<link rel="alternate icon" type="image/png" href="[/.]+/static\.files/favicon-(16x16|32x32)-[0-9a-f]+\.png">::g'
+	$(Q)for f in $(rustdoc_output)/static.files/rustdoc-*.css; do \
+		echo ".logo-container > img { object-fit: contain; }" >> $$f; done
 
 rustdoc-macros: private rustdoc_host = yes
 rustdoc-macros: private rustc_target_flags = --crate-type proc-macro \
-- 
2.42.0



