Return-Path: <stable+bounces-245028-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC7WJ7+UAGpvKgEAu9opvQ
	(envelope-from <stable+bounces-245028-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 16:22:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0937C504945
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 16:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E858D30021F1
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 14:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F844382373;
	Sun, 10 May 2026 14:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxDRi9FZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DF519CD03
	for <stable@vger.kernel.org>; Sun, 10 May 2026 14:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778422973; cv=none; b=WZzj8eMy+9INq7Ey31tNPWTJ1HpRXd1z8x/mpp3+L0Tv34qa+/2zn2NuWRhEqTN4CkafFmE2CjFXD+PxvjLG4HWkTsQIhsgbrIe4P+GnYhqxDpw7Jvo6BlZcyNsWnWc5INwneNa+SyoA3b5y+FO0C+ZjOjnDT9k9gdS1Fylck6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778422973; c=relaxed/simple;
	bh=kCiGC9tXWgcstBjfBu5ox7ME0+JjsFdw+M8nI8puW4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwXw001bz5sh+PWZwunqXGzXafzImkYuzr8lIHLRsfrNHKN1CSr68blZsLfc+5VF1bacwEIcVyOPvhCys/8q4LJ1VTwFiFSmX2KF3zsKFpq7Yz5z3eBEqdfyRuS/xWygmsWrDAE8VLPB+IgLeacCBLdMoSSHwWAlGxDOpitUj04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxDRi9FZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F60C2BCC9;
	Sun, 10 May 2026 14:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778422972;
	bh=kCiGC9tXWgcstBjfBu5ox7ME0+JjsFdw+M8nI8puW4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TxDRi9FZa6U+2FQ2xB8iOXqdfFiZDNzloNsUNMwitBVrDZ8RaLEim6eT03AiqweOq
	 /mN7ICPbZEYCRQeebvSZBA8Ej9wsL0N01UclkSP8zxb5cnk/0T/IglLr+XX2j61tiL
	 1iNh/AN6Igq0NQDaXPnFEmLG9k9UhNVrXcIUVzzsDqtDCU8VZKEjZ0qnroR7Xd95Gx
	 dEatWCDgzLVNvVpR5lb5Wb/71az1PQVYM0XG7E75ekrwhKP5uS6XaPy9DUU9ebwZLV
	 cZdHRXnkNJcbMwmWF0yjnONDP+RCi6vaydM2WdEgLKJjNBydwxNX3zd6NBJjOjUUPO
	 /lLhuEKnhFJDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	John Ogness <john.ogness@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] printk: add print_hex_dump_devel()
Date: Sun, 10 May 2026 10:22:49 -0400
Message-ID: <20260510142250.4179491-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050437-exorcism-sensitive-efda@gregkh>
References: <2026050437-exorcism-sensitive-efda@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0937C504945
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245028-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,apana.org.au:email,linutronix.de:email]
X-Rspamd-Action: no action

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit d134feeb5df33fbf77f482f52a366a44642dba09 ]

Add print_hex_dump_devel() as the hex dump equivalent of pr_devel(),
which emits output only when DEBUG is enabled, but keeps call sites
compiled otherwise.

Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 177730a273b1 ("crypto: caam - guard HMAC key hex dumps in hash_digest_key")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/printk.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index b1a12916f0361..c56bd25a3fe5f 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -747,6 +747,19 @@ static inline void print_hex_dump_debug(const char *prefix_str, int prefix_type,
 }
 #endif
 
+#if defined(DEBUG)
+#define print_hex_dump_devel(prefix_str, prefix_type, rowsize,		\
+			     groupsize, buf, len, ascii)		\
+	print_hex_dump(KERN_DEBUG, prefix_str, prefix_type, rowsize,	\
+		       groupsize, buf, len, ascii)
+#else
+static inline void print_hex_dump_devel(const char *prefix_str, int prefix_type,
+					int rowsize, int groupsize,
+					const void *buf, size_t len, bool ascii)
+{
+}
+#endif
+
 /**
  * print_hex_dump_bytes - shorthand form of print_hex_dump() with default params
  * @prefix_str: string to prefix each line with;
-- 
2.53.0


