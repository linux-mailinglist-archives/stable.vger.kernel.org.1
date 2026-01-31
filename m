Return-Path: <stable+bounces-212966-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5aJgCTuBfmlQaAIAu9opvQ
	(envelope-from <stable+bounces-212966-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 23:24:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63308C41F6
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 23:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BD083014551
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 22:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B15F38A732;
	Sat, 31 Jan 2026 22:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="m0FLgLAv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B9520CCDC;
	Sat, 31 Jan 2026 22:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769898291; cv=none; b=CfNAYO7guz/Jv9O1OSMn+SrOKF4fUs6qmcsX1SyEBI6Dr5/dOUr5cU4KVD1PUSgSVTKUNOb8PXVldP4I9L3h8cf0PsgtxScEKWWeIz1vH45MM5uhLfmDk9zdWmlGLi8YygUArdPzMHRzvaBfARDXv8CqTyAXspRbd6VrYm1QbJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769898291; c=relaxed/simple;
	bh=V+BiavjyoArCY0Gz4a3ZTCVJkwpV6iO+ERzBiPfV9a0=;
	h=Date:To:From:Subject:Message-Id; b=q0+MBmS7fxwDz+oUeCWJah6Jrsg4g+KklQud3YPsxG1MUKSILYoATJhNDt6jBxKV1YvVvJl/iwUft3pQrPvU6mSEMxBt8JHne5WC0Qkae4LXPZYL6UNT90ZtJBCl+sA1pM/W2aqfT6L0dJPbRV1kUvfGFp1OqQAH58C/MKGCaTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=m0FLgLAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0E1C4CEF1;
	Sat, 31 Jan 2026 22:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769898291;
	bh=V+BiavjyoArCY0Gz4a3ZTCVJkwpV6iO+ERzBiPfV9a0=;
	h=Date:To:From:Subject:From;
	b=m0FLgLAvXuvdoTLGpvNR/91jSyALOoCVH9xgjapjFLvbJ6WStOgyArT3vwiw5knjx
	 8e29kE8tiKiQ7rNZ6yqIa27aznuPfU9JUfr/cBsGHpT+SD7TtqQK/RuiFsPwvGGLCK
	 A7zWkpC5GC0VgRnZ/s4UKCNvDenIeBS3lisgI+R8=
Date: Sat, 31 Jan 2026 14:24:51 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,jcmvbkbc@gmail.com,chris@zankel.net,williamt@cadence.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-stable] mm-highmem-fix-__kmap_to_page-build-error.patch removed from -mm tree
Message-Id: <20260131222451.AA0E1C4CEF1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212966-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,zankel.net,cadence.com,linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email,linux-foundation.org:dkim,zankel.net:email]
X-Rspamd-Queue-Id: 63308C41F6
X-Rspamd-Action: no action


The quilt patch titled
     Subject: mm/highmem: fix __kmap_to_page() build error
has been removed from the -mm tree.  Its filename was
     mm-highmem-fix-__kmap_to_page-build-error.patch

This patch was dropped because it was merged into the mm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: William Tambe <williamt@cadence.com>
Subject: mm/highmem: fix __kmap_to_page() build error
Date: Thu, 11 Dec 2025 12:38:19 -0800

This changes fixes following build error which is a miss from ef6e06b2ef87
("highmem: fix kmap_to_page() for kmap_local_page() addresses").

mm/highmem.c:184:66: error: 'pteval' undeclared (first use in this
function); did you mean 'pte_val'?
184 | idx = arch_kmap_local_map_idx(i, pte_pfn(pteval));

In __kmap_to_page(), pteval is used but does not exist in the function.

(akpm: affects xtensa only)

Link: https://lkml.kernel.org/r/SJ0PR07MB86317E00EC0C59DA60935FDCD18DA@SJ0PR07MB8631.namprd07.prod.outlook.com
Fixes: ef6e06b2ef87 ("highmem: fix kmap_to_page() for kmap_local_page() addresses")
Signed-off-by: William Tambe <williamt@cadence.com>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/highmem.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/mm/highmem.c~mm-highmem-fix-__kmap_to_page-build-error
+++ a/mm/highmem.c
@@ -180,12 +180,13 @@ struct page *__kmap_to_page(void *vaddr)
 		for (i = 0; i < kctrl->idx; i++) {
 			unsigned long base_addr;
 			int idx;
+			pte_t pteval = kctrl->pteval[i];
 
 			idx = arch_kmap_local_map_idx(i, pte_pfn(pteval));
 			base_addr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
 
 			if (base_addr == base)
-				return pte_page(kctrl->pteval[i]);
+				return pte_page(pteval);
 		}
 	}
 
_

Patches currently in -mm which might be from williamt@cadence.com are



