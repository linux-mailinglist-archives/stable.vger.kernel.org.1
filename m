Return-Path: <stable+bounces-214319-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLJbLLxug2lNmwMAu9opvQ
	(envelope-from <stable+bounces-214319-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:07:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCCCE9E64
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBB9231C6812
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E5A2D6611;
	Wed,  4 Feb 2026 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i98tz17q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2A519E96D;
	Wed,  4 Feb 2026 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219293; cv=none; b=NHs4k0qq39TV949CWKgyYBL96FXLulf1/B0YciigjLr01dnS44fHr5TGk3HvO/YxJwvDvJLoh/H/UcCpo8NYdbU3F09cAters26rB6Ps6qtz7euz1FMNjaDNURHJ+f8XcJ/GYrvng6t3xqYpyPW6MU8CJhnEtVRyzzmrYhrIdls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219293; c=relaxed/simple;
	bh=5KpP/PhRPy8Qy/5UB7otTC/JHlziHkIwWvkN0uNBWP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/6NAEZfpI46ObCItopwbIUs0dY8xmPExM5dqIIIO5lbv8HXsY/oKh9RtKDBy6qU+TDoLOaK062AbmUdXaJIcvj+Lufg8+tMwA2mk5Kdk1skZpIUFGxk8+804KYHPAzdaecAC1/02jYq6zHrOwmC2EZDhDlKohVXQgGY5hRvzPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i98tz17q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99ECBC4CEF7;
	Wed,  4 Feb 2026 15:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770219293;
	bh=5KpP/PhRPy8Qy/5UB7otTC/JHlziHkIwWvkN0uNBWP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i98tz17qu2uwcyDwPNntrtlysrP1FV0oS0fo8iu6eyzRAJuwZfntrD7D92iMG6PgT
	 wF0xvDpI2DcNwiD0wrfd+pnY/m81yLQJJk/HHG1ri1qXxZ190ixgRu5DPWHPwKfSRY
	 znzAwEvzs8Ow11XfOcxMkkSfNrKVVEXCa22tIvfA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	SeungJong Ha <engineer.jjhama@gmail.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Jesung Yang <y.j3ms.n@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.18 098/122] scripts: generate_rust_analyzer: fix resolution of #[pin_data] macros
Date: Wed,  4 Feb 2026 15:41:20 +0100
Message-ID: <20260204143855.375498698@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
References: <20260204143851.857060534@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-214319-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,garyguo.net];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,garyguo.net:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 1DCCCE9E64
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: SeungJong Ha <engineer.jjhama@gmail.com>

commit e440bc5c190cd0e5f148b2892aeb1f4bbbf54507 upstream.

Currently, rust-analyzer fails to properly resolve structs annotated with
`#[pin_data]`. This prevents IDE features like "Go to Definition" from
working correctly for those structs.

Add the missing configuration to `generate_rust_analyzer.py` to ensure
the `pin-init` crate macros are handled correctly.

Signed-off-by: SeungJong Ha <engineer.jjhama@gmail.com>
Fixes: d7659acca7a3 ("rust: add pin-init crate build infrastructure")
Cc: stable@vger.kernel.org
Tested-by: Tamir Duberstein <tamird@kernel.org>
Acked-by: Tamir Duberstein <tamird@kernel.org>
Acked-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Jesung Yang <y.j3ms.n@gmail.com>
Link: https://patch.msgid.link/20260123-fix-pin-init-crate-dependecies-v2-1-bb1c2500e54c@gmail.com
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/generate_rust_analyzer.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -192,7 +192,7 @@ def generate_crates(srctree, objtree, sy
             append_crate(
                 name,
                 path,
-                ["core", "kernel"],
+                ["core", "kernel", "pin_init"],
                 cfg=cfg,
             )
 



