Return-Path: <stable+bounces-272745-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7DQCHnXLTmoNUQIAu9opvQ
	(envelope-from <stable+bounces-272745-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 00:13:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD16E72AD0B
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 00:13:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=GSVIvt7L;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272745-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272745-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5CB8304D244
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 22:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E333F5BE5;
	Wed,  8 Jul 2026 22:12:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDE138B122;
	Wed,  8 Jul 2026 22:12:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783548774; cv=none; b=OS1cPqmBvxE3GNuYOsrXxSIHrTmbmJ7Ltu1Wrf97bzb2JypEqnWNoF8DGjiJllSt1J/6sOI/B5X+rLl9hh7gO+RT3uMMhifDhuz+V6GV6KGq8gIhPpGtTv5kxzOwD/yl0/oWWWZcItYkaKhZumna8+X4JEDEOWIN+BpQ0Ba8Uak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783548774; c=relaxed/simple;
	bh=ocs3W/FAuSHd6XHuqJdgjkplQY7OsSH3DoKXZ4km4mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i0UOaD7lMHiqUisZkPawtDioRCRP32rrbqKFhMC2d114xkpgmVkqKF5fRZnCyIoV6d9XjjWZ9nhvOQexQfWWMXmBGkCbY9jy4QTMrJ03q/Ku8RcD94yI09FcFPk4xtLup5FaHFu9tnUkPQtmypG89Y+lJQRkuPLVyZKSKXnY+z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSVIvt7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD883C2BCF5;
	Wed,  8 Jul 2026 22:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783548773;
	bh=ocs3W/FAuSHd6XHuqJdgjkplQY7OsSH3DoKXZ4km4mg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GSVIvt7LaUewb6Yor4iDkwNMfDJhf/m/vroxwPYPSCGrSK0e1KXQIj2XUJGuLEpu8
	 b9Cq/6qAQ436CNHHNJqb9rdjTG8YvBCoFTLow5TOldA51qbumUzi4a5K9tM9Q7yKbA
	 wH7ep7cNFMfDKPdMXJOCpjLgM0syVBs0+N2MBYZcv7VesC685hR+I5qLTON1Lnu6wd
	 WAyAcoSOVjwKWYNVzCc19k03PEod1xovD9CHpTHonS/tQ2r+H5l9brT324ei9NTKof
	 8n1M6JGS1ohWkQZwLbMw03Lql4cte5xIUYvYQpFpZ16frIumykFxe54zpC+eZ84Vjb
	 8dxr1dpU4bmLw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C421CC44503;
	Wed,  8 Jul 2026 22:12:53 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Wed, 08 Jul 2026 15:12:51 -0700
Subject: [PATCH v2 3/5] mm: hugetlb: Fix folio refcount mismatch on memcg
 charge failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-hugetlb-alloc-failure-fixes-v2-3-c7f27cbb462b@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783548773; l=1242;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=VCn99bEoQNyadmxjsM1rKLroB6Ii6NvdNcvQQwTosM0=;
 b=o1JFZ+27rVlos6MFYdiRSbM7jq5fQzxYDj7CUQVhhs+9hVEUTxvX8ee80Lj2a0M6OeF/Mef73
 j5AZHRgZWgxCMzoi/qtVUEcHbbk7tolQ4opx4Apg+u3CPShEJZQp8hA
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
	TAGGED_FROM(0.00)[bounces-272745-lists,stable=lfdr.de,ackerleytng.google.com];
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
X-Rspamd-Queue-Id: CD16E72AD0B

From: Ackerley Tng <ackerleytng@google.com>

When mem_cgroup_charge_hugetlb(folio, gfp) returns -ENOMEM, the folio has
its refcount set to 1 via folio_ref_unfreeze(folio, 1).

The error path calls free_huge_folio(folio) directly, which expects a
refcount of 0. Hence, VM_BUG_ON_FOLIO(folio_ref_count(folio), folio) is
triggered.

Even with CONFIG_DEBUG_VM disabled, returning a folio with refcount 1 to
the freelist can corrupt allocator state later.

Use folio_put(folio) instead of free_huge_folio(folio) to properly drop the
reference before freeing it.

Fixes: 991135774c0e0 ("memcg/hugetlb: introduce mem_cgroup_charge_hugetlb")
Cc: stable@vger.kernel.org
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4093c1c0a4a1d..1f3f4b964b153 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2990,7 +2990,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	lruvec_stat_mod_folio(folio, NR_HUGETLB, pages_per_huge_page(h));
 
 	if (ret == -ENOMEM) {
-		free_huge_folio(folio);
+		folio_put(folio);
 		return ERR_PTR(-ENOMEM);
 	}
 

-- 
2.55.0.795.g602f6c329a-goog



