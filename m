Return-Path: <stable+bounces-221939-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEeDAnObo2l4IAUAu9opvQ
	(envelope-from <stable+bounces-221939-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:50:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B001CBF7F
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FB3830603C4
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA5A2E7164;
	Sun,  1 Mar 2026 01:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BErxteEw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BF92D9ECA
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329510; cv=none; b=hjgODG759N1Fezonf1ZXtf+YudjF3BBXonVbAfmDKXUZTTM6IdwPHji2ZdK0W450dclqGQCOW10nrX0M07Ez5/M+Fty91JDZRposoI5qTGBFmb82yg+senoNrFs5xuz1u8OZwfBgL/stnfD0SXfXeAF476yhxJWMns4IX+vvK6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329510; c=relaxed/simple;
	bh=jg534zdcz6ZbicqVI0eVcQ15m42V1YwShpeGG92oE0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nG874o9DA5n750pq2moYsYS53/o3zZHGbAhxqQRhPqhiGc5uBxW+bJR+NMhllkKRNgGahuLPV1I+pFYa44vX7nyxmOk71qFm5u8ym9F4Zw79b6EoUEVKV9ioSMVLlV3u/cp5YGh3kfkB3MAUvSLeKFee3KTI9vl84u42U/MYgT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BErxteEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A74C19424;
	Sun,  1 Mar 2026 01:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329509;
	bh=jg534zdcz6ZbicqVI0eVcQ15m42V1YwShpeGG92oE0M=;
	h=From:To:Cc:Subject:Date:From;
	b=BErxteEwzzkrex8wuy1zhG2nczeL7ajymk6euZne2zYp2rFR7dud1tfZbZ+4QXWV4
	 vTmH762E6a5qM2uRKE6tNkSF1Id0i5aDE1Ht0nM7PgP2VTt/oFzWvX+Ki74rZ2B16U
	 c7KCqW/t7GnuTiCSG6nTmujabk2ZE1rDq1rx3NehGLgVTHeYCSUrRNYWvzAnD+BQK3
	 5eDKijJLiKkUYe6H3NNzb7i7K6lonE/qBW8eyXN02yc/Fgyn4+rfvCkZOWSpMF3MSp
	 gBdg8etNlEoUFA/kJrJP3kGLD4C+ewpvgBGVRwWgBv1yHC1AU6bTt5ua/ucvRvGTQn
	 3HaoRrnZQgKfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	harry.yoo@oracle.com
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org
Subject: FAILED: Patch "mm/slab: use unsigned long for orig_size to ensure proper metadata align" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:45:07 -0500
Message-ID: <20260301014507.1707658-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,kvack.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-221939-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,suse.cz:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 74B001CBF7F
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b85f369b81aed457acbea4ad3314218254a72fd2 Mon Sep 17 00:00:00 2001
From: Harry Yoo <harry.yoo@oracle.com>
Date: Tue, 13 Jan 2026 15:18:37 +0900
Subject: [PATCH] mm/slab: use unsigned long for orig_size to ensure proper
 metadata align

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
---
 mm/slub.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 152fe53d0fb5a..2c000dddcf74f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -854,7 +854,7 @@ static inline bool slab_update_freelist(struct kmem_cache *s, struct slab *slab,
  * request size in the meta data area, for better debug and sanity check.
  */
 static inline void set_orig_size(struct kmem_cache *s,
-				void *object, unsigned int orig_size)
+				void *object, unsigned long orig_size)
 {
 	void *p = kasan_reset_tag(object);
 
@@ -864,10 +864,10 @@ static inline void set_orig_size(struct kmem_cache *s,
 	p += get_info_end(s);
 	p += sizeof(struct track) * 2;
 
-	*(unsigned int *)p = orig_size;
+	*(unsigned long *)p = orig_size;
 }
 
-static inline unsigned int get_orig_size(struct kmem_cache *s, void *object)
+static inline unsigned long get_orig_size(struct kmem_cache *s, void *object)
 {
 	void *p = kasan_reset_tag(object);
 
@@ -880,7 +880,7 @@ static inline unsigned int get_orig_size(struct kmem_cache *s, void *object)
 	p += get_info_end(s);
 	p += sizeof(struct track) * 2;
 
-	return *(unsigned int *)p;
+	return *(unsigned long *)p;
 }
 
 #ifdef CONFIG_SLUB_DEBUG
@@ -1195,7 +1195,7 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
 		off += 2 * sizeof(struct track);
 
 	if (slub_debug_orig_size(s))
-		off += sizeof(unsigned int);
+		off += sizeof(unsigned long);
 
 	off += kasan_metadata_size(s, false);
 
@@ -1407,7 +1407,7 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
 		off += 2 * sizeof(struct track);
 
 		if (s->flags & SLAB_KMALLOC)
-			off += sizeof(unsigned int);
+			off += sizeof(unsigned long);
 	}
 
 	off += kasan_metadata_size(s, false);
@@ -8040,7 +8040,7 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 
 		/* Save the original kmalloc request size */
 		if (flags & SLAB_KMALLOC)
-			size += sizeof(unsigned int);
+			size += sizeof(unsigned long);
 	}
 #endif
 
-- 
2.51.0





