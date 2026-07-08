Return-Path: <stable+bounces-272746-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lOM2D3rLTmoOUQIAu9opvQ
	(envelope-from <stable+bounces-272746-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 00:13:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E22772AD0E
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 00:13:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=hSKU7svD;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272746-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272746-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23436304EBBD
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 22:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667D13FCB39;
	Wed,  8 Jul 2026 22:12:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A173939B9;
	Wed,  8 Jul 2026 22:12:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783548774; cv=none; b=cI4XaK9RPJFvwJjBRD4wh/OFpWhUgBMEYmNcwDXfWTb9qrZfpsmHqdEHJWHixspoQ6LSOajolP5klEJfWc4ugU0YxeLzzaUsrw7ptFaL9tPWv7sACTZ+OJx1buXpPRrRZiuxmKiSPWkZh39tjqIKNrY/QAARhQ3EL+9mY7LKE0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783548774; c=relaxed/simple;
	bh=69AY4ocHUaVliMTNSwskxx27mtLaUjKa3eI4hfXhBvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q34iEDqmHPTuPks2gK6PNo7mXE4YdhqYA04O3ZANYBK5Vua0CDpOmlEk/VIh0qVc0hPwMnD87turalvd/8PPNO5F2UK/24FEREYZzxPZBu05YUUKb/pNf9bkniNKDuJtoEstbvi4BW0VHuqnFNTbMTnsovr0vH2ttBRH2OfoBT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSKU7svD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC6D4C2BCF4;
	Wed,  8 Jul 2026 22:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783548774;
	bh=69AY4ocHUaVliMTNSwskxx27mtLaUjKa3eI4hfXhBvo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hSKU7svDBslpur3gfD1oOP5CBgiuO35zxafM/UXjUXu+5rzkTdUTQobmvuRAAd2vr
	 XvZSZNPUlOAWXh7X/HD1OhELAhgDnbN0STJvz/19nfTXIazDtx1x/ZZhU73j4rMrtF
	 QaiOv95z/RzHHqTV5u9I3yISNNTJA4S/qot6PhHAkykbh5ANVlE9pFp4OUgnUt4TUB
	 KH3wJzcdJI1lh5q74wACwsJzlJEJfXyIOuoYv/V+9lLdCWnh+bX6aRzECd0SZJ/gJz
	 RnCw1+T1gsLpTlxilTZrhnA5sGsDeNdbsNYTAyuxo79LPRHE91RgBr0dX9IjbE8xSu
	 Nhb0USqLF2f5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26DCC44508;
	Wed,  8 Jul 2026 22:12:53 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Wed, 08 Jul 2026 15:12:52 -0700
Subject: [PATCH v2 4/5] mm: hugetlb: Return -ENOSPC on memcg charge failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-hugetlb-alloc-failure-fixes-v2-4-c7f27cbb462b@google.com>
References: <20260708-hugetlb-alloc-failure-fixes-v2-0-c7f27cbb462b@google.com>
In-Reply-To: <20260708-hugetlb-alloc-failure-fixes-v2-0-c7f27cbb462b@google.com>
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@kernel.org>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
 Wupeng Ma <mawupeng1@huawei.com>, fvdl@google.com, rientjes@google.com, 
 jthoughton@google.com
Cc: vannapurve@google.com, erdemaktas@google.com, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783548773; l=2177;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=ATDEFmXVx2084y3k2D/X0eSSvzPLxfpRzdf7vni2gz8=;
 b=whjYrYebXAkYbMWBoCoWQO4eHHsGErO3ZYnQYeeOZV3idySVzaxov0v7Qk5ursaHnFiAv7Zlf
 rjMcQxMzBmQBqzPEMm8GK46Ebh8T8XnSWXnxppCLYFsxMSuLwGJR2EI
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272746-lists,stable=lfdr.de,ackerleytng.google.com];
	FORGED_RECIPIENTS(0.00)[m:muchun.song@linux.dev,m:osalvador@suse.de,m:david@kernel.org,m:joshua.hahnjy@gmail.com,m:shakeel.butt@linux.dev,m:nphamcs@gmail.com,m:akpm@linux-foundation.org,m:peterx@redhat.com,m:mawupeng1@huawei.com,m:fvdl@google.com,m:rientjes@google.com,m:jthoughton@google.com,m:vannapurve@google.com,m:erdemaktas@google.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:ackerleytng@google.com,m:stable@vger.kernel.org,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[linux.dev,suse.de,kernel.org,gmail.com,linux-foundation.org,redhat.com,huawei.com,google.com];
	FORGED_SENDER(0.00)[devnull@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[ackerleytng@google.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E22772AD0E

From: Ackerley Tng <ackerleytng@google.com>

When mem_cgroup_charge_hugetlb() fails with -ENOMEM, alloc_hugetlb_folio()
currently propagates this error. This results in the page fault handler
returning VM_FAULT_OOM.

Because HugeTLB allocations are high-order and use __GFP_RETRY_MAYFAIL,
they bypass the OOM killer. Returning VM_FAULT_OOM to the #PF handler
without triggering the OOM killer (or having it make progress) leads to
an infinite loop of retrying the fault.

Avoid this loop by returning -ENOSPC when charging fails, which maps to
VM_FAULT_SIGBUS, terminating the process cleanly.

Make mem_cgroup_charge_hugetlb() fault handling use a common error handling
path, the same handling used for hugetlb_cgroup_uncharge_cgroup{,_rsvd}(),
which also don't trigger the OOM killer and hence opt to terminate the
process with a SIGBUS.

Fixes: 991135774c0e0 ("memcg/hugetlb: introduce mem_cgroup_charge_hugetlb")
Cc: stable@vger.kernel.org
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
---
 mm/hugetlb.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1f3f4b964b153..3e1d99f03c70e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2991,7 +2991,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 	if (ret == -ENOMEM) {
 		folio_put(folio);
-		return ERR_PTR(-ENOMEM);
+		goto err;
 	}
 
 	return folio;
@@ -3014,6 +3014,17 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 out_end_reservation:
 	if (map_chg != MAP_CHG_ENFORCED)
 		vma_end_reservation(h, vma, addr);
+err:
+	/*
+	 * Return -ENOSPC when this function fails to allocate or
+	 * charge a huge page. If a standard (PAGE_SIZE) page
+	 * allocation fails, the OOM killer is given a chance to run,
+	 * which may resolve the failure on retry. However, for
+	 * HugeTLB allocations, the OOM killer is not triggered.
+	 * Returning -ENOMEM (or anything resulting in VM_FAULT_OOM)
+	 * would leak to the #PF handler, causing it to loop
+	 * indefinitely retrying the fault.
+	 */
 	return ERR_PTR(-ENOSPC);
 }
 

-- 
2.55.0.795.g602f6c329a-goog



