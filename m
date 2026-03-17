Return-Path: <stable+bounces-226295-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOn+GAaIuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226295-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:57:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B836E2AEB23
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F8DA3197688
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39533F54A4;
	Tue, 17 Mar 2026 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hiQV7M0U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A789C3F23AA;
	Tue, 17 Mar 2026 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766073; cv=none; b=bcS1gs7EAjFcEp1I5T6JliUBcelSDKoV8MIvAV0nfW74HU2gC3YjN8mgOJQtZzobeGWq95YcLcwWctjph8k3YwYzqXgUyR4Wbj8yxMZCwTSwh4LaV+d6y7NiTErM14e12JjVEG0lDvOpIJKfZal3HydTJ0nGATuESWS75MITRfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766073; c=relaxed/simple;
	bh=mEfdfgDyB68Nc4LfIWLHAsp4mmi6DIq/BPrhni5ldlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZmroCrpATdkFicD8BfV8a0P7NcXu3iLZD8ZtpLxcn5jctrE8ycEenIKrqWW01yZ5t0fxBZjZ8tfbHoZwaaxPaeL0eM3GZvPcA6Ci7s5UxtPNIQCil75TjJFq/V6cTOCjebzla4XD/cWKWSkKp5JsSvRro+7RBuLT70fSL7D/HZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hiQV7M0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF66C4CEF7;
	Tue, 17 Mar 2026 16:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766073;
	bh=mEfdfgDyB68Nc4LfIWLHAsp4mmi6DIq/BPrhni5ldlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hiQV7M0UJeVaBILX9uReh9pS4dJ+e9xtbRGJuS04NK3WKu1+PNfBF+3ga7n7e1/oz
	 rNO2r1arROJpZnQTOU2vPeLBgwpGIA5zT+GQIXxsW+aMOs6jLPaMloQeLK8GmzrHIH
	 fQB2HyWKEc6Y2ZjshclbO/5aORQvbWXGxqjq5k3c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.19 131/378] rust: kbuild: emit dep-info into $(depfile) directly
Date: Tue, 17 Mar 2026 17:31:28 +0100
Message-ID: <20260317163011.834763682@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_HAS_CURRENCY(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-226295-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,zulipchat.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B836E2AEB23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gary Guo <gary@garyguo.net>

commit e174dd14bf0beac811a5201e370ab26ce8c67f23 upstream.

After commit 295d8398c67e ("kbuild: specify output names separately for
each emission type from rustc"), the preferred pattern is to ask rustc to
emit dependency information into $(depfile) directly, and after commit
2185242faddd ("kbuild: remove sed commands after rustc rules"), the
post-processing to remove comments is no longer necessary as fixdep can
handle comments directly. Thus, emit dep-info into $(depfile) directly and
remove the mv and sed invocation.

This fixes the issue where a non-ignored .d file is emitted during
compilation and removed shortly afterwards.

[ Like Gary mentioned in Zulip, this likely happened due to rebasing
  the builds part of the old `syn` work I had. - Miguel ]

Reported-by: Onur Özkan <work@onurozkan.dev>
Closes: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/syn.20artifact.20being.20tracked.20by.20git/with/575467879
Fixes: 7dbe46c0b11d ("rust: kbuild: add proc macro library support")
Signed-off-by: Gary Guo <gary@garyguo.net>
Tested-by: Onur Özkan <work@onurozkan.dev>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260224072957.214979-1-gary@garyguo.net
[ Reworded for a couple of typos. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 rust/Makefile |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/rust/Makefile
+++ b/rust/Makefile
@@ -509,11 +509,9 @@ quiet_cmd_rustc_procmacrolibrary = $(RUS
       cmd_rustc_procmacrolibrary = \
 	$(if $(skip_clippy),$(RUSTC),$(RUSTC_OR_CLIPPY)) \
 		$(filter-out $(skip_flags),$(rust_common_flags) $(rustc_target_flags)) \
-		--emit=dep-info,link --crate-type rlib -O \
+		--emit=dep-info=$(depfile) --emit=link=$@ --crate-type rlib -O \
 		--out-dir $(objtree)/$(obj) -L$(objtree)/$(obj) \
-		--crate-name $(patsubst lib%.rlib,%,$(notdir $@)) $<; \
-	mv $(objtree)/$(obj)/$(patsubst lib%.rlib,%,$(notdir $@)).d $(depfile); \
-	sed -i '/^\#/d' $(depfile)
+		--crate-name $(patsubst lib%.rlib,%,$(notdir $@)) $<
 
 $(obj)/libproc_macro2.rlib: private skip_clippy = 1
 $(obj)/libproc_macro2.rlib: private rustc_target_flags = $(proc_macro2-flags)



