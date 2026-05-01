Return-Path: <stable+bounces-242560-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCzUM8E59Wl8JgIAu9opvQ
	(envelope-from <stable+bounces-242560-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 01:39:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 480E74B053D
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 01:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BC8130185BB
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 23:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E445637F73E;
	Fri,  1 May 2026 23:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlalabs-com.20251104.gappssmtp.com header.i=@amlalabs-com.20251104.gappssmtp.com header.b="Jo0TF+pU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2CB37BE63
	for <stable@vger.kernel.org>; Fri,  1 May 2026 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777678780; cv=none; b=cmPMJgWz76HuntYJUYuG8CCVLBqvoUWP6WhNd/2kzXUBQ/wGkjaZ0bFCURymIpttlRtRaEb4n37vzT77JTkZq0lMLBAaSza4baDuFQkFWbQjoZN44j3iL7NtBkvRUZfI6smyhDa6tFVxEO0YRkxdZpoJ4YcsjqVIafZghMxVtmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777678780; c=relaxed/simple;
	bh=MQlW50n380xfH4YSLTJFu5splwcmM0wqWdXlHGJpjXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZLsIE85EJj1rMc2EYqMVmzqd5DQd7dp/gcTmKesM/1Zq4PjCBGkZVf+x1cJXmG7zdaERCfyIfsdUgLlby9pXk7MvjD/62hNa0NMMHTtvhDgJG5yfZIjO9WCREmrvyLZM2kFqCp9VotaFttFgZSnM4OralSAk3FojAXxzIz/j+2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amlalabs.com; spf=pass smtp.mailfrom=amlalabs.com; dkim=pass (2048-bit key) header.d=amlalabs-com.20251104.gappssmtp.com header.i=@amlalabs-com.20251104.gappssmtp.com header.b=Jo0TF+pU; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amlalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlalabs.com
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-7dbccf6a23dso2134607a34.2
        for <stable@vger.kernel.org>; Fri, 01 May 2026 16:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amlalabs-com.20251104.gappssmtp.com; s=20251104; t=1777678778; x=1778283578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2qFO2NeB0Skobdzpthr8c1Mn9L79Z6O0Ds9iXE6n6s0=;
        b=Jo0TF+pUjzgyZkOGcV1NdwCDthNAFPhlu603OU85L26A7GhwkIjvCfrBxlpL+24yVW
         jrGPSwQyDhaZe10csr1h6IwzeRfhkfzUN3MRmbd/llzAaFSjTxP0cH2lgacZA5ORkNUI
         zF6PTk8+ccP/sxWtsqsiw36YjRup6hcVL8UeT2z01b9TaQVDMJITztrRNJP4fC+lYcJd
         mssGWt34VrRGw9bN3xRMltC/X64+yT4Qh0uzL3brVwcryXbjFw9QjcTPlxNDP7H4Cyd8
         RE5RpdBlsuB8QORqrNNRosR1yqfLzv8h2jfff98fdlRke7VHrjjx7JCXTX7rCSuhTmi0
         zwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777678778; x=1778283578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qFO2NeB0Skobdzpthr8c1Mn9L79Z6O0Ds9iXE6n6s0=;
        b=tOzyr1ePpLtNVsLnp4/u8A4jnymHZi7tgarum4k5iPvkup77uocbgeQtOLVABebwou
         xo9a75ykmBxWhfC2YBftpfAiM/Fd9plYWvN/fhx8g5EOQqHSWsVMmYzm+jbkkzX2m/gd
         +t7v4ASm6UVxYk71u8/KAQzOhNn3DifybrZyUEc/VC2v3+XshygxDqNojCaT59b1Q9b8
         453z5rcEihlQCM86I6Wzktk8MwWHrQNPMksWy+oFUwJ1OIzm0NZHt2fI9V6mUL8NnjQV
         u9fbtcXraFrUkEWetfw2g+M2nFw72wKfrg0QOYREuRbdrbRQEHF87cQpJzEgb3r0V1gV
         sgmQ==
X-Forwarded-Encrypted: i=1; AFNElJ8FVhL2sHZq1jBWT05dbhv+3pWndznn8hOhaF+UYAK5yW5UrOUtrBKWqelORubBaABAKr0dmQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxku+aZNEuVmllK5ghU8rr0Cw+px+lC06NSXNE7hKJGHZUPfcUX
	XtV2UNlhSbxkgMIT/1W4w0dIr4lwXfeVnlujIlqk1MxYOutOaPidIOzaSQMknoHgatDttQprHx8
	u/HZZyyqLWmMUTAR5rYhID0DjfbvxOPEbLAYCmm4=
X-Gm-Gg: AeBDieuyRh6nWly6OWNjav/Be3jY6JFxIeS4mjQro+lmNb1Q2GFXkvH7lqm+pvLoOyz
	fBsyl9wFhusu2km0clLJAjI3Nt2goaW1mqGFGV7bKaX30PtHywKNGqqUhmWxmPaJ1O7mzXvxaKH
	k/YVTgZ7BGMh3WJTl8McqcW0Y33oYAtV/rbK1khbOeEjqs2CTdT7uXW8d/2KE1kpid4qCvN5eWQ
	Jsrkn1gjtyJDZQxRa3Snl+OGIopiAM+KZYy4BAiAdp3QdOm61aMp0CFSsjlInQXWESo3E9pvOP9
	7teLz/spxGrTCfX1E1MsJQ5qyA90B9z9UiCCeY8HIPPR/0Ze+TeTojqiVWB44x1VBkPhlQ2indm
	Y94S0ZvcH/haPuH0pfHRVPc0t2eAnJAvy2NnKBpzjTZlVS8/+Brc5MhmoE+HHhz4/htyqFuGJ7U
	IrmHT6z7Y7
X-Received: by 2002:a05:6820:61e:b0:67e:160c:36ba with SMTP id 006d021491bc7-69697d6a089mr608506eaf.48.1777678778004;
        Fri, 01 May 2026 16:39:38 -0700 (PDT)
Received: from amlalabs.com (104-10-255-95.lightspeed.sntcca.sbcglobal.net. [104.10.255.95])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-434549400e9sm365539fac.5.2026.05.01.16.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 16:39:38 -0700 (PDT)
X-Relaying-Domain: amlalabs.com
From: Souvik Banerjee <souvik@amlalabs.com>
To: dan.j.williams@intel.com
Cc: willy@infradead.org,
	jack@suse.cz,
	apopple@nvidia.com,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Souvik Banerjee <souvik@amlalabs.com>
Subject: [PATCH] fs/dax: check for empty/zero entries before calling pfn_to_page()
Date: Fri,  1 May 2026 23:39:33 +0000
Message-ID: <20260501233933.2614302-1-souvik@amlalabs.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 480E74B053D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amlalabs-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242560-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[amlalabs.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amlalabs-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[souvik@amlalabs.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amlalabs-com.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amlalabs.com:mid,amlalabs.com:email,nvidia.com:email]

Commit 98c183a4fccf ("fs/dax: don't disassociate zero page entries")
added zero/empty-entry early returns to dax_associate_entry() and
dax_disassociate_entry(), but placed them *after* the
`struct folio *folio = dax_to_folio(entry);` line.  dax_to_folio()
expands to page_folio(pfn_to_page(dax_to_pfn(entry))), and page_folio()
performs READ_ONCE(page->compound_head) -- a real dereference of the
struct page pointer derived from a bogus PFN extracted from the
empty/zero XA value.

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
zero/empty guard in dax_disassociate_entry().  Apply the same
treatment to dax_busy_page(), which has the identical pattern but
was not touched by the prior fix.

Fixes: 98c183a4fccf ("fs/dax: don't disassociate zero page entries")
Fixes: 38607c62b34b ("fs/dax: properly refcount fs dax pages")
Cc: stable@vger.kernel.org # v6.15+
Cc: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Souvik Banerjee <souvik@amlalabs.com>
---
 fs/dax.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 6d175cd47a99..6878473265bb 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -505,21 +505,23 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
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


