Return-Path: <stable+bounces-222182-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yP3nAd6eo2lzIgUAu9opvQ
	(envelope-from <stable+bounces-222182-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:05:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 746AB1CCE0C
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E6BB30AE786
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98102FDC20;
	Sun,  1 Mar 2026 01:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UN5v+89d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4E42F6596;
	Sun,  1 Mar 2026 01:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330104; cv=none; b=VcpMZ2FKB6iUkVbr1guXkOmT8NdX9T+jBd3aUBbP7cUXq4FVvJpb0ZuM7HQKTqNkFv5ROs+2bCR58x2RFoYUke8eV5hoEhhD46tRbSLzrcfgRJ9RgtkfUb2XmwAkvs8ceaAXn3H9oXg5uLtg69PKFlKOqLhu1U8zhTEfPbUgNS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330104; c=relaxed/simple;
	bh=4LkAhYQkxRnyaUYBdBY8Jf7ufPw2u8PPFxuJBUsRjZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cziUG1FuU5hDkjsxw7A0SN/OkKdPUSoNphgXEBygwJmdpO3HthjLVx4knSPrMAHSthoNZebK7q7B0UvM7BBI3If1WO4U2FIlUN99tOFdzOUG2SELouwdGWCQ34hGAVKfj1UK+O524ANNuul7nIJuq2fjHSruuSB2T0PIw/r/oXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UN5v+89d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D3AC19421;
	Sun,  1 Mar 2026 01:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330104;
	bh=4LkAhYQkxRnyaUYBdBY8Jf7ufPw2u8PPFxuJBUsRjZ8=;
	h=From:To:Cc:Subject:Date:From;
	b=UN5v+89dV1mCnIiZNlDLmtqAS2d1WSBKUSaLnoHlD9VzkOdwPwcFGVkFfeWB4p9GQ
	 EwJPsPiacRwobq2sEIKLB0nproOA4FukS2UiaGwfMeXl8073RR/AEqtycokEz1iRkw
	 1Cr9DD0dyY7wwQGEUKbuM/QAAadAMhko/5Bgpwbqtvd6CBUtSY8jfWYGVcxWwuPnrJ
	 SdF6WyhVUhLqt/OvaYpob6xMRtqvIDOtq/I/FjRYcpIgdfmQCBQZ+J1sb3bdECs93Y
	 6lpPJ9strYh8nTKrSX1czEpwAz5MA34kqszPsBycNuqMIGgV0nqOR7gjYf3iI+C22D
	 Zb/sBUWnl9mFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ojeda@kernel.org
Cc: David Wood <david@davidtw.co>,
	Wesley Wiser <wwiser@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	rust-for-linux@vger.kernel.org
Subject: FAILED: Patch "rust: kbuild: pass `-Zunstable-options` for Rust 1.95.0" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:55:02 -0500
Message-ID: <20260301015502.1722156-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davidtw.co,gmail.com,garyguo.net,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-222182-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,garyguo.net:email,davidtw.co:email]
X-Rspamd-Queue-Id: 746AB1CCE0C
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0a9be83e57de0d0ca8ca4ec610bc344f17a8e5e7 Mon Sep 17 00:00:00 2001
From: Miguel Ojeda <ojeda@kernel.org>
Date: Fri, 6 Feb 2026 21:45:35 +0100
Subject: [PATCH] rust: kbuild: pass `-Zunstable-options` for Rust 1.95.0

Custom target specifications are unstable, but starting with Rust 1.95.0,
`rustc` requires to explicitly pass `-Zunstable-options` to use them [1]:

    error: error loading target specification: custom targets are unstable and require `-Zunstable-options`
      |
      = help: run `rustc --print target-list` for a list of built-in targets

David (Rust compiler team lead), writes:

   "We're destabilising custom targets to allow us to move forward with
    build-std without accidentally exposing functionality that we'd like
    to revisit prior to committing to. I'll start a thread on Zulip to
    discuss with the RfL team how we can come up with an alternative
    for them."

Thus pass it.

Cc: David Wood <david@davidtw.co>
Cc: Wesley Wiser <wwiser@gmail.com>
Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Link: https://github.com/rust-lang/rust/pull/151534 [1]
Reviewed-by: Gary Guo <gary@garyguo.net>
Tested-by: Gary Guo <gary@garyguo.net>
Link: https://patch.msgid.link/20260206204535.39431-1-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/rust/Makefile b/rust/Makefile
index 4dcc2eff51cb2..725158740fc6f 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -552,6 +552,8 @@ $(obj)/$(libpin_init_internal_name): private rustc_target_flags = --cfg kernel
 $(obj)/$(libpin_init_internal_name): $(src)/pin-init/internal/src/lib.rs FORCE
 	+$(call if_changed_dep,rustc_procmacro)
 
+# `rustc` requires `-Zunstable-options` to use custom target specifications
+# since Rust 1.95.0 (https://github.com/rust-lang/rust/pull/151534).
 quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L $@
       cmd_rustc_library = \
 	OBJTREE=$(abspath $(objtree)) \
@@ -562,6 +564,7 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
 		--crate-type rlib -L$(objtree)/$(obj) \
 		--crate-name $(patsubst %.o,%,$(notdir $@)) $< \
 		--sysroot=/dev/null \
+		-Zunstable-options \
 	$(if $(rustc_objcopy),;$(OBJCOPY) $(rustc_objcopy) $@) \
 	$(cmd_objtool)
 
-- 
2.51.0





