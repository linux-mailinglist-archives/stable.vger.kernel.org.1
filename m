Return-Path: <stable+bounces-239763-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH0xLf9Z5mmtvAEAu9opvQ
	(envelope-from <stable+bounces-239763-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:53:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5539D4302BB
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 044A3321B0A4
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E076C33A70A;
	Mon, 20 Apr 2026 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Da0EpII3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44B92C11C6
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701152; cv=none; b=COU5oAZF0UgFxQRnfJWrdhaXWMQ30qBlOvNCL6WWnyME0TnNZw28nq0ohqzHcxr9iCUpqfOyCwhm9cRvOWivbuAKd9wjOWiW4MXhpiJrFdOM/ggpg0hUw7tUyr0dahEPV7rlUAz8BXQjRiUAQ9GcREkx4HZpGSBtSUm2oXQ5Leg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701152; c=relaxed/simple;
	bh=1nWqsysMeAMaMFwnMMoWilObOiKO9FEV91o6ulwwoMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JscpvcGgXKKb6NXI7/w3VpErwAZXPnx9Dk3QRR48PohaY8xrJfbn7V4ssKai82GIik8XlPsVcLW706VML9PHv5pGC53H9GCdgGVUqx+JGuTl0T/RSQp5VjQpKM+yZvHkrX8/NBpqqeOr46akjVg5HKykoqYfYdkpI7YOGuSe7U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Da0EpII3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32C2C2BCB4;
	Mon, 20 Apr 2026 16:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776701152;
	bh=1nWqsysMeAMaMFwnMMoWilObOiKO9FEV91o6ulwwoMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Da0EpII35XQsRxhEqfPusVK24HB5sga7H4/9lTT9kqHjeUFGhgYOxoX3XW3BCEhda
	 ZtoaO0KQxBIs8HnvcV99eR4Q1s+8A/4YztcHi2gRJFYbBUhlk2ELeMSE6FRgVne9PZ
	 aou35yuDut7tPvJWZWRHNoZcl9sexGBje3ZBoRTBIp9FfgJbK4V9WHn2ms2GhZlX9t
	 7vrSc4KOKCxFUyDteV09AOx3a2W45/uShOdc5WVEx1WvZKB/2Fnj0Y7mD0sTALnwu4
	 85tBrWGCrMIb9vwiMDtll+xqmvpBUU9OkBk87l65O4TQFDvUrSaZUEIsMeErEu43gh
	 mAPUqvMbiwTiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tamir Duberstein <tamird@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Fiona Behrens <me@kloenk.dev>,
	Trevor Gross <tmgross@umich.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] scripts: generate_rust_analyzer.py: define scripts
Date: Mon, 20 Apr 2026 12:05:50 -0400
Message-ID: <20260420160550.1184938-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042046-underfeed-riding-d661@gregkh>
References: <2026042046-underfeed-riding-d661@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239763-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,collabora.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,umich.edu:email,kloenk.dev:email]
X-Rspamd-Queue-Id: 5539D4302BB
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
index 852444352657e..1016f857f7be2 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -166,6 +166,18 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs, core_edit
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
@@ -181,7 +193,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs, core_edit
     for folder in extra_dirs:
         for path in folder.rglob("*.rs"):
             logging.info("Checking %s", path)
-            name = path.name.replace(".rs", "")
+            name = path.stem
 
             # Skip those that are not crate roots.
             if not is_root_crate(path.parent / "Makefile", name) and \
-- 
2.53.0


