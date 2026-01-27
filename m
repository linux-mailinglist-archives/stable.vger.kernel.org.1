Return-Path: <stable+bounces-211860-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFzVJkXueGkCuAEAu9opvQ
	(envelope-from <stable+bounces-211860-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:56:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C5E980D9
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A77F3047C53
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 16:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E046835B639;
	Tue, 27 Jan 2026 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCOkzOrK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A244E3161B1;
	Tue, 27 Jan 2026 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769531747; cv=none; b=sxtBJc96TKykzaWN2Si9U3RioAACVxmhXN2ExyQd7oX2BFumIVDVH8m3MuW8549/cYd/VvYWY8hd3tzJ8FiEqmiTJYvt3NR5UJHrpJ+VWoswHBFKU/WgZXi8dBQ6TPAt5odh1Yw9QxeJ2l51V0sONVsZVYWvOmddT6vzjgWexXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769531747; c=relaxed/simple;
	bh=cr26WC5/jQYq2j+tJmLcxta5293mWj+TZtRfHWsdvz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=l7gNsI9rIuJdqwNW2qeHkbZzOcqXNmEQd/bNaJ8i6DTY3ctkzZoSdi+aH4dYTBD8iVqm36owK5a90QZvSiqF51GHzh/piAGJN7CMnrtK9iwt9r90Zqm+TeyB4XqBDojN43kiVOGeuTDS2iNUByYdKOEHgdkobb4CIIvDxppuKVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCOkzOrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB818C116C6;
	Tue, 27 Jan 2026 16:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769531747;
	bh=cr26WC5/jQYq2j+tJmLcxta5293mWj+TZtRfHWsdvz4=;
	h=From:Date:Subject:To:Cc:From;
	b=CCOkzOrK25eLLiF0AJA5dN2tM+8+7kFCq8umKj8K69QJ5rSLutuPNVgytpQP38g2K
	 8jU0nNCtCjTMGLkK8zLg2dee/hfxAr8tGzq5t+nDHCMBuZB7cv3TPTIvpJ+UOw2gfA
	 LaUBhPRHixANi5sC81ZnY+uQl77LkEtxTFNEZKwTbqQA0kgk65DM8dCh7KgbHcIc+d
	 o7EbSZjTDU+xa8KTsS9yt2tbw+8PQ6kW9CNQMfw2dJyD3GSMj6FozZGQ6uUDBJQVUy
	 pL46WOWcQA4mYwWuyF5BzrYz/QSKaABiPK8tLM7ZFfG49MAWC40VgAMSJhRRzg369m
	 8fLgsIyoLzv8A==
From: Tamir Duberstein <tamird@kernel.org>
Date: Tue, 27 Jan 2026 11:35:43 -0500
Subject: [PATCH v2] scripts: generate_rust_analyzer.py: avoid FD leak
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-rust-analyzer-fd-leak-v2-1-1bb55b9b6822@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0K6dkw7QEFW3sOwKDBAhRQzBSIS7
 i7gAVy+5P33V+GJLXmRBatgmq23g9sBL4EoW+MaAlvtLFCilgoRePIjGGf65UMMdQU9mQ4KjJI
 0lJXWmsS+fTHV9n12H/mP/VQ8qRyP2GG01o8DL+fxrA7v38esQMEtiuMkSVVYoLx3xI7668CNy
 Ldt+wLY/mCSzQAAAA==
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1769531745; l=1497;
 i=tamird@kernel.org; h=from:subject:message-id;
 bh=cr26WC5/jQYq2j+tJmLcxta5293mWj+TZtRfHWsdvz4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QN65+Zy/TyTBsEhHd95G2H430nlTNkkGyHi46HzKomof5m5D7AfFrLIl9NsboE3ddoPTm6jfO9l
 gJ7bU0hmLrQY=
X-Developer-Key: i=tamird@kernel.org; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211860-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,kloenk.dev,web.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamird@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,kloenk.dev:email,collabora.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,umich.edu:email]
X-Rspamd-Queue-Id: C2C5E980D9
X-Rspamd-Action: no action

Use `pathlib.Path.read_text()` to avoid leaking file descriptors.

Fixes: 8c4555ccc55c ("scripts: add `generate_rust_analyzer.py`")
Cc: stable@vger.kernel.org
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
Changes in v2:
- Use pathlib.Path.read_text. (Levi Zim)
- Drop errant Tested-by tag. (Miguel Ojeda)
- Link to v1: https://patch.msgid.link/20260122-rust-analyzer-fd-leak-v1-1-945577813b20@kernel.org
---
 scripts/generate_rust_analyzer.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 3b645da90092..152bd3705303 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -190,9 +190,10 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs, core_edit
 
     def is_root_crate(build_file, target):
         try:
-            return f"{target}.o" in open(build_file).read()
+            contents = build_file.read_text()
         except FileNotFoundError:
             return False
+        return f"{target}.o" in contents
 
     # Then, the rest outside of `rust/`.
     #

---
base-commit: 2af6ad09fc7dfe9b3610100983cccf16998bf34d
change-id: 20260122-rust-analyzer-fd-leak-b247830d666e

Best regards,
--  
Tamir Duberstein <tamird@kernel.org>


