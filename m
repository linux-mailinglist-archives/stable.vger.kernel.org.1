Return-Path: <stable+bounces-255436-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIVzGGqiGGqblggAu9opvQ
	(envelope-from <stable+bounces-255436-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:15:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E43ED5F82F7
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FF8A3095468
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9BE33CE8A;
	Thu, 28 May 2026 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZkEUJwF8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D936F33A702;
	Thu, 28 May 2026 20:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998904; cv=none; b=l+djgQaUc1DARyGfMrLyHjXBCw8ZS6J4jCJy2SfsQOrWSe3hZMdrVVltZSAYE/RIDA19zrzmKbnkokbDvy9bJaqCYkf6kiWsDQY7NaWaJM9YsnnpaD/NK3Z8kovZ5Pjv/khUsycnccN+3Xa40y0aAXjoLwx278l7QeP0VrwvfBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998904; c=relaxed/simple;
	bh=kiee/kpQJLj2tBj6CowO59rPPUx5iohbBSaz93xQ278=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sisRdYDoiadPvD1ex1iMFnd6Ys1q4zjbpCK0Fod9Ez6i6cZ5jQieIFAkO8DlkAF6SC0Y4TCt0UljGvt1JxW9FQ3ciCxREH2P0FSIBA8lXlp1lEEaXQ019hN7DCS7MtrEGfYagcn5+o5L8NQkxpWVFLz2V27MIE298fhB9xNozu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZkEUJwF8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B111F000E9;
	Thu, 28 May 2026 20:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998903;
	bh=2uDJe3KWARjmyxW/kxqOcwNr9tXss14v2u3j9WwhB+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZkEUJwF8vR9GJLlKI8rlPMykyMIXz0DBnRS1Tpo13lvF2Sb7eNj+jDgbflu3TQOlF
	 R9cWdO/7MwGIJTCbdagtEf6/Xmsqv4veUwwAXR7lj7Xwc2q9/rqvs9b1hXq8N/xNHg
	 wvT03rKusNCYOmBs+UYwgWKxvepHm39aSE7pDFa0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Josua Mayer <josua@solid-run.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 339/461] iommupt: Check for missing PAGE_SIZE in the pgsize_bitmap
Date: Thu, 28 May 2026 21:47:48 +0200
Message-ID: <20260528194657.173972484@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255436-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,amd.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,solid-run.com:email]
X-Rspamd-Queue-Id: E43ED5F82F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit 8ef3f77c440005c7f04229a75976bfc078364247 ]

Sashiko pointed out that the driver could drop PAGE_SIZE from the
pgsize_bitmap. That is technically allowed but nothing does it, and
such an iommu_domain would not be used with the DMA API today.

Still, it is against the design and it is trivial to fix up. Lift
the PT_WARN_ON to the if branch and just skip the fast path.

Fixes: dcd6a011a8d5 ("iommupt: Add map_pages op")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Tested-by: Josua Mayer <josua@solid-run.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/generic_pt/iommu_pt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index c0241b24a6098..4be33c45bedc9 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -909,8 +909,8 @@ static int NS(map_range)(struct pt_iommu *iommu_table, dma_addr_t iova,
 		return ret;
 
 	/* Calculate target page size and level for the leaves */
-	if (pt_has_system_page_size(common) && len == PAGE_SIZE) {
-		PT_WARN_ON(!(pgsize_bitmap & PAGE_SIZE));
+	if (pt_has_system_page_size(common) && len == PAGE_SIZE &&
+		likely(pgsize_bitmap & PAGE_SIZE)) {
 		if (log2_mod(iova | paddr, PAGE_SHIFT))
 			return -ENXIO;
 		map.leaf_pgsize_lg2 = PAGE_SHIFT;
-- 
2.53.0




