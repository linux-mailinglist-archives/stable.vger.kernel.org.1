Return-Path: <stable+bounces-245934-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CL3kGYFoA2qa5gEAu9opvQ
	(envelope-from <stable+bounces-245934-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:50:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AB452635B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E60C230E8FC1
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E1D3D9693;
	Tue, 12 May 2026 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wG0NeEsv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7553A355803;
	Tue, 12 May 2026 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607931; cv=none; b=TViFdzuC410zF3m2mB8QZ8NT7EkpMiw3xgBXTjTTBK8xS82YT0LN9jqwLHeOlatBT5i9+DGLwxauTiJ8IJHLrZMBQw1D5wknMiGIsIDknlxsWsB29BBCqFA6wxyOvzjvGqoo/mAKmd4xSuVdn+iH0cHcIeDrhYNriE7ZqJENwZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607931; c=relaxed/simple;
	bh=g1LNv4wfFYvX3/mM+wCSO1P9J5BncVpNmgxEgkkaMcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGl9KTc/6FcJepRDyXV61jLrReXlT138lqGm7QsAMy8SZooLj6U4KRzBNDU7H+klhUhTv1LCxYk9kWwNPA6r3juvM+ct00Xm6rpRBvx/oJEuwzZc0smnDCU0XAUB4Sb38giP7cHkAOw2ymDrQgTbD5yKow7Ux8tZPF74I15bjoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wG0NeEsv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDDBC2BCB0;
	Tue, 12 May 2026 17:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778607931;
	bh=g1LNv4wfFYvX3/mM+wCSO1P9J5BncVpNmgxEgkkaMcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wG0NeEsvvddOJy1W6FfNOIYGcA063q7UWQgqS1FPjHl42Xave01hsoHptI9uSfMau
	 z2dajKi8pQFo8MvMnaL+ad/BhHpZzVkLGjndlWgb8bvjdvT/zeD7+3xp3BMJiZv3eh
	 OcY8Bj+bX+69vXZhQYYwT3ovsXSXSlSk20So+V14=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Naman Jain <namjain@linux.microsoft.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.12 090/206] block: add pgmap check to biovec_phys_mergeable
Date: Tue, 12 May 2026 19:39:02 +0200
Message-ID: <20260512173934.763181085@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
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
X-Rspamd-Queue-Id: B8AB452635B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245934-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,lst.de:email,kernel.dk:email]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Naman Jain <namjain@linux.microsoft.com>

commit 13920e4b7b784b40cf4519ff1f0f3e513476a499 upstream.

biovec_phys_mergeable() is used by the request merge, DMA mapping,
and integrity merge paths to decide if two physically contiguous
bvec segments can be coalesced into one. It currently has no check
for whether the segments belong to different dev_pagemaps.

When zone device memory is registered in multiple chunks, each chunk
gets its own dev_pagemap. A single bio can legitimately contain
bvecs from different pgmaps -- iov_iter_extract_bvecs() breaks at
pgmap boundaries but the outer loop in bio_iov_iter_get_pages()
continues filling the same bio. If such bvecs are physically
contiguous, biovec_phys_mergeable() will coalesce them, making it
impossible to recover the correct pgmap for the merged segment
via page_pgmap().

Add a zone_device_pages_have_same_pgmap() check to prevent merging
bvec segments that span different pgmaps.

Fixes: 49580e690755 ("block: add check when merging zone device pages")
Cc: stable@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
Link: https://patch.msgid.link/20260410153414.4159050-2-namjain@linux.microsoft.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/block/blk.h
+++ b/block/blk.h
@@ -117,6 +117,8 @@ static inline bool biovec_phys_mergeable
 
 	if (addr1 + vec1->bv_len != addr2)
 		return false;
+	if (!zone_device_pages_have_same_pgmap(vec1->bv_page, vec2->bv_page))
+		return false;
 	if (xen_domain() && !xen_biovec_phys_mergeable(vec1, vec2->bv_page))
 		return false;
 	if ((addr1 | mask) != ((addr2 + vec2->bv_len - 1) | mask))



