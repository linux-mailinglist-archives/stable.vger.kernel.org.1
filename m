Return-Path: <stable+bounces-213208-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHJQFnbvgWlAMwMAu9opvQ
	(envelope-from <stable+bounces-213208-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 13:52:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8F9D960B
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 13:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10FCE307D7C6
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 12:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8189634026B;
	Tue,  3 Feb 2026 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rYBK3oKA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45245284B2F
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122658; cv=none; b=ktyeRUhW9MRNaJxIml/D1iN3roWjnqOcwHUoL8CjJd2XHLoQcwBcknHOExK5v6MLgCdyPJ0QXoplsNd686c54DoByGS7aHA9yar7ER7WZjp6ARfh82ZVAYEjzzaOQXKCu978ed7ub+pcTF7xNCHpj6Fi2nL8dpO6jLGjbY3LCJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122658; c=relaxed/simple;
	bh=/O2jF1rWdvlEOVrHSfUrq1wiT/M3YZ8CbNxS3YNPLmw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZBzNzTgNkJ/+5H6v3EYXKiQMk6d3UFyV5e9aQySeN90DINs4pt67Cp3tQnvSu0660drJcjAJJJoWZhGDLYUpnLTmWFpX/SCqBvrcCUxoWe6wjt85ErVb0U2oVEoGnwR9xysDQzof/+cTvO41KvTEc4GcdrGOWys9FFGll5cpdNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rYBK3oKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B12C116D0;
	Tue,  3 Feb 2026 12:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770122658;
	bh=/O2jF1rWdvlEOVrHSfUrq1wiT/M3YZ8CbNxS3YNPLmw=;
	h=Subject:To:Cc:From:Date:From;
	b=rYBK3oKACZuHI1ng4pniXxi5yaACZMR0gOLs/9JTOE28AtpulqsjMlyQdLgPHsLi5
	 cXeoOqszrrg2gMbVZctcvh2OeU3EVin0pTDn9iFj+clyc8nIDz0LRiGJI8x4NlxCDb
	 compaeI9QCB9sfbY6eBuprMkx/7eU/IVmmlvPjKg=
Subject: FAILED: patch "[PATCH] rust: kbuild: give `--config-path` to `rustfmt` in `.rsi`" failed to apply to 6.1-stable tree
To: ojeda@kernel.org,aliceryhl@google.com,gary@garyguo.net,nathan@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Feb 2026 13:44:14 +0100
Message-ID: <2026020314-retool-immobile-ceeb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213208-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,linuxfoundation.org:dkim,rust-lang.org:url,msgid.link:url,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA8F9D960B
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x af20ae33e7dd949f2e770198e74ac8f058cb299d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026020314-retool-immobile-ceeb@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From af20ae33e7dd949f2e770198e74ac8f058cb299d Mon Sep 17 00:00:00 2001
From: Miguel Ojeda <ojeda@kernel.org>
Date: Thu, 15 Jan 2026 19:38:32 +0100
Subject: [PATCH] rust: kbuild: give `--config-path` to `rustfmt` in `.rsi`
 target

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

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 5037f4715d74..0c838c467c76 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -356,7 +356,7 @@ $(obj)/%.o: $(obj)/%.rs FORCE
 quiet_cmd_rustc_rsi_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
       cmd_rustc_rsi_rs = \
 	$(rust_common_cmd) -Zunpretty=expanded $< >$@; \
-	command -v $(RUSTFMT) >/dev/null && $(RUSTFMT) $@
+	command -v $(RUSTFMT) >/dev/null && $(RUSTFMT) --config-path $(srctree)/.rustfmt.toml $@
 
 $(obj)/%.rsi: $(obj)/%.rs FORCE
 	+$(call if_changed_dep,rustc_rsi_rs)


