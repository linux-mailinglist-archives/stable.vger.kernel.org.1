Return-Path: <stable+bounces-264666-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BGM4FjF9MWq7kgUAu9opvQ
	(envelope-from <stable+bounces-264666-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:43:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5B1692623
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:43:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=oCPCjf78;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264666-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-264666-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC6B1306A18E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722BC3A8746;
	Tue, 16 Jun 2026 16:26:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC7143E4BE;
	Tue, 16 Jun 2026 16:26:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627172; cv=none; b=RxaOM00zIPyjQjfDWUBeTfNYZJ4VOh2fjN34OehvsDYu4DNoNaj3KHBjUJWfBvRSnliGe1k38xWViLIMnz5psTsLZweLMSxH5FTqDZj74a68S5yw2HwXnKen2Dof8ZA3q/MdtRK9ufUr8PKhtDzcz3JgcNq1IJ85pQQetF95mcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627172; c=relaxed/simple;
	bh=LjwjRJbdNt38e+bktAlqdgx47kiG4yJSztD5HueXC4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JolJEyxUMoQpzUiqbbT+7CReV+h9uNymIIzqBQp7bGS2PgQIxgI8yV6xzocrqy0IhMm+czXJE+g81iadz9+PhfEAA2v9htFrdenMuiHh2Ta1VkmZOdhJ/X55n4U0/7xeSD6PnMa2nGedgyMOKby4FvMdLMjLIZ6N9/7S9+IUYsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oCPCjf78; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57051F000E9;
	Tue, 16 Jun 2026 16:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781627170;
	bh=IOZNm7i5TRvqZOWv5DDypzW/TFcn1xGDK2DrGBXJeyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oCPCjf78hLivlu0pLjWIVrVqOurrMhrkufsYDVdl9l1UIwGHVjcj7OV6QJoDmtY8Q
	 vnndQVvgsBAyzjA1DUnSei5U0W5j/ryWD4g+OWyyEQasnG/U9fpFS8p8b2hQxow38S
	 8eSX5QVXp9Nl24sjedHBRKLV+V12U3ZhvqxACOZk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ralf Jung <post@ralfj.de>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.12 129/261] rust: x86: support Rust >= 1.98.0 target spec
Date: Tue, 16 Jun 2026 20:29:27 +0530
Message-ID: <20260616145051.066219578@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264666-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:post@ralfj.de,m:aliceryhl@google.com,m:ojeda@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,msgid.link:url,ralfj.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A5B1692623

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miguel Ojeda <ojeda@kernel.org>

commit 905b06d32a52afe32fcf5f30cf298c9ea6359f11 upstream.

Starting with Rust 1.98.0 (expected 2026-08-20), the target spec will not
support `x86-softfloat` anymore [1]. Instead, `softfloat` should be used,
which is an alias. Otherwise, one gets:

    error: error loading target specification: rustc-abi: invalid rustc abi: 'x86-softfloat'. allowed values: 'x86-sse2', 'softfloat' at line 3 column 32
      |
      = help: run `rustc --print target-list` for a list of built-in targets

Thus conditionally use one or the other depending on the version.

The alias has existed since Rust 1.95.0 (released 2026-04-16) [2], but
use the newer version instead to avoid changing how the build works for
existing compilers, at least until more testing takes place.

Cc: Ralf Jung <post@ralfj.de>
Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Link: https://github.com/rust-lang/rust/pull/157151 [1]
Link: https://github.com/rust-lang/rust/pull/151154 [2]
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://patch.msgid.link/20260530114925.260754-1-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/generate_rust_target.rs |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/scripts/generate_rust_target.rs
+++ b/scripts/generate_rust_target.rs
@@ -194,7 +194,9 @@ fn main() {
         }
     } else if cfg.has("X86_64") {
         ts.push("arch", "x86_64");
-        if cfg.rustc_version_atleast(1, 86, 0) {
+        if cfg.rustc_version_atleast(1, 98, 0) {
+            ts.push("rustc-abi", "softfloat");
+        } else if cfg.rustc_version_atleast(1, 86, 0) {
             ts.push("rustc-abi", "x86-softfloat");
         }
         ts.push(
@@ -234,7 +236,9 @@ fn main() {
             panic!("32-bit x86 only works under UML");
         }
         ts.push("arch", "x86");
-        if cfg.rustc_version_atleast(1, 86, 0) {
+        if cfg.rustc_version_atleast(1, 98, 0) {
+            ts.push("rustc-abi", "softfloat");
+        } else if cfg.rustc_version_atleast(1, 86, 0) {
             ts.push("rustc-abi", "x86-softfloat");
         }
         ts.push(



