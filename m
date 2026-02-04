Return-Path: <stable+bounces-214320-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HjJOQ5wg2lgmwMAu9opvQ
	(envelope-from <stable+bounces-214320-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:13:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D470EA034
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 700C130267BD
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88A92D6611;
	Wed,  4 Feb 2026 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iwZmT4YQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9B819E96D;
	Wed,  4 Feb 2026 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219296; cv=none; b=mQ3CDLoj87WtABEtNNPAo+SyR+jZR/hCYlwVSWKWLudhAdvVoTMkkTcddX13VEYikUNXJ13Goek41HxGPLS30MMoxHKWyilGMyd6I69pKDfSzoAGSJxL6E1AOgwbcinVNcSE2vq9SuUKiAJAedtU8WAWjzLvz4ahuLBUZo2zAe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219296; c=relaxed/simple;
	bh=nL3NUhHf2dSsL5qnHcF/PqAYj+cN2gxjmziNHXb9WP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ump/AhGEdATPvYrYPpJYR/+ZoMsbpkJPuVEXoE6ooCTDNJpzm9NiaHdKtM/PtyFS09C1c7BTqkzD9GyjbR7qUDnIf/9dapjHUbhTCVTVCzUL32ff6iFD6qrniscOpjOx58mdQR09fX3tnezBYL6PasVoA0ardBzbNgiy5Qa30EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iwZmT4YQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0441C4CEF7;
	Wed,  4 Feb 2026 15:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770219296;
	bh=nL3NUhHf2dSsL5qnHcF/PqAYj+cN2gxjmziNHXb9WP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iwZmT4YQDX7Pqx6qHajB94h2iXYKqEywy+FzDFvHT3H9K678X8q1iUnmb+UwvMj0h
	 8yEhx3rsOMAICUq8Jq4OZ1Kgdy5BNZfeCxybEFfrIEbG0LigVaWIQx7RGHUc5F6k6F
	 Kqc2dKKKgb4lFN11SO2/jZEB+KGkOH2cZ9OfyZbE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tamir Duberstein <tamird@kernel.org>,
	Jesung Yang <y.j3ms.n@gmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.18 099/122] scripts: generate_rust_analyzer: Add compiler_builtins -> core dep
Date: Wed,  4 Feb 2026 15:41:21 +0100
Message-ID: <20260204143855.411224449@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-214320-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 0D470EA034
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tamir Duberstein <tamird@kernel.org>

commit 5157c328edb35bac05ce77da473c3209d20e0bbb upstream.

Add a dependency edge from `compiler_builtins` to `core` to
`scripts/generate_rust_analyzer.py` to match `rust/Makefile`. This has
been incorrect since commit 8c4555ccc55c ("scripts: add
`generate_rust_analyzer.py`")

Signed-off-by: Tamir Duberstein <tamird@kernel.org>
Reviewed-by: Jesung Yang <y.j3ms.n@gmail.com>
Acked-by: Benno Lossin <lossin@kernel.org>
Fixes: 8c4555ccc55c ("scripts: add `generate_rust_analyzer.py`")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250723-rust-analyzer-pin-init-v1-1-3c6956173c78@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/generate_rust_analyzer.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -106,7 +106,7 @@ def generate_crates(srctree, objtree, sy
     append_crate(
         "compiler_builtins",
         srctree / "rust" / "compiler_builtins.rs",
-        [],
+        ["core"],
     )
 
     append_crate(



