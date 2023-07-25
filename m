Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00D7761252
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjGYLBQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbjGYLA6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:00:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC5619A0
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:58:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C62761602
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5055AC433C7;
        Tue, 25 Jul 2023 10:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282695;
        bh=RTZJyYl0kZtVhirUa6qyZyNNRl63+lbtRe8XQTQXLNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SkF+dIf5KudiH6fyygLLEbwsMLrLjVoaF0cXnO7E7Iy6iaJpDtVgb1EaaRHd2ZW7i
         5s5LeOBdxHg1xIuV+sj5KxC0TVhjLzRFLdvTupNI8A8Cht7XZ3aYAW3psSpKllxi+J
         AW6LrkjqBp83py0I32Lv+01X0UtzbMuqX8gQ72Hw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Raphael Nestler <raphael.nestler@gmail.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 6.4 220/227] kbuild: rust: avoid creating temporary files
Date:   Tue, 25 Jul 2023 12:46:27 +0200
Message-ID: <20230725104523.822012845@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Miguel Ojeda <ojeda@kernel.org>

commit df01b7cfcef08bf3fdcac2909d0e1910781d6bfd upstream.

`rustc` outputs by default the temporary files (i.e. the ones saved
by `-Csave-temps`, such as `*.rcgu*` files) in the current working
directory when `-o` and `--out-dir` are not given (even if
`--emit=x=path` is given, i.e. it does not use those for temporaries).

Since out-of-tree modules are compiled from the `linux` tree,
`rustc` then tries to create them there, which may not be accessible.

Thus pass `--out-dir` explicitly, even if it is just for the temporary
files.

Similarly, do so for Rust host programs too.

Reported-by: Raphael Nestler <raphael.nestler@gmail.com>
Closes: https://github.com/Rust-for-Linux/linux/issues/1015
Reported-by: Andrea Righi <andrea.righi@canonical.com>
Tested-by: Raphael Nestler <raphael.nestler@gmail.com> # non-hostprogs
Tested-by: Andrea Righi <andrea.righi@canonical.com> # non-hostprogs
Fixes: 295d8398c67e ("kbuild: specify output names separately for each emission type from rustc")
Cc: stable@vger.kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/Makefile.build |    5 ++++-
 scripts/Makefile.host  |    6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -279,6 +279,9 @@ $(obj)/%.lst: $(src)/%.c FORCE
 
 rust_allowed_features := core_ffi_c,explicit_generic_args_with_impl_trait,new_uninit,pin_macro
 
+# `--out-dir` is required to avoid temporaries being created by `rustc` in the
+# current working directory, which may be not accessible in the out-of-tree
+# modules case.
 rust_common_cmd = \
 	RUST_MODFILE=$(modfile) $(RUSTC_OR_CLIPPY) $(rust_flags) \
 	-Zallow-features=$(rust_allowed_features) \
@@ -287,7 +290,7 @@ rust_common_cmd = \
 	--extern alloc --extern kernel \
 	--crate-type rlib -L $(objtree)/rust/ \
 	--crate-name $(basename $(notdir $@)) \
-	--emit=dep-info=$(depfile)
+	--out-dir $(dir $@) --emit=dep-info=$(depfile)
 
 # `--emit=obj`, `--emit=asm` and `--emit=llvm-ir` imply a single codegen unit
 # will be used. We explicitly request `-Ccodegen-units=1` in any case, and
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -86,7 +86,11 @@ hostc_flags    = -Wp,-MMD,$(depfile) \
 hostcxx_flags  = -Wp,-MMD,$(depfile) \
                  $(KBUILD_HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
                  $(HOSTCXXFLAGS_$(target-stem).o)
-hostrust_flags = --emit=dep-info=$(depfile) \
+
+# `--out-dir` is required to avoid temporaries being created by `rustc` in the
+# current working directory, which may be not accessible in the out-of-tree
+# modules case.
+hostrust_flags = --out-dir $(dir $@) --emit=dep-info=$(depfile) \
                  $(KBUILD_HOSTRUSTFLAGS) $(HOST_EXTRARUSTFLAGS) \
                  $(HOSTRUSTFLAGS_$(target-stem))
 


