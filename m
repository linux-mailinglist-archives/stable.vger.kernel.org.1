Return-Path: <stable+bounces-230332-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAXvGrnew2kgugQAu9opvQ
	(envelope-from <stable+bounces-230332-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 14:10:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E68ED32577B
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 14:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 426A130C7638
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 12:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC413D6496;
	Wed, 25 Mar 2026 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTulG/6S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5081A3C5530;
	Wed, 25 Mar 2026 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774443482; cv=none; b=eMRsGAhPUPnB6VLgmKKsvKMWQnI2ipXOrC5gFTzpJ0RTnA3JdccnjJqeD7gUWGyK+gLmrncgoiIRbOv9dCfsGU1B37KqX7sRWH4u65P91LczGCb8OTmYqMvJSlIA3iWxHLmVFsw+O+iH4f9+HFp2kje2aPo9ZP9gZI4SRzHZRlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774443482; c=relaxed/simple;
	bh=UfnWN285MUfmVLKA6MU77kon2/LGoWZDM0gUkI/WdZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A5d8Z5vAm8ilGHbVWC70Ou0kkQ15chbKMOLowpCwqCMhzjuNjHQSaS0WnLsph9AClOUCNDE/ZR+gcsqmKAj46/nY5t2wWPI6ONare0iIj6vcK9Fs4/C3OQaTX4q2igze24jVmcqC7GG4NEdJGDQWw2Xd1bfTqFwR7R6KK4urXG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTulG/6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF0CC4CEF7;
	Wed, 25 Mar 2026 12:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774443482;
	bh=UfnWN285MUfmVLKA6MU77kon2/LGoWZDM0gUkI/WdZ4=;
	h=From:To:Cc:Subject:Date:From;
	b=sTulG/6SOO0DK+PXudE5JGao6Lp1K7IeslX+1Y8mRZvfxxItOWA6bYzOyFAjY+0vy
	 3CKAeoVJ35hnCLPR8CQEJULgESzmYbMY/z2dCd/DWKSVXVdT+C5uyh2eNTJStPVwyd
	 oO2iyVsoTlXHe1zqD6VdDGjQiXDXK3awqmoROQKt0AJ402ZhVg4PG/xJX12gtS2Jd3
	 9uAwLjGq1vJ7IhjIp3Lugv1d6JtAotcUCjZnG+xsIBYoXIkJd3/e3DjUkI88gjLKnM
	 eJre8fPmxlGCSLAfdh7okr39XUt2Q7VoxeJB9acsj79uRRYbKhbV2FEB5z/V7SJnfU
	 7d3g1rTmA9s7Q==
From: Benno Lossin <lossin@kernel.org>
To: Benno Lossin <lossin@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: stable@vger.kernel.org,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.18.y 1/2] rust: pin-init: internal: init: document load-bearing fact of field accessors
Date: Wed, 25 Mar 2026 13:57:50 +0100
Message-ID: <20260325125753.944918-1-lossin@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230332-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lossin@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zulipchat.com:url,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,garyguo.net:email]
X-Rspamd-Queue-Id: E68ED32577B
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
index d6acf2cd291e..fdf38b4fdbdc 100644
--- a/rust/pin-init/src/macros.rs
+++ b/rust/pin-init/src/macros.rs
@@ -1310,6 +1310,10 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
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
@@ -1349,6 +1353,10 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
         // return when an error/panic occurs.
         unsafe { $crate::Init::__init(init, ::core::ptr::addr_of_mut!((*$slot).$field))? };
 
+        // NOTE: the field accessor ensures that the initialized field is properly aligned.
+        // Unaligned fields will cause the compiler to emit E0793. We do not support
+        // unaligned fields since `Init::__init` requires an aligned pointer; the call to
+        // `ptr::write` below has the same requirement.
         // SAFETY:
         // - the field is not structurally pinned, since the line above must compile,
         // - the field has been initialized,
@@ -1389,6 +1397,10 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
             unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
         }
 
+        // NOTE: the field accessor ensures that the initialized field is properly aligned.
+        // Unaligned fields will cause the compiler to emit E0793. We do not support
+        // unaligned fields since `Init::__init` requires an aligned pointer; the call to
+        // `ptr::write` below has the same requirement.
         #[allow(unused_variables)]
         // SAFETY:
         // - the field is not structurally pinned, since no `use_data` was required to create this
@@ -1429,6 +1441,10 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
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

base-commit: 4aea1dc4cad17cd146072e13b1fd404f32b8b3ef
-- 
2.53.0


