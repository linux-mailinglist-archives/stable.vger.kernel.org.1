Return-Path: <stable+bounces-26807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC32A8723F3
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 17:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C21288985
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 16:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21640128377;
	Tue,  5 Mar 2024 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="IEjOGKw+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AIE7XwLq"
X-Original-To: stable@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3502E127B7D
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655586; cv=none; b=vFPk6xlXmoOIYZRZI4HSeRN1SNaJbUv3ZYdGgYo1c4pVw784jK83ZdJxfNlbEkeMQLvY+S2/w1fCBLA0bBydlQOqLq+ZDRREVCHP0dikU1PfPr3tlAP1ul934HN7nzVkHMisWPnU4h/sevJ2b6QZnMXG1p15fgcKBxZw1CG6FKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655586; c=relaxed/simple;
	bh=prULtiE200EjwnB3KdR3ZLVJ9t8YPIoKZ3IUEEV7fRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q3SjWat7qof14Cub08FxKPOr4wBpPxVLf02c1tNNVKMrYGAWIEDo/vD3sF7/Tt1ydF89VLcY00tYxhI2mB3w3BBAUaOMCplX1nY90O/ePzQ4kR/1iqy0TtANjG12b7Ll/+uppggbTu57eJjzgNwMsp1QpOLHgdWLW1lngyE+/bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=IEjOGKw+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AIE7XwLq; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2622713800B1;
	Tue,  5 Mar 2024 11:19:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 05 Mar 2024 11:19:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm1; t=1709655584; x=
	1709741984; bh=cebIwQz4NE6KUjZeHKpCkqPfLkmI0BXvci7kY9MsUcE=; b=I
	EjOGKw+d1D5ItrmlyPGojuFO9uDQlLbVEi7LuqSXVk0HPAD88/dwDHLjL3MmhO/Q
	AoyurWi+C+wgEt8315i3L3a5eINHI1oYCyv38FbJtnwwxS1HNznpbFy99KmIv72U
	7RP9mShGBf7pEDdZTruFhVfOOk/tS5NtKdo9Vqr8b4jk26xLOUq7Ph1L5+CbXQcs
	J+14tl802knRJKPOvIVvaD9SuTNRCWc7eOSj1O8jPhgNga66OGxmaGBzgxpj42kG
	Dx0VsEQJ6EyBahrr/6O2/uZWqzYdM7ARty3CTqT3lpHF8Dec+jgfW3g7GutvUjNp
	OOnD8yXOqWG42wsnfLNSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1709655584; x=1709741984; bh=c
	ebIwQz4NE6KUjZeHKpCkqPfLkmI0BXvci7kY9MsUcE=; b=AIE7XwLqaGXhbulex
	VKKMwfx9YLj5KULgFZdcRGhADOxNcg6mJyCWmygmHXmaFi1P3Wk04jHNQ6YPHkr5
	mLe62m1h0EpSR1ql0c+JabwcFp504X1cb+xeb9tdRia1eh4WDlULsL1lGDId7utd
	k8XcMR6utJNbj5gpJkLaWWKIw6AoGaifpe+EFumMZJ4GLzlCnZ9GcJflNshz3krA
	o0xavWB0+vqB8HdKQjmmosrRvPuu+Qc4XsrXfo3ym+1fPbVRg7NuLjicjCUiehy2
	om/evbkXMzSJv+7HqqkWZs8jbgKeCowi+WS4auJ3WGOzcucAHiznicv38kxf2/kv
	aaeGA==
X-ME-Sender: <xms:H0bnZcxkJFAOCK4jGbRPt58fsPWme3IJBQj20jBh0YhpAxNuUhhJXg>
    <xme:H0bnZQRPFO6CG3gK0qXrzutl13hpU5NVBKx310k_6f6tywG3vHVBkIo9wn_6oOkUA
    Ui7kdSEB2RgdPVtBA>
X-ME-Received: <xmr:H0bnZeWUs-TO_gbiV7RocWxihvQJ42EgFElGdcP-9Qrr-9goa7LpNtcLL-zPUGRc4Lg96_LjeE5lwu2efGoEM_LZ669I-xx7vJhB9Jfvob4AzFlqkGCrZs7r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkfforhggtgfgsehtkeertdertdejnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeuveethe
    evudduffevteefheeukeehuedtueehieehieelveegveeuffeileffhfenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
    htrdgtohhm
X-ME-Proxy: <xmx:H0bnZaiPO9Zr_9ZMqV6U7ROvLI7K1_TEPo4DQbTeehfUR3MgsWom2g>
    <xmx:H0bnZeDekBViCKyWrvibHFssBBCdKxTT2ipIumJplBmeALMIe-OhdA>
    <xmx:H0bnZbLBUo5rJqrWTmizkIwUy_5WQD6xMr4gZUvbXTJnq68dwtUqTg>
    <xmx:IEbnZS7pbCkilyMpXL3wKxFjkdByPRyBlRR3IH3LM8GUrNBWypRuHA>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Mar 2024 11:19:43 -0500 (EST)
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
Date: Tue,  5 Mar 2024 11:19:41 -0500
Message-ID: <20240305161941.92021-1-zi.yan@sent.com>
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

Corresponding swapcache entries need to be updated as well.
e71769ae5260 ("mm: enable thp migration for shmem thp") fixed it already.

Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")

Signed-off-by: Zi Yan <ziy@nvidia.com>
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


