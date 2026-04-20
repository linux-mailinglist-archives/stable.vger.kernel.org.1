Return-Path: <stable+bounces-239942-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FYxHiFc5mmtvAEAu9opvQ
	(envelope-from <stable+bounces-239942-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:02:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EC143069D
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEE97312FCEB
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EFE341ADF;
	Mon, 20 Apr 2026 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Djk62cDk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2E434107F
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776702315; cv=none; b=lllLeSxMTGuApoPBAOlgdq1wn76wNUlmOQpYxTO+Zo/IE62Do/IlebgyYsBETBPZUMgzxQu8xtNZDl6lCoGAXQ98ZfgYL6QSFYNEHv21QNDSdxdIIlhguwQ4j2L+WpCG3F28QstacGLTnMe0/gG0KUAuvkQBfiIwZWPioj3hT50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776702315; c=relaxed/simple;
	bh=nkikaXbuQw00EBqlS6zJ4SxfxibN+blVhL323O1n/3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwLz7Vriads2kYjCehZvnIiJWe9aGYfeMz1B/439SwtF+JUU+RQpeB5QaQKlgV0w7wjKY/EyHYquQEae3nmV6Bv7AGTincoV3peu9ZIsxtuFdKcn7pbEON0s2mdUc9pop64lyPiL3nYRdmAaduMuPW8Ivto5Yhb9+QIcVX5pKKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Djk62cDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399BDC19425;
	Mon, 20 Apr 2026 16:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776702314;
	bh=nkikaXbuQw00EBqlS6zJ4SxfxibN+blVhL323O1n/3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Djk62cDkewi+7L0V1eqLYdTkWQZYd4u9lnSdx0vQ6uUnv4n/zXV7VFpnM9KM050sC
	 78t7GqIOpljL/ox5laQ9RgIPqhPDSLgP6BNrxh7KIrtcT+UxviVWazDYFQYVXcKy6B
	 fh48MxT5kWvYgaBwB7TwkkHNoKei87W3GQZQD6UT8MtNea1YRnmNWLohY4x0bk+8nd
	 eI7u3g1ExUEC6dUoaXH+5H8NOFBbnCvpwoUpUZVN8FUnDLVNiVvTuVA6V9dgt8Gfv5
	 yX8N2DRi/4QRJuWUes7FU6FYsCCNvA1PnG8PVEg8BO9Y+VQQbR7OJ5xN1Nqz67lt3W
	 RF+JwVnX40pfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tamir Duberstein <tamird@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Fiona Behrens <me@kloenk.dev>,
	Trevor Gross <tmgross@umich.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] scripts: generate_rust_analyzer.py: define scripts
Date: Mon, 20 Apr 2026 12:25:12 -0400
Message-ID: <20260420162512.1267976-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042047-drizzly-oblivious-029f@gregkh>
References: <2026042047-drizzly-oblivious-029f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239942-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,umich.edu:email,kloenk.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4EC143069D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 scripts/generate_rust_analyzer.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 99d5b177a43c6..92534fafdf564 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -119,6 +119,18 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
         "exclude_dirs": [],
     }
 
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
             return f"{target}.o" in open(build_file).read()
@@ -134,7 +146,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     for folder in extra_dirs:
         for path in folder.rglob("*.rs"):
             logging.info("Checking %s", path)
-            name = path.name.replace(".rs", "")
+            name = path.stem
 
             # Skip those that are not crate roots.
             if not is_root_crate(path.parent / "Makefile", name) and \
-- 
2.53.0


