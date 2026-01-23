Return-Path: <stable+bounces-211432-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGiYFqwFdGm81QAAu9opvQ
	(envelope-from <stable+bounces-211432-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 00:35:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EA77B807
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 00:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0003C3015476
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 23:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A05296BA9;
	Fri, 23 Jan 2026 23:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmbUUTqi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816422A1BA;
	Fri, 23 Jan 2026 23:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769211300; cv=none; b=jqTce2wDz5TaR7OETVBtoW2AXeMwJLOj87i5aqeFVqPeUDsTGvNXZ3GuNcdROx439i5a9f5okopKHcDgYvDTw9nUr22edB0W2haxsSLWQaKnljZ2KE+6RK/A6fqHr2nO8Yd5JHVDjSBQDjuS4fafad//Foo4fnmkg0zoHbUZ7Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769211300; c=relaxed/simple;
	bh=u+/URG18L0dtZ2a2AJ1vvUt3ELVMjVvOX9jgyRTfNHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FUGn/DYm5IEhOhfkv96xdX73IOCtFO86+PubFqXp4Zac+a3Uuv6PsO2bk06Bu9RbkAnhF9Eik2x1c1b+xzg2a/dL2ph+nS7KRkLuN81DpeKENWkl3PbkmpZTiQaQmrt30uaWmRDFith6jUPf+x7tLYmPpqxnmcbDO+9x4GO668w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmbUUTqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5D8C4CEF1;
	Fri, 23 Jan 2026 23:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769211300;
	bh=u+/URG18L0dtZ2a2AJ1vvUt3ELVMjVvOX9jgyRTfNHs=;
	h=From:To:Cc:Subject:Date:From;
	b=QmbUUTqiMwfQfB/G6S+QNPb+/6sYMJG1NiniwoyHpam8GvuaM06470cBFME5h6vtJ
	 eKzF0tF2i7sWbeghKEeBxPRfTDdhnISnvZYzYpqpEcYWT20iF/SjrzvanZAIp/jlqp
	 hITJnWmHAnKscrTI0h7BAQ32W/q62HgYRj1YAD0jOCaLw3Fnb5bt8W3i1p+N2TVk8F
	 SFrb/a/aAvHJW73hcX4mWjzWDu9PrBr+l/eOgqq8UU1cxIDr4orc46mmP+xNDKcv21
	 YILrMqe7GycdnJixaLk2kTSxhrlHq2cPbIbj44vvkV9ueWpPW7jcgpS90JLobZ8W8b
	 2ybebzhM0DyrQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Gary Guo <gary@garyguo.net>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] rust: sync: atomic: Provide stub for `rusttest` 32-bit hosts
Date: Sat, 24 Jan 2026 00:34:32 +0100
Message-ID: <20260123233432.22703-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[arm.com,garyguo.net,vger.kernel.org,protonmail.com,kernel.org,google.com,umich.edu];
	TAGGED_FROM(0.00)[bounces-211432-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,infradead.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojeda@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0EA77B807
X-Rspamd-Action: no action

For arm32, on a x86_64 builder, running the `rusttest` target yields:

    error[E0080]: evaluation of constant value failed
      --> rust/kernel/static_assert.rs:37:23
       |
    37 |         const _: () = ::core::assert!($condition $(,$arg)?);
       |                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ the evaluated program panicked at 'assertion failed: size_of::<isize>() == size_of::<isize_atomic_repr>()', rust/kernel/sync/atomic/predefine.rs:68:1
       |
      ::: rust/kernel/sync/atomic/predefine.rs:68:1
       |
    68 | static_assert!(size_of::<isize>() == size_of::<isize_atomic_repr>());
       | -------------------------------------------------------------------- in this macro invocation
       |
       = note: this error originates in the macro `::core::assert` which comes from the expansion of the macro `static_assert` (in Nightly builds, run with -Z macro-backtrace for more info)

The reason is that `rusttest` runs on the host, so for e.g. a x86_64
builder `isize` is 64 bits but it is not a `CONFIG_64BIT` build.

Fix it by providing a stub for `rusttest` as usual.

Fixes: 84c6d36bcaf9 ("rust: sync: atomic: Add Atomic<{usize,isize}>")
Cc: stable@vger.kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
I kept the `cfg`s separated instead of using `all` so that, when we get
to remove this (since these tests will eventually be moved to KUnit), it
will just be line deletions (and I find it easier to read, too).

 rust/kernel/sync/atomic/predefine.rs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
index 45a17985cda4..0fca1ba3c2db 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -35,12 +35,23 @@ fn rhs_into_delta(rhs: i64) -> i64 {
 // as `isize` and `usize`, and `isize` and `usize` are always bi-directional transmutable to
 // `isize_atomic_repr`, which also always implements `AtomicImpl`.
 #[allow(non_camel_case_types)]
+#[cfg(not(testlib))]
 #[cfg(not(CONFIG_64BIT))]
 type isize_atomic_repr = i32;
 #[allow(non_camel_case_types)]
+#[cfg(not(testlib))]
 #[cfg(CONFIG_64BIT)]
 type isize_atomic_repr = i64;

+#[allow(non_camel_case_types)]
+#[cfg(testlib)]
+#[cfg(target_pointer_width = "32")]
+type isize_atomic_repr = i32;
+#[allow(non_camel_case_types)]
+#[cfg(testlib)]
+#[cfg(target_pointer_width = "64")]
+type isize_atomic_repr = i64;
+
 // Ensure size and alignment requirements are checked.
 static_assert!(size_of::<isize>() == size_of::<isize_atomic_repr>());
 static_assert!(align_of::<isize>() == align_of::<isize_atomic_repr>());

base-commit: a44bfed9df8a514962e2cb076d9c0b594caeff36
--
2.52.0

