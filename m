Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FE57D31C6
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbjJWLNF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjJWLNE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:13:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C6AF9
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:13:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BE3C433C8;
        Mon, 23 Oct 2023 11:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059580;
        bh=wW3HtY5Ec4W/ZiJJ5b8Q7wq0yL7xVQB2YfqNfyBppuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GbwQNmF0Apd3abkNeKEt36Pzy0pG8PTTx8M+EP+LBVwN93d5rpH8ZbENBfoIFjSxa
         nzxa3nS1fn8Zq8EKQ1YuYRceIcSZw76+vQOgVj/LpcFVoWaJZRUQ/cGgCAd7FjdQ1J
         B72KQNTWhqX1vLXRqvcHly8jWDcHHut+mHlA/HA0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Akira Yokosawa <akiyks@gmail.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 224/241] docs: Move rustdoc output, cross-reference it
Date:   Mon, 23 Oct 2023 12:56:50 +0200
Message-ID: <20231023104839.327386371@linuxfoundation.org>
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

From: Carlos Bilbao <carlos.bilbao@amd.com>

[ Upstream commit 48fadf44007568e75c7af92857083058d57be403 ]

Generate rustdoc documentation with the rest of subsystem's documentation
in Documentation/output. Add a cross reference to the generated rustdoc in
Documentation/rust/index.rst if Sphinx target rustdoc is set.

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Link: https://lore.kernel.org/r/20230718151534.4067460-2-carlos.bilbao@amd.com
Stable-dep-of: cfd96726e611 ("rust: docs: fix logo replacement")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/rust/index.rst |  8 ++++++++
 rust/Makefile                | 15 +++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/rust/index.rst b/Documentation/rust/index.rst
index 4ae8c66b94faf..e599be2cec9ba 100644
--- a/Documentation/rust/index.rst
+++ b/Documentation/rust/index.rst
@@ -6,6 +6,14 @@ Rust
 Documentation related to Rust within the kernel. To start using Rust
 in the kernel, please read the quick-start.rst guide.
 
+.. only:: rustdoc and html
+
+	You can also browse `rustdoc documentation <rustdoc/kernel/index.html>`_.
+
+.. only:: not rustdoc and html
+
+	This documentation does not include rustdoc generated information.
+
 .. toctree::
     :maxdepth: 1
 
diff --git a/rust/Makefile b/rust/Makefile
index 4124bfa01798d..b9acbe5a7a5d5 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
+# Where to place rustdoc generated documentation
+rustdoc_output := $(objtree)/Documentation/output/rust/rustdoc
+
 obj-$(CONFIG_RUST) += core.o compiler_builtins.o
 always-$(CONFIG_RUST) += exports_core_generated.h
 
@@ -65,7 +68,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
 	OBJTREE=$(abspath $(objtree)) \
 	$(RUSTDOC) $(if $(rustdoc_host),$(rust_common_flags),$(rust_flags)) \
 		$(rustc_target_flags) -L$(objtree)/$(obj) \
-		--output $(objtree)/$(obj)/doc \
+		--output $(rustdoc_output) \
 		--crate-name $(subst rustdoc-,,$@) \
 		@$(objtree)/include/generated/rustc_cfg $<
 
@@ -82,15 +85,15 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
 # and then retouch the generated files.
 rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins \
     rustdoc-alloc rustdoc-kernel
-	$(Q)cp $(srctree)/Documentation/images/logo.svg $(objtree)/$(obj)/doc
-	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(objtree)/$(obj)/doc
-	$(Q)find $(objtree)/$(obj)/doc -name '*.html' -type f -print0 | xargs -0 sed -Ei \
+	$(Q)cp $(srctree)/Documentation/images/logo.svg $(rustdoc_output)
+	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(rustdoc_output)
+	$(Q)find $(rustdoc_output) -name '*.html' -type f -print0 | xargs -0 sed -Ei \
 		-e 's:rust-logo\.svg:logo.svg:g' \
 		-e 's:rust-logo\.png:logo.svg:g' \
 		-e 's:favicon\.svg:logo.svg:g' \
 		-e 's:<link rel="alternate icon" type="image/png" href="[./]*favicon-(16x16|32x32)\.png">::g'
 	$(Q)echo '.logo-container > img { object-fit: contain; }' \
-		>> $(objtree)/$(obj)/doc/rustdoc.css
+		>> $(rustdoc_output)/rustdoc.css
 
 rustdoc-macros: private rustdoc_host = yes
 rustdoc-macros: private rustc_target_flags = --crate-type proc-macro \
@@ -154,7 +157,7 @@ quiet_cmd_rustdoc_test = RUSTDOC T $<
 		@$(objtree)/include/generated/rustc_cfg \
 		$(rustc_target_flags) $(rustdoc_test_target_flags) \
 		--sysroot $(objtree)/$(obj)/test/sysroot $(rustdoc_test_quiet) \
-		-L$(objtree)/$(obj)/test --output $(objtree)/$(obj)/doc \
+		-L$(objtree)/$(obj)/test --output $(rustdoc_output) \
 		--crate-name $(subst rusttest-,,$@) $<
 
 # We cannot use `-Zpanic-abort-tests` because some tests are dynamic,
-- 
2.42.0



