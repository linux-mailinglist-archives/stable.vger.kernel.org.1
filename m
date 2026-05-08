Return-Path: <stable+bounces-244654-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMQEB3g+/WkuZgAAu9opvQ
	(envelope-from <stable+bounces-244654-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 03:38:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2AF4F09DD
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 03:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93A6D3009F01
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 01:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A14D221723;
	Fri,  8 May 2026 01:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnM9Vuez"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA0A21CA02
	for <stable@vger.kernel.org>; Fri,  8 May 2026 01:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778204272; cv=none; b=h10Ew9osMQFpaHD/De2Kvkc7E94ix8iTMgtlKa7jDbGUkBJB7HnZc3ADqNpowPcCRCGSGklSYIMWojqzm9SBu2r5qO68x1d1xC1oliyYfI8bOHicgDRhEGaG7NGSBMUBDYCAAJG9ttbuFXxInjlMuQjHfaAAWIrtwFFRXS4ctUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778204272; c=relaxed/simple;
	bh=NodABNO6pgBTz+Kzyb5ShxbMNHSSLanh6fB43z/I/rU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Zwv/7D+0RFAvr4RHnBUhJDnxFmwdnV3uiNf7T07bXTQ21EsFdwEmoEDl8kTLqfk+YJD8mnC3PSI1jRXQa5fvEX/nOOLF0UG9hZtuUPrF7a8lBCePedgu/RrYFdcJyzjuzmwQd7dDmvjdkZ/hgwOxUNMA/IEVb+7l/tCP6KTxc+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnM9Vuez; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bb962ce4dcfso224727666b.1
        for <stable@vger.kernel.org>; Thu, 07 May 2026 18:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778204269; x=1778809069; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCR0Uxw8nPMjXkQNBVuhopP7MZk6tXzc3P0jjJgs7Do=;
        b=KnM9VuezIRV7uhZyYlNheoi+BFnZymnoDR82PhwiL6U7Ky7uZq08nBsn3/qLrHqpu3
         nFjwfzTI0YSqUBOoBkp7s+LK0SRluMCbRvnUXV3kaE3GRAsoz795wa1tMDh7givKUmrK
         +AQCQRfPUyGHpO//f6KKbDVMK/cj6q6EVq8K79v0kcC6M0l6Y6mLLuraZxfVecIWIAFi
         QsKSYCH2na0wE8J7dtGzMI3PI0uIfIwSYQX3vnhxpfGSnNdzm4JyrhqTZAFxM1t+Pi/m
         jwarqhWRXAFa6PG8zR/1pSRvv0jyU+bHqogVfHQJBRT3D3g4CmOtZv3aT2Qxl4C6A0Es
         gF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778204269; x=1778809069;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mCR0Uxw8nPMjXkQNBVuhopP7MZk6tXzc3P0jjJgs7Do=;
        b=U8db/YpGzTo7cUzFIqOZmRPOHnfSWRK3zLaLLTAltrTmUjzZujSZK1K42rnGF4Jf8P
         XxFPbK0oDJ7LZb030GDzzPPg/rTtDIoRSib9rNk8HCAKMDnoGoaXQlafoLe6JNOPcp0G
         3EO+rvJDXqeHz1+vTuTKw2xtbi22Ti3+OudwXDs0dJxyz2ZotIRSGLcGule3QppB/Sp+
         BhQz+oP8L1qJZ4EGrwftrzqFqcpmGA9DCwMNo6luJqs4H3W6+aypjcGHvnaxLyH4iMZQ
         4/aSoNXn2ZDEpDJEXk7VOtIA+ahLrbFrGqZ4i+rBVeXT7Zqqm166rdMbH6w2R2UcpdoQ
         YcBw==
X-Forwarded-Encrypted: i=1; AFNElJ9Hk7Z5m77IHwHkmY8gQFcYY2Q5oPjYjAkl/RAl0R//DwCmYd3TH6uvuwFLiwMJPMU6ctxQ5Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjaf4cD3oHdje5bCzQHVSTzm4yPc0YMf8tdFmRICmFl0Bazad8
	1b4yhK0+xga/6nrrEJtwEx5NOQgawIiQA+KwwLYHXYmabcjWpz1lRnTA
X-Gm-Gg: AeBDievqHnFcUInMCsJ6xgDAC9ggN5OJoL42RnDJpixMOwnTLrw6Itbi0GsO09h+IV+
	TLSMdlrowwKOHlLmfaRG+6OKDm/eO9V+TjqvWq57X0wCb1EibCZfUNTzU4pjwFfkIOPpqjAwkY+
	d3HdhCeTnSC4iEBwBQz8M+2tSwmxibHV/bhoAaTVqDAwr+wPKJOz+/gj0WX6sYXOXzJ//TfL+dB
	btCWNT8ackZ59NrMHe5yip4BGJxGJkWaL6woqLkTZEWBaGwCLWrI2OuOCnms6LeJMja93Lcg3bd
	kbam7HSl9htZAj+eUZsGRK3w8dMLLKUOk/SgjEmlPk5QumhwbJn/T8BMcH0aM1pMBfSZ0ZBA3XP
	CyowaV/BUA50oVVbWFdfHRTM5PVNYIOgmbrs5LEzVEYk2VPdQaTPOdT0rAhaPB5lFFiyp7X7nn0
	vBKVjdm2DXmqGAHhsS8huokwchPXjz2k2V
X-Received: by 2002:a17:907:25c8:b0:bc1:526c:1ee3 with SMTP id a640c23a62f3a-bc56b124741mr594281766b.13.1778204268865;
        Thu, 07 May 2026 18:37:48 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcac02c82a3sm12614666b.13.2026.05.07.18.37.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 May 2026 18:37:47 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	sj@kernel.org,
	ziy@nvidia.com,
	balbirs@nvidia.com
Cc: linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/page_vma_mapped: revalidate and do proper check before return device-private pmd
Date: Fri,  8 May 2026 01:37:28 +0000
Message-Id: <20260508013728.21285-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 1C2AF4F09DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-244654-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,gmail.com,oracle.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email,nvidia.com:email]
X-Rspamd-Action: no action

For pmd_trans_huge() and pmd_is_migration_entry(), we does following
before return the pmd entry:

  * re-validate pmd entry
  * check PVMW_MIGRATION
  * check_pmd()
  * handle on pte level if split under us

But for device-private pmd, we just return after pmd_lock(). This may
lead to inproper situation.

This patch fixes commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration
support device-private entries") by following the same pattern as
pmd_trans_huge() and pmd_is_migration_entry().

Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: <stable@vger.kernel.org>
---
 mm/page_vma_mapped.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index a4d52fdb3056..5d337ea43019 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -269,21 +269,33 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			spin_unlock(pvmw->ptl);
 			pvmw->ptl = NULL;
 		} else if (!pmd_present(pmde)) {
-			const softleaf_t entry = softleaf_from_pmd(pmde);
+			softleaf_t entry = softleaf_from_pmd(pmde);
 
 			if (softleaf_is_device_private(entry)) {
 				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
-				return true;
-			}
-
-			if ((pvmw->flags & PVMW_SYNC) &&
-			    thp_vma_suitable_order(vma, pvmw->address,
-						   PMD_ORDER) &&
-			    (pvmw->nr_pages >= HPAGE_PMD_NR))
-				sync_with_folio_pmd_zap(mm, pvmw->pmd);
+				entry = softleaf_from_pmd(*pvmw->pmd);
+
+				if (softleaf_is_device_private(entry)) {
+					if (pvmw->flags & PVMW_MIGRATION)
+						return not_found(pvmw);
+					if (!check_pmd(softleaf_to_pfn(entry), pvmw))
+						return not_found(pvmw);
+					return true;
+				}
 
-			step_forward(pvmw, PMD_SIZE);
-			continue;
+				/* THP pmd was split under us: handle on pte level */
+				spin_unlock(pvmw->ptl);
+				pvmw->ptl = NULL;
+			} else {
+				if ((pvmw->flags & PVMW_SYNC) &&
+				    thp_vma_suitable_order(vma, pvmw->address,
+							   PMD_ORDER) &&
+				    (pvmw->nr_pages >= HPAGE_PMD_NR))
+					sync_with_folio_pmd_zap(mm, pvmw->pmd);
+
+				step_forward(pvmw, PMD_SIZE);
+				continue;
+			}
 		}
 		if (!map_pte(pvmw, &pmde, &ptl)) {
 			if (!pvmw->pte)
-- 
2.34.1


