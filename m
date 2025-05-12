Return-Path: <stable+bounces-144056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F3EAB46C6
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 23:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550A74A032A
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 21:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341BC299951;
	Mon, 12 May 2025 21:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1/5nQ6o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D27259C9F
	for <stable@vger.kernel.org>; Mon, 12 May 2025 21:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747086762; cv=none; b=ifrk+wQYtchLKzc46h3QxWcDFfHSt7eEl3D6HYomujJlpV4VMEtD3n1Fk8gmGpEC4nFhXdivqtFmDz25SbHkO8EzshJO6xSyxLPNZwXRYW9OyMaLMmWRAjPWEl5ArkoDutmtt5H0NlWab74kE39Z7c0i9uPcRSujQcWTrrdHcEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747086762; c=relaxed/simple;
	bh=8Cphp9RNg9Ov7CGNM1k8vSnwPft/QpI8xnb8Yk2C10k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTE+Jw8Drc9qB0wIo1bO6ULqXQeLsuH4P00XqNoKwUp3p+6wuKNXvODWV15gkPAciAl7/+v5Ih1v5VpQlLbBAuldhE1Ky3DWMbXv+I3cR2ORZqdaB3lDT7x5tGs82P3XkL5NYdTiyrsXhW5FLuNWY1J1Tu8aRcYJyVP6ZV1eI28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1/5nQ6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08F0C4CEE7;
	Mon, 12 May 2025 21:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747086760;
	bh=8Cphp9RNg9Ov7CGNM1k8vSnwPft/QpI8xnb8Yk2C10k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I1/5nQ6oBxOcN/W3kYjwMDbWdQjLfUtrvgqWKM5hPOdEB8q8IP6x1VXou3fTwynwJ
	 D2gu+a+0CPBaGCrC2PL9KEedt0BnLD/yT+LFLWYeo4Y8749RylmmZ7UaRqrbx1Z2GO
	 NjoicyKdy+UB7AacbKE2J5xk/KDRUSb7mXdIDRq1st6Dd9R/1/+jkdsGrItVb9DshF
	 K7dq/6gcnbuxSMiApc/CnO+t1l+LklSF7lA3rng3V76gUZHIjaf3m51GatIerNUR6d
	 9wMC+PFL8GdhCfTPZ0D9XxhFoMAh2SmZAAVwaCQtrlcjKrlfKLGyf/r2mhVgVzPETs
	 n98O0MdAq5JOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ojeda@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14.y] rust: clean Rust 1.88.0's `clippy::uninlined_format_args` lint
Date: Mon, 12 May 2025 17:52:36 -0400
Message-Id: <20250512170256-aa13e96862457ea5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250512131657.1407076-1-ojeda@kernel.org>
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

Note: The patch differs from the upstream commit:
---
1:  211dcf77856db ! 1:  3d50fea3c59c6 rust: clean Rust 1.88.0's `clippy::uninlined_format_args` lint
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
    @@ rust/macros/paste.rs: fn concat_helper(tokens: &[TokenTree]) -> Vec<(String, Spa
          }
      
     
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
| stable/linux-6.14.y       |  Success    |  Success   |

