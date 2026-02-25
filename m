Return-Path: <stable+bounces-218031-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKtfCk9BnmlgUQQAu9opvQ
	(envelope-from <stable+bounces-218031-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:24:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC2D18E5F2
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0744D306DFE9
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 00:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1108420C00C;
	Wed, 25 Feb 2026 00:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KGAwt1gs"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DF23EBF2A
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 00:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771979083; cv=none; b=fOSnlylmsRUoSZbd2ybjs0oRtCYB6/OCrXVOddmeJPuwpSCjUTFhinFzjoX9DLmVOfefnLsJd1n3kTtGw5S2qRvRYa+0WnYF4nFPDbokshT2rfLS5WBJ+CO2qgQqOpQBXG+EG4H3u9rey0ZT4UsU8b2ZEvJdWp/Ctdzwy3Zj/IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771979083; c=relaxed/simple;
	bh=1djW+sviE8GMc9yihya8bBPKGdGDhx7z9iqWw0JDbyc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qHgaFCxYZKWpbAtqs5xGQeTve4qUKhvP+fpWqT7aKxaGTwjtyOrxeSP7mAI8OzbWsMhZrJhMjljwvyOJLnaQQRkVO3eyHNxfHtsDDuwxKclbzbZPL/OzGruMXfjTbJ2wzexXI5wmU3I3fzDV7JY/cFPZ9CoDQPfldeCZRCla7IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KGAwt1gs; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1275c6fc58aso11381864c88.0
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 16:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771979081; x=1772583881; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y6p6m2t6gYC4KUM+VAX+tvTTd08UPZbYNt8kHVfP8DA=;
        b=KGAwt1gs8tZ3qGiqO4U78pB5RCwJZBnhefIrimB38tRLN7WyjqFWq42mA+lp0cqGno
         nwU0KsVFrtqUiKVi22cft0jmQ8eAI6UFZ+eVlrPZ4qQA3I1QocC2/rQxjT5cVx+oO3Re
         yngkSWeGjvsSc+LvoO4FpOyAoUPzh1QhHOKVsTDb3kokHyeGeikUshb1r7b59sgeZ3BB
         qk1ssUFQpUzc5hvxVlbkDRCAHFCu/Z+dzcqzCuXzgTet0yS6wvlJx1Ap4Xxx9y3qNUXs
         3JmdZvBlg70vV9b4bSmJpSVN1bMkHmPK4q0p6lYsKV3occFALqWO6BDuzaYeUqfj6NIJ
         meSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771979081; x=1772583881;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y6p6m2t6gYC4KUM+VAX+tvTTd08UPZbYNt8kHVfP8DA=;
        b=XQxi3hoA70Wq9HZmEPeowPxkgqfpqACXkk1M7U17MgymwPsFBVUKKGarPFgpL7pnq1
         VSG6lQ2L+58Fu/lXvZqi8JahdJh+az/JqagP5rHvPIH/d0u6AVxtdUIJKcGkqN64kMNm
         M6QIcAFPU/tEYsSjV1HjobSZB987kv7gxHM2bziDEA+dWRnvxYD9KC0tbL9ZquWBwg1i
         02XKR36asLrRJq3HZybPkws3VYfLmqu43e/iSRHZpoyae4CK8gZvu+ooqlLaNHrUAAzz
         07R+KWfpzknYgpZYSJl/S89fQhp98P7sup3MV5YXdTFDx26zO5aMuLwFhPBB3PZV+i3G
         2Yag==
X-Forwarded-Encrypted: i=1; AJvYcCXUdoQLJpfKlvg7CmuzLVqjKk+WwzbMc00m/Rv+6CEynDo4csYygpicxNPe+zXtXmM+MUFmNfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YycuQR5frCpbr1JH7BxMl3L6fjlBhMUWO3bL5sKTwiR+gmWYVXr
	vn4j43MfFG6n0FN9G9/DTyHwL0l5692XP0W2ImPENa+Jm16EPNkDe0SQguQpFD8GoT0Jwbzcagl
	T4CsBukwYZQ+zm8NvBYTJWH0o5YllH+Epqw==
X-Received: from dlbsn11.prod.google.com ([2002:a05:7022:b90b:b0:127:365a:84c7])
 (user=axelrasmussen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:2521:b0:11b:99a2:9082 with SMTP id a92af1059eb24-12781dd78c8mr205452c88.15.1771979080917;
 Tue, 24 Feb 2026 16:24:40 -0800 (PST)
Date: Tue, 24 Feb 2026 16:24:34 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225002434.2953895-1-axelrasmussen@google.com>
Subject: [PATCH] Revert "ptdesc: remove references to folios from
 __pagetable_ctor() and pagetable_dtor()"
From: Axel Rasmussen <axelrasmussen@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Axel Rasmussen <axelrasmussen@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218031-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axelrasmussen@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9EC2D18E5F2
X-Rspamd-Action: no action

This change swapped out mod_node_page_state for lruvec_stat_add_folio.
But, these two APIs are not interchangeable: the lruvec version also
increments memcg stats, in addition to "global" pgdat stats.

So after this change, the "pagetables" memcg stat in memory.stat always
yields "0", which is a userspace visible regression.

I tried to look for a refactor where we add a variant of
lruvec_stat_mod_folio which takes a pgdat and a memcg instead of a
folio, to try to adhere to the spirit of the original patch. But at the
end of the day this just means we have to call
folio_memcg(ptdesc_folio(ptdesc)) anyway, which doesn't really
accomplish much.

This regression is visible in master as well as 6.18 stable, so CC
stable too.

Fixes: f0c92726e89f ("ptdesc: remove references to folios from __pagetable_ctor() and pagetable_dtor()")
Cc: stable@vger.kernel.org
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/mm.h | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5be3d8a8f806..abb4963c1f06 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3514,26 +3514,21 @@ static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void ptlock_free(struct ptdesc *ptdesc) {}
 #endif /* defined(CONFIG_SPLIT_PTE_PTLOCKS) */
 
-static inline unsigned long ptdesc_nr_pages(const struct ptdesc *ptdesc)
-{
-	return compound_nr(ptdesc_page(ptdesc));
-}
-
 static inline void __pagetable_ctor(struct ptdesc *ptdesc)
 {
-	pg_data_t *pgdat = NODE_DATA(memdesc_nid(ptdesc->pt_flags));
+	struct folio *folio = ptdesc_folio(ptdesc);
 
-	__SetPageTable(ptdesc_page(ptdesc));
-	mod_node_page_state(pgdat, NR_PAGETABLE, ptdesc_nr_pages(ptdesc));
+	__folio_set_pgtable(folio);
+	lruvec_stat_add_folio(folio, NR_PAGETABLE);
 }
 
 static inline void pagetable_dtor(struct ptdesc *ptdesc)
 {
-	pg_data_t *pgdat = NODE_DATA(memdesc_nid(ptdesc->pt_flags));
+	struct folio *folio = ptdesc_folio(ptdesc);
 
 	ptlock_free(ptdesc);
-	__ClearPageTable(ptdesc_page(ptdesc));
-	mod_node_page_state(pgdat, NR_PAGETABLE, -ptdesc_nr_pages(ptdesc));
+	__folio_clear_pgtable(folio);
+	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
 }
 
 static inline void pagetable_dtor_free(struct ptdesc *ptdesc)
-- 
2.53.0.414.gf7e9f6c205-goog


