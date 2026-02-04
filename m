Return-Path: <stable+bounces-214195-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GPwMs9og2kbmgMAu9opvQ
	(envelope-from <stable+bounces-214195-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:42:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B914E9285
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5033310F590
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D43029BD80;
	Wed,  4 Feb 2026 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MOQ2vvPa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F032417E0;
	Wed,  4 Feb 2026 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218882; cv=none; b=azEpiIGGLIuC18bERbL8oeBb/fRbpwgnLeNyvpZSbHcSgH27LudnRlNnkXqppPjng4aa1U69zqWTEyfE66jPzv9EanEkLuKTQNmSunNqduOoaCmGKc1l/DjNQJWx7N7G6T5RIITbyg/7a+Ol4ptVY80D42ES/abjvjmzTJtVZ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218882; c=relaxed/simple;
	bh=u1ArZm6J2hpQHIYTRMoMATHUNEzaN9pzp/h5Rv+sGCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXmqzlgZBhqUjN5Ewl5beP4DGWEl+nTC/DNbjJQu0nN55r+8SRWnlqPDEF6kTM6rBMsuaNwCT2SifdanrpWb4+AmK7ryNu1mB4Suh0FJHzGly05TRJ7OdDm0GOE/ywZ1Qy1uMiYE3b02GtXLGidHYoWXLrDZf31ibrwKCgUXXb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MOQ2vvPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77342C4CEF7;
	Wed,  4 Feb 2026 15:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218881;
	bh=u1ArZm6J2hpQHIYTRMoMATHUNEzaN9pzp/h5Rv+sGCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MOQ2vvPaJgfUnu6LtNBawrnvG9i0YXBa7TM9UoHWG4JpoEkFKxCc8jPu/hsDBmNZn
	 nj/+QmeJzuhhCTWS2cmR4/WxBPCz5FUtLVeppXFzevLAU0TgB39XsyIL2ciRq3wVfY
	 jPw+l7M0Vyl8SwzBqfJxS4P4KN1G7kVjOUbpk/Ls=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.12 56/87] scripts: generate_rust_analyzer: remove sysroot assertion
Date: Wed,  4 Feb 2026 15:40:54 +0100
Message-ID: <20260204143848.934289751@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214195-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zulipchat.com:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 4B914E9285
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Onur Özkan <work@onurozkan.dev>

commit 1b83ef9f7ad4635c913b80ef5e718f95f48e85af upstream.

With nixpkgs's rustc, rust-src component is not bundled
with the compiler by default and is instead provided from
a separate store path, so this assumption does not hold.

The assertion assumes these paths are in the same location
which causes `make LLVM=1 rust-analyzer` to fail on NixOS.

Link: https://rust-for-linux.zulipchat.com/#narrow/stream/x/topic/x/near/565284250
Signed-off-by: Onur Özkan <work@onurozkan.dev>
Reviewed-by: Gary Guo <gary@garyguo.net>
Fixes: fe992163575b ("rust: Support latest version of `rust-analyzer`")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251224135343.32476-1-work@onurozkan.dev
[ Reworded title. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/generate_rust_analyzer.py |    3 ---
 1 file changed, 3 deletions(-)

--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -170,9 +170,6 @@ def main():
         level=logging.INFO if args.verbose else logging.WARNING
     )
 
-    # Making sure that the `sysroot` and `sysroot_src` belong to the same toolchain.
-    assert args.sysroot in args.sysroot_src.parents
-
     rust_project = {
         "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src, args.exttree, args.cfgs, args.core_edition),
         "sysroot": str(args.sysroot),



