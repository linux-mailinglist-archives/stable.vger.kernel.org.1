Return-Path: <stable+bounces-231062-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGtXICBDymky7AUAu9opvQ
	(envelope-from <stable+bounces-231062-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:32:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DF23583A5
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 561E1301A416
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7013A1A38;
	Mon, 30 Mar 2026 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G4GhK2y5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3022D37FF4B
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774862686; cv=none; b=Jh+3V6bRcOGHsAdF65RHnZ+1MZ6O7rZC2EZMQB/11ia0rVbh6Owx7L305g9dRt9hYL2bsrW9l+Kev36wUdGWbVbzXmRLij0eZAm00rdBdvAU5z83W19c4/jubNgMNesvFILvywdWyLmOuxPJy1XFHjhDc6iqVAnC/L/Qo51PW/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774862686; c=relaxed/simple;
	bh=ButcmC2lKFOYkgx+1wXjq0T3b/C7hclRMzLIAlMKxm8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=i9Uq8UJOCXU9adlHi6jfhw+pWs3/nowACjbaIrrFjRpIVg66Z2PWNI6igrl0fuRISY1zLt4ETJU/VYgFxfcBm+8EWe1F6Kvj0Fd95FBrhPiPxeqXCm3ONxTdyNcLf09Ox+zopM3dp4JTVBZVSZuxJ7GQ1bu+JHChfODHhzQYsDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G4GhK2y5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9118EC2BCB1;
	Mon, 30 Mar 2026 09:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774862686;
	bh=ButcmC2lKFOYkgx+1wXjq0T3b/C7hclRMzLIAlMKxm8=;
	h=Subject:To:Cc:From:Date:From;
	b=G4GhK2y5xwmAbwoaRqYuqVhDP3URumogcSu6xpAlW5Fk4SJI4Y5TsLMZgJ754qbpf
	 YEzhnW2BimFHBn1d5ve4HSi7cmb/Z1YDLS9CPUw+w/HTjAVdcRFebSUbAuL7/jJ0F2
	 RMNidZwXJmrzoaVBwZ04h/v7nL+JNzgwm9egXEtU=
Subject: FAILED: patch "[PATCH] mm/huge_memory: fix folio isn't locked in softleaf_to_folio()" failed to apply to 6.6-stable tree
To: tujinjiang@huawei.com,akpm@linux-foundation.org,baohua@kernel.org,david@kernel.org,liam.howlett@oracle.com,ljs@kernel.org,mhocko@suse.com,rppt@kernel.org,ryan.roberts@arm.com,stable@vger.kernel.org,sunnanyong@huawei.com,surenb@google.com,vbabka@kernel.org,wangkefeng.wang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 11:24:37 +0200
Message-ID: <2026033037-lethargic-pandemic-39fa@gregkh>
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
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231062-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15]
X-Rspamd-Queue-Id: 87DF23583A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 4c5e7f0fcd592801c9cc18f29f80fbee84eb8669
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033037-lethargic-pandemic-39fa@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4c5e7f0fcd592801c9cc18f29f80fbee84eb8669 Mon Sep 17 00:00:00 2001
From: Jinjiang Tu <tujinjiang@huawei.com>
Date: Thu, 19 Mar 2026 09:25:41 +0800
Subject: [PATCH] mm/huge_memory: fix folio isn't locked in softleaf_to_folio()

On arm64 server, we found folio that get from migration entry isn't locked
in softleaf_to_folio().  This issue triggers when mTHP splitting and
zap_nonpresent_ptes() races, and the root cause is lack of memory barrier
in softleaf_to_folio().  The race is as follows:

	CPU0                                             CPU1

deferred_split_scan()                              zap_nonpresent_ptes()
  lock folio
  split_folio()
    unmap_folio()
      change ptes to migration entries
    __split_folio_to_order()                         softleaf_to_folio()
      set flags(including PG_locked) for tail pages    folio = pfn_folio(softleaf_to_pfn(entry))
      smp_wmb()                                        VM_WARN_ON_ONCE(!folio_test_locked(folio))
      prep_compound_page() for tail pages

In __split_folio_to_order(), smp_wmb() guarantees page flags of tail pages
are visible before the tail page becomes non-compound.  smp_wmb() should
be paired with smp_rmb() in softleaf_to_folio(), which is missed.  As a
result, if zap_nonpresent_ptes() accesses migration entry that stores tail
pfn, softleaf_to_folio() may see the updated compound_head of tail page
before page->flags.

This issue will trigger VM_WARN_ON_ONCE() in pfn_swap_entry_folio()
because of the race between folio split and zap_nonpresent_ptes()
leading to a folio incorrectly undergoing modification without a folio
lock being held.

This is a BUG_ON() before commit 93976a20345b ("mm: eliminate further
swapops predicates"), which in merged in v6.19-rc1.

To fix it, add missing smp_rmb() if the softleaf entry is migration entry
in softleaf_to_folio() and softleaf_to_page().

[tujinjiang@huawei.com: update function name and comments]
  Link: https://lkml.kernel.org/r/20260321075214.3305564-1-tujinjiang@huawei.com
Link: https://lkml.kernel.org/r/20260319012541.4158561-1-tujinjiang@huawei.com
Fixes: e9b61f19858a ("thp: reintroduce split_huge_page()")
Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Cc: Barry Song <baohua@kernel.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Nanyong Sun <sunnanyong@huawei.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/leafops.h b/include/linux/leafops.h
index a9ff94b744f2..05673d3529e7 100644
--- a/include/linux/leafops.h
+++ b/include/linux/leafops.h
@@ -363,6 +363,23 @@ static inline unsigned long softleaf_to_pfn(softleaf_t entry)
 	return swp_offset(entry) & SWP_PFN_MASK;
 }
 
+static inline void softleaf_migration_sync(softleaf_t entry,
+		struct folio *folio)
+{
+	/*
+	 * Ensure we do not race with split, which might alter tail pages into new
+	 * folios and thus result in observing an unlocked folio.
+	 * This matches the write barrier in __split_folio_to_order().
+	 */
+	smp_rmb();
+
+	/*
+	 * Any use of migration entries may only occur while the
+	 * corresponding page is locked
+	 */
+	VM_WARN_ON_ONCE(!folio_test_locked(folio));
+}
+
 /**
  * softleaf_to_page() - Obtains struct page for PFN encoded within leaf entry.
  * @entry: Leaf entry, softleaf_has_pfn(@entry) must return true.
@@ -374,11 +391,8 @@ static inline struct page *softleaf_to_page(softleaf_t entry)
 	struct page *page = pfn_to_page(softleaf_to_pfn(entry));
 
 	VM_WARN_ON_ONCE(!softleaf_has_pfn(entry));
-	/*
-	 * Any use of migration entries may only occur while the
-	 * corresponding page is locked
-	 */
-	VM_WARN_ON_ONCE(softleaf_is_migration(entry) && !PageLocked(page));
+	if (softleaf_is_migration(entry))
+		softleaf_migration_sync(entry, page_folio(page));
 
 	return page;
 }
@@ -394,12 +408,8 @@ static inline struct folio *softleaf_to_folio(softleaf_t entry)
 	struct folio *folio = pfn_folio(softleaf_to_pfn(entry));
 
 	VM_WARN_ON_ONCE(!softleaf_has_pfn(entry));
-	/*
-	 * Any use of migration entries may only occur while the
-	 * corresponding folio is locked.
-	 */
-	VM_WARN_ON_ONCE(softleaf_is_migration(entry) &&
-			!folio_test_locked(folio));
+	if (softleaf_is_migration(entry))
+		softleaf_migration_sync(entry, folio);
 
 	return folio;
 }


