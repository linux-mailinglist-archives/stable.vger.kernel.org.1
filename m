Return-Path: <stable+bounces-245036-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDUVOLOnAGp/LQEAu9opvQ
	(envelope-from <stable+bounces-245036-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 17:43:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCD4504E35
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 17:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B873300767A
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 15:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3A439E6C6;
	Sun, 10 May 2026 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqYc4Hp8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F29228A72F
	for <stable@vger.kernel.org>; Sun, 10 May 2026 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778427823; cv=none; b=gvLum0vjdsacqyvG/vuUiBw4Cld1AeBj6rgcxhrjwh0OOQSywHFSJI9HjPteLueMTn+fjffrMUTYxFc9dkFEsrLwI7Ko37Xti1VZAtgojTnjkxdhsiVUN1JTVucqpDLjA8cn5fmwPaZomzaCVwl/Y3CbvHx26ihEkDvPXGCKNfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778427823; c=relaxed/simple;
	bh=S0bZ8v7nHGKy3hxxgGrd4C5ie1AhyeU7ckT3aaDEdOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCpvzHROnjgHRMhOSYEYDEEp5fzIdlIWb3x2adUtJ9b6TUr1rHw+dIdxYcQK7RoKligboAPcWoSd8aUSQjm6w25tjsCDBCSpT2QLOtustqssDJ9T2IvooV6d9ORYJHaPdLS5tcSwAQmzTlNpJpDo5UjJutfl3wzxOYvJOaP+QWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqYc4Hp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C458C2BCB8;
	Sun, 10 May 2026 15:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778427822;
	bh=S0bZ8v7nHGKy3hxxgGrd4C5ie1AhyeU7ckT3aaDEdOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tqYc4Hp8DiyXbQzwlmlG2bleNYMnObIJ4n1wbV5zGTI27qx8N8VSaH0O1XrUtba01
	 T8oNA30alLxEoM9snZ1CqMqucPQH81XZSu+TCRHfITAShZwNWqCvY+6OFnE0zk4dBQ
	 755yTjyQVUFRYqgPaDui7mDa64C0eysNPBDHGf49cFnG5pNV/gqFELXwaCAdc5xrhf
	 pQFXBUC2M8d+xCe89R4YkvEnjoW00JTWTpE1hatAMvZ3q5r73/b/87ELhw7KyskHG2
	 BGBQ6Z7Yr0w7e3PSy+PCvB6b48a/41E6o4fXjW5/c3WUjEz1XDuX7swZGhiBGKCRbZ
	 DVZQHSAkan0hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	John Ogness <john.ogness@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] printk: add print_hex_dump_devel()
Date: Sun, 10 May 2026 11:43:37 -0400
Message-ID: <20260510154339.144690-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050438-conical-landscape-5b4d@gregkh>
References: <2026050438-conical-landscape-5b4d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3BCD4504E35
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
	TAGGED_FROM(0.00)[bounces-245036-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,linutronix.de:email]
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
index 344f6da3d4c36..de3f8f774dee9 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -608,6 +608,19 @@ static inline void print_hex_dump_debug(const char *prefix_str, int prefix_type,
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


