Return-Path: <stable+bounces-159332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF53CAF77EE
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 16:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469791C83D60
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B632ED87C;
	Thu,  3 Jul 2025 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CH4CKn1y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2292DE6E5;
	Thu,  3 Jul 2025 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553900; cv=none; b=qfFvgDrAsrjuNL2n8sM6lYqEun/AT83kfxykGFqT4kL5MTRjJJWGjqVxwfbVCA9Nlb1lcKCDhbh2CizHz9HWbD3huOOnsv/zwHVpeVyNMp0QLcBGjhQN9WTRZ21h+Nw0+sW1ftolGrdWp1Olb12JpiF6DjmiXE1MTizJypJtmPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553900; c=relaxed/simple;
	bh=tjiWpyhHx7nQovMVg9ZlCCCrsEQnloepywU3zHoDHg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWsfuDENbW0hnqJnqyURuyG0jLV7SuTBHgDSiagOysOVivX79LkbEba+qxjEkMn1aUwQID+jx7J0dK4F/VdHWKcQ0+jtLzqG2gVDyswlFHBO8XJeB6zfv+3+EGsB5gy0Lv5mpwoqT06zih1h3nQu1F/SO/o2gLm0ofoG1L1EOYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CH4CKn1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD212C4CEF0;
	Thu,  3 Jul 2025 14:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751553900;
	bh=tjiWpyhHx7nQovMVg9ZlCCCrsEQnloepywU3zHoDHg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CH4CKn1y6C4AtdDc8EKczCm1pmnd7uVLHB2OQ3js6VGRgcuEiFqAHKHJIICiryQ3v
	 o69p1gH06csnKLXjaB3G+YFaz9qQpJhFyFs0Su/df1440w0Kune3LrU/tWzUBLRmhC
	 A48YWK4+Ulj3dWMNIuSBYj2jU0TtcIcVANUwRqP4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 018/218] rust: module: place cleanup_module() in .exit.text section
Date: Thu,  3 Jul 2025 16:39:26 +0200
Message-ID: <20250703143956.687940881@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143955.956569535@linuxfoundation.org>
References: <20250703143955.956569535@linuxfoundation.org>
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
index da2a18b276e0b..a5ea5850e307a 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -260,6 +260,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
                     #[cfg(MODULE)]
                     #[doc(hidden)]
                     #[no_mangle]
+                    #[link_section = \".exit.text\"]
                     pub extern \"C\" fn cleanup_module() {{
                         // SAFETY:
                         // - This function is inaccessible to the outside due to the double
-- 
2.39.5




