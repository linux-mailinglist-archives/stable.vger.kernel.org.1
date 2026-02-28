Return-Path: <stable+bounces-220818-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKbRJ6ZYo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220818-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:05:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 015F81C8C56
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC3623138442
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F651413F46;
	Sat, 28 Feb 2026 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbTyLAbZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103C3413F36;
	Sat, 28 Feb 2026 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300704; cv=none; b=q6jS78QqtBSeiXY8xkUcOu5DuMWefq02+q4KjjFQDm+qWqGQgM51VfjUGhyhvIO2PX8gYiV/J/iIiiHIE6j367KYRnl2NRcTTMtrBoip8GEFwBZnjEZ85zz98PFe/mZFjJ/gvkIXNKQD2pvndthByRPgeQ8pDuM04Bjkc6Ep7vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300704; c=relaxed/simple;
	bh=7XtzJWyng5F+/9CAkuRi23pmTU+hujE5U5871cDjoEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lzm7y9gLfgLTz/zwiWARCQNGwJDL+IH04amVX58W86LR8hl5kfwlnftyWWLncg84u+b1yhqmwwNemy+gwe6F+QVwq0Y3PdNghTwzrRXGJrVmQOXu4EhG12YTKzSrIsRhwwyme+UeC52rFgQzJliWtvTOefhdC80lF8ROjLbb0mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbTyLAbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33A2C116D0;
	Sat, 28 Feb 2026 17:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300703;
	bh=7XtzJWyng5F+/9CAkuRi23pmTU+hujE5U5871cDjoEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JbTyLAbZqdQ8vhygTt1IvR3ocQnerMTXcwKdKxRvTLmhq1VnfBi5yGu4gDByP8Cas
	 CBdiwU3rFdod+6tzDKkGqRrucnoL07fQCtUNNCDQfSSq03xHJvejdoWZyPv+wtiG1E
	 QKhbO0ER8hOsMFSqIKKvzUyxmmfyhmdkoaoAhgsqXVe+2SdQb3opcD0S+KqvWO1Th1
	 KAtYiB44vD4nPjBpdRJZJL806zLDWbfIpAkxBBNlEi2wsDnI3Cbrxuc1OzwQAUJbRS
	 WeF8zQ/XlTPqyYDaJ9Lfr6GjBwILWHuwaXqFpGn3WFv3JuDMFVsVmq5eAt1RHFt07P
	 gzS7QCfRRe8mw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Harry Yoo <harry.yoo@oracle.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 739/844] mm/slab: use unsigned long for orig_size to ensure proper metadata align
Date: Sat, 28 Feb 2026 12:30:52 -0500
Message-ID: <20260228173244.1509663-740-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,gmail.com,suse.cz,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220818-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,suse.cz:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 015F81C8C56
X-Rspamd-Action: no action

From: Harry Yoo <harry.yoo@oracle.com>

[ Upstream commit b85f369b81aed457acbea4ad3314218254a72fd2 ]

When both KASAN and SLAB_STORE_USER are enabled, accesses to
struct kasan_alloc_meta fields can be misaligned on 64-bit architectures.
This occurs because orig_size is currently defined as unsigned int,
which only guarantees 4-byte alignment. When struct kasan_alloc_meta is
placed after orig_size, it may end up at a 4-byte boundary rather than
the required 8-byte boundary on 64-bit systems.

Note that 64-bit architectures without HAVE_EFFICIENT_UNALIGNED_ACCESS
are assumed to require 64-bit accesses to be 64-bit aligned.
See HAVE_64BIT_ALIGNED_ACCESS and commit adab66b71abf ("Revert:
"ring-buffer: Remove HAVE_64BIT_ALIGNED_ACCESS"") for more details.

Change orig_size from unsigned int to unsigned long to ensure proper
alignment for any subsequent metadata. This should not waste additional
memory because kmalloc objects are already aligned to at least
ARCH_KMALLOC_MINALIGN.

Closes: https://lore.kernel.org/all/aPrLF0OUK651M4dk@hyeyoo
Suggested-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: stable@vger.kernel.org
Fixes: 6edf2576a6cc ("mm/slub: enable debugging memory wasting of kmalloc")
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
Closes: https://lore.kernel.org/all/aPrLF0OUK651M4dk@hyeyoo/
Link: https://patch.msgid.link/20260113061845.159790-2-harry.yoo@oracle.com
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/slub.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 9a7c2fec6208a..78946116ecd2f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -857,7 +857,7 @@ static inline bool slab_update_freelist(struct kmem_cache *s, struct slab *slab,
  * request size in the meta data area, for better debug and sanity check.
  */
 static inline void set_orig_size(struct kmem_cache *s,
-				void *object, unsigned int orig_size)
+				void *object, unsigned long orig_size)
 {
 	void *p = kasan_reset_tag(object);
 
@@ -867,10 +867,10 @@ static inline void set_orig_size(struct kmem_cache *s,
 	p += get_info_end(s);
 	p += sizeof(struct track) * 2;
 
-	*(unsigned int *)p = orig_size;
+	*(unsigned long *)p = orig_size;
 }
 
-static inline unsigned int get_orig_size(struct kmem_cache *s, void *object)
+static inline unsigned long get_orig_size(struct kmem_cache *s, void *object)
 {
 	void *p = kasan_reset_tag(object);
 
@@ -883,7 +883,7 @@ static inline unsigned int get_orig_size(struct kmem_cache *s, void *object)
 	p += get_info_end(s);
 	p += sizeof(struct track) * 2;
 
-	return *(unsigned int *)p;
+	return *(unsigned long *)p;
 }
 
 #ifdef CONFIG_SLUB_DEBUG
@@ -1198,7 +1198,7 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
 		off += 2 * sizeof(struct track);
 
 	if (slub_debug_orig_size(s))
-		off += sizeof(unsigned int);
+		off += sizeof(unsigned long);
 
 	off += kasan_metadata_size(s, false);
 
@@ -1394,7 +1394,7 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
 		off += 2 * sizeof(struct track);
 
 		if (s->flags & SLAB_KMALLOC)
-			off += sizeof(unsigned int);
+			off += sizeof(unsigned long);
 	}
 
 	off += kasan_metadata_size(s, false);
@@ -8021,7 +8021,7 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 
 		/* Save the original kmalloc request size */
 		if (flags & SLAB_KMALLOC)
-			size += sizeof(unsigned int);
+			size += sizeof(unsigned long);
 	}
 #endif
 
-- 
2.51.0


