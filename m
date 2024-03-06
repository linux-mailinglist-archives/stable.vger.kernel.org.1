Return-Path: <stable+bounces-26999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479AA873B2B
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 16:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7BD1C20E91
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 15:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0421353F2;
	Wed,  6 Mar 2024 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="GabD9tTY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jAb8WsMO"
X-Original-To: stable@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2515F875
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740299; cv=none; b=j1lE0Me49fuIw09BJ2/taFTAppnkyYyN2f93C1GCrX5RLs/vOcAsCFGjO+hvtItGpABrS1h0RHx7cYxS4vHnJN42Boq4aF+x+rmmOk/NzPrl/xpP6/m9EzUcXpkbgnAlBUSskQZMYld4qyMSWDDKlU508qGK1GnT0HUl3MxeteI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740299; c=relaxed/simple;
	bh=pn7EsbDyEtlwb0UE+gv87z427oHATrf2j3RVynPa9eg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E4xo5R52vq0NaCWtE4iIX14r9ICVHHlbvGKLrGS/6vDeKJPCv/vxzgW867w70Hoe05YfCBZ74Ge4ld7dskV+U7CoT0+f5En1slwlbKOUZWuMJWilEBaJvEA5gEoWnkHxe6LeyWQCPsELcll25+6kEhBfkFEtgN5RtBIYbwSNCeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=GabD9tTY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jAb8WsMO; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3A0A011400AF;
	Wed,  6 Mar 2024 10:51:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 06 Mar 2024 10:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm1; t=1709740297; x=
	1709826697; bh=6jc/qtxmjILWwrSyyKA19XZjJk/2gKrfVYgE5UGeLVE=; b=G
	abD9tTYJ/urg0kJhmKFO5GLC8pc+9yJTf58aNhBMcmVW8Z6aBGXu0w5mOj494XR/
	xpX3DB1hpOYJqH3bLUwOIDIQcCUC4a+de0upwvoQzYqMgD5jb8k1UJyvu0fqog83
	gpzgaoDj1yG6fyBbJV4wYzZ7o1klLJIC6lXoyi2+PBh5BU2MsI+6GE8Pn4cQU24w
	9UAvOx8YJJHJdR6qomOOAErf2jVnPKabpKV/QzTpnT+LK2ykGr225//f1dVC9Hfj
	39mYE5AfxJdZUhyFSPVJ6RUB0EWK6ld4U0LxVTi+CYjYrVKsvX8aiYWBrZNo/hC5
	M/1oP2lUDxS1b9lLkRYMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1709740297; x=1709826697; bh=6
	jc/qtxmjILWwrSyyKA19XZjJk/2gKrfVYgE5UGeLVE=; b=jAb8WsMOOQyKTrXTr
	AnhzB5xMfS4udVhVmFJgWmDNSB1ueaBVRg/P+BdY9Kf5Ln6u9n1/uKfzpOXjNkbe
	HpXps2w2WrBHyELnSGRawX9g4TdBzTtaK9VYcIOMN6rzvZ3uGYfqmJfGYyCFKmjJ
	9qdctDxeJmDyuxaUi4vytFlDrnyDlwQejVIUAZtZx5pLcd6+7lKrM9HJ/mjkNB3J
	88yH37AuDE0PMG62oCnNm5T7/1vr3QsAWvjTnCQYDQ45bVR7ELs7HyNTJqty7MMB
	4LG5R275FYySdbGpw/dFVJwISdM0V5QU9cSDjtKgZTzFKKrpiiR3qYfghU53/gxo
	DfagQ==
X-ME-Sender: <xms:CJHoZUAQYqSQQFN2x9WFwBDD8JtF6DzUlN5LVHSTFYMnLhQHHAhF5Q>
    <xme:CJHoZWiHUNvFj_B8ppKRZmQ_AIoIDWj2WLV9symVwMOhzcxAFQf08plu1u1oAWFNA
    5Rr3f8yDQ_Ux2dFZA>
X-ME-Received: <xmr:CJHoZXlvMbYWK8hlHYK9L6EDMgGcn2qGRjTxZ0tm0khOZhbUu650wTDxfmhjGkHHKDnha1taOPa9Thfx0fTeu57Tk8JXu1Hyvaw_fESI_EsBUPcjtC3lCUDP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkfforhggtgfgsehtkeertdertdejnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeetudevhe
    etheehieetiefhjeevjeeltdfgvdeiueeiudetffdtvedthfetvedtffenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:CZHoZayYovMNxFz7Gh42NdroGG4Ltv9rz0cF1NDHWVeWJEt6I-6gHQ>
    <xmx:CZHoZZRNOfTfUzr76xjmpf6lfEu5kNeMo8W8XPzJlVY41TNgasqAYw>
    <xmx:CZHoZVacb9XtdGAbud15qGchKL24xOLCUXvdC0c5R_ngirPRrjpA4A>
    <xmx:CZHoZeJsnqzxTlhn2fRy5Wo87ClYXG_ZyFCpEiTeDZoy3SRWgQTm5A>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Mar 2024 10:51:36 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Huang Ying <ying.huang@intel.com>,
	Naoya Horiguchi <naoya.horiguchi@linux.dev>
Subject: [PATCH STABLE v5.10.y] mm/migrate: set swap entry values of THP tail pages properly.
Date: Wed,  6 Mar 2024 10:51:35 -0500
Message-ID: <20240306155135.118231-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
Reply-To: Zi Yan <ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Zi Yan <ziy@nvidia.com>

The tail pages in a THP can have swap entry information stored in their
private field. When migrating to a new page, all tail pages of the new
page need to update ->private to avoid future data corruption.

This fix is stable-only, since after commit 07e09c483cbe ("mm/huge_memory:
work on folio->swap instead of page->private when splitting folio"),
subpages of a swapcached THP no longer requires the maintenance.

Adding THPs to the swapcache was introduced in commit
38d8b4e6bdc87 ("mm, THP, swap: delay splitting THP during swap out"),
where each subpage of a THP added to the swapcache had its own swapcache
entry and required the ->private field to point to the correct swapcache
entry. Later, when THP migration functionality was implemented in commit
616b8371539a6 ("mm: thp: enable thp migration in generic path"),
it initially did not handle the subpages of swapcached THPs, failing to
update their ->private fields or replace the subpage pointers in the
swapcache. Subsequently, commit e71769ae5260 ("mm: enable thp migration
for shmem thp") addressed the swapcache update aspect. This patch fixes
the update of subpage ->private fields.

Closes: https://lore.kernel.org/linux-mm/1707814102-22682-1-git-send-email-quic_charante@quicinc.com/
Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index fcb7eb6a6eca..c0a8f3c9e256 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -447,8 +447,12 @@ int migrate_page_move_mapping(struct address_space *mapping,
 	if (PageSwapBacked(page)) {
 		__SetPageSwapBacked(newpage);
 		if (PageSwapCache(page)) {
+			int i;
+
 			SetPageSwapCache(newpage);
-			set_page_private(newpage, page_private(page));
+			for (i = 0; i < (1 << compound_order(page)); i++)
+				set_page_private(newpage + i,
+						 page_private(page + i));
 		}
 	} else {
 		VM_BUG_ON_PAGE(PageSwapCache(page), page);
-- 
2.43.0


