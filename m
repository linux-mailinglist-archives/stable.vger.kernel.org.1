Return-Path: <stable+bounces-254293-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLuYOrJ0FWqdVAcAu9opvQ
	(envelope-from <stable+bounces-254293-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:23:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D31B5D420E
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE08B305BFA1
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04253DA5C6;
	Tue, 26 May 2026 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="RHwPVHxV"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46BF3D9038;
	Tue, 26 May 2026 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779790806; cv=none; b=tM4aboTv0CFhffR4+hOnw8/jChFC7KlI+XtYGjP0aNK5Pgne9vTQbzDPU2Zuz4fDPowEIqnQlOBeWb1upzcnfu662TgWDCTNRuEmshI+g4XGHl4YHqirqrgZ7ypjKW1nszpnYW92CO0Jvf+6wthHR6opLB/rIMs+mYgM+qQy+ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779790806; c=relaxed/simple;
	bh=8MaXZ1QkPGGo0W0+tySX3QbYsZeDAMtQipYXMYkwVeA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P4dewhwoiqUp5ZsWG6bJ2dUimQxY/uFAanp7Kk+xVPO6osL9ZANEk83vtYEyRHxCVGQzJA9eIjRuISh2ZkeP11TIs0xnw0Vk2494N/joBmYy79plGtTXQhPk9xCr6UmBSUeAqJgjDEgjG6o9vTn7ACeILweYEYZaSHkjHcak6VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=RHwPVHxV; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=U1Y9EPFwa2MKLbEE8VMEmZhNpG/L4oQPepMC6dm0RPc=;
	b=RHwPVHxVAQGaMj/4Z0eMkU+LT9BDuMPSupHh5gUqS6eOAQiFk7hRNTnfP4FhIxDfEZaxAKJ0W
	SkmKL17I5N8SV9yPiY5rcvlDNrVuywsrEfClzRfHyP0I5WtAMrayHSDODbtIwXbcSaprAXbkFYL
	trK8up60IANnXPznNQdjjpo=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gPpTF12fLz1K98y;
	Tue, 26 May 2026 18:12:17 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id DC9574055B;
	Tue, 26 May 2026 18:20:00 +0800 (CST)
Received: from huawei.com (10.50.87.63) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 May
 2026 18:20:00 +0800
From: Yin Tirui <yintirui@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Zi
 Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R .
 Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>, Ryan Roberts
	<ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
	<baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Dan Williams
	<djbw@kernel.org>, Alistair Popple <apopple@nvidia.com>,
	<wangkefeng.wang@huawei.com>, <chenjun102@huawei.com>, <yintirui@huawei.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH] mm/huge_memory: update file PUD counter before folio_put()
Date: Tue, 26 May 2026 18:13:55 +0800
Message-ID: <20260526101355.1984244-1-yintirui@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500001.china.huawei.com (7.202.194.229)
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254293-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yintirui@huawei.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:email,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Queue-Id: 6D31B5D420E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

__split_huge_pud_locked() updates the file/shmem RSS counter after
dropping the PUD mapping's folio reference. If folio_put() drops the
last reference, mm_counter_file() can later read freed folio state via
folio_test_swapbacked().

Move the counter update before folio_put().

Fixes: dbe54153296d ("mm/huge_memory: add vmf_insert_folio_pud()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Yin Tirui <yintirui@huawei.com>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a5f4a48b7b77..9832ee910d5e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3027,9 +3027,9 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 	if (!folio_test_referenced(folio) && pud_young(old_pud))
 		folio_set_referenced(folio);
 	folio_remove_rmap_pud(folio, page, vma);
-	folio_put(folio);
 	add_mm_counter(vma->vm_mm, mm_counter_file(folio),
 		-HPAGE_PUD_NR);
+	folio_put(folio);
 }
 
 void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
-- 
2.43.0


