Return-Path: <stable+bounces-270023-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gfOmKlYBRGrTnAoAu9opvQ
	(envelope-from <stable+bounces-270023-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 19:48:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B4F6E7064
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 19:48:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=Qyu+K9yj;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270023-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270023-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B17AC3002539
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 17:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAF83DD51F;
	Tue, 30 Jun 2026 17:47:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741DB3A7F5D;
	Tue, 30 Jun 2026 17:47:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782841678; cv=none; b=MnMHYH/ES51KSlcMxOtk6YZRrHY8gtiaCg3wnYZwbub5xh305um72f4WZqXofW83Wv6y5n9u2PRxpuHGNr0/T2etpWn5IymtUXFALvjMW+eQMmF0/WVDDvwotQY6kpEurX3h/Xh9RGnv/MSTvrhgQkgP3sgQON1V8+LIwjM/SK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782841678; c=relaxed/simple;
	bh=I1LOT/OjmutTzc99FoIIzp+e8Ek1SEWElD3tb5rK46g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tA7Z7MtkfH74ofhO2PBj7IaHvFchuRsMYE/9ZMYHBsdx1vx05FqHvgldBZzzkEOCoyDxl/0KbiWK8WE48j3tEkiBR7bMGi5FSnzAgbyq5WMj/PSiIatC8x3LcIPO1FV0ybTgwWL5TY/QZbq3dJFFExmFcqNyLwyYiKKin90s/Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=Qyu+K9yj; arc=none smtp.client-ip=93.190.126.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782841667;
	bh=dgGRZ+lG71CErrgxYbV81iyldDtSI4aGkhmvY2yKvvA=;
	h=From:To:Cc:Subject:Date:From;
	b=Qyu+K9yjTxCg/MicaXwCUoyas1LYGpZB1Q47o951VsDV67o9/MDqdtRD53sjcWWAo
	 crh65Fapw8YWiLaaaZegAxFFI4gfKCb7QrRlo6ijTxJQBFcK4Ge2uEk/ZYVcWVDZXW
	 COr3+qfhETFb+A9zm7FFhRlb70v5si7KQwlx+VKY=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gqVwg0ThBz114Z;
	Tue, 30 Jun 2026 17:47:47 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gqVwf4CcVz115l;
	Tue, 30 Jun 2026 17:47:46 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: akpm@linux-foundation.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH v2] lib/bootconfig: fix undefined behavior involving NULL pointer arithmetic
Date: Tue, 30 Jun 2026 17:47:46 +0000
Message-ID: <20260630174746.14795-1-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[grrlz.net,reject];
	R_DKIM_ALLOW(-0.20)[grrlz.net:s=stigmate];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-270023-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:mhiramat@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:include@grrlz.net,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[grrlz.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99B4F6E7064

When xbc_snprint_cmdline() is called during the size-probing phase
(with buf = NULL and size = 0), the function computes the end pointer
as 'buf + size' (NULL + 0) and repeatedly advances 'buf' via 'buf += ret'.

Under the C standard, performing pointer arithmetic on a NULL pointer is
undefined behavior. While harmless inside the kernel, this code is also
compiled into the userspace host tool 'tools/bootconfig', where host
compilers with UBSan or FORTIFY_SOURCE enabled abort the build when they
detect NULL pointer arithmetic.

Fix this by guarding the pointer arithmetic so 'buf' is only advanced when
non-NULL, and track the running written length in a separate 'len' counter
for the return value (which cannot be recovered from pointer math when
'buf' is NULL). The rest() helper and snprintf call sites are unchanged.

Fixes: 51887d03aca1 ("bootconfig: init: Allow admin to use bootconfig for kernel command line")
Cc: stable@vger.kernel.org
Assisted-by: GLM:glm-5.2
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 lib/bootconfig.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

Changes since v1:
- Got the big guns out! :) (see Assisted-by).
- Addressed review from Masami Hiramatsu and Breno Leitao.

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index f445b7703fdd..c913259c80ce 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -427,8 +427,9 @@ static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
 int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
 {
 	struct xbc_node *knode, *vnode;
-	char *end = buf + size;
+	char *end = buf ? buf + size : NULL;
 	const char *val, *q;
+	size_t len = 0;
 	int ret;
 
 	xbc_node_for_each_key_value(root, knode, val) {
@@ -442,7 +443,9 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
 			ret = snprintf(buf, rest(buf, end), "%s ", xbc_namebuf);
 			if (ret < 0)
 				return ret;
-			buf += ret;
+			len += ret;
+			if (buf)
+				buf += ret;
 			continue;
 		}
 		xbc_array_for_each_value(vnode, val) {
@@ -456,11 +459,13 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
 				       xbc_namebuf, q, val, q);
 			if (ret < 0)
 				return ret;
-			buf += ret;
+			len += ret;
+			if (buf)
+				buf += ret;
 		}
 	}
 
-	return buf - (end - size);
+	return len;
 }
 #undef rest
 
-- 
2.53.0


