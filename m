Return-Path: <stable+bounces-244983-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NBAARmE/2l47QAAu9opvQ
	(envelope-from <stable+bounces-244983-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 20:59:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D83250111E
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 20:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEDB3300EFB6
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 18:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191C53C2781;
	Sat,  9 May 2026 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oS0LXfMo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1590383C77
	for <stable@vger.kernel.org>; Sat,  9 May 2026 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778353172; cv=none; b=K59HxmNmtX8YtWNK3Zxppd3xa86yeHf/w8oBXEt2TErvKEychjesiZlVeX+cel10F98bFFVdQZiXDscxgL6fnKzyqchT+5muzgfINzUq8RzUYxju1y7lJvgoleytEU3q2VR7peODOu7gA134raTDAOrXdTZsHkXiVAbGgOxe7SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778353172; c=relaxed/simple;
	bh=XPmzPgpGJdDlppyWK5fw83kwQxuPh6LIpWBDPCvhVDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukuptUXNGxfmPo1cTur397oJDcAcAg2ldMdfIU8KBLwIvHhr6/EdYBh481LmR8tKS8mBsRoIoGFYAelRocjMhDZw30nVT7dbBSNKPSk6fDN2kJJklgqfTZbjK0BdHzP1Mio/GZDEwOsNg0DFx35gxdCdtXczsjpLxGoJbQFqpI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oS0LXfMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98A2C2BCB2;
	Sat,  9 May 2026 18:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778353172;
	bh=XPmzPgpGJdDlppyWK5fw83kwQxuPh6LIpWBDPCvhVDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oS0LXfMo+eWe9SsZiFGCxz0Cig4iYoVFJla/5VIfldHsg/7NEPBHMb6sCAzrRBZe4
	 5adtTp++aNx2DOajUS1qieE/6GcJeEUUvR7Aus+pttX+Sf4DnIHW2Y1+wcL5YbF9pp
	 7ToQmc8iXvwUOuS0OTgdNP2MFv9ifHVcKVhKnwvsDPGYPWUqcI/aFhzJ+o44i4oXqA
	 CDUrN7fZnXf81pXMlK6zrc3id8YOmPyofWXn0Ttq5knXQYrWPRrzdHF9pH8mYMeGsQ
	 AefAblO1lbs6geTkfHxEUvGrAV5EXmdD+tK4Dz44OXOTctYbFppyqOlmvK+Te+Sbfo
	 cAUhDq1p6gI7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	John Ogness <john.ogness@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 1/2] printk: add print_hex_dump_devel()
Date: Sat,  9 May 2026 14:59:28 -0400
Message-ID: <20260509185929.3682915-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050436-deny-perm-ab84@gregkh>
References: <2026050436-deny-perm-ab84@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4D83250111E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244983-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,apana.org.au:email,linutronix.de:email]
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
index 63d516c873b4c..54e3c621fec37 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -801,6 +801,19 @@ static inline void print_hex_dump_debug(const char *prefix_str, int prefix_type,
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


