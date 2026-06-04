Return-Path: <stable+bounces-260264-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P8w5OgEUIWrI+wAAu9opvQ
	(envelope-from <stable+bounces-260264-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 07:58:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7631F63D1B3
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 07:58:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=MSn4AOul;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260264-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260264-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61BE63038C67
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 05:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5113C3789;
	Thu,  4 Jun 2026 05:53:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BD83C09E7;
	Thu,  4 Jun 2026 05:53:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780552414; cv=none; b=DyadF10S4i5aU637RBMeBtxmgl0r2CxR3S/xoI9IIvdvchi7v3EMK9BOuIgM65FbSxsuVtLySBlUdKuRpAxZW1UkwbQpHu601tEAHIm17y86aOqyFPl03Ybs4mnE1xeimvM4RFjUpay/i1Pc94BEix08U3iSiAGao9ymkY0UBxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780552414; c=relaxed/simple;
	bh=fr1ZIAKStZBd1psxptXiTd8a10xNZESCVeJoWx72PSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkbevvxICrzGKH1pjx4C+yMbxOIQWZuo4yMN8DG4qllyxa4G8R4Vt4icX3hy5rqujSGQEZ9MVWvw7v3RhcobGV9r4GLP6SIO9O0XwoAn7/6efPCVTtrOFCnn4+sj6vw5/TAEu7dEHk0ZgYFssriehtFvSFeSE43WwwEd0mgDPO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MSn4AOul; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B4C53161;
	Wed,  3 Jun 2026 22:53:26 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 690073F632;
	Wed,  3 Jun 2026 22:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780552411; bh=fr1ZIAKStZBd1psxptXiTd8a10xNZESCVeJoWx72PSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MSn4AOuln+fZ2CVLJ6oX5bcQMRbDlPvZYZoMQ4eHlTUvTMK5Np1lmbcTk7jobKzHN
	 8ZftqXvWi5eO40qEL1SBCbcQqQZp8q8oAIv94LeQHM8Tev4qI9i3B0EsWM57JtrJmA
	 QKoxqVtIl2Z5nGJo+44H7uVSc+cVItHrU+DAlwn0=
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	david@kernel.org,
	shuah@kernel.org
Cc: Dev Jain <dev.jain@arm.com>,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	balbirs@nvidia.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-kselftest@vger.kernel.org,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	usama.arif@linux.dev,
	stable@vger.kernel.org,
	Oscar Salvador <osalvador@kernel.org>
Subject: [PATCH v3 1/2] fs/proc/task_mmu: do not warn on seeing non-migration pmd entry
Date: Thu,  4 Jun 2026 05:53:05 +0000
Message-ID: <20260604055308.1947679-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604055308.1947679-1-dev.jain@arm.com>
References: <20260604055308.1947679-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260264-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:liam@infradead.org,m:ljs@kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:david@kernel.org,m:shuah@kernel.org,m:dev.jain@arm.com,m:vbabka@kernel.org,m:jannh@google.com,m:pfalcato@suse.de,m:balbirs@nvidia.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:linux-kselftest@vger.kernel.org,m:ryan.roberts@arm.com,m:anshuman.khandual@arm.com,m:usama.arif@linux.dev,m:stable@vger.kernel.org,m:osalvador@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER(0.00)[dev.jain@arm.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev.jain@arm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:email,arm.com:mid,arm.com:dkim,arm.com:from_mime,arm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7631F63D1B3

pagemap_pmd_range_thp() warns if a non-present PMD is not a migration
entry. This became false once device-private entries at the PMD level were
added.

Therefore, remove the stale migration-only assertion.

Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
Cc: stable@vger.kernel.org
Reviewed-by: Balbir Singh <balbirs@nvidia.com>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Tested-by: Lorenzo Stoakes <ljs@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 fs/proc/task_mmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 1e3a15bf46f4e..58938e62154d9 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2129,7 +2129,6 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 			flags |= PM_SOFT_DIRTY;
 		if (pmd_swp_uffd_wp(pmd))
 			flags |= PM_UFFD_WP;
-		VM_WARN_ON_ONCE(!pmd_is_migration_entry(pmd));
 		page = softleaf_to_page(entry);
 	}
 
-- 
2.43.0


