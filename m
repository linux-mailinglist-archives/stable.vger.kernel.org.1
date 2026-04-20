Return-Path: <stable+bounces-239268-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P8mE7Ne5mm3vQEAu9opvQ
	(envelope-from <stable+bounces-239268-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:13:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A46A9430C21
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A76C13338416
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0AE31F9B7;
	Mon, 20 Apr 2026 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOLRObfV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E137432143F
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699022; cv=none; b=OfmDcelLgALAtN6b38rKczTB7nMeZgbiU86NQ05kC1MA3S8f60+LGveGr3/LcP2jg+7IKK5p+NyLj/LRcWBF/20odn05qEJSUCQNRUYDZVAZo7hl10doCzrFBxhnxEEkGM5+V2swG/rHhiOB+fhRI+hlQHocpr1n1EGXErocw/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699022; c=relaxed/simple;
	bh=LXtxkaXvs/P4RPbgzyVl3S8wjVBzmJDRC6NP8SFvqRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B34n+Es8bcKSpi5tTmQqAkTMZpzzoCM3TnVA9Z5g6PcCPoZpmb31J/7DGh2S9wcKiTpHhBrA/YN8dmoQwtSD/pVmGgY5Dgmscc93ucTwJ9JKprRjuR3XYI17JkidFKKowULeSejPBU0kRVIuOBRotOe0X7bfhcaGhrnvxkUKu0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOLRObfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE96C19425;
	Mon, 20 Apr 2026 15:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776699021;
	bh=LXtxkaXvs/P4RPbgzyVl3S8wjVBzmJDRC6NP8SFvqRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EOLRObfVQFvhC9cJPtP4NYKVIhQNYgdsstv5oqnHLjoz6zPqw8wK3/OfCGJYFoCxZ
	 OhAZKYFUweb5NAQpK1DtZhFqHT6nmImZ++QEFv1X6NqOj18228qAaTbe1IKPMO7Qb+
	 eJ/+bNNy/YxdeYGNWzbHwC9WqCcNlyqGFVZg3pWQwY0F3+EGSPrc8oXpRxNs6RBn/x
	 z3KsAFohmbZYr69gfDpAqCOe9ScCt+Xp3WtgZd0AelDVSGGIqpDtHX+OltxjqWR6X9
	 JC4GEzo3/gq/D5Dz+LttJjPI5UBVxwjxwVi298ubjAeqL+g+YxVt/VqA4Mz2dlyuNa
	 F80zyMhKKdm9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tamir Duberstein <tamird@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Fiona Behrens <me@kloenk.dev>,
	Trevor Gross <tmgross@umich.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19.y] scripts: generate_rust_analyzer.py: define scripts
Date: Mon, 20 Apr 2026 11:30:19 -0400
Message-ID: <20260420153019.1164357-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042045-fountain-ebony-21f7@gregkh>
References: <2026042045-fountain-ebony-21f7@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239268-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,umich.edu:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kloenk.dev:email,collabora.com:email]
X-Rspamd-Queue-Id: A46A9430C21
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
index 766c2d91cd811..14a75e183e7b5 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -188,6 +188,18 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs, core_edit
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
             return f"{target}.o" in open(build_file).read()
@@ -203,7 +215,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs, core_edit
     for folder in extra_dirs:
         for path in folder.rglob("*.rs"):
             logging.info("Checking %s", path)
-            name = path.name.replace(".rs", "")
+            name = path.stem
 
             # Skip those that are not crate roots.
             if not is_root_crate(path.parent / "Makefile", name) and \
-- 
2.53.0


