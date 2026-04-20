Return-Path: <stable+bounces-239510-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEYhBnBh5mmavgEAu9opvQ
	(envelope-from <stable+bounces-239510-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:25:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D52B643123F
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C266323DE72
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657922D77E5;
	Mon, 20 Apr 2026 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ogtYHi79"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AFE3382DE;
	Mon, 20 Apr 2026 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700438; cv=none; b=m/jxniS6FWm4yJCPHXTcz5Bm+UCetK0S/gU+0uRU6GRCI7lObP2+blQ3TmyhgdWM3gm5rH0kcmj6jwHI4CtZmLNDCRLVWlXV4TkvcaA6BtiA5T6R3E4ZrE1WDeJR1pVLbWJhig2IeX/t3/kblm/D5F+J6AbyBv/3QsuUYkAsbJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700438; c=relaxed/simple;
	bh=b2zRrafx/CkRmYV95ZstBDnmjm4RETp5kPlNheqodQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFtx+5e5/cDNl5HXmCbNxDHr2PKKvpEizk2Mlbn+2c8/Kn31x+S8wYBtXbfSvZUsej71Q56rEt6a1o0qkogXeJb9ot4xq9b6U0bShM7mh39GJ/XGBCEIMsVrUEQMOT6KHwzLbuIP+PjKVJOqSoP7PBLEvbEtMzEachG8oGT1w48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ogtYHi79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE903C2BCB4;
	Mon, 20 Apr 2026 15:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700438;
	bh=b2zRrafx/CkRmYV95ZstBDnmjm4RETp5kPlNheqodQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ogtYHi79vfLrOCTK8KbXa1Lp2qVNUD9LcwN5uO+EJE4ormUaLrXv6Ez7Z7DmqkSj9
	 2trD01cmeiTLJLgaQ9tItux0HUZBea+8ILr1mUDPo4BudPZ9gI0IHTejmeN8+gn/3F
	 3mEwlqOz9DcQTHlBc1DspMV2O3E+tn7pgffid10A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Fiona Behrens <me@kloenk.dev>,
	Trevor Gross <tmgross@umich.edu>,
	Tamir Duberstein <tamird@kernel.org>
Subject: [PATCH 6.19 171/220] scripts: generate_rust_analyzer.py: avoid FD leak
Date: Mon, 20 Apr 2026 17:41:52 +0200
Message-ID: <20260420153940.183276434@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239510-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[umich.edu:email,collabora.com:email,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,kloenk.dev:email]
X-Rspamd-Queue-Id: D52B643123F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tamir Duberstein <tamird@kernel.org>

commit 9b4744d8eda2824041064a5639ccbb079850914d upstream.

Use `pathlib.Path.read_text()` to avoid leaking file descriptors.

Fixes: 8c4555ccc55c ("scripts: add `generate_rust_analyzer.py`")
Cc: stable@vger.kernel.org
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Link: https://patch.msgid.link/20260127-rust-analyzer-fd-leak-v2-1-1bb55b9b6822@kernel.org
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/generate_rust_analyzer.py |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -190,9 +190,10 @@ def generate_crates(srctree, objtree, sy
 
     def is_root_crate(build_file, target):
         try:
-            return f"{target}.o" in open(build_file).read()
+            contents = build_file.read_text()
         except FileNotFoundError:
             return False
+        return f"{target}.o" in contents
 
     # Then, the rest outside of `rust/`.
     #



