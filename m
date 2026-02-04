Return-Path: <stable+bounces-214196-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EF8gB55qg2l+mgMAu9opvQ
	(envelope-from <stable+bounces-214196-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:49:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C06EAE96FF
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CBDA03075D3A
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926942417E0;
	Wed,  4 Feb 2026 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AQWDKcdk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561452D5926;
	Wed,  4 Feb 2026 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218885; cv=none; b=lAke4y7NQUMxIVsQbtfjtmhHfnHTk3sYfTZE+m38lHqC7P/wx6CcU7X3YbwWtyJSByFwY3YAM+NF8fzOymKiACUBXlDo5YwbqDsTLGL4AUrv5qy75THg9FzIW5wiTLCzrIiaaE6BC8rbvucf0m5YGQxR+JNO8WpXfvVr+1ba0SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218885; c=relaxed/simple;
	bh=8LQbF5leAVqE4VoIgmNNWccQvpfaW6zvG5eKZgJjlyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIBsQNTgqkM67IrRE/e/OmgGheQ2zsLBRSeBARvNXd4MUyy+CQ+dnn025nT3FuiYOgcoroXGnpwJgxKuQJHDaaxd5uNUfyErcjvPmJ/iPQ3mFviEFlhkNXZvOWPaj/E8N8shvXfp9x7xvOY5ocv5v1IHbZMCGCjfkFpAPkBfLT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AQWDKcdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8992EC4CEF7;
	Wed,  4 Feb 2026 15:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218885;
	bh=8LQbF5leAVqE4VoIgmNNWccQvpfaW6zvG5eKZgJjlyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AQWDKcdkQRYILKJchuamqees1NoSV2SgVLq8DOP+xFr9VtUSq8ws8CpUYeNx9hgbt
	 2QzEu4MY+tUfN18sa3xmazG/3SbjKldc5mHDT8oa5LkgdQyOjP0ffJqc00FhI8Uh/u
	 fOHnt0uk3I60CeJmmBK+JFsudlV8oZckfTGTAeUQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tamir Duberstein <tamird@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.12 57/87] scripts: generate_rust_analyzer: compile sysroot with correct edition
Date: Wed,  4 Feb 2026 15:40:55 +0100
Message-ID: <20260204143848.970149131@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143846.906385641@linuxfoundation.org>
References: <20260204143846.906385641@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-214196-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: C06EAE96FF
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tamir Duberstein <tamird@kernel.org>

commit ac3c50b9a24e9ebeb585679078d6c47922034bb6 upstream.

Use `core_edition` for all sysroot crates rather than just core as all
were updated to edition 2024 in Rust 1.87.

Fixes: f4daa80d6be7 ("rust: compile libcore with edition 2024 for 1.87+")
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260116-rust-analyzer-sysroot-v2-1-094aedc33208@kernel.org
[ Added `>`s to make the quote a single block. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/generate_rust_analyzer.py |   29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -53,7 +53,6 @@ def generate_crates(srctree, objtree, sy
         display_name,
         deps,
         cfg=[],
-        edition="2021",
     ):
         append_crate(
             display_name,
@@ -61,13 +60,37 @@ def generate_crates(srctree, objtree, sy
             deps,
             cfg,
             is_workspace_member=False,
-            edition=edition,
+            # Miguel Ojeda writes:
+            #
+            # > ... in principle even the sysroot crates may have different
+            # > editions.
+            # >
+            # > For instance, in the move to 2024, it seems all happened at once
+            # > in 1.87.0 in these upstream commits:
+            # >
+            # >     0e071c2c6a58 ("Migrate core to Rust 2024")
+            # >     f505d4e8e380 ("Migrate alloc to Rust 2024")
+            # >     0b2489c226c3 ("Migrate proc_macro to Rust 2024")
+            # >     993359e70112 ("Migrate std to Rust 2024")
+            # >
+            # > But in the previous move to 2021, `std` moved in 1.59.0, while
+            # > the others in 1.60.0:
+            # >
+            # >     b656384d8398 ("Update stdlib to the 2021 edition")
+            # >     06a1c14d52a8 ("Switch all libraries to the 2021 edition")
+            #
+            # Link: https://lore.kernel.org/all/CANiq72kd9bHdKaAm=8xCUhSHMy2csyVed69bOc4dXyFAW4sfuw@mail.gmail.com/
+            #
+            # At the time of writing all rust versions we support build the
+            # sysroot crates with the same edition. We may need to relax this
+            # assumption if future edition moves span multiple rust versions.
+            edition=core_edition,
         )
 
     # NB: sysroot crates reexport items from one another so setting up our transitive dependencies
     # here is important for ensuring that rust-analyzer can resolve symbols. The sources of truth
     # for this dependency graph are `(sysroot_src / crate / "Cargo.toml" for crate in crates)`.
-    append_sysroot_crate("core", [], cfg=crates_cfgs.get("core", []), edition=core_edition)
+    append_sysroot_crate("core", [], cfg=crates_cfgs.get("core", []))
     append_sysroot_crate("alloc", ["core"])
     append_sysroot_crate("std", ["alloc", "core"])
     append_sysroot_crate("proc_macro", ["core", "std"])



