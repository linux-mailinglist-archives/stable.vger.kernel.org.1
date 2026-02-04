Return-Path: <stable+bounces-214058-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wItVNtRmg2nQmQMAu9opvQ
	(envelope-from <stable+bounces-214058-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:33:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42729E8DE6
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E8D030AFA2C
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361114266A4;
	Wed,  4 Feb 2026 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iodbU7bo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEF84266AF;
	Wed,  4 Feb 2026 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218421; cv=none; b=D+DTYnzvM3KjEyIMcbCxciPSuKzrSF2lOTcCmfkSEEotkOpFDzEn7EBb5Xn8aHoRpzbmkywvbDIe3o0tS8puMsnl9PbOgm+KgpI46RWSQH/7aYbg//ZfZ3duerhJW4qQuMnUxdd8T5mhFnexvzjzyh5KwDenwYta1VSLC17PdS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218421; c=relaxed/simple;
	bh=O8quuI1XRNkbxFGvEKhL0zpHIGof1iAsQSiXDAR6xck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olER61rl88YS0SIjyPlL3BssNc21utN3R+tKhYokk6EMgrwjOAoYMvqkLdnxr5yYgRva+BxRtuVOgBUHo2IYtsR7a/7x52cGU/u6AwYZU5YFtjG51ClsN7HAoQpT17rmF3RiWFEDpSIGj0E29SerwmcH/o7FioYCRIlk8LLLa/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iodbU7bo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CED0C19425;
	Wed,  4 Feb 2026 15:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218420;
	bh=O8quuI1XRNkbxFGvEKhL0zpHIGof1iAsQSiXDAR6xck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iodbU7bor51N7jGPVeOUFbcYJTEEpc+9QGcR6PfGZSjCtAQ7c6EBL0veIyP5qfQgY
	 sI1fzS59W2Bl/41O/CKx0ukycuPkaM7oo98+42e0MknMIS7glaRnIVmauy7tx250pm
	 S8+jbgCjuPYg+sJAVob3/hyS2dXUCWSs/CQI9mS4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alice Ryhl <aliceryhl@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.6 25/72] rust: kbuild: give `--config-path` to `rustfmt` in `.rsi` target
Date: Wed,  4 Feb 2026 15:40:28 +0100
Message-ID: <20260204143846.536861062@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143845.603454952@linuxfoundation.org>
References: <20260204143845.603454952@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214058-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rust-lang.org:url]
X-Rspamd-Queue-Id: 42729E8DE6
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miguel Ojeda <ojeda@kernel.org>

commit af20ae33e7dd949f2e770198e74ac8f058cb299d upstream.

`rustfmt` is configured via the `.rustfmt.toml` file in the source tree,
and we apply `rustfmt` to the macro expanded sources generated by the
`.rsi` target.

However, under an `O=` pointing to an external folder (i.e. not just
a subdir), `rustfmt` will not find the file when checking the parent
folders. Since the edition is configured in this file, this can lead to
errors when it encounters newer syntax, e.g.

    error: expected one of `!`, `.`, `::`, `;`, `?`, `where`, `{`, or an operator, found `"rust_minimal"`
      --> samples/rust/rust_minimal.rsi:29:49
       |
    28 | impl ::kernel::ModuleMetadata for RustMinimal {
       |                                               - while parsing this item list starting here
    29 |     const NAME: &'static ::kernel::str::CStr = c"rust_minimal";
       |                                                 ^^^^^^^^^^^^^^ expected one of 8 possible tokens
    30 | }
       | - the item list ends here
       |
       = note: you may be trying to write a c-string literal
       = note: c-string literals require Rust 2021 or later
       = help: pass `--edition 2024` to `rustc`
       = note: for more on editions, read https://doc.rust-lang.org/edition-guide

A workaround is to use `RUSTFMT=n`, which is documented in the `Makefile`
help for cases where macro expanded source may happen to break `rustfmt`
for other reasons, but this is not one of those cases.

One solution would be to pass `--edition`, but we want `rustfmt` to
use the entire configuration, even if currently we essentially use the
default configuration.

Thus explicitly give the path to the config file to `rustfmt` instead.

Reported-by: Alice Ryhl <aliceryhl@google.com>
Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")
Cc: stable@vger.kernel.org
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://patch.msgid.link/20260115183832.46595-1-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/Makefile.build |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -294,7 +294,7 @@ $(obj)/%.o: $(src)/%.rs FORCE
 quiet_cmd_rustc_rsi_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
       cmd_rustc_rsi_rs = \
 	$(rust_common_cmd) -Zunpretty=expanded $< >$@; \
-	command -v $(RUSTFMT) >/dev/null && $(RUSTFMT) $@
+	command -v $(RUSTFMT) >/dev/null && $(RUSTFMT) --config-path $(srctree)/.rustfmt.toml $@
 
 $(obj)/%.rsi: $(src)/%.rs FORCE
 	$(call if_changed_dep,rustc_rsi_rs)



