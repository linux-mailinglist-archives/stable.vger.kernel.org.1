Return-Path: <stable+bounces-219661-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJSTGKAhn2mPZAQAu9opvQ
	(envelope-from <stable+bounces-219661-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 17:21:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFC819A7F5
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 17:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D8A231C0223
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 16:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889BE3D7D70;
	Wed, 25 Feb 2026 16:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="psXGNg6g"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C403B9600;
	Wed, 25 Feb 2026 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772035512; cv=none; b=nwyaPN09Tw617WPGYz0JbUwgLnsotJlZG0duUrAxxt5Uv4SR/g/cQYq+PhSrxJnDIDVwhWSLd2lZMENzGu6qAkUUkAlFpe/3mWFr/oplSUMCrqvuP5hUpe4LAf83itRwrMf0hFJQ9QmDl174DE51acPMrdUwusRbEuF2n4u0gNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772035512; c=relaxed/simple;
	bh=aCNNmoiFt0MLWQHelqXMftI8rFdJfWFm5KtyyhGRLvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xhp5OjlizFLDMOmyVosT6J/woJvXtiUSZvPQYyuwjKEAni1QschTcDR/c/TN5zyZJq15Ohus5N4pzsOZyQQ6eL/sa1GOxuik9zjqNkmQnssCFh80kMFqP07QXJoHkDei3cjwvTUY1RKikUAJxlaA2D4JxYbYZMxpMS+kn74dxhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=psXGNg6g; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w2mHEadrI82HevMOqzNsydbPuFfL3JspAsXzk7QxJzo=; b=psXGNg6g61/oc6WQCvMVMCNhlW
	3A9Yrcb4Am0HNGEvdPaEBgNrUXC5I+rl6pVamJKW4QoHB4Seq/37+igO7VVBTFCGvSvsyB/bud0Xm
	bn3pjm7CG2jQIymlbKrjsgSoy9bFqtovRFC6dLF4TWQeQjbXFq7t8lF1GgqVVS66a6/tTJinsZLkS
	Jou+WpE7fL6DAOFGeeNaU5R4yjlrdC15Gi9ZKExrs45vYY4U1r4DhOcCd4xc5KOMM/z8HdcDsoGte
	HLuKPN3rkMbeucb+NqJ1heauPS75JmW2H/bJPqKqYzasEpybXRBjc5KU6PbMaO+5Y0WtTSg2gDsSC
	yjPGunKA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvHNq-00000001Iny-2zuo;
	Wed, 25 Feb 2026 16:05:06 +0000
Date: Wed, 25 Feb 2026 16:05:06 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "ptdesc: remove references to folios from
 __pagetable_ctor() and pagetable_dtor()"
Message-ID: <aZ8dsnqAsAcGE34o@casper.infradead.org>
References: <20260225002434.2953895-1-axelrasmussen@google.com>
 <aZ8dasxUYuuWF9M1@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ8dasxUYuuWF9M1@casper.infradead.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219661-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[casper.infradead.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: DBFC819A7F5
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 04:03:54PM +0000, Matthew Wilcox wrote:
> On Tue, Feb 24, 2026 at 04:24:34PM -0800, Axel Rasmussen wrote:
> > This change swapped out mod_node_page_state for lruvec_stat_add_folio.
> > But, these two APIs are not interchangeable: the lruvec version also
> > increments memcg stats, in addition to "global" pgdat stats.
> > 
> > So after this change, the "pagetables" memcg stat in memory.stat always
> > yields "0", which is a userspace visible regression.
> > 
> > I tried to look for a refactor where we add a variant of
> > lruvec_stat_mod_folio which takes a pgdat and a memcg instead of a
> > folio, to try to adhere to the spirit of the original patch. But at the
> > end of the day this just means we have to call
> > folio_memcg(ptdesc_folio(ptdesc)) anyway, which doesn't really
> > accomplish much.
> 
> Thank you!  I hadn't been able to get a straight answer on this before.
> 
> You're right that there's no good function to call, but that just means
> we need to make one.  The principle here is that (eventually) different
> memdescs don't need to know about each other.  Obviously we're not there
> yet, but we can start disentangling them by not casting ptdescs back to
> folios (even though they're created that way).
> 
> Here's three patches smooshed together; I have them separately and I'll
> post them soon.

Argh, fatfingered the inclusion and ended up sending ...

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5be3d8a8f806..34bc6f00ed7b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3519,21 +3519,32 @@ static inline unsigned long ptdesc_nr_pages(const struct ptdesc *ptdesc)
 	return compound_nr(ptdesc_page(ptdesc));
 }
 
+static inline struct mem_cgroup *pagetable_memcg(const struct ptdesc *ptdesc)
+{
+#ifdef CONFIG_MEMCG
+	return ptdesc->pt_memcg;
+#else
+	return NULL;
+#endif
+}
+
 static inline void __pagetable_ctor(struct ptdesc *ptdesc)
 {
 	pg_data_t *pgdat = NODE_DATA(memdesc_nid(ptdesc->pt_flags));
+	struct mem_cgroup *memcg = pagetable_memcg(ptdesc);
 
 	__SetPageTable(ptdesc_page(ptdesc));
-	mod_node_page_state(pgdat, NR_PAGETABLE, ptdesc_nr_pages(ptdesc));
+	memcg_stat_mod(memcg, pgdat, NR_PAGETABLE, ptdesc_nr_pages(ptdesc));
 }
 
 static inline void pagetable_dtor(struct ptdesc *ptdesc)
 {
 	pg_data_t *pgdat = NODE_DATA(memdesc_nid(ptdesc->pt_flags));
+	struct mem_cgroup *memcg = pagetable_memcg(ptdesc);
 
 	ptlock_free(ptdesc);
 	__ClearPageTable(ptdesc_page(ptdesc));
-	mod_node_page_state(pgdat, NR_PAGETABLE, -ptdesc_nr_pages(ptdesc));
+	memcg_stat_mod(memcg, pgdat, NR_PAGETABLE, -ptdesc_nr_pages(ptdesc));
 }
 
 static inline void pagetable_dtor_free(struct ptdesc *ptdesc)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3cc8ae722886..e9b1da04938a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -564,7 +564,7 @@ FOLIO_MATCH(compound_head, _head_3);
  * @ptl:              Lock for the page table.
  * @__page_type:      Same as page->page_type. Unused for page tables.
  * @__page_refcount:  Same as page refcount.
- * @pt_memcg_data:    Memcg data. Tracked for page tables here.
+ * @pt_memcg:         Memcg that this page table belongs to.
  *
  * This struct overlays struct page for now. Do not modify without a good
  * understanding of the issues.
@@ -602,7 +602,7 @@ struct ptdesc {
 	unsigned int __page_type;
 	atomic_t __page_refcount;
 #ifdef CONFIG_MEMCG
-	unsigned long pt_memcg_data;
+	struct mem_cgroup *pt_memcg;
 #endif
 };
 
@@ -617,7 +617,7 @@ TABLE_MATCH(rcu_head, pt_rcu_head);
 TABLE_MATCH(page_type, __page_type);
 TABLE_MATCH(_refcount, __page_refcount);
 #ifdef CONFIG_MEMCG
-TABLE_MATCH(memcg_data, pt_memcg_data);
+TABLE_MATCH(memcg_data, pt_memcg);
 #endif
 #undef TABLE_MATCH
 static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 3c9c266cf782..0da38ea25c97 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -518,7 +518,8 @@ static inline const char *vm_event_name(enum vm_event_item item)
 
 void mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			int val);
-
+void memcg_stat_mod(struct mem_cgroup *memcg, pg_data_t *pgdat,
+		enum node_stat_item idx, long val);
 void lruvec_stat_mod_folio(struct folio *folio,
 			     enum node_stat_item idx, int val);
 
@@ -536,6 +537,12 @@ static inline void mod_lruvec_state(struct lruvec *lruvec,
 	mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
 }
 
+static inline void memcg_stat_mod(struct mem_cgroup *memcg, pg_data_t *pgdat,
+		enum node_stat_item idx, long val)
+{
+	mod_node_page_state(pgdat, idx, val);
+}
+
 static inline void lruvec_stat_mod_folio(struct folio *folio,
 					 enum node_stat_item idx, int val)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a52da3a5e4fd..8d9e4a42aecf 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -787,24 +787,27 @@ void mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 		mod_memcg_lruvec_state(lruvec, idx, val);
 }
 
+void memcg_stat_mod(struct mem_cgroup *memcg, pg_data_t *pgdat,
+		enum node_stat_item idx, long val)
+{
+	/* Untracked pages have no memcg, no lruvec. Update only the node */
+	if (!memcg) {
+		mod_node_page_state(pgdat, idx, val);
+	} else {
+		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
+		mod_lruvec_state(lruvec, idx, val);
+	}
+}
+
 void lruvec_stat_mod_folio(struct folio *folio, enum node_stat_item idx,
 			     int val)
 {
 	struct mem_cgroup *memcg;
 	pg_data_t *pgdat = folio_pgdat(folio);
-	struct lruvec *lruvec;
 
 	rcu_read_lock();
 	memcg = folio_memcg(folio);
-	/* Untracked pages have no memcg, no lruvec. Update only the node */
-	if (!memcg) {
-		rcu_read_unlock();
-		mod_node_page_state(pgdat, idx, val);
-		return;
-	}
-
-	lruvec = mem_cgroup_lruvec(memcg, pgdat);
-	mod_lruvec_state(lruvec, idx, val);
+	memcg_stat_mod(memcg, pgdat, idx, val);
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL(lruvec_stat_mod_folio);
@@ -812,24 +815,9 @@ EXPORT_SYMBOL(lruvec_stat_mod_folio);
 void mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
 {
 	pg_data_t *pgdat = page_pgdat(virt_to_page(p));
-	struct mem_cgroup *memcg;
-	struct lruvec *lruvec;
 
 	rcu_read_lock();
-	memcg = mem_cgroup_from_virt(p);
-
-	/*
-	 * Untracked pages have no memcg, no lruvec. Update only the
-	 * node. If we reparent the slab objects to the root memcg,
-	 * when we free the slab object, we need to update the per-memcg
-	 * vmstats to keep it correct for the root memcg.
-	 */
-	if (!memcg) {
-		mod_node_page_state(pgdat, idx, val);
-	} else {
-		lruvec = mem_cgroup_lruvec(memcg, pgdat);
-		mod_lruvec_state(lruvec, idx, val);
-	}
+	memcg_stat_mod(mem_cgroup_from_virt(p), pgdat, idx, val);
 	rcu_read_unlock();
 }
 

