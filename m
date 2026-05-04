Return-Path: <stable+bounces-243916-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFFABMcI+Wlt4gIAu9opvQ
	(envelope-from <stable+bounces-243916-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 22:59:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F49B4C3D55
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 22:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80E953019832
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 20:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B1531985D;
	Mon,  4 May 2026 20:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TwK+kjLZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082E940DFD4
	for <stable@vger.kernel.org>; Mon,  4 May 2026 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777928387; cv=none; b=MKGyl6KUEiegnL1htTjXZTj5ueVdW1irKuHgJHXvreL/GDh6fp9pqCwOIbGLU9Xup08mi8RBSeDUgxFoqmEsgqCfhK/BlVXoFB+bMl+80yg0fdXBgk4JhY+NwZvjBfmrQxYDOZx4S7GoFp1/H6iDyC+T6IMhV/1I97kId5zwwT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777928387; c=relaxed/simple;
	bh=UBspWeP9+Y9KER5FPAd9r8ffEvw0TRbos3Go8Qip3hM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uWJCfDQZGSjh/Dt30pKsHjpDr0Aqb9B62Bx7H1QgeOlB/9OtxwSrtGMKaXp0h+4vd+knI0ka72YmzXVbmNTJK8tcPHv8zV1/NjOpVrl4JQFbWOvofwc6sIXMmuWyMeqzcXMV2xZ+LLDdebWf5pn4irodAAbURhzolJTDmQqSZF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TwK+kjLZ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777928386; x=1809464386;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UBspWeP9+Y9KER5FPAd9r8ffEvw0TRbos3Go8Qip3hM=;
  b=TwK+kjLZVtBCO0uCO2i+R8tRdC0lQBtTwdbF8SXlS2SoMSmS+RiHMRkG
   OUYyCpyAyGUFjIhYKLo2LVN6L74hx53PwKtglvWkYoGa6m4nNb+gUlVJO
   r+XC6CnWP1PSRl9GnFzoBgWkvYAfndz+lQ6RotEakcY1w/BbumazorCLR
   3tNnTPX/FUUylsQy/7Ny2haaIPXRytcRELKOuXFrWsMN4vpkcgUyRFWfx
   ghSyhh6t0qfnkzLhjuY7nUsfLftZaDNdlrAcrLq6y4NEJdJZcrgKFQGjC
   PxXORteM64y7A9t0tRWe6Ke7U/BklMPEmKYHe6ds2rYukdSjENalNyI9C
   g==;
X-CSE-ConnectionGUID: O3QwjmzNR+OL+SNWqXvk/g==
X-CSE-MsgGUID: 0Wd7w2YGQ829o8tKPoiX1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="82644510"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="82644510"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 13:59:40 -0700
X-CSE-ConnectionGUID: 4taIv8CRSeGe7JJtsmODtQ==
X-CSE-MsgGUID: O+hk1x6tQAGW3aNWeI3IDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="229138914"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.139])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 13:59:40 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	=?UTF-8?q?=EA=B9=80=EC=98=81=EB=AF=BC?= <osori@hspace.io>,
	Oleg Nesterov <oleg@redhat.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] x86: shadow stacks: proper error handling for mmap lock
Date: Mon,  4 May 2026 13:59:24 -0700
Message-ID: <20260504205924.536382-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5F49B4C3D55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243916-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rick.p.edgecombe@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email,hspace.io:email]

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit 52f657e34d7b21b47434d9d8b26fa7f6778b63a0 ]

김영민 reports that shstk_pop_sigframe() doesn't check for errors from
mmap_read_lock_killable(), which is a silly oversight, and also shows
that we haven't marked those functions with "__must_check", which would
have immediately caught it.

So let's fix both issues.

Reported-by: 김영민 <osori@hspace.io>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Acked-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/shstk.c   | 3 ++-
 include/linux/mmap_lock.h | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 19e4db582fb69..d259d7d5b962f 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -311,7 +311,8 @@ static int shstk_pop_sigframe(unsigned long *ssp)
 	need_to_check_vma = PAGE_ALIGN(*ssp) == *ssp;
 
 	if (need_to_check_vma)
-		mmap_read_lock_killable(current->mm);
+		if (mmap_read_lock_killable(current->mm))
+			return -EINTR;
 
 	err = get_shstk_data(&token_addr, (unsigned long __user *)*ssp);
 	if (unlikely(err))
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 8d38dcb6d044c..153e018677909 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -116,7 +116,7 @@ static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
 	__mmap_lock_trace_acquire_returned(mm, true, true);
 }
 
-static inline int mmap_write_lock_killable(struct mm_struct *mm)
+static inline int __must_check mmap_write_lock_killable(struct mm_struct *mm)
 {
 	int ret;
 
@@ -147,7 +147,7 @@ static inline void mmap_read_lock(struct mm_struct *mm)
 	__mmap_lock_trace_acquire_returned(mm, false, true);
 }
 
-static inline int mmap_read_lock_killable(struct mm_struct *mm)
+static inline int __must_check mmap_read_lock_killable(struct mm_struct *mm)
 {
 	int ret;
 
@@ -157,7 +157,7 @@ static inline int mmap_read_lock_killable(struct mm_struct *mm)
 	return ret;
 }
 
-static inline bool mmap_read_trylock(struct mm_struct *mm)
+static inline bool __must_check mmap_read_trylock(struct mm_struct *mm)
 {
 	bool ret;
 
-- 
2.54.0


