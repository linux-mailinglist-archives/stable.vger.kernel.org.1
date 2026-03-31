Return-Path: <stable+bounces-232231-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELZ5FQQGzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232231-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:36:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B699136EF91
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75996308CB37
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6593240710B;
	Tue, 31 Mar 2026 16:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K/f+TgMc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22109425CD5;
	Tue, 31 Mar 2026 16:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976215; cv=none; b=chQohHnGJYrHI5v6t8zK7G0voqaf3tG2xUkr6kyBNzdI4pAMiBTRDIhDeZcwCMXN4yhrqRzN48cLkegn8khEZv3KAFeNQCjuTSmJOGlVKBD/ZVqb2PADi8+/NfQ6up7omDtEh4Z3O0jNT4lJCoGps1B5vmYej8F/36hOnzGrZBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976215; c=relaxed/simple;
	bh=7mlq3QF2JnjfzHpPPVdyR5vyknHPk7PkVQO8VPmbblk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3p2JcFdcE3ciSwqFmvt+diCrkwhJpphdueXmA/lVKK9tQXV2LcKwgGlp1p0l7ANkQRBZ4fqPIr1e3vniZEWbdn2wVw2udMnDiKsHKC1W/DbIPgG4GH3c7fhdowuhh9WGWI6SdM9jhSO/9GWQNfmsPBYIwtnk3wdeF1ltylQ0no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K/f+TgMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A733EC19423;
	Tue, 31 Mar 2026 16:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976215;
	bh=7mlq3QF2JnjfzHpPPVdyR5vyknHPk7PkVQO8VPmbblk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K/f+TgMc+/Z6+nUqKx0W2LqcHKJv2JATfPMcJHFrtBVvZqORX+U81SOxGrqT5TLcR
	 X5fJp2GLNfLvTzxf5ZiTUlImhEPuAhUje+eHJLPdQZJoc+UXsAZn1FCKZEmGs38nfe
	 wpxP6Hkfrw1qyeQieWp5YaISAgyyArGIw2bYdLFQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benno Lossin <lossin@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.12 209/244] rust: pin-init: internal: init: document load-bearing fact of field accessors
Date: Tue, 31 Mar 2026 18:22:39 +0200
Message-ID: <20260331161749.473456466@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232231-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,zulipchat.com:url,garyguo.net:email]
X-Rspamd-Queue-Id: B699136EF91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benno Lossin <lossin@kernel.org>

commit 580cc37b1de4fcd9997c48d7080e744533f09f36 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 rust/kernel/init/macros.rs |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -1231,6 +1231,10 @@ macro_rules! __init_internal {
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
@@ -1270,6 +1274,10 @@ macro_rules! __init_internal {
         // return when an error/panic occurs.
         unsafe { $crate::init::Init::__init(init, ::core::ptr::addr_of_mut!((*$slot).$field))? };
 
+        // NOTE: the field accessor ensures that the initialized field is properly aligned.
+        // Unaligned fields will cause the compiler to emit E0793. We do not support
+        // unaligned fields since `Init::__init` requires an aligned pointer; the call to
+        // `ptr::write` below has the same requirement.
         // SAFETY:
         // - the field is not structurally pinned, since the line above must compile,
         // - the field has been initialized,
@@ -1310,6 +1318,10 @@ macro_rules! __init_internal {
             unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
         }
 
+        // NOTE: the field accessor ensures that the initialized field is properly aligned.
+        // Unaligned fields will cause the compiler to emit E0793. We do not support
+        // unaligned fields since `Init::__init` requires an aligned pointer; the call to
+        // `ptr::write` below has the same requirement.
         #[allow(unused_variables, unused_assignments)]
         // SAFETY:
         // - the field is not structurally pinned, since no `use_data` was required to create this
@@ -1350,6 +1362,10 @@ macro_rules! __init_internal {
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



