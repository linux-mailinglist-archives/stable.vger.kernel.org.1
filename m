Return-Path: <stable+bounces-27000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B7B873B31
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 16:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3352811C3
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 15:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E30135A48;
	Wed,  6 Mar 2024 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="kdEmKqCY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qndP8us+"
X-Original-To: stable@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA32C134CFA
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740321; cv=none; b=i5na94/9M0Pd9gG4vA13sNjVOBoSCZ+0zcnDuiXr78zpu/y6CkO7mydvUDo4RCorpUb4xIHOhng+WtO1VWvdnP3S/CwWbMiUgYNQgSFOWwerx7DxBgpty6WETKbS/A3wSNe+ymdoUfgiTVms0NTO6RD+WJd62y2oBgCxysOQf9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740321; c=relaxed/simple;
	bh=xi09wlQ87kp6lRlv3wu52A+S9SUdXf8AXs+Eah0uBeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=olIJ1JJc9Y27G/yImqsaO0qyx34wcdJVOZcwKV93xTKy/8q7LflK/ckIX57+ZRX1otBqG4D6Rs8oQfh6KQrZbKi6Dmj4AFe3lj7969uuLm+7wpH5Acn6TI+iYI8kWWzTxvgFgDklyo6ldTemOrHCKHunwthBnaAljeH+j3E55GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=kdEmKqCY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qndP8us+; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A59BE114010C;
	Wed,  6 Mar 2024 10:51:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 06 Mar 2024 10:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm1; t=1709740318; x=
	1709826718; bh=ff578PMopIxtDhAZSekNz6TpN9rdsoY/51EawT6DkeU=; b=k
	dEmKqCYgAa244AhkT2l8FdhpDT5ao0XBEoGOpjuObR6HS1EZgGJRWB2lDlMiQMw0
	KkxrS1olfoP1c3FWfjL5/XQ0rvI93pWZsVkbywZt0HCiQFrCm2JVC69Mjv+XPuRQ
	Fdn/1z4maHwkI0kfkSzcPLj9vyNe3y6OiX/D9NOiJ093APu4n5NoTfDsfMlelDcM
	3/wu+Kg/RfXGqSFzDDNAO9AijOAVErnhRFMJrphYQfunpipsPeaUN5RMbdtHDXHQ
	szZXjP7r8lkZcT0iLe2Ce+r52PrnMVS6Pd3qePDcrHCP13AoPDqW/ws54/WQloRy
	zWpBjh8vwJiTvqBvE+7jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1709740318; x=1709826718; bh=f
	f578PMopIxtDhAZSekNz6TpN9rdsoY/51EawT6DkeU=; b=qndP8us+gKjIAuHre
	CKIjxP89J/zPdtmk2Zfu8aNBxgrVeQrilAZPEfQpVb9s4EBbvCUnzXYiq8BgFh6x
	FM1FGJKpCLwlb76pFCyN8zHrgdAZBpP6T0zqOritsMqfwOhLuJ+lNULwBpuSvXti
	zaMb4l8PVByoXBmbI6how9grgj2WVfCyiNH1W6lHvkPfLuzu5EbHevIQglaCMwP/
	gzw4IPOzUFt48xbHI3D8+DGnBkO+lNfgZG+0N7qnCGztPmDtzYLTfYN3WDaHEsp8
	le0iA2/wdwvVRV/CK2kwiktM4Ld/C8to45tTRmffVV6ptPOXY5h2VEgjTNJS4VOU
	xbWoA==
X-ME-Sender: <xms:HpHoZWuyXydxSeN0Ay4cYqCf6x-TpD8JOkUG_DKM93GDVcWUWWlE1A>
    <xme:HpHoZbc1pUr_GkKxNz1LLAs83kKourd3Ony5Qjuxq2wi242QVlX3ik81XoFiISXnb
    76Ug6d372zZi-fC9A>
X-ME-Received: <xmr:HpHoZRyhrmRMApBf2Q2FX-XApUd06NYTSBcHDVU0_G4qBn1gXk7VILyt_KUxjufwP2IV7-EvGYXlUZncZxwfHRnPIJ_UuiFBS7lI29grwonwaaILxhCWDcDb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkfforhggtgfgsehtkeertdertdejnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeetudevhe
    etheehieetiefhjeevjeeltdfgvdeiueeiudetffdtvedthfetvedtffenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:HpHoZRMtzdWHzjdue8J9dOvnlyxvEYfD25fL-RD6tkEqOWsZDlXeKg>
    <xmx:HpHoZW8Ho6J9fUZIjFa-4oXk5yEF8fqZAgwePPmgzYM-y4Ty-Q1Jfw>
    <xmx:HpHoZZWAUlWPg7AlYDR8EwSgDS32FVwvY4drjPWTiWYzd2Q48zBUMQ>
    <xmx:HpHoZX1TJiA0ipJdNqUqimJTxmQHOacjoUu5BJBQU8QFS-tJuzS8aA>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Mar 2024 10:51:58 -0500 (EST)
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
Subject: [PATCH STABLE v5.15.y] mm/migrate: set swap entry values of THP tail pages properly.
Date: Wed,  6 Mar 2024 10:51:57 -0500
Message-ID: <20240306155157.118343-1-zi.yan@sent.com>
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
index c7d5566623ad..c37af50f312d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -424,8 +424,12 @@ int migrate_page_move_mapping(struct address_space *mapping,
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


