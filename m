Return-Path: <stable+bounces-170043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B980B2A050
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA0737AA6D8
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA0031B11E;
	Mon, 18 Aug 2025 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrQ94KUS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B77131B112
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755516369; cv=none; b=Ps0o2Y9a+HDQBttTt0qrtLW61QzZq5cUhDxaNNk34dl6e6m3r6kk8sdGaTEc160qY2OuaBRJfQo6kckOCX3v42o9EtpHRhKB0OOJ4JhY1AukyShZLoo91K7XFvCcZX+2WLF6aKLqBtkS+L1WsX4aFKprWi2u/fNR+J8UYMxYKY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755516369; c=relaxed/simple;
	bh=8/vV4d7MLqXGjvfZLpZhS2GtQ7Q7EMjyUG9MpX9x050=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWJpsD7bSOsP7ES7ctXxSNiFx0ptqYYj+G4fvhnOrDXcoHYxL1JyT74mLJcbpkSyH9yiPdmcxUYIk9ezQau7wbA0RuzsfgZlJx5BZrQ7P4t/xRPakc6TNJEddWeho8U4yDNzvtZbuDsdlXwdg8crTqjA53rMsD+pVeoE7teYvsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrQ94KUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749EDC4CEEB;
	Mon, 18 Aug 2025 11:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755516368;
	bh=8/vV4d7MLqXGjvfZLpZhS2GtQ7Q7EMjyUG9MpX9x050=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jrQ94KUSrFzh1DH2q4tzFiBPnoxr5D1orIX0zGmEfK7OjKLvC4AG/k0V8Y/ksWTf8
	 5oHZWubV/KOv5lJsGsHa5ltI0SybfGv6F2jVK6KTl2GsQ3B7Opp1UDPuSx122F+tvE
	 VKa/U1um2PhFtmhQE8/ir9u2QeorkWxCGLkLgTU8RLEmmY3cap9Ik2aBbK3I8i/mns
	 CG76OUQGJ3fIh6ErA9GV09zgzO/BRTIU7fGkera9DXM4pMdySqrKLjJTzFH3FxZ6+x
	 x/WCfEzPEOpknpeRUumjR6wexRIeYSPkN9fR8gCd3IV6HguatcYekalR/+V/WRNLuG
	 Z/rl67/nw0Hng==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>
Subject: [PATCH 6.12.y] rust: kbuild: clean output before running `rustdoc`
Date: Mon, 18 Aug 2025 13:26:02 +0200
Message-ID: <20250818112602.2838732-1-ojeda@kernel.org>
In-Reply-To: <2025081858-zips-enchanted-3d3e@gregkh>
References: <2025081858-zips-enchanted-3d3e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
(cherry picked from commit 252fea131e15aba2cd487119d1a8f546471199e2)
---
 rust/Makefile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 17491d8229a4..84dc4cd46e7e 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -92,14 +92,14 @@ rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins \
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
@@ -116,6 +116,9 @@ rustdoc-kernel: $(src)/kernel/lib.rs rustdoc-core rustdoc-ffi rustdoc-macros \
     $(obj)/bindings.o FORCE
 	+$(call if_changed,rustdoc)
 
+rustdoc-clean: FORCE
+	$(Q)rm -rf $(rustdoc_output)
+
 quiet_cmd_rustc_test_library = RUSTC TL $<
       cmd_rustc_test_library = \
 	OBJTREE=$(abspath $(objtree)) \
-- 
2.50.1


