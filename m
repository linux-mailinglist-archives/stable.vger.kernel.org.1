Return-Path: <stable+bounces-221765-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAjUL3+oo2mWJAUAu9opvQ
	(envelope-from <stable+bounces-221765-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:46:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 397961CDE74
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68826305B2BD
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C822F39A7;
	Sun,  1 Mar 2026 01:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaMZYgfM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5612D9798;
	Sun,  1 Mar 2026 01:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329083; cv=none; b=mIeyaANsR3Rp8AbwqslqbZKEcNMmmiJaudIJ+vIqQVsls4F6Db88ybyKkDDpqKU8Lft98ABWAJEq0LxkgAb9wuqo2KBfypZNY4mPLQZHD7HsrYNQ7hH4yEgZY9LTBJOqtNW8iWkCwHBxNxjkBW3+Kkur6frw8kFlK0g7B0fj33U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329083; c=relaxed/simple;
	bh=qIZG7MMXRmedZlrLHNVgyp0PIjaX3N7tmpvi8z+WHNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uQe0kvKTLQ8GM2sW7EY0E4cgl94VTFHu1Lb69ODMNpdvbasi/UowpR2wQ3A2NyP+RvNi3rF6k79gtFAUKDAeu+6g/BRSqGqq6uMRydvF3xD66UaOL8or3EdA5jmPL/7CdBcCq0X5JFpsZDM9fA0e6u4dk2o/+i8ylH/NTg+ziRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaMZYgfM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64ADC19421;
	Sun,  1 Mar 2026 01:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329083;
	bh=qIZG7MMXRmedZlrLHNVgyp0PIjaX3N7tmpvi8z+WHNc=;
	h=From:To:Cc:Subject:Date:From;
	b=AaMZYgfMmKqYyTCkLe40WZ0Fb3hCIvhk3sdcf540l/kZEpF6c4lKUojyHseiVNp22
	 PYnNPUhilBl4ZxDY5K+kEMssATC5L3GUsCeEkJFH50VbThcW3JjIn1ayWzFaVCDV3j
	 fQnim0PRHkW3hG0fGDbYTU6VMkm5MjLK+04z9F25Z/hYt5c9d60VF/IeNxZZd8ikQ6
	 9Le2QZmVmmmohcT/j4ssJY6t7BUt9OhQI8Q9VTLdwX9fgVQjFWdkHJSCW3XGgA7EMV
	 gO7JdznbJ5e5jT11yXNTnnqTkcLMj0F2GxkkFmBKRORNVJpI6+7aeL45S2C3l8lnTQ
	 kLT0HEh9Wj3jQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ojeda@kernel.org
Cc: David Wood <david@davidtw.co>,
	Wesley Wiser <wwiser@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	rust-for-linux@vger.kernel.org
Subject: FAILED: Patch "rust: kbuild: pass `-Zunstable-options` for Rust 1.95.0" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:38:01 -0500
Message-ID: <20260301013801.1698337-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davidtw.co,gmail.com,garyguo.net,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-221765-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,davidtw.co:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 397961CDE74
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
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





