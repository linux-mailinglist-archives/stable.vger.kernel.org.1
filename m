Return-Path: <stable+bounces-27001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DF9873B34
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 16:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5381C21D1B
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 15:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CEE1350C7;
	Wed,  6 Mar 2024 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="aiXBMJEx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="atQTcM8Z"
X-Original-To: stable@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4795A134CFA
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740342; cv=none; b=TyNxmfuzqDf05t5aRU3NnnHYURPimmwiQpDRHrdATEW2fz0Ab6lDuS4X5gUswxRuqSRxYGOxlYNI6b/0ACLshnV9lXn+51bySUAgpab2OlgQ9iK7MD6Av8AZkxs5H/SliCset8XcIdJwihndYvnsYZ6/4DDHE1eZweyWKZ/QPcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740342; c=relaxed/simple;
	bh=LyiZPE/C7SFldX1gwc3Ii0kWNVlR+Jfyam8294zkvM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gBvyEOargRqzmeXwNm+dMBeTBpWTwA5dOHnWzoIPebMsvZXcsLSvqk+1BxwCzDYWTzQDPj8A3Ob6oFjdMaQrJ9g2kdbsFgxmCtNxf6THAjBW5odpt+5d1jhaavodY7KAihGxM/nBno6SvjHB8WFEsnbJ/wI2I+ZH2hhACkxRpNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=aiXBMJEx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=atQTcM8Z; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4E38513800C3;
	Wed,  6 Mar 2024 10:52:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 06 Mar 2024 10:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm1; t=1709740339; x=
	1709826739; bh=KZx88+PWHckkBWj3fAbJBJI9cPRjH7bxyyotuefqMm0=; b=a
	iXBMJEx8qzKXQiqR/r57ENae3EfNmoCp+nRkMeLDbptbeiBjZ8BD9c64+AqYvfj2
	73wY4kahLM8p33OznCaQClKlsgL+9bWmLSRJrMmqrhbfC4FxnzUQ2lNsYc9U0xkY
	Ze8uGhOx6WBMc8VtGNg6Udl+QypHSZNAEXdqdupTmPtsGgpTGhguQEAtW7Kp5kBa
	Tz2rntyuncF7gYL4l3Y2eyO/Jxmq5uZxGrSpDU4B4DQmIqYumIQLFNVrdmd8aSvK
	wayvYjFzVmbqaqrZHBdDhcimVAYbbhaA8sXCR+R/wC1KN1O6aTNqFKDHinvP4CZg
	2YSZf+t0RtjWEXHyUOHlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1709740339; x=1709826739; bh=K
	Zx88+PWHckkBWj3fAbJBJI9cPRjH7bxyyotuefqMm0=; b=atQTcM8ZwA5b6u48m
	EyOfZ/t2B4cv8+boNIFz65taj51scm7/HmkzavMB8eJjUb3Xnd9NZc4yN+ZJ7Xo7
	0wCVKTBRtYM1KPQ+z5zbREc1PVTAgp4gAyYcD8IBOzV1eog9l8vC6/DolwahCfO5
	I20xcHr48xD8ymK0VAUh6c+77W0vikeEpillKM0krx3NRRTmfJ55QnBFqdR+xFfK
	bUS0S/+0M3KjYASWkw4NkuuxKf+m2aZSbvLf1lJNYYsPGlF1Co8tw56ie0h+5rHq
	rH29dlVOT67Zptfq+kdghYis/Jd8fIqP89Q06iSZK7YJguvZOwjVSkrr/X2509BR
	kPV3A==
X-ME-Sender: <xms:M5HoZZL-oxY9IQ0hWm1XWavVCN4imIj_1bnqNTEwCSNDUobU-sYoJg>
    <xme:M5HoZVKsGI2Zzjcay9XX2WFiytV2u7mRiVDNJOeCFbW1I-dCbVvtJymjLN9H_H3Ze
    4d3116Zrwi45f9EoA>
X-ME-Received: <xmr:M5HoZRtjSy1ZbMz1_s-EjVvW7gOwKIMp333u5LOp_juXlguYCiG0Snwxc31_cXZeHM96_RoknE2OZcpb0xyxgysOyqawuWHejebT2zMqI7rZc8G_EutDrsMu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkfforhggtgfgsehtkeertdertdejnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeetudevhe
    etheehieetiefhjeevjeeltdfgvdeiueeiudetffdtvedthfetvedtffenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:M5HoZabg6g9XN8uBU6gksKOWaOYkuPvhWwqveA-CC6o5z-uew5z10A>
    <xmx:M5HoZQaPIhaltBGSpHmGVkU-ycscqtGUHuqOum5-0Wy1BzG3MkWw6Q>
    <xmx:M5HoZeDlpAeu65ZvyTXqxzhVHQOpF0gGwz4j9EwMI2EXaIwcPhqZWQ>
    <xmx:M5HoZdTuAoPN0f6NyBsp2xsUavTqLgEhlXHx47d8dvE9K70mRt8gxQ>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Mar 2024 10:52:18 -0500 (EST)
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
Subject: [PATCH STABLE v6.1.y] mm/migrate: set swap entry values of THP tail pages properly.
Date: Wed,  6 Mar 2024 10:52:17 -0500
Message-ID: <20240306155217.118467-1-zi.yan@sent.com>
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
index c93dd6a31c31..c5968021fde0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -423,8 +423,12 @@ int folio_migrate_mapping(struct address_space *mapping,
 	if (folio_test_swapbacked(folio)) {
 		__folio_set_swapbacked(newfolio);
 		if (folio_test_swapcache(folio)) {
+			int i;
+
 			folio_set_swapcache(newfolio);
-			newfolio->private = folio_get_private(folio);
+			for (i = 0; i < nr; i++)
+				set_page_private(folio_page(newfolio, i),
+					page_private(folio_page(folio, i)));
 		}
 		entries = nr;
 	} else {
-- 
2.43.0


