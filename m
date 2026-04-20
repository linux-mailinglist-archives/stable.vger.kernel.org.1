Return-Path: <stable+bounces-239889-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GJfO3hR5mkDuwEAu9opvQ
	(envelope-from <stable+bounces-239889-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:16:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E63642F3F3
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C953230444C1
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7813451C1;
	Mon, 20 Apr 2026 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lugG4VVg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5391633F5A9
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701474; cv=none; b=RmbcwF/mtCpUHBdA5mUw5fLFgXvR+5wYg7TvQYXwlicSe12kJl7Wz4ojAYRx8qxZhtDjcLgnt/hDZ6JQ+VCLaG7pO2+AoVJKoo1/Kn2lB/ubprXe3O0/jY5sp0sTNWXnkvfLBUk8kqJFAz2XkNEG+1bNI5rqR9SchErctKLxjfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701474; c=relaxed/simple;
	bh=jcoSa8x2PcdksFgJAnlmWynJ243zWlqOmyp/AvGrsu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6fY1FNFQVmKhbg68zvNVac3B/GYF1+bKlbSyRWjN77w048ZBaaxLs4DqFvGmtbgXCBhub9z1aXFBFyMi9laVdnagFQ1VjFJcRX7dk1IL6Ywig0Hn8y2+eKrpPXU7OSkiSTUSCGHeZFCwnvsBglAySCdvLMR8ViYwy2DAbIqfL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lugG4VVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF30C2BCB7;
	Mon, 20 Apr 2026 16:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776701474;
	bh=jcoSa8x2PcdksFgJAnlmWynJ243zWlqOmyp/AvGrsu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lugG4VVgkWmDpHpvi2PeMrNs/DwF4D0ahBwKC/v1FnFRfjn26YCSZ1r/+nTHmjhNJ
	 t9BBMNhjSUaekZpVVVC5rwKZMgfGxQHKpWsv/05vsccFX5HzJPJ6RMJovuWntNMsZV
	 GuXporLHFhtNOnwgzE4Zc9s4gIFmhghafemUmnsmCk4bJrqpG368PU43hDK62ry2i9
	 VhRCDS/GJXV2j4kczIsg/lIMwnDSw/rxNJC/VUaMiixeQ4MBA5LE4a7ATuCiJS65MO
	 QZ8GWT+GM4cgb1tfPPJTnxZD4346Ozzu50AeJzn5EMSuJWEhwrSrP6UV32O/PS8K8I
	 VDuMfPg2tvXbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tamir Duberstein <tamird@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Fiona Behrens <me@kloenk.dev>,
	Trevor Gross <tmgross@umich.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] scripts: generate_rust_analyzer.py: define scripts
Date: Mon, 20 Apr 2026 12:11:12 -0400
Message-ID: <20260420161112.1235394-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042046-anime-babied-0905@gregkh>
References: <2026042046-anime-babied-0905@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239889-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,kloenk.dev:email,umich.edu:email]
X-Rspamd-Queue-Id: 8E63642F3F3
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
index bfb350a77fbb6..8a7813e49f474 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -144,6 +144,18 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs, core_edit
     append_crate_with_generated("uapi", ["core", "ffi"])
     append_crate_with_generated("kernel", ["core", "macros", "build_error", "ffi", "bindings", "uapi"])
 
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
@@ -159,7 +171,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs, core_edit
     for folder in extra_dirs:
         for path in folder.rglob("*.rs"):
             logging.info("Checking %s", path)
-            name = path.name.replace(".rs", "")
+            name = path.stem
 
             # Skip those that are not crate roots.
             if not is_root_crate(path.parent / "Makefile", name) and \
-- 
2.53.0


