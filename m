Return-Path: <stable+bounces-238752-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD9+ORUl5ml1sgEAu9opvQ
	(envelope-from <stable+bounces-238752-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:07:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EE842B3C2
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FD5230B6EB8
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 12:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FF539B966;
	Mon, 20 Apr 2026 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EKFcz1mj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7185D39A04B
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689816; cv=none; b=nlQ5j8nUCa2R65IwH8KY8wEvzfKprnWuaHt0PdTg+uB7SQKt6S2gYd4uPRa5hXV79nG3mOxS7oEK2Keb2eLgrj8xf8jTbU9m51K8hmTM6zQXw8uH8IYrbd4vAT3rAa18VPRadEjMUVPemC0GATu1ntgVyvzpyZXAx1ok4Nc0gr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689816; c=relaxed/simple;
	bh=Ot9BWAH0ju7DUcU2aCxjke22jzqGAms7myFvmdeXF6M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VV3dG4NMbQkVZQfFB6DVfi35d0OmiKRj4CaWfoGrE5tgKbBMmH19T0wmgZeQtONa/IWiwpMttnYuukYGXQrZj35jlb/thfin5/b3I6sSMUDoz3h0So3UWeDhZGdKVgpzi0dBzwrak9yfuCyZqT9Kq3bxAZPFHJPzhMySHGsoRyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EKFcz1mj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCCFC19425;
	Mon, 20 Apr 2026 12:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776689816;
	bh=Ot9BWAH0ju7DUcU2aCxjke22jzqGAms7myFvmdeXF6M=;
	h=Subject:To:Cc:From:Date:From;
	b=EKFcz1mji3IdjqSNNj1ziACOip20t6B+ORVI6r6jvxzUqynV7azHBN9kzHIhf1jDr
	 kGRpKvbD5NfBVVX2Yc5fbzDrRX0/Q+7p/pqICO6XR7KcZr+c4JvN8u0RnzprzH8Tg+
	 EbXD+w3UVDB60witSP4muodRNIwWicWpRyQ6lojw=
Subject: FAILED: patch "[PATCH] scripts: generate_rust_analyzer.py: define scripts" failed to apply to 6.19-stable tree
To: tamird@kernel.org,daniel.almeida@collabora.com,me@kloenk.dev,tmgross@umich.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Apr 2026 14:56:45 +0200
Message-ID: <2026042045-fountain-ebony-21f7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238752-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kloenk.dev:email,collabora.com:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,msgid.link:url]
X-Rspamd-Queue-Id: 49EE842B3C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.19.y
git checkout FETCH_HEAD
git cherry-pick -x 36c619f6bd793493294becb10a02fea370b67a91
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042045-fountain-ebony-21f7@gregkh' --subject-prefix 'PATCH 6.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 36c619f6bd793493294becb10a02fea370b67a91 Mon Sep 17 00:00:00 2001
From: Tamir Duberstein <tamird@kernel.org>
Date: Thu, 22 Jan 2026 11:53:28 -0500
Subject: [PATCH] scripts: generate_rust_analyzer.py: define scripts

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

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 7becc2698c14..38e834bd209e 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -299,6 +299,18 @@ def generate_crates(
         "kernel", [core, macros, build_error, pin_init, ffi, bindings, uapi]
     )
 
+    scripts = srctree / "scripts"
+    makefile = (scripts / "Makefile").read_text()
+    for path in scripts.glob("*.rs"):
+        name = path.stem
+        if f"{name}-rust" not in makefile:
+            continue
+        append_crate(
+            name,
+            path,
+            [std],
+        )
+
     def is_root_crate(build_file: pathlib.Path, target: str) -> bool:
         try:
             return f"{target}.o" in open(build_file).read()
@@ -316,7 +328,7 @@ def generate_crates(
     for folder in extra_dirs:
         for path in folder.rglob("*.rs"):
             logging.info("Checking %s", path)
-            name = path.name.replace(".rs", "")
+            name = path.stem
 
             # Skip those that are not crate roots.
             if not is_root_crate(path.parent / "Makefile", name) and \


