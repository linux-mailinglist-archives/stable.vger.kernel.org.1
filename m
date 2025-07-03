Return-Path: <stable+bounces-159952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FF2AF7BCD
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9765D4E84A6
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CC82EF9AA;
	Thu,  3 Jul 2025 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BE5aRAWz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BB91C68A6;
	Thu,  3 Jul 2025 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555894; cv=none; b=EcyA//TQNAeNQ32qW9FO9+0zcUS8ZPCbp+Nc05O4XoXv+BcjCTOiaiyx4O+3PYq+ugcvf+Fxh0dTCsRE+WQpmBPSNQ0+dOmdMhp0xbk5pOQKogmLSEEH85hM+FgWz1x4q0Z3RkKEZJDcmWfm72eAjBXSYoTpm9scdtDEtUaTpe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555894; c=relaxed/simple;
	bh=E/uySTLFX0uAYP4/hAPq/0C8iVfl7jStp1heUNQIhdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqWbv2LUNFIcrVzuvbSiUylnYxCj3kbe5xW7AYaPMo7isEIQUrNh1w5IX4zTVinlqiEJQKcdx6PkozMUa33CF8X8pKYTXTKUEunh5TJyYoB37BkHNXyvfDucYEMmCXW5nUg1VCFGq/ok1qKOgm8jJ68/kFu4dLpbe6QyzCMvcp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BE5aRAWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3F5C4CEE3;
	Thu,  3 Jul 2025 15:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751555894;
	bh=E/uySTLFX0uAYP4/hAPq/0C8iVfl7jStp1heUNQIhdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BE5aRAWz357QeLKMNxkBwGRJatMK7tX9r5cPkw6jBUxRGYhYArZ+c/6OQNTIoqIAx
	 sFDRVx8THv+WUp2hFurq1eTlAB53mxblftF8Z34ONIOFn7pBeq5E2gINjh6doMsZna
	 d+b9a3k2oS7jOTPaQTd2RbE8yzg7VLhCBzwgwjyE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 011/132] rust: module: place cleanup_module() in .exit.text section
Date: Thu,  3 Jul 2025 16:41:40 +0200
Message-ID: <20250703143939.837943478@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143939.370927276@linuxfoundation.org>
References: <20250703143939.370927276@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: FUJITA Tomonori <fujita.tomonori@gmail.com>

[ Upstream commit 249c3a0e53acefc2b06d3b3e1fc28fb2081f878d ]

Place cleanup_module() in .exit.text section. Currently,
cleanup_module() is likely placed in the .text section. It's
inconsistent with the layout of C modules, where cleanup_module() is
placed in .exit.text.

[ Boqun asked for an example of how the section changed to be
  put in the log. Tomonori provided the following examples:

    C module:

      $ objdump -t ~/build/x86/drivers/block/loop.o|grep clean
      0000000000000000 l     O .exit.data    0000000000000008 __UNIQUE_ID___addressable_cleanup_module412
      0000000000000000 g     F .exit.text    000000000000009c cleanup_module

    Rust module without this patch:

      $ objdump -t ~/build/x86/samples/rust/rust_minimal.o|grep clean
      00000000000002b0 g     F .text         00000000000000c6 cleanup_module
      0000000000000000 g     O .exit.data    0000000000000008 _R...___UNIQUE_ID___addressable_cleanup_module

    Rust module with this patch:

      $ objdump -t ~/build/x86/samples/rust/rust_minimal.o|grep clean
      0000000000000000 g     F .exit.text    00000000000000c6 cleanup_module
      0000000000000000 g     O .exit.data    0000000000000008 _R...___UNIQUE_ID___addressable_cleanup_module

  - Miguel ]

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/r/20250308044506.14458-1-fujita.tomonori@gmail.com
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/macros/module.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 94a92ab82b6b3..eeca6b2d5160a 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -229,6 +229,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
                     #[cfg(MODULE)]
                     #[doc(hidden)]
                     #[no_mangle]
+                    #[link_section = \".exit.text\"]
                     pub extern \"C\" fn cleanup_module() {{
                         // SAFETY:
                         // - This function is inaccessible to the outside due to the double
-- 
2.39.5




