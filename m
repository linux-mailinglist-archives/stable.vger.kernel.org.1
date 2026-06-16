Return-Path: <stable+bounces-265759-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e2QzAmaPMWrrmgUAu9opvQ
	(envelope-from <stable+bounces-265759-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:01:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D1C693BAE
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:01:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=OVA6a1W+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265759-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-265759-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2E6D30166F6
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235F13CF97E;
	Tue, 16 Jun 2026 18:00:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF353CC324;
	Tue, 16 Jun 2026 18:00:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632838; cv=none; b=khgHllKTM3Q+SR/4KHERvEKEVu8LG0a21u+8wo2GhIx9fkCjismXx2sz3Wfbxw1VohEkdI7XYXxPmF+p05HYYizHrR/8uvQaXlYWq/fYDzxOWCtaG5YVO0P/eh9Xb/aoGwGfBIsNfyuans/Y5ro5Ar19w/fqtVPThF1wBDoEs7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632838; c=relaxed/simple;
	bh=ufJBd8jycZ/87ks3tTcu3RgEJAoEVgcpYw3y2xKbVhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vsu6iyKYR/qqyeRseMZFkGdCFggBXySrLoqvUhfE1+wT+SQfJkpDv/JlNulEmJ7kwgE368uDeDyJ+pJ+g7HYyt08JhCx9s6bIXPOoHsf35VqrWmwDcHd0NKgMTTZJWBPkvRltmnFtzECWmuqdEAw3RPtP8l259f+RZv9SV85Lws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OVA6a1W+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FF71F000E9;
	Tue, 16 Jun 2026 18:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781632837;
	bh=PO/ba9MgXDjiO1P3RkGasAsvJpSexYE5BdQiWq3HHys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OVA6a1W+mXeQj+qdFBVBYnVqrVR3ejnseJBOWiODufWOD3N1/2iCrnpv8QA8nESdl
	 cxbapw5+3jCcDqa3Tbf9ExxFI651Pipl2I2j+VkG2xkl8ybGqFZYBu4iOjqPoMSxKH
	 UeCrq+DE7XQe9Sk9LAB7kaojhwT4lP0FGJbXJfec=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 487/522] RDMA/umem: fix kernel-doc warnings
Date: Tue, 16 Jun 2026 20:30:34 +0530
Message-ID: <20260616145148.594771524@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265759-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:rdunlap@infradead.org,m:leon@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56D1C693BAE

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit ff46d1392750444fab5ae5a0194764ffdc4ac0d2 ]

Add or correct kernel-doc comments to eliminate warnings:

Warning: include/rdma/ib_umem.h:104 function parameter 'biter' not
 described in 'rdma_umem_for_each_dma_block'
Warning: include/rdma/ib_umem.h:140 function parameter 'pgsz_bitmap' not
 described in 'ib_umem_find_best_pgoff'
Warning: include/rdma/ib_umem.h:141 No description found for return
 value of 'ib_umem_find_best_pgoff'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://patch.msgid.link/20260224003120.3173892-1-rdunlap@infradead.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Stable-dep-of: 15fe76e23615 ("RDMA/umem: Fix truncation for block sizes >= 4G")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/rdma/ib_umem.h |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -90,6 +90,7 @@ static inline bool __rdma_umem_block_ite
 /**
  * rdma_umem_for_each_dma_block - iterate over contiguous DMA blocks of the umem
  * @umem: umem to iterate over
+ * @biter: block iterator variable
  * @pgsz: Page size to split the list into
  *
  * pgsz must be <= PAGE_SIZE or computed by ib_umem_find_best_pgsz(). The
@@ -117,7 +118,7 @@ unsigned long ib_umem_find_best_pgsz(str
  * ib_umem_find_best_pgoff - Find best HW page size
  *
  * @umem: umem struct
- * @pgsz_bitmap bitmap of HW supported page sizes
+ * @pgsz_bitmap: bitmap of HW supported page sizes
  * @pgoff_bitmask: Mask of bits that can be represented with an offset
  *
  * This is very similar to ib_umem_find_best_pgsz() except instead of accepting
@@ -130,6 +131,9 @@ unsigned long ib_umem_find_best_pgsz(str
  *
  * If the pgoff_bitmask requires either alignment in the low bit or an
  * unavailable page size for the high bits, this function returns 0.
+ *
+ * Returns: best HW page size for the parameters or 0 if none available
+ *   for the given parameters.
  */
 static inline unsigned long ib_umem_find_best_pgoff(struct ib_umem *umem,
 						    unsigned long pgsz_bitmap,



