Return-Path: <stable+bounces-211262-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BiPAAhecmnbjAAAu9opvQ
	(envelope-from <stable+bounces-211262-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 18:27:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D766B41F
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 18:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57DAA302D0CF
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 17:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364B936654E;
	Thu, 22 Jan 2026 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWE2eawu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99C33542E7;
	Thu, 22 Jan 2026 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100813; cv=none; b=Pz+PHcJfrz1odnfPVZUQFCX8fe58lwouFOXSw4LWtfO58XHH+K7OOoppTVa5R5t+/Hyhxv8TaFksleNRzry20Ae+KVhUkHDeoUOAmT+YCoFGsRtmHDlL14f3VMHb4ujrt5BEtvsETV4kxxWH3s3BOUw7LI8dj+xDmSJMkKn+BAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100813; c=relaxed/simple;
	bh=OJ/kYHFaOJ7fdfw7JgN5gowIHgz75A3DM0HCQzH3wxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OKT5NpP/MgVds+1fIt8i+jKBfoJSp+1q+QlJ3VHFy2Z90apGOH/PTQkP4CKHa6V3W7MahsmGd/HwOm2IvKOXe5y7v1ELVf+kjGpwuOG7YVUnbU1ZJhaVxoR/PHdbbeARuoMmQFPgQDtSWDon4pjTEnRuJsgcWDttOjQA5P3/Ye4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWE2eawu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2B6C116C6;
	Thu, 22 Jan 2026 16:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769100812;
	bh=OJ/kYHFaOJ7fdfw7JgN5gowIHgz75A3DM0HCQzH3wxU=;
	h=From:Date:Subject:To:Cc:From;
	b=cWE2eawuFVspph/zCAu3bnq5AtzAQ82MA6U1aLPaWTDsOeB1PL7e3bqVJJu7FrocB
	 M3jiUS4YbMmhbWEAG4oQOUCPTm4PLeWNtFsIo3X6Vg8eX3PQPOj6MGcfOw+zcWhBIl
	 cpiRLNYsFmoqHxi2/Dxg24FKShhAa77CUj+RUlKv+pqr8FU97cBpLe/Ts8dL3o8v9f
	 TuwpUebt2riv26W3S6LE0nXEJyPbplsaBnt/SgDYhwWW2vUSwm0NrHF2Fwa8sdPwod
	 smoOUTgPab5a4X8ecMZfcsR6zV8pY5QZEwz5VY6k9DD3UMQNfzH93HLqk46eUXU4/2
	 OXm4Tp+9kCKCw==
From: Tamir Duberstein <tamird@kernel.org>
Date: Thu, 22 Jan 2026 11:53:28 -0500
Subject: [PATCH] scripts: generate_rust_analyzer.py: define scripts
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-rust-analyzer-scripts-v1-1-ff6ba278170e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CMBBA4auQWTsJLQmIVzEuSp3qEFLJTCH8h
 Ltbcfkt3ttBSZgUbsUOQjMrf2KGuRTg3y6+CPmZDba0dWmsRZk0oYtuWDcSVC88JsWqpbqpXGu
 uIUBuR6HAy/m9P/7WqevJp98MjuML0Orzn3kAAAA=
X-Change-ID: 20260122-rust-analyzer-scripts-39e673a918ff
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Kees Cook <kees@kernel.org>, 
 David Gow <davidgow@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>, 
 Fiona Behrens <me@kloenk.dev>, Tamir Duberstein <tamird@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1769100810; l=2147;
 i=tamird@kernel.org; h=from:subject:message-id;
 bh=OJ/kYHFaOJ7fdfw7JgN5gowIHgz75A3DM0HCQzH3wxU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEr3PGDj7bLaKyJrOcqk+8hQO/8EZs8o8J1YuEQV1+/6jMhfubMo3m69MtDIb3OtMWojlqKUSlE
 +DF3T9Uq55Qo=
X-Developer-Key: i=tamird@kernel.org; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211262-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamird@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kloenk.dev:email,umich.edu:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,collabora.com:email]
X-Rspamd-Queue-Id: 77D766B41F
X-Rspamd-Action: no action

Generate rust-project.json entries for scripts written in Rust.

Use `Pathlib.path.stem` for consistency.

Fixes: 9a8ff24ce584 ("scripts: add `generate_rust_target.rs`")
Cc: stable@vger.kernel.org
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 scripts/generate_rust_analyzer.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 3b645da90092..650535f2228d 100755
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
+            deps=["std"],
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

---
base-commit: 2af6ad09fc7dfe9b3610100983cccf16998bf34d
change-id: 20260122-rust-analyzer-scripts-39e673a918ff

Best regards,
--  
Tamir Duberstein <tamird@kernel.org>


