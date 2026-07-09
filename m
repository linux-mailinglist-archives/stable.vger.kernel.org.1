Return-Path: <stable+bounces-272798-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CB9+CcMkT2qLbAIAu9opvQ
	(envelope-from <stable+bounces-272798-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 06:34:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF1172C906
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 06:34:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Np5Ny8qp;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272798-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-272798-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEE8B302E7C2
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 04:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03853A5423;
	Thu,  9 Jul 2026 04:33:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D1339B4A2;
	Thu,  9 Jul 2026 04:33:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783571635; cv=none; b=UKsgjar/CqdaSgYccgsf6L29eQX504dt8Ow9AWUIbHbPpB08oU4FzDgodmeYp/gIkill/BnclhPYta6YNxZE/ZPLuM6Y0AN2CS4naZpAEZDq37g/zXlwaHog3xBOozjm92yyxde4sWRMHWqvCE7AedfPdmj7wK7pQvvfS5HPjIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783571635; c=relaxed/simple;
	bh=ILGzOl+rTD67v9a93I1Osxcu5qKab2IXB9ts0axXMd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOgHashL3WTcuGBW8lgcgvR/DHydd/9leWThH6hAgcSnCKNoU9WjUzq2fa5fFiFbSuuz4aODaKQb2XJ0C4Lkh/s7Epbhu2KOvKvAya+n2MUCestZQFOY2JS9puYQ5jSHY1pRLiQcMxfNdlJf5QDjMTwk5lqkFpfwF924n10nmM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Np5Ny8qp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82DE1F00A3E;
	Thu,  9 Jul 2026 04:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783571634;
	bh=vz46/TBNe/EF9SYWbW08wMCjAW43INaaPX/UHcq/6FQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Np5Ny8qpXavsIQMdyn0CUikSoVGMu2B/6w+YwIK/C3FV26lEionhbhHOrXiqfhiR9
	 doGuinl50/sH/2fygis6ckRctPEucR7f7bUC3wz3p2GFCF+SVJ9oS1k19J6sMYz8Wn
	 EprXDnLhYHzQxnWRxHGBXQzJGvIjBNAMDMjidbeg+pFt37ODaCgnbF1YcAtO6ZfsP+
	 yZE16h8jvaUGSizpkRbXXJi2Y5AAOPQhAWAH3FjOPLZ/yJBd1vmqzA/7S0/1izj9Gr
	 xqocxEMd5Mu2Wzlb4dfJ5rBUlB7+fQdWFZ1ijDirTb4FFskOjkgCutcYsd+3UsDB85
	 3lentajEX60Sg==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.18 2/4] add default_gfp() helper macro and use it in the new *alloc_obj() helpers
Date: Thu,  9 Jul 2026 00:32:59 -0400
Message-ID: <20260709043301.142931-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709043301.142931-1-ebiggers@kernel.org>
References: <20260709043301.142931-1-ebiggers@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272798-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:kees@kernel.org,m:torvalds@linux-foundation.org,m:ebiggers@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux-foundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EF1172C906

From: Linus Torvalds <torvalds@linux-foundation.org>

commit e19e1b480ac73c3e62ffebbca1174f0f511f43e7 upstream.

Most simple allocations use GFP_KERNEL, and with the new allocation
helpers being introduced, let's just take advantage of that to simplify
that default case.

It's a numbers game:

    git grep 'alloc_obj(' |
	sed 's/.*\(GFP_[_A-Z]*\).*/\1/' |
	sort | uniq -c | sort -n | tail

shows that about 90% of all those new allocator instances just use that
standard GFP_KERNEL.

Those helpers are already macros, and we can easily just make it be the
default case when the gfp argument is missing.

And yes, we could do that for all the legacy interfaces too, but let's
keep it to just the new ones at least for now, since those all got
converted recently anyway, so this is not any "extra" noise outside of
that limited conversion.

And, in fact, I want to do this before doing the -rc1 release, exactly
so that we don't get extra merge conflicts.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/linux/gfp.h  |  4 ++++
 include/linux/slab.h | 48 ++++++++++++++++++++++----------------------
 2 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index b155929af5b1..09559f7126ac 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -13,6 +13,10 @@
 struct vm_area_struct;
 struct mempolicy;
 
+/* Helper macro to avoid gfp flags if they are the default one */
+#define __default_gfp(a,...) a
+#define default_gfp(...) __default_gfp(__VA_ARGS__ __VA_OPT__(,) GFP_KERNEL)
+
 /* Convert GFP flags to their corresponding migrate type */
 #define GFP_MOVABLE_MASK (__GFP_RECLAIMABLE|__GFP_MOVABLE)
 #define GFP_MOVABLE_SHIFT 3
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 67f5b9831c56..976c781a7842 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -1011,8 +1011,8 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node);
  * Returns: newly allocated pointer to a @VAR_OR_TYPE on success, or NULL
  * on failure.
  */
-#define kmalloc_obj(VAR_OR_TYPE, GFP)			\
-	__alloc_objs(kmalloc, GFP, typeof(VAR_OR_TYPE), 1)
+#define kmalloc_obj(VAR_OR_TYPE, ...) \
+	__alloc_objs(kmalloc, default_gfp(__VA_ARGS__), typeof(VAR_OR_TYPE), 1)
 
 /**
  * kmalloc_objs - Allocate an array of the given type
@@ -1023,8 +1023,8 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node);
  * Returns: newly allocated pointer to array of @VAR_OR_TYPE on success,
  * or NULL on failure.
  */
-#define kmalloc_objs(VAR_OR_TYPE, COUNT, GFP)		\
-	__alloc_objs(kmalloc, GFP, typeof(VAR_OR_TYPE), COUNT)
+#define kmalloc_objs(VAR_OR_TYPE, COUNT, ...) \
+	__alloc_objs(kmalloc, default_gfp(__VA_ARGS__), typeof(VAR_OR_TYPE), COUNT)
 
 /**
  * kmalloc_flex - Allocate a single instance of the given flexible structure
@@ -1038,32 +1038,32 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node);
  * will immediately fail if @COUNT is larger than what the type of the
  * struct's counter variable can represent.
  */
-#define kmalloc_flex(VAR_OR_TYPE, FAM, COUNT, GFP)	\
-	__alloc_flex(kmalloc, GFP, typeof(VAR_OR_TYPE),	FAM, COUNT)
+#define kmalloc_flex(VAR_OR_TYPE, FAM, COUNT, ...) \
+	__alloc_flex(kmalloc, default_gfp(__VA_ARGS__), typeof(VAR_OR_TYPE), FAM, COUNT)
 
 /* All kzalloc aliases for kmalloc_(obj|objs|flex). */
-#define kzalloc_obj(P, GFP)				\
-	__alloc_objs(kzalloc, GFP, typeof(P), 1)
-#define kzalloc_objs(P, COUNT, GFP)			\
-	__alloc_objs(kzalloc, GFP, typeof(P), COUNT)
-#define kzalloc_flex(P, FAM, COUNT, GFP)		\
-	__alloc_flex(kzalloc, GFP, typeof(P), FAM, COUNT)
+#define kzalloc_obj(P, ...) \
+	__alloc_objs(kzalloc, default_gfp(__VA_ARGS__), typeof(P), 1)
+#define kzalloc_objs(P, COUNT, ...) \
+	__alloc_objs(kzalloc, default_gfp(__VA_ARGS__), typeof(P), COUNT)
+#define kzalloc_flex(P, FAM, COUNT, ...)		\
+	__alloc_flex(kzalloc, default_gfp(__VA_ARGS__), typeof(P), FAM, COUNT)
 
 /* All kvmalloc aliases for kmalloc_(obj|objs|flex). */
-#define kvmalloc_obj(P, GFP)				\
-	__alloc_objs(kvmalloc, GFP, typeof(P), 1)
-#define kvmalloc_objs(P, COUNT, GFP)			\
-	__alloc_objs(kvmalloc, GFP, typeof(P), COUNT)
-#define kvmalloc_flex(P, FAM, COUNT, GFP)		\
-	__alloc_flex(kvmalloc, GFP, typeof(P), FAM, COUNT)
+#define kvmalloc_obj(P, ...) \
+	__alloc_objs(kvmalloc, default_gfp(__VA_ARGS__), typeof(P), 1)
+#define kvmalloc_objs(P, COUNT, ...) \
+	__alloc_objs(kvmalloc, default_gfp(__VA_ARGS__), typeof(P), COUNT)
+#define kvmalloc_flex(P, FAM, COUNT, ...) \
+	__alloc_flex(kvmalloc, default_gfp(__VA_ARGS__), typeof(P), FAM, COUNT)
 
 /* All kvzalloc aliases for kmalloc_(obj|objs|flex). */
-#define kvzalloc_obj(P, GFP)				\
-	__alloc_objs(kvzalloc, GFP, typeof(P), 1)
-#define kvzalloc_objs(P, COUNT, GFP)			\
-	__alloc_objs(kvzalloc, GFP, typeof(P), COUNT)
-#define kvzalloc_flex(P, FAM, COUNT, GFP)		\
-	__alloc_flex(kvzalloc, GFP, typeof(P), FAM, COUNT)
+#define kvzalloc_obj(P, ...) \
+	__alloc_objs(kvzalloc, default_gfp(__VA_ARGS__), typeof(P), 1)
+#define kvzalloc_objs(P, COUNT, ...) \
+	__alloc_objs(kvzalloc, default_gfp(__VA_ARGS__), typeof(P), COUNT)
+#define kvzalloc_flex(P, FAM, COUNT, ...) \
+	__alloc_flex(kvzalloc, default_gfp(__VA_ARGS__), typeof(P), FAM, COUNT)
 
 #define kmem_buckets_alloc(_b, _size, _flags)	\
 	alloc_hooks(__kmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, _b), _flags, NUMA_NO_NODE))
-- 
2.55.0


