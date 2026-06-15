Return-Path: <stable+bounces-263484-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l5QaLqqCMGr4TwUAu9opvQ
	(envelope-from <stable+bounces-263484-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 00:54:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E0368A802
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 00:54:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KQa74io7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263484-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263484-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E95FE310BBD9
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 22:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5373BB11A;
	Mon, 15 Jun 2026 22:52:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301A233A6E2
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 22:52:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563958; cv=none; b=BdqQEB1iD7rmo2RrBmeb6HxGzMKoD+BqO8W2jkdDBucutr1eTdgIGRcsld9mDsnQhiELiPUpSeizKIXbxc2aVphCx9eGb6/qN1yBs44ffiKAN3FZEPgkUaJxZ+RzmfPrAJwpYkthOafbn8NmdrixERT+RTUiWUPwbr7mgpJD+1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563958; c=relaxed/simple;
	bh=vK7U92GBSn6kfYoxz+DT7CVIBlEaka7Y8boJhmDM4OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJZUcmka0xmu6R/yAMQZmmu6QbjzzMv5t1dyv4bDA4wuIf1/miBFIr1rtmZE+M9q8Vfve48DTjk8UuZbNGlOUIEOTTlQSItidnmL9PEho9XDUEahtL61Qa8vX8mA+nyFlFgIdJRNxMkunxk8voZPRUq0OHGaWX61Zomo/dOXzJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQa74io7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE151F000E9;
	Mon, 15 Jun 2026 22:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781563957;
	bh=0GFs4O2Q7lHnz+oyRZGzqXMb5TIUW1yK3MW98AsNtqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KQa74io7fnKc4beSWszb9ixSEw3wx6bX+7qjnAjV3+TM9mtVRq2wZvznH6zPOi2N8
	 yCdi1T0yz1+bBlIa962DRNPt9CgHO37SbXqs8zdIxEeYqi6umY7L2ZU2d/rfNm5P4V
	 2LG4QJyq8qj27VskZ1EEUosF9i/IANMSc/A55/F/XudgTVOpZU2XImadoDZkV2TfW3
	 Kle+INRm8bO+BruARYP0TE8q0eTEC7WIRR2e2oE9dBC7mm2Ra/S748e3Pcg69D547X
	 ctwYVO+/vtJJY4YqjHQYawQIQG+915DktRfEeDQG9z82F3LL/QPjHAMjtXFyzMZe4G
	 3mzuhe/ZXt9Hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yin Tirui <yintirui@huawei.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"David Hildenbrand (arm)" <david@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Dev Jain <dev.jain@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Chen Jun <chenjun102@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Yang Shi <yang.shi@linux.alibaba.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/huge_memory: update file PMD counter before folio_put()
Date: Mon, 15 Jun 2026 18:52:33 -0400
Message-ID: <20260615225233.2520866-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061508-robin-cupid-c1e8@gregkh>
References: <2026061508-robin-cupid-c1e8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263484-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:yintirui@huawei.com,m:ljs@kernel.org,m:david@kernel.org,m:lance.yang@linux.dev,m:dev.jain@arm.com,m:baolin.wang@linux.alibaba.com,m:baohua@kernel.org,m:chenjun102@huawei.com,m:wangkefeng.wang@huawei.com,m:liam@infradead.org,m:npache@redhat.com,m:ryan.roberts@arm.com,m:vbabka@kernel.org,m:yang.shi@linux.alibaba.com,m:ziy@nvidia.com,m:akpm@linux-foundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 36E0368A802

From: Yin Tirui <yintirui@huawei.com>

[ Upstream commit 8d878059924f12c1bc24556a92ec56add74de3c8 ]

__split_huge_pmd_locked() updates the file/shmem RSS counter after
dropping the PMD mapping's folio reference.  If folio_put() drops the last
reference, mm_counter_file() can later read freed folio state via
folio_test_swapbacked().

Move the counter update before folio_put().

Link: https://lore.kernel.org/20260526101337.1984081-1-yintirui@huawei.com
Fixes: fadae2953072 ("thp: use mm_file_counter to determine update which rss counter")
Signed-off-by: Yin Tirui <yintirui@huawei.com>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Acked-by: David Hildenbrand (arm) <david@kernel.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Chen Jun <chenjun102@huawei.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ changed folio API calls (folio_remove_rmap_pmd/mm_counter_file(folio)/folio_put) to page-based equivalents (page_remove_rmap/mm_counter_file(page)/put_page) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/huge_memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 78f5df12b8eb37..4443cc44cbf9f1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2095,7 +2095,9 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			if (!PageReferenced(page) && pmd_young(old_pmd))
 				SetPageReferenced(page);
 			page_remove_rmap(page, vma, true);
+			add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR);
 			put_page(page);
+			return;
 		}
 		add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR);
 		return;
-- 
2.53.0


