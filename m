Return-Path: <stable+bounces-233232-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLL2OgIX0GmV3AYAu9opvQ
	(envelope-from <stable+bounces-233232-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 21:37:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E35B397B9F
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 21:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91704302452F
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 19:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8CB3CA4B2;
	Fri,  3 Apr 2026 19:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.it header.i=@amazon.it header.b="Fm+GaN3x"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592E633EAED
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 19:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775244738; cv=none; b=eJyK9m1hnirYDGDY10GY14EFk+xUpzBG1ffrLtWOtxjnRD1QaH/xeioalWzsMauoUddFSaN0v1nJFqg+/gp+LMW5WE8BSDBbsqmgwySLEMs2a6MZ3xWUUTTsEFD25QDDRhbOZSSqMso/05TMpEPCQCcTFbuBgYQNQnuBvTAdIdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775244738; c=relaxed/simple;
	bh=ycG1vAoajTYWTQidO+jgNfLzn8hwwFmi4Xb0pSLdzKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7LbMV+BT8QFk/IwgYPF8Mwfg0tKetP55+1BSPaHfasItU73vt8Wq8QB+SrMMjpLP/o/L7euhUt4yNYwEchAccf54vMRnYwDQAvFY1MIGdZKmYchGDZr0Jgy431NhA50AjlHDDfMcr0TohqvGfZ3m0+BD4voSMdfjMMPnNU6faE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.it; spf=pass smtp.mailfrom=amazon.it; dkim=pass (2048-bit key) header.d=amazon.it header.i=@amazon.it header.b=Fm+GaN3x; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.it
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.it; i=@amazon.it; q=dns/txt; s=amazoncorp2;
  t=1775244736; x=1806780736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EyFJJlejxGzTWLtg5fvYIh3yb3XlIEjqtxfx4waTmGo=;
  b=Fm+GaN3xQOyP4E9oMMXvO/GSmccJB2Wo+PLx1eRmhm1AP+DWh7bOitTO
   9JTKvMvh9ULwZAkD6kd3s9bnmVn6T+d8C8Hg9MjAOipyFypy4NR+/NJFG
   KAabf/qtSLCuWd1KWdFPSZ4W9f1/s5di4cGTx1olrwq+cbEyvX+ftVhYp
   JTMTmX8iqc7niScdxDcZadHqrmZNa6rRepNiDAVRK57TCJFmXvj3pIZBd
   YaDkAvVTXtFQWD/iuQpL6wheurhb4T0LxeWqpoJBI5k4Z8QYxxXI1gEqA
   ko++ZKOFJtC5Pj0r6u4IyQDptwtxlfHM6Qrz9gEN7tmB519TX7b+n8l4/
   w==;
X-CSE-ConnectionGUID: dK/pQWMoT++SxpAyFYBuGg==
X-CSE-MsgGUID: tnZJDo4gT1mrbB7m1z/kyQ==
X-IronPort-AV: E=Sophos;i="6.23,158,1770595200"; 
   d="scan'208";a="16501205"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 19:32:13 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:21222]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.27:2525] with esmtp (Farcaster)
 id 0d515a4f-e37c-4c3f-887f-155432f3fc21; Fri, 3 Apr 2026 19:32:13 +0000 (UTC)
X-Farcaster-Flow-ID: 0d515a4f-e37c-4c3f-887f-155432f3fc21
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 3 Apr 2026 19:32:09 +0000
Received: from dev-dsk-dipiets-2b-fa1865ee.us-west-2.amazon.com
 (172.22.139.101) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Fri, 3 Apr 2026
 19:32:09 +0000
From: Salvatore Dipietro <dipiets@amazon.it>
To: <dipietro.salvatore@gmail.com>
CC: <stable@vger.kernel.org>
Subject: [PATCH 1/1] iomap: avoid compaction for costly folio order allocation
Date: Fri, 3 Apr 2026 19:32:01 +0000
Message-ID: <20260403193201.30479-2-dipiets@amazon.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403193201.30479-1-dipiets@amazon.it>
References: <20260403193201.30479-1-dipiets@amazon.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D038UWB001.ant.amazon.com (10.13.139.148) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.it,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amazon.it:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233232-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.it:dkim,amazon.it:email,amazon.it:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[amazon.it:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[dipiets@amazon.it,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4E35B397B9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
introduced high-order folio allocations in the buffered write
path. When memory is fragmented, each failed allocation triggers
compaction and drain_all_pages() via __alloc_pages_slowpath(),
causing a 0.75x throughput drop on pgbench (simple-update) with 
1024 clients on a 96-vCPU arm64 system.

Strip __GFP_DIRECT_RECLAIM from folio allocations in
iomap_get_folio() when the order exceeds PAGE_ALLOC_COSTLY_ORDER,
making them purely opportunistic.

Fixes: 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
Cc: stable@vger.kernel.org
Signed-off-by: Salvatore Dipietro <dipiets@amazon.it>
---
 fs/iomap/buffered-io.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 92a831cf4bf1..cb843d54b4d9 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -715,6 +715,7 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
 struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
 {
 	fgf_t fgp = FGP_WRITEBEGIN | FGP_NOFS;
+	gfp_t gfp;
 
 	if (iter->flags & IOMAP_NOWAIT)
 		fgp |= FGP_NOWAIT;
@@ -722,8 +723,20 @@ struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
 		fgp |= FGP_DONTCACHE;
 	fgp |= fgf_set_order(len);
 
+	gfp = mapping_gfp_mask(iter->inode->i_mapping);
+
+	/*
+	 * If the folio order hint exceeds PAGE_ALLOC_COSTLY_ORDER,
+	 * strip __GFP_DIRECT_RECLAIM to make the allocation purely
+	 * opportunistic.  This avoids compaction + drain_all_pages()
+	 * in __alloc_pages_slowpath() that devastate throughput
+	 * on large systems during buffered writes.
+	 */
+	if (FGF_GET_ORDER(fgp) > PAGE_ALLOC_COSTLY_ORDER)
+		gfp &= ~__GFP_DIRECT_RECLAIM;
+
 	return __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
-			fgp, mapping_gfp_mask(iter->inode->i_mapping));
+			fgp, gfp);
 }
 EXPORT_SYMBOL_GPL(iomap_get_folio);
 
-- 
2.50.1 (Apple Git-155)




AMAZON DEVELOPMENT CENTER ITALY SRL, viale Monte Grappa 3/5, 20124 Milano, Italia, Registro delle Imprese di Milano Monza Brianza Lodi REA n. 2504859, Capitale Sociale: 10.000 EUR i.v., Cod. Fisc. e P.IVA 10100050961, Societa con Socio Unico




