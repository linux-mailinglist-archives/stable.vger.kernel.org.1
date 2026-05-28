Return-Path: <stable+bounces-254864-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGpHNvQpGGrneggAu9opvQ
	(envelope-from <stable+bounces-254864-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:41:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCF35F16AC
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8312F300B466
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B559F3E51FC;
	Thu, 28 May 2026 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j9YM91F6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A923E51F5
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968492; cv=none; b=Ara79HP6RkjIbw53QKyBdNMoXS/MTtim3asRe9Z+EOmO1f5s4JpMKQmmxntXFImIop/tqKfYRFPXCfTvW9pEoXBQpsjLZJHVA7EiNegQEM9QUPG4m6g2MjimdzLP8QKtp6B8cJ7sJ4PCR4KTs9WwytZhQwm+MH2DbqnlrplYM20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968492; c=relaxed/simple;
	bh=bSZIJbi958YQVDEl5RtXA59f1w3iSYPpUtGdsZvAp1A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=o5XQdEVluxRO2b5VMYIeYmliHtTFOKAUt9XQpMvuU7moWqrkzkk9gw0qL77FkntHYYQ+1Rgd/vNU3wpnORqpmPbmfEZ1WmVJXVUoMaX8Q4t4HwLdoshNDp8ber4OFYto/EE9oqDhPGBJZd0l746zh/AMoionScs7YInW5BWYejw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j9YM91F6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA1E1F000E9;
	Thu, 28 May 2026 11:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779968491;
	bh=TYQD0qEsBZ7KBrx0tai2JZiKAyhsXDwAyZEfWtIFZPk=;
	h=Subject:To:Cc:From:Date;
	b=j9YM91F6dnZFS1tEfQHW06CyYJx3lJhZQ7sBwK0xh4QjKTioxz5+IqNQsvbA/6fPV
	 pf8YexSAaaEPLi256LGLsL4zWcCDvvCB2YCYtMtkv2SRyDmFQLjKbFrEggdTjGO+U5
	 XxezECGmrr/18uq54NBcDYruxskloTRtUNhwX3LU=
Subject: FAILED: patch "[PATCH] arm64: tlb: Flush walk cache when unsharing PMD tables" failed to apply to 6.12-stable tree
To: zengheng4@huawei.com,catalin.marinas@arm.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 13:40:33 +0200
Message-ID: <2026052833-matter-helmet-c510@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254864-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,arm.com:email,huawei.com:email]
X-Rspamd-Queue-Id: 7FCF35F16AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c2ff4764e03e7a8d758352f4aceb8fe1be6ac971
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052833-matter-helmet-c510@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c2ff4764e03e7a8d758352f4aceb8fe1be6ac971 Mon Sep 17 00:00:00 2001
From: Zeng Heng <zengheng4@huawei.com>
Date: Thu, 21 May 2026 15:30:11 +0800
Subject: [PATCH] arm64: tlb: Flush walk cache when unsharing PMD tables

When huge_pmd_unshare() is called to unshare a PMD table, the
tlb_unshare_pmd_ptdesc() function sets tlb->unshared_tables=true
but the aarch64 tlb_flush() only checked tlb->freed_tables to
determine whether to use TLBF_NONE (vae1is, invalidates walk
cache) or TLBF_NOWALKCACHE (vale1is, leaf-only).

This caused the stale PMD page table entry to remain in the walk cache
after unshare, potentially leading to incorrect page table walks.

Fix by including unshared_tables in the check, so that when
unsharing tables, TLBF_NONE is used and the walk cache is properly
invalidated.

Here is the detailed distinction between vae1is and vale1is:

| Instruction Combination  | Actual Invalidation Scope                         |
| ------------------------ | --------------------------------------------------|
| `VAE1IS`  + TTL=`0`      | All entries at all levels (full invalidation)     |
| `VAE1IS`  + TTL=`2` (L2) | Non-leaf at Level 0/1 + leaf at Level 2           |
| `VALE1IS` + TTL=`0`      | Leaf entries at all levels (non-leaf not cleared) |
| `VALE1IS` + TTL=`2` (L2) | Leaf entry at Level 2 only                        |

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
Fixes: 8ce720d5bd91 ("mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables using mmu_gather")
Cc: <stable@vger.kernel.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 10869d7731b8..751bd57bc3ba 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -53,7 +53,8 @@ static inline int tlb_get_level(struct mmu_gather *tlb)
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
 	struct vm_area_struct vma = TLB_FLUSH_VMA(tlb->mm, 0);
-	tlbf_t flags = tlb->freed_tables ? TLBF_NONE : TLBF_NOWALKCACHE;
+	tlbf_t flags = (tlb->freed_tables || tlb->unshared_tables) ?
+			TLBF_NONE : TLBF_NOWALKCACHE;
 	unsigned long stride = tlb_get_unmap_size(tlb);
 	int tlb_level = tlb_get_level(tlb);
 


