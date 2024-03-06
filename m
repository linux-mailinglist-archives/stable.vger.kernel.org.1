Return-Path: <stable+bounces-26997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70D7873B27
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 16:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34BD9B216C3
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 15:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8316C134CFA;
	Wed,  6 Mar 2024 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="VA9scI+i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nm8+3aoW"
X-Original-To: stable@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F76130AF2
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740258; cv=none; b=dovlpk16Z+jELCRfAYwpdN3qRHmrkbrBGlcI7UAAN6S/7gIgkCxT+8kfM1SJE+9xCY6sh88DDoaYYi5xw8jepZFVMh6nwHKiFL5iGWjceQZTPsjlPcKa3NgFya5I+Cbp+VdIvXneZ2phJNvps0NPbck+8fkUu6AWxfonv7CckTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740258; c=relaxed/simple;
	bh=eOsUyM2+koEtvJMf08+nn08wFzWK2yQwTnODj4AeRC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kde8eK85T+PniYAKjQG9BuGt6E3lBKe53o7X+Wp1rpDU2zxDHTTIfzy/LN/6SeF2n2FGrVn/CH3TjOMJGqdnNqND2Ld7uSN1hogGACo5qEIVPz9jD1b+E5q3JD2usqIPpEjoBrNDSMnWoyeqOv8R+P3YuFiD2Y7E4V9nWy9DrTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=VA9scI+i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nm8+3aoW; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 542B01380105;
	Wed,  6 Mar 2024 10:50:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 06 Mar 2024 10:50:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm1; t=1709740255; x=
	1709826655; bh=qzePdldU740unyHstJjgnlk+QHTFGgi426JeFTsNY58=; b=V
	A9scI+iwkEt5vW6faJK5izhvN3X4EP1eliDsldgmRxSBzhQSC5n2V6aZ0Mn0Eiwa
	mrphAWdZ/Pn7bSJzIfqiLhnYt6CDNyTlH8gPkV4y63AVtRvV5N18VF+MyUBidv90
	cTnkUT7lceQyRmot6LeYnbTT32AT7otpX6cqgkDWqjJQe/6dUkpKCErCkNSHftzs
	1jL/XaBhRSQ/bRHZQjeMYDzNCX3ftWQ2Pb/aMEGYBuwUjmT0s+5lWcFPgV23Ccrb
	ilh1uYzEs1OOR7tnAvXSi2Gkktfbl6YMM5ppeb76xqP0PHveijRg6TrxrFqT9ZBR
	Avka29XV7LnxshnWN7z2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1709740255; x=1709826655; bh=q
	zePdldU740unyHstJjgnlk+QHTFGgi426JeFTsNY58=; b=nm8+3aoWU0UM5Y2fU
	T7NGWkEwQrFT5VPG8XT5E51H+7iZrcbOtGg4ShtH1ZzWSFOwc1lWiapNoCwlGDj0
	ii775ApiOKSTNIhSYkZnQdyA0JFF6082arEp+w58C/RrG+ree7+AjuYfaRTHUKWz
	yk6hN+JAUzQ1MfLMnXg7Gm2S7sRoapl3vEswVGSku2t+HE2AywYr6nCbLQZgwHXU
	UQ3VeWY3VvOaBqpOyBcw14cD/wEIOyX+xrPKuEL/V3nbNAvrq9eldV87McLvoh6F
	erode6JAMRP6VS7iqxM9WBCUrDE1IdQmvw6SP6izu05D9Mpq8QugzJpVmqexGAFX
	dazfQ==
X-ME-Sender: <xms:35DoZaqJdqcKuwCzabvftOR15xxLgZXhR-vNPNy1_PdfchMNVs86eA>
    <xme:35DoZYp11Wn9PxB81MLoeqbRSWHDNMSS4N7yqsWKIRQBsd2YvzernIImKcgF1lepB
    UHu0ys6hHJqs3oTcg>
X-ME-Received: <xmr:35DoZfNfFdbV9q6fhSQoPSwY4fsMaUCkmJc2b6JUiSxqYl4MQgdivFe3z77D-Vh8LGFWKi5dnlpCYzrX-7XnbE1HsQgSLPeh54Bc9PAnvwr1HcRqY7r2Tatg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkfforhggtgfgsehtkeertdertdejnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeetudevhe
    etheehieetiefhjeevjeeltdfgvdeiueeiudetffdtvedthfetvedtffenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:35DoZZ6YNc66WzDQ63JSvA29mBkeXWtRVoUtN1u3f7CLLrelQSDNkA>
    <xmx:35DoZZ6z2-VUH5pyNKzsFPBLpJnr3rKz9jxX0bwTNJ5aHG0XLkfMgQ>
    <xmx:35DoZZgKelyQojbJ5ITs93Pt1XltXhnM8MEAP_mUEAea4Kfm7URD0A>
    <xmx:35DoZWxpLkgHZVXgomMdgTlL0pzXJugKYgMCwk7MIqDr5AOhyXdjJQ>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Mar 2024 10:50:54 -0500 (EST)
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
Subject: [PATCH STABLE v4.19.y] mm/migrate: set swap entry values of THP tail pages properly.
Date: Wed,  6 Mar 2024 10:50:52 -0500
Message-ID: <20240306155052.118007-1-zi.yan@sent.com>
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
index 171573613c39..893ea04498f7 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -514,8 +514,12 @@ int migrate_page_move_mapping(struct address_space *mapping,
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


