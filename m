Return-Path: <stable+bounces-26805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C94F8723E3
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 17:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD641C2390C
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 16:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FEC128370;
	Tue,  5 Mar 2024 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="Xu6QgjH+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SsXzf1m9"
X-Original-To: stable@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D732C12880F
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655199; cv=none; b=K6Mcos2P8j8oYHtbrRW5RwBXir2dk+QivyaMdwm3xJgiBsiHeQQj3Ww4rvYQbDfcKXy1qsfYXBdEBGZXsKWyvZIPsxx/inVEH0aocDyLZ1f9IKtYRXS7b/XIYqEAqSuxCevySe6o/q9BFPQokKLa0De0CA4VDqKMbGmpHJfq3rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655199; c=relaxed/simple;
	bh=FNB3BvD/VEGKc9uFnPqIMIKJSMwMcy1ci3VE1iViYF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SXhaXsHGfQt05IGuKunmy/PUILww8bwQdLZzoEk7KGifYxshHIWpzk0Aag7o260dPw37TxBRAVglaeCrgKswwI2Vb/Y+CMbZmHkxM/Iv5gucD+1nRx/BZpVgzilnZN/32zhghxZMdV+IihT1AoP7Ii+9eC+3t7TwbqOB55Sy62c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=Xu6QgjH+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SsXzf1m9; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id C17AE1380090;
	Tue,  5 Mar 2024 11:13:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 05 Mar 2024 11:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm1; t=1709655196; x=
	1709741596; bh=MQAE8rdyXk8pt4o4BGwUXXML/VVJgez4A8nNBD4O3ko=; b=X
	u6QgjH+5jDGIMtcjeBRFliBnb6LrSlR0ueQg79UXqwcL36H8IEGor8B+WeLGlToe
	uWCu5wQJRkp8Up/7yvivt4HxGedY6fFPI77nWGwEGyB4DzCWl8JmlWcBtOHhXn92
	ulX8/bCf2D+T/vQvTQrfFjPusWdOI8s+R8/Ntk8LRJpomEwRsLL+VTw/G4rVy+PC
	gG/oUNph2lv5lxx0qVOekGwB+ba37p09lVcnUtatUmf2iB5AeTOpgiquIVyW0SQU
	dxz5Z/29NxFuWIyUbjpMh+eS/jZftb5MpZtovwR3c0m8zW4XstHK27+d76/qEgtn
	MVedtOizH+XkUrzwMbTHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1709655196; x=1709741596; bh=M
	QAE8rdyXk8pt4o4BGwUXXML/VVJgez4A8nNBD4O3ko=; b=SsXzf1m9in2NrK/ar
	sVIOBIj+uvIzmq3uRSdbepmc8IIM7+Ahf/XoSSbfb51DYXkoZ1Buv9INR6AYMFtK
	yixwOZ/T/Rmrgpqd1WajfAChKRP/CRouYbyE3TWIg1xbAlAPaa9sALWd0VHzlYVp
	msJYt+ZzWGBzgEbwYb+EXUAXLj00M8wIJKGBooeSJTWR5Avd3+T9U+tN3vq1Qo3m
	2coZ/0MjB6I9Oo4aBt8e02Vy/J5zQMrQq8gT1J9DQ6VzSFnzcHRgBV+dYmFwdes1
	CeehtksYDHkrpuEJOvm6g4AI+kvAJ/c67U65JacLPuooSS6pA86OFcnYI3OQpPIr
	fatjQ==
X-ME-Sender: <xms:nETnZTfI4rE84wFHeSf1TdHCpsG2x17ipJrMB5oQwN9c0EJOIi1YAw>
    <xme:nETnZZPFGgrjJGJjoAeXZbzBYWipXHhvSTGZB0OuYQ3FfXiNupiJaFUYKD02e-BI4
    l3NmrxoKnjJttSvuA>
X-ME-Received: <xmr:nETnZciJzO-pFrYUmRqG-yIP1ExCoBSU3GHcsYhinkD0Drmz7sGGF8CrIzVKxqLliCd81zlDmx6HykDXGMo9LQ9KustDUgjEHtYMAmg2BiR8TnhsLXRwBaDG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkfforhggtgfgsehtkeertdertdejnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeuveethe
    evudduffevteefheeukeehuedtueehieehieelveegveeuffeileffhfenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
    htrdgtohhm
X-ME-Proxy: <xmx:nETnZU_GI5cMQUH4oAVuqwqJr1Ck_uH_e56gfGZ6m0Ph8mTiRhvaPw>
    <xmx:nETnZfstfg3MNllGoB2SgWrUK0O_S-VwVGeB-m1koitGgpl4xpR79w>
    <xmx:nETnZTGyU6rhcCJpEci9QRbmOvrzhf_hkO23WxU0LwPRMAvDSNOs8Q>
    <xmx:nETnZQk1iO9hPhDqT70SCxVnzHCW7R6pYwAZU1ESOxhnzQlcWH9Khg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Mar 2024 11:13:16 -0500 (EST)
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
Date: Tue,  5 Mar 2024 11:13:13 -0500
Message-ID: <20240305161313.90954-1-zi.yan@sent.com>
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

Signed-off-by: Zi Yan <ziy@nvidia.com>
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


