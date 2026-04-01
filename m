Return-Path: <stable+bounces-232825-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLinBolPzWkWbwYAu9opvQ
	(envelope-from <stable+bounces-232825-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 19:02:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3266B37E542
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 19:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 736083053778
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 16:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63E0477E40;
	Wed,  1 Apr 2026 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRXkikZi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2329308F26
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775061931; cv=none; b=EY0wfklHnOLKrlQiGYnyJ05jkfB1TPzurbycmqsZ+ZmAcqt5JASrDHfVR6TiCX+55W2gfDpaEx68LrkbuiEmA2MGzL6LIia3yN54xgZcyoD+T/bk4aHlawrcDZlEcvrDkOtce0hrPMLKR4TvVuP9fF3D2R6rdgfPLkevnORoi8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775061931; c=relaxed/simple;
	bh=3WGy125Z2CllwYHgNUY456JYX5aTUoILIAu03Q8blc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZN0s4ueCO4HPF1hGWQ5SeLMQZWoWFDDo+4xTgUBAj/INOuyTsQr20QrfG2CMFzMCtc8EQ9WkaopjBIYYKE3zXSguMGz5QrD4Xt7CUHr0iglqhbl3e/7lcnpIQFZt+jTojm8+UIcRKRXBoSKOe3SwnfpD4TKttnlo/9QmcCoNIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRXkikZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61819C19423;
	Wed,  1 Apr 2026 16:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775061930;
	bh=3WGy125Z2CllwYHgNUY456JYX5aTUoILIAu03Q8blc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YRXkikZiVk35UlRY/MrHX2uOcUwZvKbaLOySrZqUWvHcgxEsvx4u+WipUtn5AeFtw
	 t97GItbg81dT3nU+M+JZyulR3A3Ne01U8Q0CuIdkMb1Je5zoxn5gOhiOi08S/Jchj3
	 YbNY0TCE+Xy0QHjklFeOIulByh5l9zlgEUQy53K6lDCJEKmQoHcWJqI9lgDbc0P1XZ
	 GX/XIcLkdVAkZIxx/cFtoY5HlPMdUYnJtcxx8/JAGeYOdWVdkR0lHOjcYOIh+61MGD
	 o2thu1Podcb7WteR+EuURZ1/csRnTljkuyCNV6USOpfLr6SGaqnwH+sw6ry6X7+7hA
	 jGTBQtUfiPxGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	Liam Howlett <liam.howlett@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Xu <peterx@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] mm/memory: fix PMD/PUD checks in follow_pfnmap_start()
Date: Wed,  1 Apr 2026 12:45:26 -0400
Message-ID: <20260401164526.141913-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401164526.141913-1-sashal@kernel.org>
References: <2026033028-blitz-spill-525b@gregkh>
 <20260401164526.141913-1-sashal@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232825-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3266B37E542
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit ffef67b93aa352b34e6aeba3d52c19a63885409a ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index a217d9bacc0cf..94bf107a47caf 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6697,11 +6697,16 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
 
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
@@ -6713,9 +6718,16 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
 
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
-- 
2.53.0


