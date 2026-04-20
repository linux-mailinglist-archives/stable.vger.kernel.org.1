Return-Path: <stable+bounces-239322-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAdbOdRf5mkxvgEAu9opvQ
	(envelope-from <stable+bounces-239322-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:18:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1DF430F2E
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A61C323530F
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1E933A9F8;
	Mon, 20 Apr 2026 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CxGMNfoR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4CC2C236B;
	Mon, 20 Apr 2026 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699950; cv=none; b=EKuAfcuD9QeT7H3PcKL8nAL64UXUjoyUfJUXbEBzKKD8TGeGwlyXY5lUBNahW2Txpq5kvMKMppraChLlAV69VE4vsr69GjY9dofZ/aUhLuW8nkRQ8OrLTm0Icn2FXD6mvjO087ajbUHthYbjkOtb9XERedljN9qlRPfM+Mqphts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699950; c=relaxed/simple;
	bh=l/AxNCS7Vw3wcuzHD65ONPgRnbsJOCxFDGPzbBajCgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTb/AO6y4EjxOlv9ErGqPZ59ymY7WEpKF1/5aoibcCFDZCt+GrlxXMRKmMt7HJTbtfGYFQdcCFHYJ4S3X4yVen4tHXz7Q7RxwuB4BZzPFZnmu3IJOO7GeMnjLF/2m0EQ85hPOnOELvauSxMmu/U1vyE42phv7tg78ooPta0lGrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CxGMNfoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A482BC19425;
	Mon, 20 Apr 2026 15:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776699950;
	bh=l/AxNCS7Vw3wcuzHD65ONPgRnbsJOCxFDGPzbBajCgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CxGMNfoRQgE/SaixoFZA3Pv9veHFMKFaX2boLHa6l+dUJsRVsJDJzS8Sp4+U49DMj
	 OJOK87jUMhRzoM5t3b46J1XJeTP86evcJc2VTVnjiCxYxrDlRWuOiTVcU0mbtt8kmY
	 RABuItwYNLtxsDuW9q75SFsjJSyDZ1sZm/en41c0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 7.0 60/76] x86-64/arm64/powerpc: clean up and rename __copy_from_user_flushcache
Date: Mon, 20 Apr 2026 17:42:11 +0200
Message-ID: <20260420153913.004519604@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153910.810034134@linuxfoundation.org>
References: <20260420153910.810034134@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239322-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1B1DF430F2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 809b997a5ce945ab470f70c187048fe4f5df20bf upstream.

This finishes the work on these odd functions that were only implemented
by a handful of architectures.

The 'flushcache' function was only used from the iterator code, and
let's make it do the same thing that the nontemporal version does:
remove the two underscores and add the user address checking.

Yes, yes, the user address checking is also done at iovec import time,
but we have long since walked away from the old double-underscore thing
where we try to avoid address checking overhead at access time, and
these functions shouldn't be so special and old-fashioned.

The arm64 version already did the address check, in fact, so there it's
just a matter of renaming it.  For powerpc and x86-64 we now do the
proper user access boilerplate.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/uaccess.h   |    2 +-
 arch/powerpc/include/asm/uaccess.h |    3 +--
 arch/powerpc/lib/pmem.c            |   11 ++++++-----
 arch/x86/include/asm/uaccess_64.h  |    8 ++++----
 arch/x86/lib/usercopy_64.c         |    8 ++++----
 lib/iov_iter.c                     |    2 +-
 6 files changed, 17 insertions(+), 17 deletions(-)

--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -478,7 +478,7 @@ extern __must_check long strnlen_user(co
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 extern unsigned long __must_check __copy_user_flushcache(void *to, const void __user *from, unsigned long n);
 
-static inline int __copy_from_user_flushcache(void *dst, const void __user *src, unsigned size)
+static inline size_t copy_from_user_flushcache(void *dst, const void __user *src, size_t size)
 {
 	kasan_check_write(dst, size);
 	return __copy_user_flushcache(dst, __uaccess_mask_ptr(src), size);
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -434,8 +434,7 @@ copy_mc_to_user(void __user *to, const v
 }
 #endif
 
-extern long __copy_from_user_flushcache(void *dst, const void __user *src,
-		unsigned size);
+extern size_t copy_from_user_flushcache(void *dst, const void __user *src, size_t size);
 
 static __must_check __always_inline bool __user_access_begin(const void __user *ptr, size_t len,
 							     unsigned long dir)
--- a/arch/powerpc/lib/pmem.c
+++ b/arch/powerpc/lib/pmem.c
@@ -66,15 +66,16 @@ EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
 /*
  * CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE symbols
  */
-long __copy_from_user_flushcache(void *dest, const void __user *src,
-		unsigned size)
+size_t copy_from_user_flushcache(void *dest, const void __user *src,
+				 size_t size)
 {
-	unsigned long copied, start = (unsigned long) dest;
+	unsigned long not_copied, start = (unsigned long) dest;
 
-	copied = __copy_from_user(dest, src, size);
+	src = mask_user_address(src);
+	not_copied = __copy_from_user(dest, src, size);
 	clean_pmem_range(start, start + size);
 
-	return copied;
+	return not_copied;
 }
 
 void memcpy_flushcache(void *dest, const void *src, size_t size)
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -149,7 +149,7 @@ raw_copy_to_user(void __user *dst, const
 
 #define copy_to_nontemporal copy_to_nontemporal
 extern size_t copy_to_nontemporal(void *dst, const void *src, size_t size);
-extern long __copy_user_flushcache(void *dst, const void __user *src, unsigned size);
+extern size_t copy_user_flushcache(void *dst, const void __user *src, size_t size);
 
 static inline int
 copy_from_user_inatomic_nontemporal(void *dst, const void __user *src,
@@ -164,11 +164,11 @@ copy_from_user_inatomic_nontemporal(void
 	return ret;
 }
 
-static inline int
-__copy_from_user_flushcache(void *dst, const void __user *src, unsigned size)
+static inline size_t
+copy_from_user_flushcache(void *dst, const void __user *src, size_t size)
 {
 	kasan_check_write(dst, size);
-	return __copy_user_flushcache(dst, src, size);
+	return copy_user_flushcache(dst, src, size);
 }
 
 /*
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -43,14 +43,14 @@ void arch_wb_cache_pmem(void *addr, size
 }
 EXPORT_SYMBOL_GPL(arch_wb_cache_pmem);
 
-long __copy_user_flushcache(void *dst, const void __user *src, unsigned size)
+size_t copy_user_flushcache(void *dst, const void __user *src, size_t size)
 {
 	unsigned long flushed, dest = (unsigned long) dst;
-	long rc;
+	unsigned long rc;
 
-	stac();
+	src = masked_user_access_begin(src);
 	rc = copy_to_nontemporal(dst, (__force const void *)src, size);
-	clac();
+	user_access_end();
 
 	/*
 	 * copy_to_nontemporal() uses non-temporal stores for the bulk
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -296,7 +296,7 @@ static __always_inline
 size_t copy_from_user_iter_flushcache(void __user *iter_from, size_t progress,
 				      size_t len, void *to, void *priv2)
 {
-	return __copy_from_user_flushcache(to + progress, iter_from, len);
+	return copy_from_user_flushcache(to + progress, iter_from, len);
 }
 
 static __always_inline



