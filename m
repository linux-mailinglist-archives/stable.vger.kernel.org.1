Return-Path: <stable+bounces-144049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B15AB46BF
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 23:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D4C1894316
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 21:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA9E299951;
	Mon, 12 May 2025 21:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzIjoyLM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF73322338
	for <stable@vger.kernel.org>; Mon, 12 May 2025 21:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747086730; cv=none; b=beedUGFHUKxHOblbAovzwsE78uJx718AO8JP7u0NuFsUDh48/tzsBqryGtK4zs0yhjr9ItcdIGc2NBzl+H5EbL+aeTk0hQo51CL7ZWu3XQ7l4qdG6+5Y/shgTbZmmN8hwL9AUs3NqXlxykzUXz1vqe+HUWVB32v9FpxAntQaxI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747086730; c=relaxed/simple;
	bh=WqYOeKJO1+mir0s4Xoatpc04YsW0hrP0TngNmDNKkoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pqTtbkEanS/Zhe1nBDUX6pM3A0/KcFeiHe5xQfSgX0sy45ptJHPGj4BhHlkkqKLBwHcM97GHY1O17rmRn20V7p7aP4zkvEZCIsNcPtsk5zeTWZYDKW4RF95MDeww8kZIXGYK85F9ZLfnRe7/1zAJwTKtXLb/mcdiz12+EpvBgjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzIjoyLM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633BDC4CEE7;
	Mon, 12 May 2025 21:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747086729;
	bh=WqYOeKJO1+mir0s4Xoatpc04YsW0hrP0TngNmDNKkoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EzIjoyLMMhOcNk8pbd+Q/DE4Hu9ruwPXJICUid96BbmFaG+03Q7Y6bTgxkK5dxisD
	 Yys6QkVj6E8nEuXuASGV1XCvvcfuFJEo/APJdi12mGycMyGl0II1Ek4Y1g+roD8nUC
	 4JCKuTnB5oupXpIPrgyyyJhWn1T9lqdBbF6BufiGYSqztaMVMGEmRExlUX/AaqXONd
	 KN81qRaYF5RsZE6mBfm4a+cbQHkbUGvRKA/Fd49bUqwyUDBkHaxzkyjzpY7q9PE5Fe
	 MlY5CFUsx3GuLL7b1K/6101i+GnppE0CDIjkBOJaLaQzm4QYQ+ip3GAISrs+RpdsmW
	 cAevUZYgYD+BQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ojeda@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] rust: clean Rust 1.88.0's `clippy::uninlined_format_args` lint
Date: Mon, 12 May 2025 17:52:06 -0400
Message-Id: <20250512160613-3d6ef16f3b9aa1e4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250512133126.1409649-1-ojeda@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 211dcf77856db64c73e0c3b9ce0c624ec855daca

Status in newer kernel trees:
6.14.y | Not found

Note: The patch differs from the upstream commit:
---
1:  211dcf77856db ! 1:  72f32deb26fb4 rust: clean Rust 1.88.0's `clippy::uninlined_format_args` lint
    @@ Commit message
         Reviewed-by: Alice Ryhl <aliceryhl@google.com>
         Link: https://lore.kernel.org/r/20250502140237.1659624-6-ojeda@kernel.org
         Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
    -
    - ## drivers/gpu/nova-core/gpu.rs ##
    -@@ drivers/gpu/nova-core/gpu.rs: pub(crate) fn arch(&self) -> Architecture {
    - // For now, redirect to fmt::Debug for convenience.
    - impl fmt::Display for Chipset {
    -     fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
    --        write!(f, "{:?}", self)
    -+        write!(f, "{self:?}")
    -     }
    - }
    - 
    +    (cherry picked from commit 211dcf77856db64c73e0c3b9ce0c624ec855daca)
    +    Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
     
      ## rust/kernel/str.rs ##
     @@ rust/kernel/str.rs: fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
    @@ rust/kernel/str.rs: fn test_cstr_display_all_bytes() {
      }
      
     
    - ## rust/macros/kunit.rs ##
    -@@ rust/macros/kunit.rs: pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
    -     }
    - 
    -     if attr.len() > 255 {
    --        panic!(
    --            "The test suite name `{}` exceeds the maximum length of 255 bytes",
    --            attr
    --        )
    -+        panic!("The test suite name `{attr}` exceeds the maximum length of 255 bytes")
    -     }
    - 
    -     let mut tokens: Vec<_> = ts.into_iter().collect();
    -@@ rust/macros/kunit.rs: pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
    -     let mut kunit_macros = "".to_owned();
    -     let mut test_cases = "".to_owned();
    -     for test in &tests {
    --        let kunit_wrapper_fn_name = format!("kunit_rust_wrapper_{}", test);
    -+        let kunit_wrapper_fn_name = format!("kunit_rust_wrapper_{test}");
    -         let kunit_wrapper = format!(
    --            "unsafe extern \"C\" fn {}(_test: *mut kernel::bindings::kunit) {{ {}(); }}",
    --            kunit_wrapper_fn_name, test
    -+            "unsafe extern \"C\" fn {kunit_wrapper_fn_name}(_test: *mut kernel::bindings::kunit) {{ {test}(); }}"
    -         );
    -         writeln!(kunit_macros, "{kunit_wrapper}").unwrap();
    -         writeln!(
    -             test_cases,
    --            "    kernel::kunit::kunit_case(kernel::c_str!(\"{}\"), {}),",
    --            test, kunit_wrapper_fn_name
    -+            "    kernel::kunit::kunit_case(kernel::c_str!(\"{test}\"), {kunit_wrapper_fn_name}),"
    -         )
    -         .unwrap();
    -     }
    -
      ## rust/macros/module.rs ##
     @@ rust/macros/module.rs: fn emit_base(&mut self, field: &str, content: &str, builtin: bool) {
                  )
    @@ rust/macros/module.rs: fn parse(it: &mut token_stream::IntoIter) -> Self {
      
              info
     
    - ## rust/macros/paste.rs ##
    -@@ rust/macros/paste.rs: fn concat_helper(tokens: &[TokenTree]) -> Vec<(String, Span)> {
    -                 let tokens = group.stream().into_iter().collect::<Vec<TokenTree>>();
    -                 segments.append(&mut concat_helper(tokens.as_slice()));
    -             }
    --            token => panic!("unexpected token in paste segments: {:?}", token),
    -+            token => panic!("unexpected token in paste segments: {token:?}"),
    -         };
    -     }
    - 
    -
    - ## rust/pin-init/internal/src/pinned_drop.rs ##
    -@@ rust/pin-init/internal/src/pinned_drop.rs: pub(crate) fn pinned_drop(_args: TokenStream, input: TokenStream) -> TokenStream
    + ## rust/macros/pinned_drop.rs ##
    +@@ rust/macros/pinned_drop.rs: pub(crate) fn pinned_drop(_args: TokenStream, input: TokenStream) -> TokenStream
                  // Found the end of the generics, this should be `PinnedDrop`.
                  assert!(
                      matches!(tt, TokenTree::Ident(i) if i.to_string() == "PinnedDrop"),
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

