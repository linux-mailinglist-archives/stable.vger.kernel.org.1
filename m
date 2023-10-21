Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024247D1F6F
	for <lists+stable@lfdr.de>; Sat, 21 Oct 2023 22:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjJUUTl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 21 Oct 2023 16:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUUTl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 21 Oct 2023 16:19:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D20119
        for <stable@vger.kernel.org>; Sat, 21 Oct 2023 13:19:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7502BC433C7;
        Sat, 21 Oct 2023 20:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697919575;
        bh=qxF8AyBiKS6OFh499R5kOv5dBqgC2SjjyBUOme2qY+8=;
        h=Subject:To:Cc:From:Date:From;
        b=xhowQdRNot6ISOWmrztXEbv6yba1GSCwql8qKGFjSjqKSLhTc8jT2111nnKDjsoQ7
         ND//CnYtjFVmBsWsgCn7o+UypMhyhB2gzKx2560epj8fX9cRr0CcrcQINHjdM+cbiX
         O2CZSQbqUKhvI8/gTyp++ZATPqPEQO+7dS0i4gjM=
Subject: FAILED: patch "[PATCH] rust: docs: fix logo replacement" failed to apply to 6.5-stable tree
To:     ojeda@kernel.org, a.hindborg@samsung.com, benno.lossin@proton.me
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 21 Oct 2023 22:19:33 +0200
Message-ID: <2023102132-relay-underpay-845a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x cfd96726e61136e68a168813cedc4084f626208b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102132-relay-underpay-845a@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cfd96726e61136e68a168813cedc4084f626208b Mon Sep 17 00:00:00 2001
From: Miguel Ojeda <ojeda@kernel.org>
Date: Wed, 18 Oct 2023 17:55:27 +0200
Subject: [PATCH] rust: docs: fix logo replacement

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

diff --git a/rust/Makefile b/rust/Makefile
index 1e78c82a18a8..7dbf9abe0d01 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -93,15 +93,14 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
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

