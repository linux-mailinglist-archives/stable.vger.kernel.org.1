Return-Path: <stable+bounces-41710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F373F8B5902
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 14:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16FBCB26EB9
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 12:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E9D535C1;
	Mon, 29 Apr 2024 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0KMtun6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769AC53383
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394776; cv=none; b=j80W9QsQUIrVvFdMsDIY/V2Vvk0S0zfFhlYB5gqjOJsIBc/+IYk4UQenDq0UhQzNULG2XR/yUHOUV91faI7UU2lIukXnHzvzg7t9XrQqCXkj93O0+qg1bXRcTqm3hGV1kjapNbQ17J6tcgAAaPyf43FpMNS9tLtu5GKZoeRD67c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394776; c=relaxed/simple;
	bh=sDK40VaPsRW0CucKpZKJA+3fb2KuJArruyVdtchsTB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qFoIzxcQDPehc/yE7A7l8XBVHmbwuvNk8Xsn1fsgE/6LR12aktS4QQ0v+YTMGwxBq+Mrnw88N7a3sppyYX2Viy+5PrmerJzu7TWN+5XKhf4PCqFispeJvflHOggdxLtkLCNNPJXavY4GnmhFrLdHGb9AsRNOJMAtP9WycSNMD6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0KMtun6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1078CC113CD;
	Mon, 29 Apr 2024 12:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714394776;
	bh=sDK40VaPsRW0CucKpZKJA+3fb2KuJArruyVdtchsTB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y0KMtun6ezkRBZ56f1fo/WGZ70+1XB4mdm8sRIt0fwD3KoVtaQ7FSXXXg9Xb0TAv5
	 RGKedcqrXpibyNLTNnE0LcemdkVbbPvB+lRcPUII3oxTWR5KsHqyVCiov1BVaUmZ1r
	 EvP6XmqEh4ewuhgD9os9g1SfIXhdtl3wyxYdj+gMwKM2mYceGvLqLboqMFH0CZKolF
	 NCvxWzkVIQ0RvmYbxUDTpuAdXdzRzu96WpuNWzbNGgqmX7fK0nlvHXGMd1xEhpbd4q
	 ttgBm0el5ie92QsHk3tfwvxItpIWXlU5NPpfgG/VYpyPBqTIQLin7w49L9VAN0HFEY
	 WqidHkvWLSOFQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org
Cc: Aswin Unnikrishnan <aswinunni01@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.1.y] rust: remove `params` from `module` macro example
Date: Mon, 29 Apr 2024 14:45:05 +0200
Message-ID: <20240429124505.28432-1-ojeda@kernel.org>
In-Reply-To: <2024042924-ribcage-browsing-7e8b@gregkh>
References: <2024042924-ribcage-browsing-7e8b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aswin Unnikrishnan <aswinunni01@gmail.com>

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
(cherry picked from commit 19843452dca40e28d6d3f4793d998b681d505c7f)
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/macros/lib.rs | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 91764bfb1f89..f2efa86a747a 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -27,18 +27,6 @@ use proc_macro::TokenStream;
 ///     author: b"Rust for Linux Contributors",
 ///     description: b"My very own kernel module!",
 ///     license: b"GPL",
-///     params: {
-///        my_i32: i32 {
-///            default: 42,
-///            permissions: 0o000,
-///            description: b"Example of i32",
-///        },
-///        writeable_i32: i32 {
-///            default: 42,
-///            permissions: 0o644,
-///            description: b"Example of i32",
-///        },
-///    },
 /// }
 ///
 /// struct MyModule;
-- 
2.44.0


