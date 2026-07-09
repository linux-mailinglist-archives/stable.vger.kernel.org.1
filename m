Return-Path: <stable+bounces-273013-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xmqIGJriT2rmpgIAu9opvQ
	(envelope-from <stable+bounces-273013-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 20:04:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD877341A4
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 20:04:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RxepG8Na;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273013-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273013-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8C1430193A7
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 18:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507842E7631;
	Thu,  9 Jul 2026 18:04:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221A84195BB
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 18:04:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783620248; cv=none; b=mVuKE4zOqfmQAdt1GZ3sXY9Mx91SMW20MduXm0tIOISr2Z8tBk8+LCZPEfUMmHT+xbeXS5rtG+AEeko9/WqV1BK54N6R5KDtpGzlzGjgna+DK7EwCIV3RlNvqkgfJwrjS/A1EFLtyijvX057EvJ4TPZCbi4VREaZren23D8pYVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783620248; c=relaxed/simple;
	bh=PogOSVAIok8EGg3dUWCHYf7X5cUIeqnLtT+v1VBeLx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9IQ/qxxsRFV33NZJ3LqCr3+pAIVM/QgD7OyTI4uaO6++lDie6KKLElqK8wA/K0zHaEOIppPrsanf0I84vWhmD7lPsg2mMr3H2YMt45Fi6oWEhJF9RlaXPYF7S2uFDIODKKc+XgOVXpaLaJxakYerJFz82fCOyVdow7aDFfDY7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxepG8Na; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA901F000E9;
	Thu,  9 Jul 2026 18:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783620246;
	bh=n+IHVAT80tKNiUROUiPt6GsLCCudN114SFEwlxpoqXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RxepG8NaTc670VvJsEgcur4ZoNcg/EYnccb/V4UBvktZFbweQUhu0x0CbSJlTsyGF
	 4jyJlkUJ/dgzuDBGAtOpsJTfiuN30ifzuBEBkKie4tQ0qdZquNqcx/iUYKd54ZptbR
	 PA13wC4Xie7T6ai1TGdmoE29X0DPTQ3u3/lVFRjukgRfHj39fEnpAF0IFa4eBUR2wD
	 YUJNZhxp127siN/Qwc7ATgUhze5+W8ALANEZKZyuQf8Lf67l9BZNIPDHKGXnmDwA6U
	 cOqGQdEDRrZcMqklm5pR/IX94BSUwXlNrxQf/buZzUP4aD+27M835R4/NnV2TRZLsQ
	 CUPh6MQW3uwug==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org
Cc: Alice Ryhl <aliceryhl@google.com>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.12.y] rust: kasan: KASAN+RUST requires clang
Date: Thu,  9 Jul 2026 20:03:59 +0200
Message-ID: <20260709180359.130168-1-ojeda@kernel.org>
In-Reply-To: <2026070939-unworldly-mantra-5611@gregkh>
References: <2026070939-unworldly-mantra-5611@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-273013-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ojeda@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:aliceryhl@google.com,m:gary@garyguo.net,m:ojeda@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojeda@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,garyguo.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFD877341A4

From: Alice Ryhl <aliceryhl@google.com>

Kernel KASAN involves passing various llvm/gcc specific arguments to
the C and Rust compiler. Since these arguments differ between llvm and
gcc, it's not safe to mix an llvm-based rustc with a gcc build when
kasan is enabled.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Cc: stable@vger.kernel.org
Fixes: e3117404b411 ("kbuild: rust: Enable KASAN support")
Link: https://patch.msgid.link/20260408-kasan-rust-sw-tags-v3-1-e07964d14363@google.com
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
(cherry picked from commit 5b271543d0f08e9733d4732721e960e285f6448f)
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index f4b91b1857bf..53eba5cd88ff 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1974,6 +1974,7 @@ config RUST
 	depends on !CFI_CLANG || HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC
 	select CFI_ICALL_NORMALIZE_INTEGERS if CFI_CLANG
 	depends on !CALL_PADDING || RUSTC_VERSION >= 108100
+	depends on !KASAN || CC_IS_CLANG
 	depends on !KASAN_SW_TAGS
 	depends on !(MITIGATION_RETHUNK && KASAN) || RUSTC_VERSION >= 108300
 	help
-- 
2.55.0


