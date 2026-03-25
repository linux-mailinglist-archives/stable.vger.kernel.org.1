Return-Path: <stable+bounces-230330-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOHANVjmw2lvugQAu9opvQ
	(envelope-from <stable+bounces-230330-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 14:42:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE03325FF4
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 14:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9747C32B1E9C
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 12:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0813D6CB4;
	Wed, 25 Mar 2026 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0UvsWor"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1D3347512;
	Wed, 25 Mar 2026 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774443461; cv=none; b=USqa1IelMSt0hLKNTYv9Zm3XzYp+mAKj14BQIO4D1a78OJXy+iNE5Tt5OBLOjy+Y88IuO/wGgSNttiA1qe6Jm8vp61/L/OUJYRbAseYzqoaM6sbMx8IFs9W+onISf5iW0MAaWlCChSVB69TliwTGHJF66xZqoZYbJV2UZqrff9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774443461; c=relaxed/simple;
	bh=l8M9I9R09uIzgXauaUhIPnjcg4h+8HGRjaBcvx5EY3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XAoRRWx/yJ2Hkz4SB+TkntCTXsDrEE7W7oPz16uDTcvuo5HliVTle+H0k5IHHXgiwyvvQwDLJD4PLf8pp0i+HegSNrFXucKr49Uk2eE9i/QUWnnSTePD8sGEKtsfDlKXRXJn50kXQobBtCzd009m8xxTL/0BgCNYWDG8ODWm7jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0UvsWor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED221C4CEF7;
	Wed, 25 Mar 2026 12:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774443460;
	bh=l8M9I9R09uIzgXauaUhIPnjcg4h+8HGRjaBcvx5EY3Q=;
	h=From:To:Cc:Subject:Date:From;
	b=p0UvsWorVmR8DvakHkJ88ECMQoRcz6AK6mKPME2P0bljb4FSSSNTcm1Sc9ncJVzTK
	 B2WZ5ajKvwoedYHTcQSfRGtEHfxKH2TG7g9D/fSWv3jsL79g3i/kkm7+QYj81f82mX
	 9zUMoeQteU79pNMy8MIDwWpoY7l1gcbHoz+tJrtGijIGLS44nv+HsztqvF7QOqGv/J
	 D5/etv9s8uGmm2HEtHGtx0Q+J4pHPc+ua/EnteCG0OsqWZOnMZoo6F5O9JUyMwuF52
	 Yyg/YV1EmNhtHGoEXYX10bblB4yDI1kcdB4R58I2BmUpdpSOO6Ve6Vba5flxF89Ftk
	 Kl7UON9UCXXOg==
From: Benno Lossin <lossin@kernel.org>
To: Benno Lossin <lossin@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: stable@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.19.y 1/2] rust: pin-init: internal: init: document load-bearing fact of field accessors
Date: Wed, 25 Mar 2026 13:57:31 +0100
Message-ID: <20260325125734.944247-1-lossin@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu];
	TAGGED_FROM(0.00)[bounces-230330-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lossin@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zulipchat.com:url,msgid.link:url]
X-Rspamd-Queue-Id: 1AE03325FF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[ Upstream commit 580cc37b1de4fcd9997c48d7080e744533f09f36 ]

The functions `[Pin]Init::__[pinned_]init` and `ptr::write` called from
the `init!` macro require the passed pointer to be aligned. This fact is
ensured by the creation of field accessors to previously initialized
fields.

Since we missed this very important fact from the beginning [1],
document it in the code.

Link: https://rust-for-linux.zulipchat.com/#narrow/channel/561532-pin-init/topic/initialized.20field.20accessor.20detection/with/576210658 [1]
Fixes: 90e53c5e70a6 ("rust: add pin-init API core")
Cc: <stable@vger.kernel.org> # 6.6.y, 6.12.y: 42415d163e5d: rust: pin-init: add references to previously initialized fields
Cc: <stable@vger.kernel.org> # 6.6.y, 6.12.y, 6.18.y, 6.19.y
Signed-off-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://patch.msgid.link/20260302140424.4097655-2-lossin@kernel.org
[ Updated Cc: stable@ tags as discussed. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
[ Moved changes to the declarative macro, because 6.19.y and earlier do not
  have `syn`. Also duplicated the comment for all field accessor creations.
  - Benno ]
Signed-off-by: Benno Lossin <lossin@kernel.org>
---
 rust/pin-init/src/macros.rs | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/rust/pin-init/src/macros.rs b/rust/pin-init/src/macros.rs
index 682c61a587a0..1980584c442a 100644
--- a/rust/pin-init/src/macros.rs
+++ b/rust/pin-init/src/macros.rs
@@ -1312,6 +1312,10 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
         // return when an error/panic occurs.
         // We also use the `data` to require the correct trait (`Init` or `PinInit`) for `$field`.
         unsafe { $data.$field(::core::ptr::addr_of_mut!((*$slot).$field), init)? };
+        // NOTE: the field accessor ensures that the initialized field is properly aligned.
+        // Unaligned fields will cause the compiler to emit E0793. We do not support
+        // unaligned fields since `Init::__init` requires an aligned pointer; the call to
+        // `ptr::write` below has the same requirement.
         // SAFETY:
         // - the project function does the correct field projection,
         // - the field has been initialized,
@@ -1351,6 +1355,10 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
         // return when an error/panic occurs.
         unsafe { $crate::Init::__init(init, ::core::ptr::addr_of_mut!((*$slot).$field))? };
 
+        // NOTE: the field accessor ensures that the initialized field is properly aligned.
+        // Unaligned fields will cause the compiler to emit E0793. We do not support
+        // unaligned fields since `Init::__init` requires an aligned pointer; the call to
+        // `ptr::write` below has the same requirement.
         // SAFETY:
         // - the field is not structurally pinned, since the line above must compile,
         // - the field has been initialized,
@@ -1391,6 +1399,10 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
             unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
         }
 
+        // NOTE: the field accessor ensures that the initialized field is properly aligned.
+        // Unaligned fields will cause the compiler to emit E0793. We do not support
+        // unaligned fields since `Init::__init` requires an aligned pointer; the call to
+        // `ptr::write` below has the same requirement.
         #[allow(unused_variables)]
         // SAFETY:
         // - the field is not structurally pinned, since no `use_data` was required to create this
@@ -1431,6 +1443,10 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
             // SAFETY: The memory at `slot` is uninitialized.
             unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
         }
+        // NOTE: the field accessor ensures that the initialized field is properly aligned.
+        // Unaligned fields will cause the compiler to emit E0793. We do not support
+        // unaligned fields since `Init::__init` requires an aligned pointer; the call to
+        // `ptr::write` below has the same requirement.
         // SAFETY:
         // - the project function does the correct field projection,
         // - the field has been initialized,

base-commit: 4a2b0ed2ac7abe9743e1559d212075a0ebac96b3
-- 
2.53.0


