Return-Path: <stable+bounces-222606-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNLQEWeapWnxEgYAu9opvQ
	(envelope-from <stable+bounces-222606-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:10:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B23B71DA6CE
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7223306CC0B
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 14:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3DB3FB076;
	Mon,  2 Mar 2026 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPs0t3FI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9163FB075;
	Mon,  2 Mar 2026 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460279; cv=none; b=Vj+2kueWOVBWjRoB3C1uEJzk6gfz5Rpzb4MHwxmLrH3lbSIXkAKsuvStUeFoSVW8Vjfew3RKxhmgO1+pTJ1m57TXh3Wca73Bj0Ifftie0iKMUF9uK5vC5VoAsP5a6VkD81opWayJlp7wzv4wNoQ1C1IsJjFjEaFAZfAquwrbVBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460279; c=relaxed/simple;
	bh=DbIQyN4/yzHKlY1q7pbNwcaynEivTFVygC/s84+psuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DAwJuo9YEFtL5Gu5FdhTlJh23hyNXLLBXQSjrIqVpXeMrbVDXjiFHiZrAXsxwbE5NA/YfqlckniMhQz3C9nGZE1Bk0N5iQdYcHu82CLeweH0yXByql2Fo/ooYVTs0o0kCatvBV9nmIdFFnSoz6Op6NMyzisRnElMMJbD9sCoJM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPs0t3FI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADC3C2BCAF;
	Mon,  2 Mar 2026 14:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772460279;
	bh=DbIQyN4/yzHKlY1q7pbNwcaynEivTFVygC/s84+psuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rPs0t3FIhBJ+g/NnZJbYfcK42PqlLZ9XO2XW4mc/XlKJHYqjFRRSbovWdYGSfQSMN
	 Ikp88a+Z/9xaQFuH1oarlZL4WUg7Y/4lzdSi+hlT1+9gB9JmEaAV70mKC9ayTZYcND
	 WohllrnWYsq2L+7QymD5S75fopjzYGhMbdLiKhmgvFH8BfrDtUcPXq5CTUWnEDM3Fy
	 cikxm/MkrHnEuGTftOpT1N4oUhCPRwpOukkEknJET178BqB5YqbSf5SeSTE8jQRS3n
	 DVh1AbZl/+q72n+AbhxVoiuZA5lo/nTBQveXcY4j2toT9oclV2qDGTjy8rE4sBO0xI
	 xwcGJsgxRnEgw==
From: Benno Lossin <lossin@kernel.org>
To: Benno Lossin <lossin@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: stable@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] rust: pin-init: internal: init: document load-bearing fact of field accessors
Date: Mon,  2 Mar 2026 15:04:15 +0100
Message-ID: <20260302140424.4097655-2-lossin@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302140424.4097655-1-lossin@kernel.org>
References: <20260302140424.4097655-1-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222606-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lossin@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B23B71DA6CE
X-Rspamd-Action: no action

The functions `[Pin]Init::__[pinned_]init` and `ptr::write` called from
the `init!` macro require the passed pointer to be aligned. This fact is
ensured by the creation of field accessors to previously initialized
fields.

Since we missed this very important fact from the beginning [1],
document it in the code.

Link: https://rust-for-linux.zulipchat.com/#narrow/channel/561532-pin-init/topic/initialized.20field.20accessor.20detection/with/576210658 [1]
Fixes: 90e53c5e70a6 ("rust: add pin-init API core")
Cc: stable@vger.kernel.org # 6.19.y and 6.18.y: patch should apply without issues
Cc: stable@vger.kernel.org # 6.12.y and 6.6.y: need prerequisite see below `---` for more info
Signed-off-by: Benno Lossin <lossin@kernel.org>
---
As already explained in the previous email, we discovered an unsoundness
in pin-init that exists since the beginning, but was unknowingly fixed
in commit 42415d163e5d ("rust: pin-init: add references to previously
initialized fields").

We introduced pin-init in 90e53c5e70a6 ("rust: add pin-init API core"),
which was included in 6.4. The affected stable trees that are still
maintained are: 6.12 and 6.6. Note that 6.18 and 6.19 already contain
42415d163e5d, so they are unaffected.

We still should backport this piece of documentation explaining the need
for the field accessors for soundness. For this reasons we also want to
backport it to 6.18 and 6.19.

Note that this patch depends on 42415d163e5d; so the only versions this
patch can go in directly are 6.18 and 6.19. I will send separate patch
series' for the older versions. The series' will include a backport of
42415d163e5d as well as a modified version of this patch, since this
patch depends on the `syn` rewrite, which is not present in older
versions.
---
 rust/pin-init/internal/src/init.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/pin-init/internal/src/init.rs b/rust/pin-init/internal/src/init.rs
index da53adc44ecf..738f62c8105c 100644
--- a/rust/pin-init/internal/src/init.rs
+++ b/rust/pin-init/internal/src/init.rs
@@ -251,6 +251,10 @@ fn init_fields(
                 });
                 // Again span for better diagnostics
                 let write = quote_spanned!(ident.span()=> ::core::ptr::write);
+                // NOTE: the field accessor ensures that the initialized field is properly aligned.
+                // Unaligned fields will cause the compiler to emit E0793. We do not support
+                // unaligned fields since `Init::__init` requires an aligned pointer; the call to
+                // `ptr::write` below has the same requirement.
                 let accessor = if pinned {
                     let project_ident = format_ident!("__project_{ident}");
                     quote! {
@@ -278,6 +282,10 @@ fn init_fields(
             InitializerKind::Init { ident, value, .. } => {
                 // Again span for better diagnostics
                 let init = format_ident!("init", span = value.span());
+                // NOTE: the field accessor ensures that the initialized field is properly aligned.
+                // Unaligned fields will cause the compiler to emit E0793. We do not support
+                // unaligned fields since `Init::__init` requires an aligned pointer; the call to
+                // `ptr::write` below has the same requirement.
                 let (value_init, accessor) = if pinned {
                     let project_ident = format_ident!("__project_{ident}");
                     (
-- 
2.53.0


