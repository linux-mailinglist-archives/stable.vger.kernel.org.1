Return-Path: <stable+bounces-220442-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB04HvY6o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220442-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:59:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A42A51C67AF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A45D530E068C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14013B6415;
	Sat, 28 Feb 2026 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eL8RNLzo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E033B640A;
	Sat, 28 Feb 2026 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300331; cv=none; b=gGsvFz/8FXZo4p03zjoqm7M2mTBPoYfwJ4j2fCPNPM8w2QXMP+G2/+n6vbQ36Pr3M8JWPrhosnH1Q0J0xdHh3tBhkXNsEH476FUSbbMjWSnBMuPPPdyC2cGxS1VrvBc45HmvFRCcR7wt/dXcOvpaXszDKMZ+DZWb6cUvlOamEmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300331; c=relaxed/simple;
	bh=ghFaaLmJj1iPLJhplCjQVJwlTyugZcyZZUzRtfbzkyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNYF9VyRFj9iEjx5OhJ00T+T84DH+gwRRupjoVa1hAWoAhYIiyCekC9NeZcTCoGHKJDU47TUOfYME0mBX3HbUnK8I0yqUvXY2dQTFqBVJMcViFOethVU5+z9Awlnc2fZIfj/xCi6fZWnp0LUftUupyYsfQLAVPI9ULqKKE6pxY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eL8RNLzo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFB6C19424;
	Sat, 28 Feb 2026 17:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300331;
	bh=ghFaaLmJj1iPLJhplCjQVJwlTyugZcyZZUzRtfbzkyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eL8RNLzo5jcpaNmrGe+3E9NdCDw+ZAoHkqueHgsX0U9ukBZpOl+ffTGsVWwsfVlFA
	 RHRL7uOZBJvBFOjnyuufzzYSFpxYldR8FEn2cNzld48Xu/KSwaDFj4TLE39ZhKDIAk
	 klf1SKy/LnjTmJch2BYsDFsqlj7ZZIKdVIX8xrFH4DUwhDfVy0nDC12SYUQ+IcKUrn
	 u0QHxDyrO64URhrxXpkCpy/l5kozb31kpQMEhsG/cDw3PI2yJCaJJYBq5dCrIWLAvx
	 XWGzRP8YTKtDtM6G2ujWSoe7xtZ2ZsrQy9JVKBs1h8yID93RWN92edKN4SpxMkLArK
	 aqKlX1pN+g4KA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Palmer <daniel@thingy.jp>,
	Greg Ungerer <gerg@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 363/844] m68k: nommu: fix memmove() with differently aligned src and dest for 68000
Date: Sat, 28 Feb 2026 12:24:36 -0500
Message-ID: <20260228173244.1509663-364-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220442-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,thingy.jp:email]
X-Rspamd-Queue-Id: A42A51C67AF
X-Rspamd-Action: no action

From: Daniel Palmer <daniel@thingy.jp>

[ Upstream commit 590fe2f46c8698bb758f9002cb247ca10ce95569 ]

68000 has different alignment needs to 68020+.
memcpy() checks if the destination is aligned and does a smaller copy
to fix the alignment and then critically for 68000 it checks if the
source is still unaligned and if it is reverts to smaller copies.

memmove() does not currently do the second part and malfunctions if
one of the pointers is aligned and the other isn't.

This is apparently getting triggered by printk. If I put breakpoints
into the new checks added by this commit the first hit looks like this:

memmove (n=205, src=0x2f3971 <printk_shared_pbufs+205>, dest=0x2f3980 <printk_shared_pbufs+220>) at arch/m68k/lib/memmove.c:82

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
Signed-off-by: Greg Ungerer <gerg@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/m68k/lib/memmove.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/m68k/lib/memmove.c b/arch/m68k/lib/memmove.c
index 6519f7f349f66..e33f00b02e4c0 100644
--- a/arch/m68k/lib/memmove.c
+++ b/arch/m68k/lib/memmove.c
@@ -24,6 +24,15 @@ void *memmove(void *dest, const void *src, size_t n)
 			src = csrc;
 			n--;
 		}
+#if defined(CONFIG_M68000)
+		if ((long)src & 1) {
+			char *cdest = dest;
+			const char *csrc = src;
+			for (; n; n--)
+				*cdest++ = *csrc++;
+			return xdest;
+		}
+#endif
 		if (n > 2 && (long)dest & 2) {
 			short *sdest = dest;
 			const short *ssrc = src;
@@ -66,6 +75,15 @@ void *memmove(void *dest, const void *src, size_t n)
 			src = csrc;
 			n--;
 		}
+#if defined(CONFIG_M68000)
+		if ((long)src & 1) {
+			char *cdest = dest;
+			const char *csrc = src;
+			for (; n; n--)
+				*--cdest = *--csrc;
+			return xdest;
+		}
+#endif
 		if (n > 2 && (long)dest & 2) {
 			short *sdest = dest;
 			const short *ssrc = src;
-- 
2.51.0


