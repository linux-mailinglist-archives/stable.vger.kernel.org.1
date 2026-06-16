Return-Path: <stable+bounces-263511-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rejDFXOoMGrzVwUAu9opvQ
	(envelope-from <stable+bounces-263511-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 03:35:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EDB68B4A7
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 03:35:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DqNYAUlI;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263511-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263511-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF6C530459F9
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 01:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB9836F8F9;
	Tue, 16 Jun 2026 01:35:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35EC1A6803
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 01:35:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573708; cv=none; b=n7+t23vN4+xB9HqW/KdPvGHKwtXBOlba1OAZSSLeiXTQ5wyCs90E5mnVXQxV0T/K9hjYKeZZunxEAPKVpvSDGf5bgLPCeujtkY/fHMY3LXuvfUZ32K9v3um/170xhQSivzmpI/BDtYLtSot8lOnH19f8N5bt6zyQI+m1sygl2Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573708; c=relaxed/simple;
	bh=55FKlZPYBdEjaSQaK3gjgP3dTq9fiwBWokO0cIRt4gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qme+iXpZKyk8Tis0PxAV7E7RYwzvh525RgV0oWJo4YqRIY+TSTd+nucm0luJCCcwzVeucEbSPZqJIzDCSAZX0E10YkyxdQZZ5eEW569oa7p7ccB6gF0LQBqydcF8xWeEoLHoZg2ll9mm0/diPiuyQpJ4/F18zFKtnOkZKqc5ACI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqNYAUlI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81641F000E9;
	Tue, 16 Jun 2026 01:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781573706;
	bh=OssSHsxO1g+tHbXT/xHaULs0sSqtbeGXLKSdnmCYVJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DqNYAUlIsVXCnakGJQq1XVAbrGiZRvoFOSWHu3W8/82VeatoJDX8P+gQCnz2EOyC/
	 GKHYyriZi/GLLlC8fO4yK76YvZ379P+jAco5DW3IAyeBfuaIO1ByR9RTfOQa+urFnE
	 rgrP1s3lGyFs0YTmd7b4Yc4OnVFys8Ufv8ZqUVr2eSPu592D3+T8AquLyphGCD/atr
	 zV35pwdcaVJL33YukJUkYkZihGeUrQJZVXZavinjimJ/CuHgU05MlMnIujAAf4p0QE
	 hVM9MYdptVlxnsGdwRAyPii6LdztQVnnDHy0z/2+4pq/8Pd1IzY/3k0hV6v+A2v2An
	 dZ7waY2W9qp4w==
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
Subject: [PATCH 5.15.y] mm/huge_memory: update file PMD counter before folio_put()
Date: Mon, 15 Jun 2026 21:35:03 -0400
Message-ID: <20260616013503.2708473-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061512-encrypt-banking-e175@gregkh>
References: <2026061512-encrypt-banking-e175@gregkh>
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
	TAGGED_FROM(0.00)[bounces-263511-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:yintirui@huawei.com,m:ljs@kernel.org,m:david@kernel.org,m:lance.yang@linux.dev,m:dev.jain@arm.com,m:baolin.wang@linux.alibaba.com,m:baohua@kernel.org,m:chenjun102@huawei.com,m:wangkefeng.wang@huawei.com,m:liam@infradead.org,m:npache@redhat.com,m:ryan.roberts@arm.com,m:vbabka@kernel.org,m:yang.shi@linux.alibaba.com,m:ziy@nvidia.com,m:akpm@linux-foundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
X-Rspamd-Queue-Id: A9EDB68B4A7

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/huge_memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e9c5de967b2c15..934c08de74f42d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1994,7 +1994,9 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			if (!PageReferenced(page) && pmd_young(old_pmd))
 				SetPageReferenced(page);
 			page_remove_rmap(page, true);
+			add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR);
 			put_page(page);
+			return;
 		}
 		add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR);
 		return;
-- 
2.53.0


