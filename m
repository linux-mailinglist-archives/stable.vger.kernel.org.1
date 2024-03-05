Return-Path: <stable+bounces-26815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10355872452
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 17:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419B31C2363B
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 16:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DA9128803;
	Tue,  5 Mar 2024 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="IXJBrMF6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T9NjM0uB"
X-Original-To: stable@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297A5286A2
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709656070; cv=none; b=WTzWx/e4QJAIIl/+ImjglFUOHVgaGfvQ7zn24U0RXLUbosfPiG+yvvr0/e8KKvrYUEX7ZIMXJ5GsXeFVj1V2MTziUTxTwhWB2zcgoajp2xk2wkNDpWVmJgBT8UW1cbla2CVijaU2kM9kkfHNno7WcwRGANu072T7no7U9ptkHXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709656070; c=relaxed/simple;
	bh=go9KyGvWuzXjMg9EbrYJnPDCBdr83Q8QuluqziDq3V8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VdFcfWL4wS5jYQSf3BcAKUCZKTRRs1ohTcTRyJiPoAW/6J602lDZOjihXmB/B80ITf+XDS9sffo9+RPjSwZIkhQ3XiHelvQE+LbUbH31+zMyu3TvkXbrdnqAt8jyqxhbMehHQthfXzT5JaXadBIh2mqTm27D4ugTS9y+Ua53Zc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=IXJBrMF6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T9NjM0uB; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3ECC21140102;
	Tue,  5 Mar 2024 11:27:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 05 Mar 2024 11:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm1; t=1709656068; x=
	1709742468; bh=rv9CWGPrXcYc3Xg91xHt2tGn5vOuXTAu4AiypxdwtfI=; b=I
	XJBrMF6GoMrvn8+2qQGNQfmtPI48iFvUdOMd6UMFm0M/R6y72wKrBkOCzZPLEhJn
	F10PoPYhf28TG+LMEJ3VvAJgfDiMxdaAPNUvl8cvHwGomtDOvvbuOLfLzns6bkWw
	TzxpAHeZtrr3MB/DE/gQg0Ixj0brKQVL/qDo+mgEo1X+vXPlqJR/reosqegOBX+h
	+iWWh5rWqdP2DFAeJMrX5eZMXi+qjVVWCtjVikKjSmBQB+Zz29Wfd4tfAgYTd5Jb
	lkwNY5XYbG5H2KRSXitZxxDzneYCwvPSULojxHqB0Jx59Uvv3KRoEfbzn4qCbirg
	612HWqQYsf8GIZxmWn9mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1709656068; x=1709742468; bh=r
	v9CWGPrXcYc3Xg91xHt2tGn5vOuXTAu4AiypxdwtfI=; b=T9NjM0uBULIOagiAZ
	4H3YfMTXy9Giplp5/jyZVKAOMXFL0v14dvzCr/k4n/cAE/wrDFt40DXNvUIxZ6J0
	upSDkvR6GVfcIe9QfTr46boPX2rJEpp/fMGJ8uAJ99E3adEa9xOGpLVrPNBfJDkP
	TkDDPhYnN64VyX8Y2L2X3VtkGi7TzlRH4WJsFITZ1UdFV8573qCnTnpIhLRioPLn
	UvyEYbJAGFtQhUEsZz72ZnBCggfbj84R9bYhzE2Kiz0rM9fbgHWjTXZdajE5iQ/s
	6xHkKWoRhlKYCVZH4pW/GrpFBNgO65pUCrKGRqVIT4dedf7XmZaNREoqK1rqyGBJ
	ubrPA==
X-ME-Sender: <xms:A0jnZV_ROX4fghkr_iogbAAHW25vmE62RckLgYADRTiHcYQ3eRoG3A>
    <xme:A0jnZZubQ15fVm12FNU9kJamcBIIYfVMmKmJJ8VCL3WE2MmUnbTwbid_YjdJchiao
    r0ojp_Kjvf8MnCyAA>
X-ME-Received: <xmr:A0jnZTDb2rR-OPetTn43m0bHiaD8SY-fLld2VJ_0VtsPz7wUVS83gvqi8OSYnCu-PVQ3HMKvpR62K3YR5NFv5qlHQ0H8WkpylhX17K4k0WayXAAOM2d9QE-0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkfforhggtgfgsehtkeertdertdejnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeetudevhe
    etheehieetiefhjeevjeeltdfgvdeiueeiudetffdtvedthfetvedtffenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:A0jnZZffP5czWyqEovSs6xO9SYrS4r383Ys2MoO_oLBJffjYu6yrmQ>
    <xmx:A0jnZaOhixYlpefddgmWMP2hUgrBQOH8A78ulaj8A-zFe6JcMjCPZg>
    <xmx:A0jnZbng1ukXQSOcAJP9X5AW5fblsnyPHOKW5vSq7uyNZyZP9F9PHw>
    <xmx:BEjnZbHi-b7lFVkMNjPpNPAWzO4MFfiCkXe020d_qIAIYGrK7sJQKA>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Mar 2024 11:27:46 -0500 (EST)
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
Date: Tue,  5 Mar 2024 11:27:44 -0500
Message-ID: <20240305162744.93431-1-zi.yan@sent.com>
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

Closes: https://lore.kernel.org/linux-mm/1707814102-22682-1-git-send-email-quic_charante@quicinc.com/
Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
Signed-off-by: Zi Yan <ziy@nvidia.com>
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


