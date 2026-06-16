Return-Path: <stable+bounces-264727-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id INcHE8Z6MWqmkQUAu9opvQ
	(envelope-from <stable+bounces-264727-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:33:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3AC692327
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:33:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Pg6+f256;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264727-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-264727-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A1DD303C2AD
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B92247799F;
	Tue, 16 Jun 2026 16:32:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172454502F;
	Tue, 16 Jun 2026 16:32:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627544; cv=none; b=o0jsTrgCY0ZKeV94k8Fqh+LJoFyB7sSkjV5Xg39EUEsN0smURcuvbIMPgSgyyhY5QzBWS+iFs5niwuo62G2pd7fM21XtlgDOPBSuardD3JW0oqureiVs370SA175CLJY1zN++Q/JIiuzgDpNANBMBKgFfVRhjWIYtC0YmQM/ntI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627544; c=relaxed/simple;
	bh=08SgS7rxXqgtIv3o1PmriZUPKMrgVZ/52sD2s5iEE9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lo4SUKocUQkp1mQn8ZXan7slG/gJn/grPChg1RSlx1oJjs2wNQij64eYKtIG4X6M82lRYIGZ76V52Ey54FLUCgdVMAwJs5/+Ow6P8tbcKGLxVzHatSsfvcXRSRoSo5Tqq+ckUYha1QjcQPIiA+zcCu36JMXxDHUpXYdxxIPb7GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pg6+f256; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E461F000E9;
	Tue, 16 Jun 2026 16:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781627542;
	bh=4lnX6C4vnhQYOWw0Fia2KnQ2yd1c19PGGRwVj8KkE0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pg6+f256m9+d0WBcNX/v7ji2jOPxvAgPRHz5t4IXp5t4VAldMw2FK2ALZy7/FSELO
	 uWsTDs/HbvhG12iKVazPJl6nfQYDs8VMDHm6oOCUderslfnZmR3yMMnUK0YblL6N/J
	 0vDF3TCuZEzDI1MoR7edGDcdjHHo3A5V39++rqbQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Carlier <devnexen@gmail.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	yuehaibing <yuehaibing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12 191/261] mm/hugetlb: restore reservation on error in hugetlb folio copy paths
Date: Tue, 16 Jun 2026 20:30:29 +0530
Message-ID: <20260616145053.914170574@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linux.dev,kernel.org,google.com,suse.de,huawei.com,linux-foundation.org];
	TAGGED_FROM(0.00)[bounces-264727-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:devnexen@gmail.com,m:muchun.song@linux.dev,m:david@kernel.org,m:almasrymina@google.com,m:osalvador@suse.de,m:yuehaibing@huawei.com,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.de:email,huawei.com:email,linux-foundation.org:email,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB3AC692327

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Carlier <devnexen@gmail.com>

commit 40c81856e622a9dc59294a90d169ac07ea25b0b0 upstream.

Two sites in mm/hugetlb.c allocate a hugetlb folio via
alloc_hugetlb_folio() (consuming a VMA reservation) and then call
copy_user_large_folio(), which became int-returning in commit 1cb9dc4b475c
("mm: hwpoison: support recovery from HugePage copy-on-write faults") and
can now fail (e.g.  -EHWPOISON on a hwpoisoned source page).  On the
failure path, folio_put() restores the global hugetlb pool count through
free_huge_folio(), but the per-VMA reservation map entry is left marked
consumed:

  - hugetlb_mfill_atomic_pte() resubmission path (UFFDIO_COPY)
  - copy_hugetlb_page_range() fork-time CoW path when
    hugetlb_try_dup_anon_rmap() fails (rare: pinned hugetlb anon
    folio under fork)

User-visible effect: on UFFDIO_COPY into a private hugetlb VMA where the
resubmission copy fails, the reservation for that address is leaked from
the VMA's reserve map.  A subsequent fault at the same address takes the
no-reservation path, and under hugetlb pool pressure the task is SIGBUSed
at an address it had previously reserved.  The fork-time CoW path leaks
the same way in the child VMA's reserve map, though it requires the much
rarer combination of pinned hugetlb anon page + hwpoisoned source.

Add the missing restore_reserve_on_error() call before folio_put() on both
error paths.

Link: https://lore.kernel.org/20260520044912.6751-1-devnexen@gmail.com
Fixes: 1cb9dc4b475c ("mm: hwpoison: support recovery from HugePage copy-on-write faults")
Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Cc: David Hildenbrand <david@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: yuehaibing <yuehaibing@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/hugetlb.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5340,6 +5340,7 @@ again:
 							    addr, dst_vma);
 				folio_put(pte_folio);
 				if (ret) {
+					restore_reserve_on_error(h, dst_vma, addr, new_folio);
 					folio_put(new_folio);
 					break;
 				}
@@ -6639,6 +6640,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_
 		folio_put(*foliop);
 		*foliop = NULL;
 		if (ret) {
+			restore_reserve_on_error(h, dst_vma, dst_addr, folio);
 			folio_put(folio);
 			goto out;
 		}



