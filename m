Return-Path: <stable+bounces-230009-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLWXOjKiwWknUQQAu9opvQ
	(envelope-from <stable+bounces-230009-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 21:27:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 801FF2FD32B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 21:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A25593056B5C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 20:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CCD3B9600;
	Mon, 23 Mar 2026 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3tjUud9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B70E3D6483;
	Mon, 23 Mar 2026 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297237; cv=none; b=MixkbWPR4xoWB0evfEHzq9vJG9W6jpyVK8S9KM4NniVXSUwCjUowQ3Z4wg/swVdBYqLVAtI9ahy7YGddVUoCoDqVSZtHu91jul7KU5O9LCBS5iRA12KEtHiuJ6Y9m1qT0OjnNbl4uo8/DBQo/600GL7ZsrlN4F8BnQiQxfAaBF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297237; c=relaxed/simple;
	bh=ZLHOz0Vhge18irIpqyrf1TiEfpaeI3B97dPXYKcSdrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bsenZiyr5mNikDZFKRf6Kf0yMiNIECFYJk7kZZX8BUfpBy8cLmW1b4iHp0KL4JeBs1c4stiqxaSBhzUgzB++r/b8USlLAXCkKxVkc/f529RPv6mhT6tFL/+pns4Mjns9Ct89qkmpOUWzJHXAQnFtpajGAZY1oLciP8jdWLXvz/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3tjUud9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A27FC4CEF7;
	Mon, 23 Mar 2026 20:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774297236;
	bh=ZLHOz0Vhge18irIpqyrf1TiEfpaeI3B97dPXYKcSdrA=;
	h=From:Date:Subject:To:Cc:From;
	b=m3tjUud9rFQPQaZyJRAY9SpAB1DNiJyc+UcwiuLzB5h0bY7pWHYTYSvTH943RsHEO
	 6e5Pi39Rrzpwf1yLjJdW5h+d9YsESPw4H4N2I/VwEwP7wlqIKKYg3w6Ri/Mi2tigFw
	 8KEBNgavyP22XjykBTcUyoumFbUZM5qmvpcGQRASgiRkoucX3jVgvhUPgnqbIbb99D
	 gfxNlCrmVoav1OeK7xP4IbeLmB/iHgFXlSXwbY7MfEcqOoXZOPjdVymGoRowRRJltB
	 CcFIdqirNL0d+XC3hvXe1nEIV59llQ5nvAfPKp/FOewg5vixNtfoEk0EBW7KHtgmbl
	 SAIyJxcnZYLVA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 23 Mar 2026 21:20:18 +0100
Subject: [PATCH] mm/memory: fix PMD/PUD checks in follow_pfnmap_start()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-follow_pfnmap_fix-v1-1-5b0ec10872b3@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIGgwWkC/x2MWwqAIBAArxL7nVBuL7pKRGittVAqChVEd0/6n
 IGZByIFpgh99kCgkyM7m6DMM5g3ZVcSvCQGWcimQInCuH131+SNPZSfDN9CK90iYl01nYLU+UB
 J/89hfN8PJTkTEWMAAAA=
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, 
 Alex Williamson <alex@shazbot.org>, Max Boone <mboone@akamai.com>, 
 stable@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230009-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 801FF2FD32B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

follow_pfnmap_start() suffers from two problems:

(1) We are not re-fetching the pmd/pud after taking the PTL

Therefore, we are not properly stabilizing what the lock lock actually
protects. If there is concurrent zapping, we would indicate to the
caller that we found an entry, however, that entry might already have
been invalidated, or contain a different PFN after taking the lock.

Properly use pmdp_get() / pudp_get() after taking the lock.

(2) pmd_leaf() / pud_leaf() are not well defined on non-present entries

pmd_leaf()/pud_leaf() could wrongly trigger on non-present entries.

There is no real guarantee that pmd_leaf()/pud_leaf() returns something
reasonable on non-present entries. Most architectures indeed either
perform a present check or make it work by smart use of flags.

However, for example loongarch checks the _PAGE_HUGE flag in pmd_leaf(),
and always sets the _PAGE_HUGE flag in __swp_entry_to_pmd(). Whereby
pmd_trans_huge() explicitly checks pmd_present(), pmd_leaf() does not
do that.

Let's check pmd_present()/pud_present() before assuming "the is a
present PMD leaf" when spotting pmd_leaf()/pud_leaf(), like other page
table handling code that traverses user page tables does.

Given that non-present PMD entries are likely rare in VM_IO|VM_PFNMAP,
(1) is likely more relevant than (2). It is questionable how often (1)
would actually trigger, but let's CC stable to be sure.

This was found by code inspection.

Fixes: 6da8e9634bb7 ("mm: new follow_pfnmap API")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
Gave it a quick test in a VM with MM selftests etc, but I am not sure if
I actually trigger the follow_pfnmap machinery.
---
 mm/memory.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 219b9bf6cae0..2921d35c50ae 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6868,11 +6868,16 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
 
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
@@ -6884,9 +6889,16 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
 
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

---
base-commit: 3f4f1faa33544d0bd724e32980b6f211c3a9bc7b
change-id: 20260323-follow_pfnmap_fix-bab73335468a

Best regards,
-- 
David Hildenbrand (Arm) <david@kernel.org>


