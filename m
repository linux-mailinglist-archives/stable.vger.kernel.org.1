Return-Path: <stable+bounces-226640-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEqeJqOMuWnkJwIAu9opvQ
	(envelope-from <stable+bounces-226640-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:17:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7B12AF411
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 46E0330748A4
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FAB2DA756;
	Tue, 17 Mar 2026 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xp8nzPPe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5951E2116F6;
	Tue, 17 Mar 2026 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767592; cv=none; b=uhHNQVxTDjdYaosUTqi4mwF37iMHxuXEGh9nrWon2LSjzLjmE589HeAgl+m2QmOrOYal1748kPlJKzp4Dm6CZvoEaKFZ+o9lnw1Djrvt3JOCSbiiZmwoGUuMD/KN3MjgDS7V8bUvLUGJ/5/uGkk6AQMUZ5zObvBTUitlbJZAgxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767592; c=relaxed/simple;
	bh=iibeBrn/3Jix+macebIUjbuAQkdSrUFJkeIiUojg/uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTSDTLcfPK4TTwDv/4vdzPhGZp/BWAtqCHySbIJaG2HbiJ7l4FHjFnM6A/70zLMAizDAlTQyRJ6bk7wtAgr5Q9ssJ/uf77xdBYszK5rXWedStGxyuAJbSQaeFAhuCHxvA7SLrCk9H5mO+Pe7FTgbB+PJeZCcfq9wyKGffv2ib0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xp8nzPPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBFEC4CEF7;
	Tue, 17 Mar 2026 17:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767592;
	bh=iibeBrn/3Jix+macebIUjbuAQkdSrUFJkeIiUojg/uE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xp8nzPPehQMJHD0Vu9nfxJRVq5OVCJXmmEYvZYum5bBZeTOK1pYUy3L44bf3+zxlQ
	 4Y3X+xylXoaYvrjKKMrJwLplff33Zj9YMzHmviw+8DpjyG7f3NAT1FwQ1HgX+FVYmb
	 aCUQ8bMz1Km79FnPU/T8iRyqtOXbYARh5ehLNLSU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.18 119/333] rust: str: make NullTerminatedFormatter public
Date: Tue, 17 Mar 2026 17:32:28 +0100
Message-ID: <20260317163003.780625088@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226640-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,nvidia.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C7B12AF411
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Courbot <acourbot@nvidia.com>

commit 3ac88a9948792b092a4b11323e2abd1ecbe0cc68 upstream.

If `CONFIG_BLOCK` is disabled, the following warnings are displayed
during build:

  warning: struct `NullTerminatedFormatter` is never constructed
    --> ../rust/kernel/str.rs:667:19
      |
  667 | pub(crate) struct NullTerminatedFormatter<'a> {
      |                   ^^^^^^^^^^^^^^^^^^^^^^^
      |
      = note: `#[warn(dead_code)]` (part of `#[warn(unused)]`) on by default

  warning: associated function `new` is never used
    --> ../rust/kernel/str.rs:673:19
      |
  671 | impl<'a> NullTerminatedFormatter<'a> {
      | ------------------------------------ associated function in this implementation
  672 |     /// Create a new [`Self`] instance.
  673 |     pub(crate) fn new(buffer: &'a mut [u8]) -> Option<NullTerminatedFormatter<'a>> {

Fix them by making `NullTerminatedFormatter` public, as it could be
useful for drivers anyway.

Fixes: cdde7a1951ff ("rust: str: introduce `NullTerminatedFormatter`")
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260224-nullterminatedformatter-v1-1-5bef7b9b3d4c@nvidia.com
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 rust/kernel/str.rs |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -880,13 +880,13 @@ impl fmt::Write for Formatter<'_> {
 ///
 /// * The first byte of `buffer` is always zero.
 /// * The length of `buffer` is at least 1.
-pub(crate) struct NullTerminatedFormatter<'a> {
+pub struct NullTerminatedFormatter<'a> {
     buffer: &'a mut [u8],
 }
 
 impl<'a> NullTerminatedFormatter<'a> {
     /// Create a new [`Self`] instance.
-    pub(crate) fn new(buffer: &'a mut [u8]) -> Option<NullTerminatedFormatter<'a>> {
+    pub fn new(buffer: &'a mut [u8]) -> Option<NullTerminatedFormatter<'a>> {
         *(buffer.first_mut()?) = 0;
 
         // INVARIANT:



