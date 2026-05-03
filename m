Return-Path: <stable+bounces-242691-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MQpKDI292nQdQIAu9opvQ
	(envelope-from <stable+bounces-242691-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 13:49:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EB54B5645
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 13:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DEA27300231F
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 11:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E772E093A;
	Sun,  3 May 2026 11:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fPE30lpU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6776F223323
	for <stable@vger.kernel.org>; Sun,  3 May 2026 11:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777808942; cv=none; b=DOw1hcCdalAGwPBLcV4AtWA71YUoe+M3yMrwsDx1GUSQ6Ix23Kfe7CnpElVGsPBdYYNXpawgnakmdv3J9KgJ7Xbnf8QTyXQHX+TAoQqhHHP/U7yhzZCqeZAKyqD7Md6ogX/tZIYHiIEpO9XqAJnm9bJ/KZOEaGESXDpsi4ueQPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777808942; c=relaxed/simple;
	bh=NX+c3VnpLEUyX9N7DohYf4hYZqP+oDn0r5qgAe98Ebo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=afr+TZ9GQTg+JpP6GtGdC/AGPgbcdU4GiEuU5tUh28Zy02c694Ax7j8WPec9fmM0Xl0IsOFUZNmqTbMKIPuk5hmyEBSdw54L//GlaiTiOE0DHAtz7AK7A1Ipfkldo7HJtVIEqSgaDvvF8XQilUKeu2XCOgHIDdxJ7bmadR9mzuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fPE30lpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA075C2BCB4;
	Sun,  3 May 2026 11:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777808942;
	bh=NX+c3VnpLEUyX9N7DohYf4hYZqP+oDn0r5qgAe98Ebo=;
	h=Subject:To:Cc:From:Date:From;
	b=fPE30lpU2Bf0Ek0+b4yqbGYd5QwwLDWpAIHUGgteS1TFM1mEOFJFsrKo9/p3tesAK
	 vQzCrq49nqLRBraGIvycJLHIAnwzLuCDUdWQIxLPe7duI0jpdR+GCwi7CqhIhDTf8x
	 pjEOShRZD4Rn1Ce07ptRrvihhVoVGwgt3Gs30yKo=
Subject: FAILED: patch "[PATCH] mm/memory: fix PMD/PUD checks in follow_pfnmap_start()" failed to apply to 6.12-stable tree
To: david@kernel.org,akpm@linux-foundation.org,liam.howlett@oracle.com,ljs@kernel.org,mhocko@suse.com,peterx@redhat.com,rppt@kernel.org,stable@vger.kernel.org,surenb@google.com,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 May 2026 13:48:47 +0200
Message-ID: <2026050347-zigzagged-portal-87c9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 87EB54B5645
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242691-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,gregkh:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 26e7888a0c89e36332c1e897e4887f69e1e9c751
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050347-zigzagged-portal-87c9@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 26e7888a0c89e36332c1e897e4887f69e1e9c751 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 23 Mar 2026 21:20:18 +0100
Subject: [PATCH] mm/memory: fix PMD/PUD checks in follow_pfnmap_start()

follow_pfnmap_start() suffers from two problems:

(1) We are not re-fetching the pmd/pud after taking the PTL

Therefore, we are not properly stabilizing what the lock actually
protects.  If there is concurrent zapping, we would indicate to the
caller that we found an entry, however, that entry might already have
been invalidated, or contain a different PFN after taking the lock.

Properly use pmdp_get() / pudp_get() after taking the lock.

(2) pmd_leaf() / pud_leaf() are not well defined on non-present entries

pmd_leaf()/pud_leaf() could wrongly trigger on non-present entries.

There is no real guarantee that pmd_leaf()/pud_leaf() returns something
reasonable on non-present entries.  Most architectures indeed either
perform a present check or make it work by smart use of flags.

However, for example loongarch checks the _PAGE_HUGE flag in pmd_leaf(),
and always sets the _PAGE_HUGE flag in __swp_entry_to_pmd().  Whereby
pmd_trans_huge() explicitly checks pmd_present(), pmd_leaf() does not do
that.

Let's check pmd_present()/pud_present() before assuming "the is a present
PMD leaf" when spotting pmd_leaf()/pud_leaf(), like other page table
handling code that traverses user page tables does.

Given that non-present PMD entries are likely rare in VM_IO|VM_PFNMAP, (1)
is likely more relevant than (2).  It is questionable how often (1) would
actually trigger, but let's CC stable to be sure.

This was found by code inspection.

Link: https://lkml.kernel.org/r/20260323-follow_pfnmap_fix-v1-1-5b0ec10872b3@kernel.org
Fixes: 6da8e9634bb7 ("mm: new follow_pfnmap API")
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/memory.c b/mm/memory.c
index 6d54e5ec82f2..425e852a2eb7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6824,11 +6824,16 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
 
 	pudp = pud_offset(p4dp, address);
 	pud = pudp_get(pudp);
-	if (pud_none(pud))
+	if (!pud_present(pud))
 		goto out;
 	if (pud_leaf(pud)) {
 		lock = pud_lock(mm, pudp);
-		if (!unlikely(pud_leaf(pud))) {
+		pud = pudp_get(pudp);
+
+		if (unlikely(!pud_present(pud))) {
+			spin_unlock(lock);
+			goto out;
+		} else if (unlikely(!pud_leaf(pud))) {
 			spin_unlock(lock);
 			goto retry;
 		}
@@ -6840,9 +6845,16 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
 
 	pmdp = pmd_offset(pudp, address);
 	pmd = pmdp_get_lockless(pmdp);
+	if (!pmd_present(pmd))
+		goto out;
 	if (pmd_leaf(pmd)) {
 		lock = pmd_lock(mm, pmdp);
-		if (!unlikely(pmd_leaf(pmd))) {
+		pmd = pmdp_get(pmdp);
+
+		if (unlikely(!pmd_present(pmd))) {
+			spin_unlock(lock);
+			goto out;
+		} else if (unlikely(!pmd_leaf(pmd))) {
 			spin_unlock(lock);
 			goto retry;
 		}


