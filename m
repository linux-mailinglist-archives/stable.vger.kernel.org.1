Return-Path: <stable+bounces-225565-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPMmK4gVuGl/YwEAu9opvQ
	(envelope-from <stable+bounces-225565-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:36:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F89129B80C
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F38DF30210FB
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 14:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A283D293B5F;
	Mon, 16 Mar 2026 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xPEmzIGx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65330625
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671691; cv=none; b=ErOTBY9B6/IAso9e4KOjVq+GXzZtLBaEhueCSHnXjD0ORBe8Elr4DW+WO2gKUq+za5gqcaWjXWvx6QwV5BIHaAczIUb81dEUlGoTLnKHOb8MuRqaZSE249bJjQPBsTuTjZzgy+r1g32b/eFsT4sLULA5/rz//0vaMh5z1Xz8mEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671691; c=relaxed/simple;
	bh=OQx/QlYT9mF5PnLi1EVh7UDhwlZMZRh/E402Ag2E0CI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CQRXJ3W5hy3NWrOPsoAaasAoFImV5QtglVgeFV+IMgABTdJ9ZvUHHu7PB46MF5LySDRYS7UbVIaplbXBMb+EVGViP9v6LoeC2OBy1cYolWdB4i0A+aS++gBpF5TDcit9/PXtqoIwmBTAgyvdTK6XsC86rhcQW6kHAPL6ch+ohAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xPEmzIGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BD1C19421;
	Mon, 16 Mar 2026 14:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773671691;
	bh=OQx/QlYT9mF5PnLi1EVh7UDhwlZMZRh/E402Ag2E0CI=;
	h=Subject:To:Cc:From:Date:From;
	b=xPEmzIGxH3uKd2OQDlk2zfsvSshJfGbtYuz9MpzVoT/C8RWb59szHp0wYPSqvfJA5
	 KFbCyi7vquAHND2BJnwYUiQYNrvBiFKxZJmV9pv2CmKK7rOigVv2ALNXucn5IYCQMX
	 eghDGO+BC1B7htQkG3F26gb5l9IErpyHZ5RPPMAA=
Subject: FAILED: patch "[PATCH] rust: pin-init: internal: init: document load-bearing fact of" failed to apply to 6.18-stable tree
To: lossin@kernel.org,gary@garyguo.net,ojeda@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 16 Mar 2026 15:34:34 +0100
Message-ID: <2026031633-recall-abacus-d8e0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225565-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,zulipchat.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,garyguo.net:email]
X-Rspamd-Queue-Id: 4F89129B80C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 580cc37b1de4fcd9997c48d7080e744533f09f36
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031633-recall-abacus-d8e0@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 580cc37b1de4fcd9997c48d7080e744533f09f36 Mon Sep 17 00:00:00 2001
From: Benno Lossin <lossin@kernel.org>
Date: Mon, 2 Mar 2026 15:04:15 +0100
Subject: [PATCH] rust: pin-init: internal: init: document load-bearing fact of
 field accessors

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


