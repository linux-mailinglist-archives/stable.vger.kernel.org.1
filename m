Return-Path: <stable+bounces-244986-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id S2qyFl2n/2mz8wAAu9opvQ
	(envelope-from <stable+bounces-244986-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 23:30:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A3F501792
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 23:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D793300CC1D
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 21:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FB438E126;
	Sat,  9 May 2026 21:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxkVpb9M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D9738C2AE
	for <stable@vger.kernel.org>; Sat,  9 May 2026 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778362201; cv=none; b=iSt2mZPiUU+vWxbdqFae4TkJophKOMryGYxbqoTFJR6I5nKCYEQ31gwCt54yMYyJ+GuMFLrwaG6Zn0Kia9ENPaqBOu2zaPr2hL8J+mFgYda8P9MXXIyEC08KXplgDWe0MG7LxTALeOPirOjWnG4UnjsmEW0FTOO/dFPKbHNLgJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778362201; c=relaxed/simple;
	bh=CHejKJEBlZh8AhNArK7l8VtZOYcLfThQ+Di/SPd1Bz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9B0QrkHmpE0YbdTRbMUH6bhWgZbBXUGs3w+YZIK32kIpCOdOotRWsdgrrcmetTyvaygxKxiw8nScdKUFaprMab6suxXuUsmO/qAP1M/t9kaZugQhq2lIzn4TAmSTt7iJWzI0Lc5I1KBETajzJdIJek3bg9gOjQQWoYvUlOAi68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxkVpb9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAC0C2BCB2;
	Sat,  9 May 2026 21:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778362200;
	bh=CHejKJEBlZh8AhNArK7l8VtZOYcLfThQ+Di/SPd1Bz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RxkVpb9MEld+7C07jssDjzj8ubuQNxxE9yPxVm8nYGQxLbG6YY27Qj74c0VYt45uI
	 z9lYN14aSya1nKHpLJtQxtddSFzxKc6WOXCLdaQGAg+zyqq+bUteFkwiz5pBno+5gR
	 SuKN9NN2yf6RnO7oybYjOOJ0uzG9LLjlc5nc75IdVYvXUzQ1hU84o2FZW2wMFDNjAE
	 QRsZCIG5a1EPX6qPwNO/1lGpyYy83FXac2eKB66ub7NdncBM9/NNx2N4UrDFDbqmv3
	 l/6hPfU2we3NcU4TTiTEdURjzEqx3Soj29ENa4MYtv9T5k8FMZqV/n/unH5q8wB9oQ
	 9Uu6Mz/rhNEvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	John Ogness <john.ogness@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] printk: add print_hex_dump_devel()
Date: Sat,  9 May 2026 17:29:56 -0400
Message-ID: <20260509212957.3843722-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050436-chastity-emoticon-ecfc@gregkh>
References: <2026050436-chastity-emoticon-ecfc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A9A3F501792
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244986-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:email,linux.dev:email,linutronix.de:email]
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
index 45c663124c9bd..9a8eaed5f8778 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -802,6 +802,19 @@ static inline void print_hex_dump_debug(const char *prefix_str, int prefix_type,
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


