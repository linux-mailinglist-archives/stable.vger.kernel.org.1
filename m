Return-Path: <stable+bounces-212208-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMiVJCQwemlq3wEAu9opvQ
	(envelope-from <stable+bounces-212208-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:49:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E404BA47FF
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 320B0314F236
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603F02EB5A6;
	Wed, 28 Jan 2026 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qFpo6aoW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E8C2E2299;
	Wed, 28 Jan 2026 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614747; cv=none; b=LFVy0tVkHLf5b1fXxcU2Dh4jlfkCJpF977XZdkKNQ2+1CsFrAQO5+lu5gzxUg2ei/CE+w4om1ie+i/H616GzQDqyQY2tgMYapyuhqfk6TnkA5yUiNHUDgCXjl4+RFW6JTM6TRmXiPxVZ2x6+E6lQqRuZurES6HopBE0hImWhHXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614747; c=relaxed/simple;
	bh=2naxXq9mJaRjzqpOKlGuUZdJdwCUbBxsQQxr7NV+3gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a516pdkktedI1KpeQ7u8CZUlXfl1R2K7/3mEeqH9CWbH1KtQnsHZlpautlxQRn9DUHetHCaEjvqXBnWOKiErqr+8YzbO43Alc/JyY2GFfX+ELNMvaB/AOdzavZUMKWH/aFLuitsbZVfGX+EuCG0Ziqv5/ueerexx2oOBGBC05r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qFpo6aoW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EF9C4CEF1;
	Wed, 28 Jan 2026 15:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614747;
	bh=2naxXq9mJaRjzqpOKlGuUZdJdwCUbBxsQQxr7NV+3gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qFpo6aoWjaMEVK7gv3L3RBkRQM9DdpynVm4iU6Cky0tiG3QbGeEcZzGb8AqqfRQ/k
	 3JOQL5+6sKJIUEoBR073YV3Xljxxo8F/2Clwr4ZszMqeqkia8ePqGaMpBodrPyfN+O
	 Nzw2eGIJzOyNpBPDJJLFWk6bw1lnMqw5CjCXr0Vc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Laurence Oberman <loberman@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Oscar Salvador <osalvador@suse.de>,
	Liu Shixin <liushixin2@huawei.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Lance Yang <lance.yang@linux.dev>,
	"Uschakow, Stanislav" <suschako@amazon.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 229/254] mm/rmap: fix two comments related to huge_pmd_unshare()
Date: Wed, 28 Jan 2026 16:23:25 +0100
Message-ID: <20260128145353.028208584@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212208-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linux.dev:email,oracle.com:email,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amazon.de:email,suse.de:email]
X-Rspamd-Queue-Id: E404BA47FF
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "David Hildenbrand (Red Hat)" <david@kernel.org>

[ Upstream commit a8682d500f691b6dfaa16ae1502d990aeb86e8be ]

PMD page table unsharing no longer touches the refcount of a PMD page
table.  Also, it is not about dropping the refcount of a "PMD page" but
the "PMD page table".

Let's just simplify by saying that the PMD page table was unmapped,
consequently also unmapping the folio that was mapped into this page.

This code should be deduplicated in the future.

Link: https://lkml.kernel.org/r/20251223214037.580860-4-david@kernel.org
Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count")
Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
Cc: Liu Shixin <liushixin2@huawei.com>
Cc: Harry Yoo <harry.yoo@oracle.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: "Uschakow, Stanislav" <suschako@amazon.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/rmap.c |   20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1579,14 +1579,8 @@ static bool try_to_unmap_one(struct foli
 					flush_tlb_range(vma,
 						range.start, range.end);
 					/*
-					 * The ref count of the PMD page was
-					 * dropped which is part of the way map
-					 * counting is done for shared PMDs.
-					 * Return 'true' here.  When there is
-					 * no other sharing, huge_pmd_unshare
-					 * returns false and we will unmap the
-					 * actual page and drop map count
-					 * to zero.
+					 * The PMD table was unmapped,
+					 * consequently unmapping the folio.
 					 */
 					page_vma_mapped_walk_done(&pvmw);
 					break;
@@ -1945,14 +1939,8 @@ static bool try_to_migrate_one(struct fo
 						range.start, range.end);
 
 					/*
-					 * The ref count of the PMD page was
-					 * dropped which is part of the way map
-					 * counting is done for shared PMDs.
-					 * Return 'true' here.  When there is
-					 * no other sharing, huge_pmd_unshare
-					 * returns false and we will unmap the
-					 * actual page and drop map count
-					 * to zero.
+					 * The PMD table was unmapped,
+					 * consequently unmapping the folio.
 					 */
 					page_vma_mapped_walk_done(&pvmw);
 					break;



