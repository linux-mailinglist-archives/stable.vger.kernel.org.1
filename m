Return-Path: <stable+bounces-211590-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4H4sLr1pd2nCfQEAu9opvQ
	(envelope-from <stable+bounces-211590-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:18:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBD288B85
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D0073016D24
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 13:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E403732E134;
	Mon, 26 Jan 2026 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MwCbWOAD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72B5303CAA
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769433528; cv=none; b=An4xzKNXbi7s7TGutMO1hzcJZ/QYwGwRnamQxtvKWlKgaB8LCHUygf5x8D/Q084BeQrw1o9iRo0qwzOdHki6HOm62kQmPCi38wi4D+zMCWlm3DJjU0+ce97QUc8FTWZLVSuLfItzd4Z9qc1haYcxGFJGsrRgs+feUj8a6obwM4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769433528; c=relaxed/simple;
	bh=l2cRIdVQPBpdOYJMcAcOgryh/sP72BQhrKNrTyIKXJo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ta4znEYZmW+d0UtUmhCEqL1d3Vm/mbD4wRKpXoilaHIE6AhUUaE2fObSHHR4oW5gHZjzEZ9u6eDrtVp9c1N5EbVH+QcVs9BM0ASVbrKea0oiWE3JlRDF9Zg5FzbgoGwwBv58mWZCIXI85abnbdi64qKfpkQMAIcWMyA+yX0+kbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MwCbWOAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4AEC116C6;
	Mon, 26 Jan 2026 13:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769433528;
	bh=l2cRIdVQPBpdOYJMcAcOgryh/sP72BQhrKNrTyIKXJo=;
	h=Subject:To:Cc:From:Date:From;
	b=MwCbWOADkDyeMYhfDo/HjOfSkq4cObVL18tmJpMrcbjTq3xdp3exe0xhg7bKXdnd8
	 fxFeMvHW7APquDF2Xbgs3wcpz4BSYOGFvIioEcHMY5RcS9Q3CBjueyFh0Fkd7DZuqx
	 uT7QZMT+A5h/i0U8mXHcC2AfEPRjhK4PpLxB5CVA=
Subject: FAILED: patch "[PATCH] mm/rmap: fix two comments related to huge_pmd_unshare()" failed to apply to 6.1-stable tree
To: david@kernel.org,akpm@linux-foundation.org,harry.yoo@oracle.com,lance.yang@linux.dev,liushixin2@huawei.com,loberman@redhat.com,lorenzo.stoakes@oracle.com,osalvador@suse.de,riel@surriel.com,stable@vger.kernel.org,suschako@amazon.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Jan 2026 14:18:37 +0100
Message-ID: <2026012637-grope-geologic-e069@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211590-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linux-foundation.org:email,surriel.com:email,huawei.com:email,amazon.de:email]
X-Rspamd-Queue-Id: 2DBD288B85
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a8682d500f691b6dfaa16ae1502d990aeb86e8be
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012637-grope-geologic-e069@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a8682d500f691b6dfaa16ae1502d990aeb86e8be Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Date: Tue, 23 Dec 2025 22:40:36 +0100
Subject: [PATCH] mm/rmap: fix two comments related to huge_pmd_unshare()

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

diff --git a/mm/rmap.c b/mm/rmap.c
index f955f02d570e..748f48727a16 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2016,14 +2016,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
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
 					goto walk_done;
 				}
@@ -2416,14 +2410,8 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
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


