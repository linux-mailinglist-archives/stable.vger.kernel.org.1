Return-Path: <stable+bounces-211261-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDqAHgtccmn5iwAAu9opvQ
	(envelope-from <stable+bounces-211261-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 18:19:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C596B0DB
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 18:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFFB5301874D
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 17:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB08938B7DB;
	Thu, 22 Jan 2026 16:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTxLINgN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ACD1E0DD8;
	Thu, 22 Jan 2026 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100279; cv=none; b=YkyQYw2GOuTGQ1q80wMZcCzBhHwSfnW9wPQHfftWwo57I11xOuNW/yiZNbq8ZNjgDIQXCvuDmRjP422BRoJIxcxqf+E8oo9beenyhHz8bpRwt3S1FVsdDu4IJ00JRd4eLksOa/A0CIAQ516PfYu/WIWTCEkQMbMgJ4BakXrQz38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100279; c=relaxed/simple;
	bh=JC52RpmU/eEqAbLLOYq4VyCvG0i40uK2mOQjuoMBLUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E58LmkXgKkFJcpyBv5N9KS7+6hkZXxHez2sYHDvj3m2MpstajUwO6enyI6SiMHCeWU7r9X4rWEe3nbtKixwZjlQrvwWVPGUbzFJ4uUJh8uBsQgLIGgcAd2bDt1B3sCimGuPz0q6gRY2CZk48OMufXlTOewYOM/H2rdVBQ2aTScY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTxLINgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AA5C116C6;
	Thu, 22 Jan 2026 16:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769100277;
	bh=JC52RpmU/eEqAbLLOYq4VyCvG0i40uK2mOQjuoMBLUM=;
	h=From:Date:Subject:To:Cc:From;
	b=pTxLINgN0aMgtL7ViUw1cB7hYh7W3Byn5q6oaUBA8O4IJLcUYJzUq7oTZm7c2gdnQ
	 6X2DagrtVWEjkQ/7HqHaxXSo7a+P4A8jDDA/JGvFmdzW+PWY0U9hUXBAy90+CpLtCo
	 fDn/53MBBMa9vRVp7exjEAt33DWmQfnanKYxUL9Nd7N5cM9OOp7UrfbUgD8GoPugzA
	 f76+IEs7H/mplkYE5mL31vjRfr5B5XUrB2uyRcwjnxcUV9q6RVVi7y1MxJGDDJtKVj
	 AuncnVAvXGH253mSrfbQaH+K/9N2r2MNbFwfcKRRq3upN5JIjY5dVvXv9wt6CIie7Q
	 +f/8EtCyzxGlA==
From: Tamir Duberstein <tamird@kernel.org>
Date: Thu, 22 Jan 2026 11:44:33 -0500
Subject: [PATCH] scripts: generate_rust_analyzer.py: avoid FD leak
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-rust-analyzer-fd-leak-v1-1-945577813b20@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CQAxA0auQrmkyVDMar2JYDEzRKhlJCwYk3
 N0Rl2/x/wrGKmxwKVZQfovJK2VUZQHtPaQbo8RsIEfeVUSok40YUuiXDyt2EXsOT2zoeDofXPT
 eM+R2UO5k3r/X+m+bmge3428G2/YFIIjSMnkAAAA=
X-Change-ID: 20260122-rust-analyzer-fd-leak-b247830d666e
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Fiona Behrens <me@kloenk.dev>, Boris-Chengbiao Zhou <bobo1239@web.de>
Cc: Kees Cook <kees@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1769100275; l=1288;
 i=tamird@kernel.org; h=from:subject:message-id;
 bh=JC52RpmU/eEqAbLLOYq4VyCvG0i40uK2mOQjuoMBLUM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAogqhziJkc867yHN5uGBWLh5t4PjCYlX/rtV4VUjJOmhXaNlTxTZocYgIGPgOGKjd3DvmaDPvb
 DP8Xut9+y8A4=
X-Developer-Key: i=tamird@kernel.org; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211261-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,kloenk.dev,web.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,umich.edu:email,kloenk.dev:email]
X-Rspamd-Queue-Id: E1C596B0DB
X-Rspamd-Action: no action

Use a context manager to avoid leaking file descriptors.

Fixes: 8c4555ccc55c ("scripts: add `generate_rust_analyzer.py`")
Cc: stable@vger.kernel.org
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 scripts/generate_rust_analyzer.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 3b645da90092..5ed375c8aa3f 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -190,7 +190,8 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs, core_edit
 
     def is_root_crate(build_file, target):
         try:
-            return f"{target}.o" in open(build_file).read()
+            with open(build_file) as f:
+                return f"{target}.o" in f.read()
         except FileNotFoundError:
             return False
 

---
base-commit: 2af6ad09fc7dfe9b3610100983cccf16998bf34d
change-id: 20260122-rust-analyzer-fd-leak-b247830d666e

Best regards,
--  
Tamir Duberstein <tamird@kernel.org>


