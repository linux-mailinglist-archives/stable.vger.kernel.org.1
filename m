Return-Path: <stable+bounces-243915-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFn6CpwI+Wnx4QIAu9opvQ
	(envelope-from <stable+bounces-243915-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 22:59:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A524C3D4C
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 22:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 543DA300B9EC
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 20:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBB2330B3F;
	Mon,  4 May 2026 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WWQ0f2Wh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F4E33507D
	for <stable@vger.kernel.org>; Mon,  4 May 2026 20:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777928342; cv=none; b=iac9tl9EP1x3ku6hj3W4M/swBc97LlXtegTt6fVnXNtH6QP73Ko2zE4lLFtqilgH2PJ0IKtueUzpj3b9xmnTPvFW2evi2cdD2A/EJsDK0eoHsUEkSYiyavvzXqXz9JSXuSoiciPjxnjSStw+7xBIbezfBIgIxl+NQVaCC1WUJL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777928342; c=relaxed/simple;
	bh=zb/1UFKL+RAMdOzSbGbh89cM1XeOU9GBkUzFF3SezVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k9pZUomcRFMh7bbt6CZ9CZHN2/wWnVCFMuszeZt3Sr7bKCuuNvFSUPtVKaVbNaxtuSFvJVVan7eBXFIGrY2vMcbdoH48BQKcfnXqQzO4OiEq0C/CxmHbQumSiLqBMT9eGWWsChbCrjnoFStIMCHS546r6aXWXZeO3LkEYQqASno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WWQ0f2Wh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777928341; x=1809464341;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zb/1UFKL+RAMdOzSbGbh89cM1XeOU9GBkUzFF3SezVw=;
  b=WWQ0f2WhMw18LZ5t5+ITxzqi9e09r/dV9ZDjU3Q+zJqh8rBwz2axScHC
   Bv7j3y9JTCdAL+/mseqXZdvwSiQTR+P4O+zml3oaBt7Av08Gt4UfKuS2R
   OfSAGxgrD5G0QFQ3WSu7blRzbV77uPTNa/+K3MEyxvtu5MEpmXeoHqS7S
   A9DlpAPUuVChCAB1utMrCUfMWEdGAuCPuX8zaEpZZSJSOCNFunjZ51oSU
   AzQbue7FnuAWdFjGmbSN3mIKH3Tal07nR/d0PHLpvXMdbRKMGajXRMowY
   9orzu4kOgyUBkrO5tQh1ZpoL8IoVRqqTUsRRvu3hWzVp5cn5iSFlrSYr2
   w==;
X-CSE-ConnectionGUID: EzQivUuaRzO9UaUAT2rJJA==
X-CSE-MsgGUID: DZ0Dtg3pTSetgLeCLOsmnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78891412"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="78891412"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 13:59:00 -0700
X-CSE-ConnectionGUID: poO50ANxRuqHtclN0jUOPA==
X-CSE-MsgGUID: kAOTgSngQS20UK1KEFP9RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="234750759"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.139])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 13:59:00 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	=?UTF-8?q?=EA=B9=80=EC=98=81=EB=AF=BC?= <osori@hspace.io>,
	Oleg Nesterov <oleg@redhat.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] x86: shadow stacks: proper error handling for mmap lock
Date: Mon,  4 May 2026 13:58:56 -0700
Message-ID: <20260504205856.536296-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C7A524C3D4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243915-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rick.p.edgecombe@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,hspace.io:email]

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
index 059685612362d..0dc983b33b003 100644
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
index de9dc20b01ba7..004112f118eab 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -114,7 +114,7 @@ static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
 	__mmap_lock_trace_acquire_returned(mm, true, true);
 }
 
-static inline int mmap_write_lock_killable(struct mm_struct *mm)
+static inline int __must_check mmap_write_lock_killable(struct mm_struct *mm)
 {
 	int ret;
 
@@ -145,7 +145,7 @@ static inline void mmap_read_lock(struct mm_struct *mm)
 	__mmap_lock_trace_acquire_returned(mm, false, true);
 }
 
-static inline int mmap_read_lock_killable(struct mm_struct *mm)
+static inline int __must_check mmap_read_lock_killable(struct mm_struct *mm)
 {
 	int ret;
 
@@ -155,7 +155,7 @@ static inline int mmap_read_lock_killable(struct mm_struct *mm)
 	return ret;
 }
 
-static inline bool mmap_read_trylock(struct mm_struct *mm)
+static inline bool __must_check mmap_read_trylock(struct mm_struct *mm)
 {
 	bool ret;
 
-- 
2.54.0


