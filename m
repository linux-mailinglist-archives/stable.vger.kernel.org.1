Return-Path: <stable+bounces-170512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 053E6B2A487
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023AB17DA4E
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B6332274B;
	Mon, 18 Aug 2025 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IW/HXzqo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79E3322744;
	Mon, 18 Aug 2025 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522880; cv=none; b=X/IP+P0zRRpYar22F4RyOCtHe+opbeRIcdutqskGKrHgs2pkT3Hl4zwYZrGuxCn8Y8QCIO7mhvYc5mk91yaBTPKFJIkISZSzVr8Hi8AhMiaVVkX3beGa3NWuRJ0/VzdIpk7RPTL00KnW3vPB49NhEdxeAtmzUjQHSh1AQWbS98I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522880; c=relaxed/simple;
	bh=qKDZbkQXCT8PVIkrn/kv8NQM+sc+hNNijKVvwYXUYhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcLu2suPmctHZMyXGkpb4dD1X+KjSfOIqiqpBN0Wtm+jdYwk2EKblBkj+O2SXNuwDARBsy8g48zJAUFtA0C3wykc7K9yofdUEnXMd34JdKxhq1fnE8WeZ4U85IOGY/BevEPHB7AxIf7IRKxZK04dqMQasv44MG386xJsP1moG9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IW/HXzqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC7CC4CEF1;
	Mon, 18 Aug 2025 13:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755522880;
	bh=qKDZbkQXCT8PVIkrn/kv8NQM+sc+hNNijKVvwYXUYhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IW/HXzqod7xVNYOEPyWU1pAtg+uNjPwCwqX/FnWRsDYGF9rFEwa/V7tRH4kdQbvAK
	 Fc8nmYAKZSL0AvaxyVOiTVp2RW/NB7A0iWqYvKYwHzpm9K78jf7EDm5fWOKBih1Llf
	 3bXkK2efOLRKMOTzrQQVum56CsK/QpmY+BbkG3GA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.12 435/444] rust: kbuild: clean output before running `rustdoc`
Date: Mon, 18 Aug 2025 14:47:41 +0200
Message-ID: <20250818124505.273219506@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miguel Ojeda <ojeda@kernel.org>

commit 252fea131e15aba2cd487119d1a8f546471199e2 upstream.

`rustdoc` can get confused when generating documentation into a folder
that contains generated files from other `rustdoc` versions.

For instance, running something like:

    rustup default 1.78.0
    make LLVM=1 rustdoc
    rustup default 1.88.0
    make LLVM=1 rustdoc

may generate errors like:

    error: couldn't generate documentation: invalid template: last line expected to start with a comment
      |
      = note: failed to create or modify "./Documentation/output/rust/rustdoc/src-files.js"

Thus just always clean the output folder before generating the
documentation -- we are anyway regenerating it every time the `rustdoc`
target gets called, at least for the time being.

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Reported-by: Daniel Almeida <daniel.almeida@collabora.com>
Closes: https://rust-for-linux.zulipchat.com/#narrow/channel/288089/topic/x/near/527201113
Reviewed-by: Tamir Duberstein <tamird@kernel.org>
Link: https://lore.kernel.org/r/20250726133435.2460085-1-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 rust/Makefile |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/rust/Makefile
+++ b/rust/Makefile
@@ -92,14 +92,14 @@ rustdoc: rustdoc-core rustdoc-macros rus
 rustdoc-macros: private rustdoc_host = yes
 rustdoc-macros: private rustc_target_flags = --crate-type proc-macro \
     --extern proc_macro
-rustdoc-macros: $(src)/macros/lib.rs FORCE
+rustdoc-macros: $(src)/macros/lib.rs rustdoc-clean FORCE
 	+$(call if_changed,rustdoc)
 
 # Starting with Rust 1.82.0, skipping `-Wrustdoc::unescaped_backticks` should
 # not be needed -- see https://github.com/rust-lang/rust/pull/128307.
 rustdoc-core: private skip_flags = --edition=2021 -Wrustdoc::unescaped_backticks
 rustdoc-core: private rustc_target_flags = --edition=$(core-edition) $(core-cfgs)
-rustdoc-core: $(RUST_LIB_SRC)/core/src/lib.rs FORCE
+rustdoc-core: $(RUST_LIB_SRC)/core/src/lib.rs rustdoc-clean FORCE
 	+$(call if_changed,rustdoc)
 
 rustdoc-compiler_builtins: $(src)/compiler_builtins.rs rustdoc-core FORCE
@@ -116,6 +116,9 @@ rustdoc-kernel: $(src)/kernel/lib.rs rus
     $(obj)/bindings.o FORCE
 	+$(call if_changed,rustdoc)
 
+rustdoc-clean: FORCE
+	$(Q)rm -rf $(rustdoc_output)
+
 quiet_cmd_rustc_test_library = RUSTC TL $<
       cmd_rustc_test_library = \
 	OBJTREE=$(abspath $(objtree)) \



