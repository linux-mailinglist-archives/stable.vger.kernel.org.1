Return-Path: <stable+bounces-42062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7864E8B7138
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 12:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C841F2339A
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940F612C472;
	Tue, 30 Apr 2024 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f9A07FGC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4912712D74E;
	Tue, 30 Apr 2024 10:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474444; cv=none; b=ceyAEHWNySYh23ahpzxgjnPcxj7p3XO5STYOdQaNTY1I1d168MUl44ZrUWGKVfZ3SYgtd3rd7ksAQQoURLwmTp1zjC2ZHC/yBjj1p5rKs1zzYPFHZ39D+8FJdPrJ/tDbVv+ndGukdnRB9c40ZrAS0+zBpayFeiiz96x2OyAeAG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474444; c=relaxed/simple;
	bh=+FbspavUHQkOjtFXjuCtNPHj8JXW90QO9aPjQu8/Os4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKIyhnGqeiOi1RtI1oG+0dzQOhG4/OehwnXid5mIu/pb7nyhYgNFKh3ybc9W7fZyZWfsHt8JYbfJPHGDmNA/dwGKz9mYzL1zjLg1pl/m8eXXZHazvnTDrY//6eSk5kb3BC15Nn35tg8JcvWz67furn6WqmuhSqgcaq435Pq8p7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f9A07FGC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A954C4AF19;
	Tue, 30 Apr 2024 10:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714474443;
	bh=+FbspavUHQkOjtFXjuCtNPHj8JXW90QO9aPjQu8/Os4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f9A07FGC68/ZJFDDHYJhlS8fj81WiQxSLTfb1F+JMLTHhmxW8GbAibf/cpKgM2uA3
	 aAZDPsYL2YtO6iOWP+w2D9wwJBAGkbiAXJAzw9UmxDceOWuBoJtRpRXEuwz2Kcv2L3
	 DDTbhw/6Y3f6wJPyzOVvynPmPxDxnhJMD/xpTEkE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aswin Unnikrishnan <aswinunni01@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.8 141/228] rust: remove `params` from `module` macro example
Date: Tue, 30 Apr 2024 12:38:39 +0200
Message-ID: <20240430103107.869091565@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
References: <20240430103103.806426847@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aswin Unnikrishnan <aswinunni01@gmail.com>

commit 19843452dca40e28d6d3f4793d998b681d505c7f upstream.

Remove argument `params` from the `module` macro example, because the
macro does not currently support module parameters since it was not sent
with the initial merge.

Signed-off-by: Aswin Unnikrishnan <aswinunni01@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Cc: stable@vger.kernel.org
Fixes: 1fbde52bde73 ("rust: add `macros` crate")
Link: https://lore.kernel.org/r/20240419215015.157258-1-aswinunni01@gmail.com
[ Reworded slightly. ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 rust/macros/lib.rs |   12 ------------
 1 file changed, 12 deletions(-)

--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -35,18 +35,6 @@ use proc_macro::TokenStream;
 ///     author: "Rust for Linux Contributors",
 ///     description: "My very own kernel module!",
 ///     license: "GPL",
-///     params: {
-///        my_i32: i32 {
-///            default: 42,
-///            permissions: 0o000,
-///            description: "Example of i32",
-///        },
-///        writeable_i32: i32 {
-///            default: 42,
-///            permissions: 0o644,
-///            description: "Example of i32",
-///        },
-///    },
 /// }
 ///
 /// struct MyModule;



