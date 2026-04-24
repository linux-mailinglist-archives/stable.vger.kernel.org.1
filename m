Return-Path: <stable+bounces-240686-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGsmIQxx62nCMwAAu9opvQ
	(envelope-from <stable+bounces-240686-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:33:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEBE45F151
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87AC0300651E
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E000B19A288;
	Fri, 24 Apr 2026 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rCVwYDn8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A392823645D;
	Fri, 24 Apr 2026 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037577; cv=none; b=J2B+Hj7pDQvzfTrawnE5XhSJoXG69GENvaAfw0cDgFroorD4gMO9egRqDZZrVC6wSROnQ/FUpgd4zkB8e3F4yTMc6oRCEnbv5VGVU4f0VnFy8x0JrlgG2oLhNhawgVdYuH6YXDcBAopm/PTIzmgHvIMxCcF+3iEac6YJKsqAvNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037577; c=relaxed/simple;
	bh=cTLfbK3NsKSqZ0kOMB2s4yL/ca+kZ5NOYIeoaLdkXrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3SD3A57loHOdc2LUyyqkYvw00b4z3u6/TtdUJ3FEVqZjY1SukRExmPH/9ZvGh01V0uQdrUXG6TfR8HluMsVybiVEyzpJT1eOAPnIeSXkjv+j0Kw9U6Nf8rFbWtHrKGnCyqrPSZITHKeqzx+rEWozslYIZAvlmF3qi95HE7rF0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rCVwYDn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07114C2BCB2;
	Fri, 24 Apr 2026 13:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777037577;
	bh=cTLfbK3NsKSqZ0kOMB2s4yL/ca+kZ5NOYIeoaLdkXrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rCVwYDn8PEs9iLzU81TM9di2V1RAxwsZAtfqexAwGkF1REajPcOAX+RXOBfokCC7x
	 I0I1Mv04ot3SpvnstuzmQpXHySQyWByhWAoh//Xgku0T08BUKab+WL/kzI7FLZR5+U
	 QxiWN6Hss0/tOahJ9lAXEF2ozhDp7NxUSEJ77z5M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Fiona Behrens <me@kloenk.dev>,
	Trevor Gross <tmgross@umich.edu>,
	Tamir Duberstein <tamird@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 08/42] scripts: generate_rust_analyzer.py: define scripts
Date: Fri, 24 Apr 2026 15:30:33 +0200
Message-ID: <20260424132422.185744295@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132420.410310336@linuxfoundation.org>
References: <20260424132420.410310336@linuxfoundation.org>
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
X-Rspamd-Queue-Id: CBEBE45F151
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240686-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,collabora.com:email,umich.edu:email]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tamir Duberstein <tamird@kernel.org>

[ Upstream commit 36c619f6bd793493294becb10a02fea370b67a91 ]

Add IDE support for host-side scripts written in Rust. This support has
been missing since these scripts were initially added in commit
9a8ff24ce584 ("scripts: add `generate_rust_target.rs`"), thus add it.

Change the existing instance of extension stripping to
`pathlib.Path.stem` to maintain code consistency.

Fixes: 9a8ff24ce584 ("scripts: add `generate_rust_target.rs`")
Cc: stable@vger.kernel.org
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Link: https://patch.msgid.link/20260122-rust-analyzer-scripts-v1-1-ff6ba278170e@kernel.org
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
[ changed `[std]` dep to `["std"]` and kept untyped `is_root_crate()` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/generate_rust_analyzer.py |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -188,6 +188,18 @@ def generate_crates(srctree, objtree, sy
     append_crate_with_generated("uapi", ["core", "ffi", "pin_init"])
     append_crate_with_generated("kernel", ["core", "macros", "build_error", "pin_init", "ffi", "bindings", "uapi"])
 
+    scripts = srctree / "scripts"
+    makefile = (scripts / "Makefile").read_text()
+    for path in scripts.glob("*.rs"):
+        name = path.stem
+        if f"{name}-rust" not in makefile:
+            continue
+        append_crate(
+            name,
+            path,
+            ["std"],
+        )
+
     def is_root_crate(build_file, target):
         try:
             contents = build_file.read_text()
@@ -204,7 +216,7 @@ def generate_crates(srctree, objtree, sy
     for folder in extra_dirs:
         for path in folder.rglob("*.rs"):
             logging.info("Checking %s", path)
-            name = path.name.replace(".rs", "")
+            name = path.stem
 
             # Skip those that are not crate roots.
             if not is_root_crate(path.parent / "Makefile", name) and \



