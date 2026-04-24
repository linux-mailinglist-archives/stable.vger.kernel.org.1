Return-Path: <stable+bounces-240549-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QODEFdjV6mlQEgAAu9opvQ
	(envelope-from <stable+bounces-240549-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 04:30:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1121458FB7
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 04:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFCFE3011585
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 02:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8AA2253EC;
	Fri, 24 Apr 2026 02:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Tbm+Qd9A"
X-Original-To: stable@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4116F33E7
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776997835; cv=none; b=tmmPZcpQvKxEeYLAKNnDoV14b7LqTF8u7Elu9RW2zI/JIqnbBTa6EMr8JYnu2+0T2YzM678wUD1qautQvXMPvnyA4WRcekDGxc3Fm+PGw5zTvb1AizdkrKOwp/jBNKCbsVBQEMzQHNRPrjADxaHcQKqPSZnkKdrpSYXouvNirGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776997835; c=relaxed/simple;
	bh=8pEnnD41yxIR3nLVFwLRZILWOASlPifVA1qeKcRpiCo=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=RfugoTWm0z8sqpDwLNf10LT2/kx73p3jstZyetExrp3n4RyMxXBGLAK2h1nVcKH1hblcOFerikxd+T+sXNNnXycTjqPHhov8KPCBqp9cgvBpk8SRNR6TE82IVdZ+yfvbqCrJM62DqWpNJyiiz7uHcRPGfe267z8Jtup20e51ke8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Tbm+Qd9A; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1776997823;
	bh=0OrM2zulGw7FX0n14ZZhn63gz9NxxF3iSw5fX5FUW3w=;
	h=From:To:Cc:Subject:Date;
	b=Tbm+Qd9AVN1TYdped8ElU571cHa/rqoFaOBtUkkorBUsnzEWLaVUO3PF6Jmqbq8fw
	 g64DvrtssFl9xMW7fSIuEHHRcfn+FsZZ94V/DTNuqg4/tG1gG7nMRKFI42LnRCrk9f
	 G4tYbkpgyqXiVh2Vma5mj5nJeCx+p58fqfYKbZ6I=
Received: from China-team ([183.241.55.34])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 72519857; Fri, 24 Apr 2026 10:28:37 +0800
X-QQ-mid: xmsmtpt1776997717tdh861y2f
Message-ID: <tencent_581BD6694B6AC63E30240FAD05708C600A09@qq.com>
X-QQ-XMAILINFO: NdJjTjI40ejMgBKJsit9mgL+lqrJRZug5RzCxPshV1O78ePq59uch1ZGt2k3ld
	 p56OERgcgz8kBdlKJfaOBF++NyN9ca4aEZAWCW75Nn+0178dJun7nEwLov9jWnXVrzlGW92CxlZL
	 a8t1u2V3zf+XLSGrr0+9oM88SRvWmalah/BCSeE2EOTn7zEZhC46uMQ5K66mcTZfowMnOtvKzJs7
	 rnP9jGo7HRM5JxIw/5nGBu0v5DsJB+/EZ1kFJNoWDrZ8NMG8pjUBPllhnKARkD4N70mPYejAtTri
	 u/tnHW8fV92e0p1q+SufdpwhOK/t3t5CZpMuzk/jVU32+8n1o9YGEe7P3Vr9xWt+Np0uiGWNeKF2
	 HxDU+ASHAB5B10Kv4X/LWym/NWIXO32qTqeic56sBtWe2rzDU1k/FnsS8vOk3IgSsa26r5ea5ttH
	 cIK7//L7RvEpcIrT4e6Ym/F+lr6Nnvj0lZXoL45HIKt1aL6+Q4SWMSch6IBFieMnVyHPhi3xJ9nX
	 4E4YnhNbei/DYPa+Jh5ZyUDGLn5L0NBpTDUu99hltwwarIFaMj+P1V6JKcfKGD7eukebO3X+WPe/
	 mYXDZvnY7Ewd5gf6EWFelqQEuFTAGtQFY7A849YdiZA37RwkvYqSpS6+34E6LjiEElBLdRBrZHWX
	 TBsIIqNgphMACPjl7hgCOkkxdsLwpJHzHJJBEbwTypKJIbU6xhfHjN/Dpncgu54dccJwXEXHQs9m
	 1MklNWn+KB89I+HgyWktntGjXMWZmJsuUY1oGObjK/lq6xC3Jx+sBQpB6oQ7Vu3R067J9muUqn8r
	 1pkwCr7FgNGholXL5xLnZ4xuaCYIO2+6FjaWnzdjB3dEyfjLCdNLZo+UXOJWVszfJIpWyglbeAoQ
	 GslHy/wMyQ0X/vvnwcGweIFYCcWCmxu85uRPNnc7qWG95Aa1XeVc5jdse4VC0oCQNzFpz8YpySlz
	 1uj9jt0qXqi5kOVf9lFAYJoiv9EVLJWcfUj57efx/TfrceHOOrHHVYlN/BmzBLoD4mjA9R/goAYA
	 i/R7b6OblUhFSfbtemkMrp7CTctaKeF/jEN/gjfAKagdybgg1vjImIPKN0R9CNEqHaGOBjlRL1Lo
	 KAqReCq+JbzMkGiqMReyfpYQ1qbg==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Steve Capper <steve.capper@arm.com>,
	Will Deacon <will@kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.1.y] arm64: mm: fix VA-range sanity check
Date: Fri, 24 Apr 2026 10:28:21 +0800
X-OQ-MSGID: <20260424022821.470-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D1121458FB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240549-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[arm.com,armlinux.org.uk,kernel.org,foxmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[foxmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,kernel];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit ab9b4008092c86dc12497af155a0901cc1156999 ]

Both create_mapping_noalloc() and update_mapping_prot() sanity-check
their 'virt' parameter, but the check itself doesn't make much sense.
The condition used today appears to be a historical accident.

The sanity-check condition:

	if ((virt >= PAGE_END) && (virt < VMALLOC_START)) {
		[ ... warning here ... ]
		return;
	}

... can only be true for the KASAN shadow region or the module region,
and there's no reason to exclude these specifically for creating and
updateing mappings.

When arm64 support was first upstreamed in commit:

  c1cc1552616d0f35 ("arm64: MMU initialisation")

... the condition was:

	if (virt < VMALLOC_START) {
		[ ... warning here ... ]
		return;
	}

At the time, VMALLOC_START was the lowest kernel address, and this was
checking whether 'virt' would be translated via TTBR1.

Subsequently in commit:

  14c127c957c1c607 ("arm64: mm: Flip kernel VA space")

... the condition was changed to:

	if ((virt >= VA_START) && (virt < VMALLOC_START)) {
		[ ... warning here ... ]
		return;
	}

This appear to have been a thinko. The commit moved the linear map to
the bottom of the kernel address space, with VMALLOC_START being at the
halfway point. The old condition would warn for changes to the linear
map below this, and at the time VA_START was the end of the linear map.

Subsequently we cleaned up the naming of VA_START in commit:

  77ad4ce69321abbe ("arm64: memory: rename VA_START to PAGE_END")

... keeping the erroneous condition as:

	if ((virt >= PAGE_END) && (virt < VMALLOC_START)) {
		[ ... warning here ... ]
		return;
	}

Correct the condition to check against the start of the TTBR1 address
space, which is currently PAGE_OFFSET. This simplifies the logic, and
more clearly matches the "outside kernel range" message in the warning.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://lore.kernel.org/r/20230615102628.1052103-1-mark.rutland@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
The fix has been backported to the Linux 5.10 and 5.15 stable trees:
  - 5.10.188: commit 32020fc2a837 ("arm64: mm: fix VA-range sanity check")
  - 5.15.150: commit 621619f626cb ("arm64: mm: fix VA-range sanity check")

This patch is backported to the Linux 6.1 stable tree.
---
 arch/arm64/mm/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e9288b28cb1e..1200527a02d6 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -451,7 +451,7 @@ static phys_addr_t pgd_pgtable_alloc(int shift)
 static void __init create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
 				  phys_addr_t size, pgprot_t prot)
 {
-	if ((virt >= PAGE_END) && (virt < VMALLOC_START)) {
+	if (virt < PAGE_OFFSET) {
 		pr_warn("BUG: not creating mapping for %pa at 0x%016lx - outside kernel range\n",
 			&phys, virt);
 		return;
@@ -478,7 +478,7 @@ void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
 				phys_addr_t size, pgprot_t prot)
 {
-	if ((virt >= PAGE_END) && (virt < VMALLOC_START)) {
+	if (virt < PAGE_OFFSET) {
 		pr_warn("BUG: not updating mapping for %pa at 0x%016lx - outside kernel range\n",
 			&phys, virt);
 		return;
-- 
2.43.0


