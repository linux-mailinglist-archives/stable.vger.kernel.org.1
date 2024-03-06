Return-Path: <stable+bounces-26998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E365873B29
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 16:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54AF7282295
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 15:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8C4135415;
	Wed,  6 Mar 2024 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="D3/9g3oT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gErwOZy4"
X-Original-To: stable@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112A7134CFA
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740278; cv=none; b=IsPNFl19MFo/gvO0qzcXBjEmwr6wr/xqxCOtV/npj0Kn5p1hft02V3C6/SyzjjClNcwgeyhkdTtGpi/YbjCx8GTcxNgSkKXZwe6m69X4+xYGDER7gO3jDXJTXB8EJcZm3R5c98Wy4Shc4br0VMDC4SWP9zn8lm2InNX7dqFPVww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740278; c=relaxed/simple;
	bh=r5BQ5qbLDhJu5KHniDoxkvIjDeg+fK1q5VVTVbWNrf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BX/cP6VyPIoYTHqQqcZYyyOjeJWOuE4E3tumNBhxHT88QGlFSZS1Ariv+BzOICxgIblfxPDZmsomapRnXsjgzTgxXArknKfadMwI3jC4CabWOQUFhxwz+2428hEbDolsdRbPvbPXjuH7JjknorzrW+ONEOML3a7vkpAKfnDXxTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=D3/9g3oT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gErwOZy4; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 17A9C114013D;
	Wed,  6 Mar 2024 10:51:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 06 Mar 2024 10:51:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm1; t=1709740275; x=
	1709826675; bh=3hLb531CJDlQKpGCSmq0lUwZE8UEmO8lXvTFABPknBA=; b=D
	3/9g3oTudqQUm9Z/eAdhH1JmskU9nj4fs3/Ka1KoYhTo56/wweaAl33Q6Ovkrx2o
	nOvj63G4RBqGnegHRdlCIxDrM1MBPApp+Hi/RV9TS9H1DnXkkqbkCuXwO4LIdvsx
	Irhsh0IHoZ4sU2jQ48qHF4ljre5FZ6Mdtweb+qclVojQe5kzDXiGNCJVRveyw6FJ
	qS7CecFYuAZCp1Mu5QDTbB8t4sdCp8J5ZvjwB1lHseecFqwl9zJDIfXzxXEnOfbr
	WSSf8SjRFRgu8SWOZ/CuDORXsO450opXPH5wGWPa7+E65C1VQULDciEspEw/cPrV
	N9XJ3cViJhoOT+urcfSfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1709740275; x=1709826675; bh=3
	hLb531CJDlQKpGCSmq0lUwZE8UEmO8lXvTFABPknBA=; b=gErwOZy4rk2w+xwnG
	RIW3kwOj3U1QfzirSiocqhBdCJ3OLSVmEfTC47iIYXstuhV24dQW67pO0ODvpiYl
	Lz8TKD4l29yXqgq7XsXOxJAoFYNNnq8WR6GeLvZ6mo87Omp1w2UuBxer8tJ5/sZn
	IbYygh6vHedx1GsJ1G4seD8E2FmLrgGlYpApU5Nrst1sUnkB3uFoXdQ/SszJK82l
	E7SwxeJZhT3tWfpWJNRZkLwqyoSz/3Tvuk6TVKxPDoaGvRBl84Hyw3TJqbVgvmi2
	fGYk0BLapr7O5+hFkUneqAeySjFm2r3X9mq69qSNtZ8AEhTGBGIN5L3hQYnoxML6
	MhLuQ==
X-ME-Sender: <xms:8pDoZXtGj36mNf341fFlQ19zKPCPtQp3FsHm1ae6-h2bGUkIyiQPAg>
    <xme:8pDoZYegrYeVdF_ibK7BUfLkMTpZNgJdRYVq9PuAu646dgoaQ4FOiyHrRyDWO-A7n
    KxWGrSczDuRtRPl5Q>
X-ME-Received: <xmr:8pDoZaz7-sjEBL1TKr5Po9jCv92mG0QFk1CUDapRJzZ2c3IgHmDDraignMpPdVdOMxBf_DJSY9bNzTEMKK_jGn21fwNL_gzaN_ZltVRCsJvw5j9y5ujN6QIE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkfforhggtgfgsehtkeertdertdejnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeetudevhe
    etheehieetiefhjeevjeeltdfgvdeiueeiudetffdtvedthfetvedtffenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:8pDoZWMcbYA6Wqb02zpVAZji7yaDABZ6dhAI4C2Df7LGFJpP0Qn_ow>
    <xmx:8pDoZX_MffflUsU1MWo-zPLHp2MVfHUUxwFT3oHCzKxKs_Ej65ry1A>
    <xmx:8pDoZWXIRI4xjVAkTSe-QRC8918KYk_kno7W09-Q4GIrm4pBbcXhUA>
    <xmx:85DoZY18fKxcD4twN_gfLT-KFm1co38mUus1_wD_nVTesMht6JNo8g>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Mar 2024 10:51:14 -0500 (EST)
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
Subject: [PATCH STABLE v5.4.y] mm/migrate: set swap entry values of THP tail pages properly.
Date: Wed,  6 Mar 2024 10:51:13 -0500
Message-ID: <20240306155113.118119-1-zi.yan@sent.com>
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
index 034b0662fd3b..9cfd53eaeb4e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -441,8 +441,12 @@ int migrate_page_move_mapping(struct address_space *mapping,
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


