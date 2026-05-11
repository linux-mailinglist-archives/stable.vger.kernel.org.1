Return-Path: <stable+bounces-245323-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCh6JvJMAmpaqQEAu9opvQ
	(envelope-from <stable+bounces-245323-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 23:41:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC8951663A
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 23:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E9AE302592D
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 21:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1AB4D90D8;
	Mon, 11 May 2026 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlalabs-com.20251104.gappssmtp.com header.i=@amlalabs-com.20251104.gappssmtp.com header.b="z4+Accw4"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f228.google.com (mail-oi1-f228.google.com [209.85.167.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF61C4D90D0
	for <stable@vger.kernel.org>; Mon, 11 May 2026 21:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778535662; cv=none; b=m8MNvDa/jB2XILmC54hwZXo83MbFtRLjrNYI+BVB6/GxSan72pNVxkNhhdP5nMdXv4Qk7JbzTXBNI8XyMI9X1yqfUuDpIYKdUzC/xclw7Hn5eWP21e+gQhqHE3KGwQadKUL2LIN3/3xo0xuz2BOO0obVrdgZnAJSS4Q/gyST5hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778535662; c=relaxed/simple;
	bh=ljekVeTJvDasxU8usBmBxCnDSxCzXGYcRwljfuuKbvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nk8A420Q1bXkpieK2PV57SQhhXZjqPNyfP534pWMxnAqzwrg9wo8LCi/fvXFtRetGNHzAyvJkglur+qr3yzDHydvgsZBe08iCdBbr0ce32eiIeOYOtFYzbNepWzAYY3dR+wS/Ny5whB/dVGx22xfbfI/poiVkFIQd9taJ59zy4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amlalabs.com; spf=pass smtp.mailfrom=amlalabs.com; dkim=pass (2048-bit key) header.d=amlalabs-com.20251104.gappssmtp.com header.i=@amlalabs-com.20251104.gappssmtp.com header.b=z4+Accw4; arc=none smtp.client-ip=209.85.167.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amlalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlalabs.com
Received: by mail-oi1-f228.google.com with SMTP id 5614622812f47-47cba53479aso3001339b6e.0
        for <stable@vger.kernel.org>; Mon, 11 May 2026 14:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amlalabs-com.20251104.gappssmtp.com; s=20251104; t=1778535660; x=1779140460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OsyEmMEatHl5JGOKxvyMcGRrS7mW1Z+dscSdDt5bxRY=;
        b=z4+Accw4Fx4gFPQhtHZ+Z5VXb+sSa5sC15b7gTHSGBVhrYlB6TYDAzlyzrD0D5iyex
         oAN3vlMA7EPxsPX7emq/M6uC4Rt4Ni98u5bG3CaxOqEIzWwLoxLD5yG+LYNjhQ+2kIoM
         LEnaqpAhi1s0TYckWYySCBBGtSM0bwPzGJELyoW0LqyWboYLlymJ9hCgtIpmQAbJ1vU4
         9YnK/atz6PXdBBLnsu3m5aIthvH93FktW11Ams1fGWTvjEYtkcEglyu/8UUhOFfBqY/D
         4zKJEYetEpod1+0zXM+O6ygrj0n+jTsXn+C3fFUjvI1YCNjY2uwy8db8mQb9PD1qrYCZ
         HbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778535660; x=1779140460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsyEmMEatHl5JGOKxvyMcGRrS7mW1Z+dscSdDt5bxRY=;
        b=ZJW36GQgxo3uEAKuIjuKcT9nA9idGAw5bHobHISjYoEEn7xWHaSma5MT3dsXCVnMSs
         8XMMe7uCIHJaqKEUhUvSHQtTfztGv1ExptIzRBs2w0U/4RWgpHb5sRDTs4t8N/azvuhX
         n7icJ4gW2y8CZvxnf6CrfDgshFpwpeD0iC2EtBYjM6ZxU8gq5Cah7uqXm4Iq5rf6hA95
         HwwZD0B2i8CqsaWa48MPQbYuiXW8kIHs3yFXXino4zbWpAQraHzL/3+e7oFLHvT4tQe0
         iiVhkui/9meywKr6PFENm1UPyf+iV8ur3AZVjMZMtCTuCZC3TgaNtIAc5XEsAeIXBmqs
         NwqQ==
X-Forwarded-Encrypted: i=1; AFNElJ/+NXaPOb3DT4aJ21kwDk5WN/Fv3vG+4YuvGobOKOLLTskR6of/AM8yJCE/tVoda6yibxvNrWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPjLM0TT7EidYNALcyhFo2ox3GsnDY5lYsqwy5dbUrLx1qhOxa
	/VSCe88cwsfUnjmogIcDd8qN5mMXCFLTEaeIkofKay5CHfVcTtPca+wkP3udknsgUIfK2WlbKi7
	SrhmF49CPu3XKYW6/sBlAobmpQnZ2w/Xlnb/U7uk=
X-Gm-Gg: Acq92OHEILwHZekRbpsZmv7eJbTb5f0eMJzr6XIFOJSh/puj282pB2EoeCkx52hfSbJ
	/xFbI6149bvsN3eijzd3b1m4wBLcpC4iMV6ONOTwRsAuODCDiWQ+h6in37Z7k5eRuDpqPcqXDVY
	5e/+mlHmWvfYUKpGPE5nncD3miKVlB4+Svuz5VaS5gFA/y4KhgMkg+mbuhcYw3xJPzOm/T7HiL8
	0CMvbjjozskot3gT3RTtSyWypK2pl8LfqiZhNTeqSDue2h90RuE4u6OnA8A/U1DAv9Br41aRCYd
	blCJTHLMWkzdHTy2EB0CeglnBx9ZRBaaf/XVjk65Jc0e9r1IBe6TdsQOKSutHeUqQyoG9h9hfh8
	+k/puj8eBH2N7+lYvIyHbw8bj5u/ir3h2uBuQ26MgtaOooxHOPdEObQouOJMyH9DkrM60TIB/Rg
	==
X-Received: by 2002:a05:6808:2e45:b0:47c:3415:3726 with SMTP id 5614622812f47-48297388e0fmr335122b6e.33.1778535659807;
        Mon, 11 May 2026 14:40:59 -0700 (PDT)
Received: from amlalabs.com (104-10-255-95.lightspeed.sntcca.sbcglobal.net. [104.10.255.95])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-435f250853csm538701fac.10.2026.05.11.14.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 14:40:59 -0700 (PDT)
X-Relaying-Domain: amlalabs.com
From: Souvik Banerjee <souvik@amlalabs.com>
To: djbw@kernel.org
Cc: david@kernel.org,
	willy@infradead.org,
	jack@suse.cz,
	apopple@nvidia.com,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Souvik Banerjee <souvik@amlalabs.com>
Subject: [PATCH v2] fs/dax: check for empty/zero entries before calling pfn_to_page()
Date: Mon, 11 May 2026 21:40:20 +0000
Message-ID: <20260511214020.208939-1-souvik@amlalabs.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ECC8951663A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amlalabs-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245323-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[amlalabs.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amlalabs-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[souvik@amlalabs.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amlalabs-com.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

Commit 98c183a4fccf ("fs/dax: don't disassociate zero page entries")
added zero/empty-entry early returns to dax_associate_entry() and
dax_disassociate_entry(), but placed them *after* the
`struct folio *folio = dax_to_folio(entry);` line.  dax_to_folio()
expands to page_folio(pfn_to_page(dax_to_pfn(entry))), which calls
_compound_head() and performs READ_ONCE(page->compound_info) -- a real
dereference of the struct page pointer derived from a bogus PFN
extracted from the empty/zero XA value.

On systems where vmemmap covers all of RAM that dereference reads
garbage and is harmless: the early return then discards the result.
On virtio-pmem with altmap (vmemmap stored inside the device), only
the real device PFN range is mapped, so the dereference triggers a
kernel paging fault from the truncate / invalidate path and from the
PMD-downgrade branch of dax_iomap_pte_fault when an entry is being
freed:

  Unable to handle kernel paging request at
  virtual address ffff_fdff_bf00_0008 (vmemmap region)
  Call trace:
   dax_disassociate_entry.isra.0+0x20/0x50
   dax_iomap_pte_fault
   dax_iomap_fault
   erofs_dax_fault

Close the residual gap by moving the dax_to_folio() call after the
zero/empty guard in both dax_associate_entry() and
dax_disassociate_entry().  Apply the same treatment to dax_busy_page(),
which has the identical pattern but was not touched by the prior fix.
dax_associate_entry() is reachable with a zero entry via
dax_insert_entry() -> dax_associate_entry(new_entry, ...), where
new_entry can carry DAX_ZERO_PAGE (built by dax_make_entry() in
dax_load_hole() / dax_pmd_load_hole()).  dax_disassociate_entry() and
dax_busy_page() additionally see DAX_EMPTY entries created by
grab_mapping_entry().

The remaining users of dax_to_folio() / dax_to_pfn() in fs/dax.c are
either guarded or only reachable on real-PFN entries, so this exhausts
the anti-pattern.

Fixes: 98c183a4fccf ("fs/dax: don't disassociate zero page entries")
Fixes: 38607c62b34b ("fs/dax: properly refcount fs dax pages")
Cc: stable@vger.kernel.org # v6.15+
Cc: Alistair Popple <apopple@nvidia.com>
Suggested-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Souvik Banerjee <souvik@amlalabs.com>
---
Changes in v2:
  - Also fix dax_associate_entry() (Suggested-by: David Hildenbrand,
    confirmed by Alistair Popple).  The same anti-pattern existed there:
    dax_to_folio(entry) ran before the zero/empty guard.  new_entry on
    that path can carry DAX_ZERO_PAGE via dax_load_hole() /
    dax_pmd_load_hole(), so the dereference reads a struct page derived
    from the zero-page PFN before the early return discards it.
  - Audited remaining dax_to_folio() / dax_to_pfn() call sites in fs/dax.c;
    no further instances of the pattern.
  - Updated the page_folio() expansion in the commit message to refer to
    the current field name (page->compound_info via _compound_head()).

v1: https://lore.kernel.org/all/20260501233933.2614302-1-souvik@amlalabs.com/

 fs/dax.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 6d175cd47a99..4bca6e2bc342 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -480,11 +480,12 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
 				unsigned long address, bool shared)
 {
 	unsigned long size = dax_entry_size(entry), index;
-	struct folio *folio = dax_to_folio(entry);
+	struct folio *folio;
 
 	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
 		return;
 
+	folio = dax_to_folio(entry);
 	index = linear_page_index(vma, address & ~(size - 1));
 	if (shared && (folio->mapping || dax_folio_is_shared(folio))) {
 		if (folio->mapping)
@@ -505,21 +506,23 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
 static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 				bool trunc)
 {
-	struct folio *folio = dax_to_folio(entry);
+	struct folio *folio;
 
 	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
 		return;
 
+	folio = dax_to_folio(entry);
 	dax_folio_put(folio);
 }
 
 static struct page *dax_busy_page(void *entry)
 {
-	struct folio *folio = dax_to_folio(entry);
+	struct folio *folio;
 
 	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
 		return NULL;
 
+	folio = dax_to_folio(entry);
 	if (folio_ref_count(folio) - folio_mapcount(folio))
 		return &folio->page;
 	else
-- 
2.51.1


