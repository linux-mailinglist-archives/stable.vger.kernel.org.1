Return-Path: <stable+bounces-227056-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM90AzeeumngZgIAu9opvQ
	(envelope-from <stable+bounces-227056-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 13:44:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 654242BBB88
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 13:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CA3331B994D
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EC53D6682;
	Wed, 18 Mar 2026 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j46d9L+q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3C21D88AC
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837576; cv=none; b=L1/0J/lwqFo90N+lLVymvm6MuCt5xpeh8VxL2+M7A+jidaE4BinzHdgE07RzfF7eh5KJa6pV8aqXSobiwWhK6K6pDY7lyjiKb1McPeq+TruOQiARxngUY4G3TrA/l1p/M9lrquMkJD3y6VWt0iO5IIhazMzVlPjHvYWz8CLCaeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837576; c=relaxed/simple;
	bh=72iiYQaqTIKFcQa08tHRnRAVaFNu9sTVqo1HVC+VCSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLijDUpEqUo1+mYbkqK0uLNF0F8QdC2KdCwvO15zYhEcv773v0GEgkl7ABql4akZWyW3boyJvciwSwKBxIhugfUYpdKlAV3LiKD8R8k73DEbYxErftpkFtpCV/0Pm8yL5MzQsiOCGYiIx5T0Gx9eu4MHJyPr5yZFuY15QUAalFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j46d9L+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53272C2BC87;
	Wed, 18 Mar 2026 12:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773837576;
	bh=72iiYQaqTIKFcQa08tHRnRAVaFNu9sTVqo1HVC+VCSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j46d9L+qHh1MlrlPyrEo/KyzKARg3Raf/vAAt7YwdU7oA97dIAqRbeoCakOfQML2R
	 wor8FuaDKuhfRuhOZNZcRJAfDdE+PRJwB183Gd5yqd/0x9FDqSDN3U/KjzGs6cjNZl
	 y4mPgV8zIFrEyqfgO63bpQecxRt8NOUjGq9LQm5jBe5qLgYfaXVPj1lqdgtDIfKZiT
	 0AZvtmEOL2qjnR5d3myLCMSVmqLqTheu0pYNVzPD7ial6G1RBZX5nZYa+gOq20vmsC
	 Dn0K2kDjv8UOn45RxMGTm3ZoQFA0Xm3kqeAruNADuM4tcXojmJHNJyUQDtPOuqYooj
	 dkASJnDm4Povg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Jianpeng Chang <jianpeng.chang.cn@windriver.com>,
	Will Deacon <will@kernel.org>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] arm64: mm: Add PTE_DIRTY back to PAGE_KERNEL* to fix kexec/hibernation
Date: Wed, 18 Mar 2026 08:39:32 -0400
Message-ID: <20260318123932.704033-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260318123932.704033-1-sashal@kernel.org>
References: <2026031755-gravel-surfacing-cad8@gregkh>
 <20260318123932.704033-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227056-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,windriver.com:email,arm.com:email,roeck-us.net:email,alibaba.com:email]
X-Rspamd-Queue-Id: 654242BBB88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Catalin Marinas <catalin.marinas@arm.com>

[ Upstream commit c25c4aa3f79a488cc270507935a29c07dc6bddfc ]

Commit 143937ca51cc ("arm64, mm: avoid always making PTE dirty in
pte_mkwrite()") changed pte_mkwrite_novma() to only clear PTE_RDONLY
when PTE_DIRTY is set. This was to allow writable-clean PTEs for swap
pages that haven't actually been written.

However, this broke kexec and hibernation for some platforms. Both go
through trans_pgd_create_copy() -> _copy_pte(), which calls
pte_mkwrite_novma() to make the temporary linear-map copy fully
writable. With the updated pte_mkwrite_novma(), read-only kernel pages
(without PTE_DIRTY) remain read-only in the temporary mapping.
While such behaviour is fine for user pages where hardware DBM or
trapping will make them writeable, subsequent in-kernel writes by the
kexec relocation code will fault.

Add PTE_DIRTY back to all _PAGE_KERNEL* protection definitions. This was
the case prior to 5.4, commit aa57157be69f ("arm64: Ensure
VM_WRITE|VM_SHARED ptes are clean by default"). With the kernel
linear-map PTEs always having PTE_DIRTY set, pte_mkwrite_novma()
correctly clears PTE_RDONLY.

Fixes: 143937ca51cc ("arm64, mm: avoid always making PTE dirty in pte_mkwrite()")
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: stable@vger.kernel.org
Reported-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
Link: https://lore.kernel.org/r/20251204062722.3367201-1-jianpeng.chang.cn@windriver.com
Cc: Will Deacon <will@kernel.org>
Cc: Huang, Ying <ying.huang@linux.alibaba.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/pgtable-prot.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 2c49c93663f1f..cdec09baf74e7 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -44,11 +44,11 @@
 
 #define _PAGE_DEFAULT		(_PROT_DEFAULT | PTE_ATTRINDX(MT_NORMAL))
 
-#define _PAGE_KERNEL		(PROT_NORMAL)
-#define _PAGE_KERNEL_RO		((PROT_NORMAL & ~PTE_WRITE) | PTE_RDONLY)
-#define _PAGE_KERNEL_ROX	((PROT_NORMAL & ~(PTE_WRITE | PTE_PXN)) | PTE_RDONLY)
-#define _PAGE_KERNEL_EXEC	(PROT_NORMAL & ~PTE_PXN)
-#define _PAGE_KERNEL_EXEC_CONT	((PROT_NORMAL & ~PTE_PXN) | PTE_CONT)
+#define _PAGE_KERNEL		(PROT_NORMAL | PTE_DIRTY)
+#define _PAGE_KERNEL_RO		((PROT_NORMAL & ~PTE_WRITE) | PTE_RDONLY | PTE_DIRTY)
+#define _PAGE_KERNEL_ROX	((PROT_NORMAL & ~(PTE_WRITE | PTE_PXN)) | PTE_RDONLY | PTE_DIRTY)
+#define _PAGE_KERNEL_EXEC	((PROT_NORMAL & ~PTE_PXN) | PTE_DIRTY)
+#define _PAGE_KERNEL_EXEC_CONT	((PROT_NORMAL & ~PTE_PXN) | PTE_CONT | PTE_DIRTY)
 
 #define _PAGE_SHARED		(_PAGE_DEFAULT | PTE_USER | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN | PTE_WRITE)
 #define _PAGE_SHARED_EXEC	(_PAGE_DEFAULT | PTE_USER | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_WRITE)
-- 
2.51.0


