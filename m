Return-Path: <stable+bounces-220519-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iK5eLrA6o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220519-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:57:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B6A1C6755
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A3F03068A77
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6835F3CD180;
	Sat, 28 Feb 2026 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLcUp3uA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290993CCA1C;
	Sat, 28 Feb 2026 17:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300403; cv=none; b=LYUIXhq4/PdyFWl3c6i4NB371eV8dbzy7eFB+abiWdzJeIFZGaQwGj63W0iP25KJX+D1PZXDvifrQ01+audf6oqp6oEc6Je664JDZyfB+X27OdEolK3+0nmUKRoNfNTjpi7oRpQLwO0FW54wdZ+GnC8Tgt3+ALGIrdWzIUAZedI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300403; c=relaxed/simple;
	bh=XiDpqIsE+Q9+ban9oyun+ipydHoaR3GRXevI8VVtrhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VD5wBXqzrt86h4cK1xcTt7jLOLqaf8QpzKUgSbIv0Vfs6SGJGXD8zG6O2Wq+skBDQeWNwinri8+g8j9LcnagvOX8UzNR02SKKMe+XQNmCTjvBQbvQlqVA38bPkNF7pjd61vpinzzpgmvtXBYCQxaC0GQTlKRkwmW+IoB5U0V3IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLcUp3uA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BC0C116D0;
	Sat, 28 Feb 2026 17:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300402;
	bh=XiDpqIsE+Q9+ban9oyun+ipydHoaR3GRXevI8VVtrhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vLcUp3uAYY9Qr7DsNFKahKTKU/bR4D73HPn2nDLjunHEn0FdYCERnA3b4U6Lclx4e
	 iT6hbNdRu0+iyq7aYqRYn8oEyzoLFPEJP50SS7e5iXuoSACQNw0C0ZnHwkZbHTzpgd
	 GrsKmDYsYeGYrLnEvQE1gywc8VTfqQgUJowM9eSR6ptUuG3CAjPCgx5Uj+G6G8zJ0N
	 TNfYEoHui6ClnwfymyDiB96nC3beqkSB10e3kAECsnXCkko5dsvroAdXjK74BalUiK
	 I4PqzljK9cuIBtS137rWGNzxXRldpS08Z1Y40JLqofWHIqlZDG03nzVVjok53aswdJ
	 yueP94m2LDXZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 440/844] arm64: hugetlbpage: avoid unused-but-set-parameter warning (gcc-16)
Date: Sat, 28 Feb 2026 12:25:53 -0500
Message-ID: <20260228173244.1509663-441-sashal@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220519-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arndb.de:email,arm.com:email]
X-Rspamd-Queue-Id: 69B6A1C6755
X-Rspamd-Action: no action

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 729a2e8e9ac47099a967567389cc9d73ef4194ca ]

gcc-16 warns about an instance that older compilers did not:

arch/arm64/mm/hugetlbpage.c: In function 'huge_pte_clear':
arch/arm64/mm/hugetlbpage.c:369:57: error: parameter 'addr' set but not used [-Werror=unused-but-set-parameter=]

The issue here is that __pte_clear() does not actually use its second
argument, but when CONFIG_ARM64_CONTPTE is enabled it still gets
updated.

Replace the macro with an inline function to let the compiler see
the argument getting passed down.

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/pgtable.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 64d5f1d9cce96..5ab5fe3bef25e 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -179,8 +179,6 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 	__pte(__phys_to_pte_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
 
 #define pte_none(pte)		(!pte_val(pte))
-#define __pte_clear(mm, addr, ptep) \
-				__set_pte(ptep, __pte(0))
 #define pte_page(pte)		(pfn_to_page(pte_pfn(pte)))
 
 /*
@@ -1320,6 +1318,13 @@ static inline bool pud_user_accessible_page(pud_t pud)
 /*
  * Atomic pte/pmd modifications.
  */
+
+static inline void __pte_clear(struct mm_struct *mm,
+			       unsigned long addr, pte_t *ptep)
+{
+	__set_pte(ptep, __pte(0));
+}
+
 static inline int __ptep_test_and_clear_young(struct vm_area_struct *vma,
 					      unsigned long address,
 					      pte_t *ptep)
-- 
2.51.0


