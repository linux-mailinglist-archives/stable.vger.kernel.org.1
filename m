Return-Path: <stable+bounces-214325-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HWjArlvg2lgmwMAu9opvQ
	(envelope-from <stable+bounces-214325-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:11:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E92E9FA2
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B19A9306AFD9
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350FD41B34E;
	Wed,  4 Feb 2026 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S0lL9gFU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5DC286890;
	Wed,  4 Feb 2026 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219314; cv=none; b=RLbNF2EeMnmNKC66eHicD+OzDhBQhM5HxNeRjeCM/Vu7EUBnbNSHdo+L+mrtm1djoazo4R1O//Ss1orWb3oPUxy+tHNz0hnPM5mwute+rem0hGNNXcP4IAelyNZgGpG5BaL6uFPZWPwjdUeI4OVCqt5Mv3DUZJTFi/Rj842b+Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219314; c=relaxed/simple;
	bh=UZpKw81lL08Dj7hYLOPj/oqTjkz0jiSQlPH1+uJk+Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swYy7sqCbP2uJxVhLRscD33rIvTVpIJcaSN5L7CrC5rEmN3ntWdaKIZyUoLtZyCL0/44qT1pbKk+aJaE7o/C2FIphbZiwwGUP0ngeKw874LxdfvLvF/OTsJ/IjNdfQMgt08gWCtB/5zni3DspoO4vg1yUjZumLhPdwEm4msnb6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S0lL9gFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34253C4CEF7;
	Wed,  4 Feb 2026 15:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770219313;
	bh=UZpKw81lL08Dj7hYLOPj/oqTjkz0jiSQlPH1+uJk+Rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S0lL9gFUtyshpHoRs6UmBXApMBxjGTaTzTOC/2G3tJXWvLbWL4K3vw6coXJsJu3pB
	 Gw+IyiOD/fKz1BugD2I90pSv4wN/E+2ma4UzDvOUpBqK7atNDzE0r44cRjj6KmIi9O
	 DzfJr0RBnaD9cFvSEcVJnJTk2ObGrylOkNA2ZBuM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tamir Duberstein <tamird@kernel.org>,
	Jesung Yang <y.j3ms.n@gmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.18 094/122] scripts: generate_rust_analyzer: Add pin_init -> compiler_builtins dep
Date: Wed,  4 Feb 2026 15:41:16 +0100
Message-ID: <20260204143855.233218970@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
References: <20260204143851.857060534@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-214325-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47E92E9FA2
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tamir Duberstein <tamird@kernel.org>

commit 98dcca855343512a99432224447f07c5988753ad upstream.

Add a dependency edge from `pin_init` to `compiler_builtins` to
`scripts/generate_rust_analyzer.py` to match `rust/Makefile`. This has
been incorrect since commit d7659acca7a3 ("rust: add pin-init crate
build infrastructure").

Signed-off-by: Tamir Duberstein <tamird@kernel.org>
Reviewed-by: Jesung Yang <y.j3ms.n@gmail.com>
Acked-by: Benno Lossin <lossin@kernel.org>
Fixes: d7659acca7a3 ("rust: add pin-init crate build infrastructure")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250723-rust-analyzer-pin-init-v1-2-3c6956173c78@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/generate_rust_analyzer.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -110,7 +110,7 @@ def generate_crates(srctree, objtree, sy
     append_crate(
         "pin_init",
         srctree / "rust" / "pin-init" / "src" / "lib.rs",
-        ["core", "pin_init_internal", "macros"],
+        ["core", "compiler_builtins", "pin_init_internal", "macros"],
         cfg=["kernel"],
     )
 



