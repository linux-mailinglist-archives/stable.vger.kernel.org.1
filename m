Return-Path: <stable+bounces-220847-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAcYJo5Zo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220847-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:09:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E8E1C8D28
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 078FF3318E62
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB57D495538;
	Sat, 28 Feb 2026 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TchFH1Dz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6C341999D;
	Sat, 28 Feb 2026 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300734; cv=none; b=oTAryC8EI8zP91Xswgv8fgVcJQSp9NWkXD8q2/zelqp9lo7leImQbfpCdmBclJLW0+ZgMTpvTazqlcwdD2up9nsZRbVPTJQIDbNdBhwv53OJp6bZmScwL3OaAly7X4LPL8oLAbB4H6/1D8TQRu5iqC+t0O01jBEq5ZfTU2ubhqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300734; c=relaxed/simple;
	bh=bLVy6HQwsr+8u5KfKcxO8vi0mFCKBljaXDJoAFyc1AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqR46YExXEu8WVyA92caKzFCLBxX40YUjYfehxdywwnL7T9XoadVoy7Wfwq/H5FGzdmXh6IhzuPwwDWr+3DRAeLBTcaWh3lTKeaEMIZImKdybElYtoIWTlnHjdS4vRjoizigDZc0oyUd3EqEHfzk6+BvTpDMnDdO2OjEVjomZEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TchFH1Dz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B16CC2BC87;
	Sat, 28 Feb 2026 17:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300734;
	bh=bLVy6HQwsr+8u5KfKcxO8vi0mFCKBljaXDJoAFyc1AI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TchFH1DzMXabrMAByugtJpVvEgLl2V2nH1CBqo38gStPP8I0Qbjj/H+39gVAUgVCX
	 mb61RfURtguYL5RPa/+Oh0ADTJsabTgIGoV+FciBEq+S+fbmS9jJkIe1wohyDWzt2I
	 E0Mp97//NS4v5ChImb3WivXrkSJPAtxdXM9oSaD5AmTF+1Sg6Oz8r4eawHFIcv3Awp
	 +VFb4FQ6wpJhnnrtvkXS8zxU2gmZENU8lwz0ED9lqkaqR7mxJKt9DrCC5BUxZIHY+Q
	 jVmVvaeGOQcwWA/D1FYkbWaKnyZ3NhQ9c/NOCAB6m4R89a9lxgCQWAlFQJMXh4oCyD
	 Or16ECg24tfhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	David Wood <david@davidtw.co>,
	Wesley Wiser <wwiser@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 768/844] rust: kbuild: pass `-Zunstable-options` for Rust 1.95.0
Date: Sat, 28 Feb 2026 12:31:21 -0500
Message-ID: <20260228173244.1509663-769-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,davidtw.co,gmail.com,garyguo.net];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220847-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,garyguo.net:email,davidtw.co:email]
X-Rspamd-Queue-Id: 01E8E1C8D28
X-Rspamd-Action: no action

From: Miguel Ojeda <ojeda@kernel.org>

[ Upstream commit 0a9be83e57de0d0ca8ca4ec610bc344f17a8e5e7 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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


