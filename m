Return-Path: <stable+bounces-243639-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EClNATOr+GnHxgIAu9opvQ
	(envelope-from <stable+bounces-243639-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:20:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE594BF20D
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22D183025E69
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3383DE443;
	Mon,  4 May 2026 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Em8eSXf7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E70C315785;
	Mon,  4 May 2026 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904398; cv=none; b=eaAj3VeIMvqm46GXhshNhIgkXwME8QwmkAN6SpK6lK3ZHgU0W1D/65qkQ+uMiE8Funh0+jzFUw84lKQ/s7+f8Mg95O3utGXzp3SKRr6RRmqEYu86PuvxRDgZRJ9ceAilaWyMcjbaaIdzuJlYTNRQ5NMPw7iy/l1GumlrxDYWrjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904398; c=relaxed/simple;
	bh=uykBgZ8JIVZkVV5UFdvhX5h3aqPOnmv3bWY6ze+o//Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P12IyGQJef5sKO2wKf/Zram4hkJklpXtWjAl9KMbIHQB5NpRIkQrBQK2tgrZZuNQWrLYDqXv1S24pZk+RmJBemWSMo8ef3ABqqae1RqT/PSsDGeyXdqzvzr1mqZG3KM6BUKN8kItiCsGJ9qL/BGQzqytcx8ufAl7EAYqbXxykv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Em8eSXf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3447CC2BCB8;
	Mon,  4 May 2026 14:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904398;
	bh=uykBgZ8JIVZkVV5UFdvhX5h3aqPOnmv3bWY6ze+o//Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Em8eSXf7rLZX4+gX8Vh22YE2jyyHuqkv4+McDpQw8WfJnWv/gCphfvGasCZhb7wx1
	 P4JM407jRMUKpkUudmlPTyNoVhmD5KYsX5ZjXJVqPGT2S8AAIvORY7L9c9TrhMZCx2
	 kU4xi3BJhd86NVmubweNJFnXxcZf8A4REdkL4IHQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benno Lossin <lossin@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 023/215] rust: init: fix `clippy::undocumented_unsafe_blocks` warnings
Date: Mon,  4 May 2026 15:50:42 +0200
Message-ID: <20260504135131.023603491@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
References: <20260504135130.169210693@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ACE594BF20D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243639-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,garyguo.net:email]

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miguel Ojeda <ojeda@kernel.org>

The stable backport in commit acc105db0826 ("rust: pin-init:
add references to previously initialized fields") introduced some
`clippy::undocumented_unsafe_blocks` warnings [1], e.g.

    error: unsafe block missing a safety comment
        --> rust/kernel/init/macros.rs:1015:25

As well as:

    --> rust/kernel/init/macros.rs:1243:45
    --> rust/kernel/init/macros.rs:1286:22
    --> rust/kernel/init/macros.rs:1374:45

After discussing it with Benno and Gary, we decided to clean the build
log by doing a minimal targeted stable commit.

Thus, depending on the case:

  - Reorder the attributes so that the existing `// SAFETY:` comments
    may be seen by Clippy.

  - Add a placeholder `// SAFETY: TODO.` comment.

Cc: Benno Lossin <lossin@kernel.org>
Cc: Gary Guo <gary@garyguo.net>
Fixes: acc105db0826 ("rust: pin-init: add references to previously initialized fields")
Link: https://lore.kernel.org/stable/20260421111111.57059-1-ojeda@kernel.org/ [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/kernel/init/macros.rs | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index e477e4de817bf..d6e27c5221155 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -1012,6 +1012,7 @@ macro_rules! __pin_data {
                         self,
                         slot: &'__slot mut $p_type,
                     ) -> ::core::pin::Pin<&'__slot mut $p_type> {
+                        // SAFETY: TODO.
                         unsafe { ::core::pin::Pin::new_unchecked(slot) }
                     }
                 )*
@@ -1235,11 +1236,11 @@ macro_rules! __init_internal {
         // Unaligned fields will cause the compiler to emit E0793. We do not support
         // unaligned fields since `Init::__init` requires an aligned pointer; the call to
         // `ptr::write` below has the same requirement.
+        #[allow(unused_variables, unused_assignments)]
         // SAFETY:
         // - the project function does the correct field projection,
         // - the field has been initialized,
         // - the reference is only valid until the end of the initializer.
-        #[allow(unused_variables, unused_assignments)]
         let $field = $crate::macros::paste!(unsafe { $data.[< __project_ $field >](&mut (*$slot).$field) });
 
         // Create the drop guard:
@@ -1278,11 +1279,11 @@ macro_rules! __init_internal {
         // Unaligned fields will cause the compiler to emit E0793. We do not support
         // unaligned fields since `Init::__init` requires an aligned pointer; the call to
         // `ptr::write` below has the same requirement.
+        #[allow(unused_variables, unused_assignments)]
         // SAFETY:
         // - the field is not structurally pinned, since the line above must compile,
         // - the field has been initialized,
         // - the reference is only valid until the end of the initializer.
-        #[allow(unused_variables, unused_assignments)]
         let $field = unsafe { &mut (*$slot).$field };
 
         // Create the drop guard:
@@ -1366,11 +1367,11 @@ macro_rules! __init_internal {
         // Unaligned fields will cause the compiler to emit E0793. We do not support
         // unaligned fields since `Init::__init` requires an aligned pointer; the call to
         // `ptr::write` below has the same requirement.
+        #[allow(unused_variables, unused_assignments)]
         // SAFETY:
         // - the project function does the correct field projection,
         // - the field has been initialized,
         // - the reference is only valid until the end of the initializer.
-        #[allow(unused_variables, unused_assignments)]
         let $field = $crate::macros::paste!(unsafe { $data.[< __project_ $field >](&mut (*$slot).$field) });
 
         // Create the drop guard:
-- 
2.53.0




