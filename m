Return-Path: <stable+bounces-234928-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGxuMB2k1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-234928-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:53:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4105A3C1D86
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D19E307B35D
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F154B3D890F;
	Wed,  8 Apr 2026 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wWk5sJiz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B3A3D9031;
	Wed,  8 Apr 2026 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674125; cv=none; b=NCar+ddDybPJC9Irtws0XhSrslRAC0rx5rh7bXBBObXlb8xKQH0AXCLyN6984RSN4wV58dFZi1YzTC6KhZNRr5iVr+wcle4BsgHea6H7CZM7OQG+wwDteeBHg08QS3proZlamu4oncSzeIDBiZvMsQwUzyUingYpxcHsuTXF6Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674125; c=relaxed/simple;
	bh=EXnR0qqiBPZUZOHsqereQwLpWVOJpsLPWojcLA5EVcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzQuoZQEj7mrQFMXHSHAVx9ajVZ6Oev5+s8KLDZO5ydvf7dwjhdKigVi49mxM26uPemlqm567XX+THT+8oqMhP4mfs9v9WKcxbGtFE/joNbTJMgFL6rSA0qGhxp0LSLfaWLWExMjQ3b+po/TcOTzpTPpEtwYo2fiMwVyvJ2hHdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wWk5sJiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49010C19421;
	Wed,  8 Apr 2026 18:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674125;
	bh=EXnR0qqiBPZUZOHsqereQwLpWVOJpsLPWojcLA5EVcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wWk5sJizF1P6XejRIyKKg/2Rm0IBTVJxgHNu6F+dDpg3wSjkDNSOD4WpxV1wsXuQv
	 S+Jy96oJtmO080Viiju2rz5RhgKBiHQ1ahSuBGOUOdzS/5FOFg99c/KDaWDgWrT0Ec
	 9Yo/+cjatNYQMcfZPGFaP35YKOw6XJPKwe3B3GdY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	Liam Howlett <liam.howlett@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Xu <peterx@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 220/242] mm/memory: fix PMD/PUD checks in follow_pfnmap_start()
Date: Wed,  8 Apr 2026 20:04:20 +0200
Message-ID: <20260408175935.321343383@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234928-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,linux-foundation.org:email]
X-Rspamd-Queue-Id: 4105A3C1D86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memory.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6457,11 +6457,16 @@ retry:
 
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
@@ -6473,9 +6478,16 @@ retry:
 
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



