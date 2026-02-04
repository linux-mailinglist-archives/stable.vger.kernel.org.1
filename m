Return-Path: <stable+bounces-214308-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JLvOXlug2lNmwMAu9opvQ
	(envelope-from <stable+bounces-214308-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:06:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E91FE9DE3
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 147013123A94
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C64331A808;
	Wed,  4 Feb 2026 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MJPRyNBm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405D22D6611;
	Wed,  4 Feb 2026 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219256; cv=none; b=VgzGCFxRBWR7t9eMxfsTsITvUfxSl7mFBaoXutl6Oy2U3EIGAfE5WcxzBs5QoWbBPTIFy0gFX9q4WzGcTk+ew7fEUEbdLcIYhftO30HA26OicVb/WFb4u29+7JmSYPvbV85jcZ/nJ5Hc8BBsw6HGStfIvJbIqfbJ+bewgmysdwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219256; c=relaxed/simple;
	bh=tC0/JykFEAq1hp6fU3CHCCNH9dRe+uuLy1cgQEZiALk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WgLSZIZRiZjFYsMwsrQrhtTX7+oB/4cNP68OxlaBaydRO9B75cRruYX7VwrOnmAcQhDFdMRzs10uWeujA/LtzABlM+4nACU5BEU4LGX+nStRFG5GP6zeF8O2uIf2tZUffJT63Fc/qiBH4YObySo6xYRTDABcnAo2yK37CHYUiCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MJPRyNBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A352FC4CEF7;
	Wed,  4 Feb 2026 15:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770219256;
	bh=tC0/JykFEAq1hp6fU3CHCCNH9dRe+uuLy1cgQEZiALk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MJPRyNBmZ3crtLSFcg0EdeooztETeccxVaKHaBMLWxsR5heuBwJTvVjZOGJx9+PkC
	 EuPF/GVZRAsqy70Ww20nRnQk2DBbMXTUwTRW0jYtmV8gqm+yVwc2Q94YxRUk+k+trb
	 foysa67AluSjURelsqQj4qtnsalUMqlFUUKozMbk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.18 096/122] scripts: generate_rust_analyzer: remove sysroot assertion
Date: Wed,  4 Feb 2026 15:41:18 +0100
Message-ID: <20260204143855.304969699@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214308-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,garyguo.net:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,onurozkan.dev:email,zulipchat.com:url]
X-Rspamd-Queue-Id: 3E91FE9DE3
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -192,9 +192,6 @@ def main():
         level=logging.INFO if args.verbose else logging.WARNING
     )
 
-    # Making sure that the `sysroot` and `sysroot_src` belong to the same toolchain.
-    assert args.sysroot in args.sysroot_src.parents
-
     rust_project = {
         "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src, args.exttree, args.cfgs, args.core_edition),
         "sysroot": str(args.sysroot),



