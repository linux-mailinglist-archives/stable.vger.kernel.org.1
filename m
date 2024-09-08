Return-Path: <stable+bounces-73862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0659706E0
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 13:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D021C20CD5
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 11:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0176B1531C9;
	Sun,  8 Sep 2024 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LXEhzxBH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A520F14C5AE
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725794850; cv=none; b=uzxmPB+AuGqlgqcfjpNqK9zSMDdVvVU3p8WbqM0v2K4/EohRRUCjJ0u4u9sm2Za2i0QVqIDtI3CjcOJhwMPy92QUqrdPZhz/eOq241IJNZTSF+Adc4I4eQ7eyTrqpqBFR3IxxkmKrJ3nuWe8CBlHSlptOXBLhM3vRolxP5rc2uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725794850; c=relaxed/simple;
	bh=saX9VfZh6eEEMnL29K/KJXrFPT543LGCwe81I+f9aDo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=R5c7Yr5PityiVNfQ13fECjgKkTvuNTZZTeoxZyWDGFOxiAgPAGAsSkfad5ddWm0pYSNYYC5OxPp3eBxyegB1GaPsFelH6kgfBVvE9ukZhekwveNIXzruozCAEYzeRB3SdVWqpvH3wFDhtwTtHhGufh280+L2I1L4e3Eo4S+x3lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LXEhzxBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2993FC4CEC3;
	Sun,  8 Sep 2024 11:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725794850;
	bh=saX9VfZh6eEEMnL29K/KJXrFPT543LGCwe81I+f9aDo=;
	h=Subject:To:Cc:From:Date:From;
	b=LXEhzxBHqBI6rZBgqzCkG5H7H2qhcnmVWmrZrZbzTSf4kVxufDfBkN+mfy7r90pk4
	 B2uWv3Gq8PIWiKRcg8gJ9eQJdNj+gihk/tapS8FYLSq4U0g0mKkf5p/rFAPb361Gkh
	 0k5QMWlhOSOzQkIkZLG3xdSGQH3DHMrSQsnVdMGM=
Subject: FAILED: patch "[PATCH] rust: macros: provide correct provenance when constructing" failed to apply to 6.1-stable tree
To: boqun.feng@gmail.com,aliceryhl@google.com,benno.lossin@proton.me,gary@garyguo.net,ojeda@kernel.org,tmgross@umich.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 13:26:32 +0200
Message-ID: <2024090831-camera-backlands-a643@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a5a3c952e82c1ada12bf8c55b73af26f1a454bd2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090831-camera-backlands-a643@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

a5a3c952e82c ("rust: macros: provide correct provenance when constructing THIS_MODULE")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a5a3c952e82c1ada12bf8c55b73af26f1a454bd2 Mon Sep 17 00:00:00 2001
From: Boqun Feng <boqun.feng@gmail.com>
Date: Wed, 28 Aug 2024 11:01:29 -0700
Subject: [PATCH] rust: macros: provide correct provenance when constructing
 THIS_MODULE

Currently while defining `THIS_MODULE` symbol in `module!()`, the
pointer used to construct `ThisModule` is derived from an immutable
reference of `__this_module`, which means the pointer doesn't have
the provenance for writing, and that means any write to that pointer
is UB regardless of data races or not. However, the usage of
`THIS_MODULE` includes passing this pointer to functions that may write
to it (probably in unsafe code), and this will create soundness issues.

One way to fix this is using `addr_of_mut!()` but that requires the
unstable feature "const_mut_refs". So instead of `addr_of_mut()!`,
an extern static `Opaque` is used here: since `Opaque<T>` is transparent
to `T`, an extern static `Opaque` will just wrap the C symbol (defined
in a C compile unit) in an `Opaque`, which provides a pointer with
writable provenance via `Opaque::get()`. This fix the potential UBs
because of pointer provenance unmatched.

Reported-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
Closes: https://rust-for-linux.zulipchat.com/#narrow/stream/x/topic/x/near/465412664
Fixes: 1fbde52bde73 ("rust: add `macros` crate")
Cc: stable@vger.kernel.org # 6.6.x: be2ca1e03965: ("rust: types: Make Opaque::get const")
Link: https://lore.kernel.org/r/20240828180129.4046355-1-boqun.feng@gmail.com
[ Fixed two typos, reworded title. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 411dc103d82e..7a5b899e47b7 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -217,7 +217,11 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             // freed until the module is unloaded.
             #[cfg(MODULE)]
             static THIS_MODULE: kernel::ThisModule = unsafe {{
-                kernel::ThisModule::from_ptr(&kernel::bindings::__this_module as *const _ as *mut _)
+                extern \"C\" {{
+                    static __this_module: kernel::types::Opaque<kernel::bindings::module>;
+                }}
+
+                kernel::ThisModule::from_ptr(__this_module.get())
             }};
             #[cfg(not(MODULE))]
             static THIS_MODULE: kernel::ThisModule = unsafe {{


