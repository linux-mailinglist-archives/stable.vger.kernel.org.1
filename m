Return-Path: <stable+bounces-239947-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKwuAVxs5mkJwQEAu9opvQ
	(envelope-from <stable+bounces-239947-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:11:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3B84328C2
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C636431BE096
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4703B351C2B;
	Mon, 20 Apr 2026 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wua/p60m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC742FB084
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776703134; cv=none; b=fc+iivhXr312xE3GJOT72a99SVG8f7w0fw6E2hqdVj2oLZCDgktKbZCEaG2RaiErJPl8KlOe2PO4wzve/v2ogH/ZgK5/N3qhVCaTaw+QDUrpIVtHIdPf2dGRW1PXqyvVrN27eHeChPgTO4Dp4Ppal2fI4H3QODWml4agXKroCTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776703134; c=relaxed/simple;
	bh=yO0nvuGE5MYg0HT8s9Hc/jITDIK1SaSt+RH6v8lJk0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLwk/DniHA7fPNe9/vEf+qea42cmIdLhI5t4wI4YD+4uVCyFZxEgwaUIfMeoc3yz7Xg5/W+hJgidwN6tqZubG6o0Rj/F1KOgHRXTBCBYS5df0WiLWF8caFFmiSW+vhOCvruNvb7M4X+g7cPVoglUJBop9O4g5d3besAfOh4biUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wua/p60m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5BAC2BCB3;
	Mon, 20 Apr 2026 16:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776703133;
	bh=yO0nvuGE5MYg0HT8s9Hc/jITDIK1SaSt+RH6v8lJk0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wua/p60mA7oyk5HhA0xrxRlO4AuMKa2cZZHuSEA4qpOMcpKVB+eIkRR2ZKLcFHhuZ
	 yGCj7hEPmCUotnePBoNxD81a/ME8+gpIa4u3BGJKgrJncms7B4HYXngtRzKS4n7d0x
	 QIDFMc/viHi4ins80x9n2RxGNZDe+MHh3IN+O+/axtPpIdBrZDfW+F2TMX0XWQLCNJ
	 JSkbK/j0raiVC49QloFAvIdZfyVHtsYo+RAGb8rlrGSIf3LGDd52C+0tCnnPL6Pyhv
	 CKidKaXZi7xFgzWPvgHt9MpK5it/AH2z4x82tM/1eCejOqHEAEdfAiavmui2+ST1KD
	 KFKgDzyZmjpPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tamir Duberstein <tamird@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Fiona Behrens <me@kloenk.dev>,
	Trevor Gross <tmgross@umich.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] scripts: generate_rust_analyzer.py: define scripts
Date: Mon, 20 Apr 2026 12:38:51 -0400
Message-ID: <20260420163851.1302521-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042047-kissable-reboot-f1bc@gregkh>
References: <2026042047-kissable-reboot-f1bc@gregkh>
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
	TAGGED_FROM(0.00)[bounces-239947-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,umich.edu:email,collabora.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kloenk.dev:email]
X-Rspamd-Queue-Id: 4E3B84328C2
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
index dadb1edf87e76..a789fb3b17e49 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -113,6 +113,18 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
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
@@ -128,7 +140,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     for folder in extra_dirs:
         for path in folder.rglob("*.rs"):
             logging.info("Checking %s", path)
-            name = path.name.replace(".rs", "")
+            name = path.stem
 
             # Skip those that are not crate roots.
             if not is_root_crate(path.parent / "Makefile", name) and \
-- 
2.53.0


