Return-Path: <stable+bounces-26817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2A687245D
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 17:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4C81F26C7D
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 16:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2538F70;
	Tue,  5 Mar 2024 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="A8SdnuzY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pgGINRdA"
X-Original-To: stable@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416DF79EE
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709656338; cv=none; b=jRTmStTF/EumPXJJGiz8ISD5Ml0u1KN20m8lUCZrYnONuZHRMY64aHMJHQ2ipYm+d/cCyr1Bgat+dtQ2eAOVVLu0AF2b9Y0e6LZifOUX3BEjR9WvT3WPOwTZ8KivB6BqBAXKaq62BbA0px7ezR3s94t7DNyDUlqBWjURd/ce4KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709656338; c=relaxed/simple;
	bh=9sqcdIEWEA0YYWpKIHIcRxsMPrYEPygnfiyS72LYCIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TG9hI5ZZIYEYfdRUAUCRNekNHH7kWF5f1VJfNy2gMjAsowqUE1uezfG1kX75nH1jZxqoq1JP4OUx8vii1WGhddjz0SrUW7f14o+Qca2tUuJff+qDeUDUsN2bIFNqfbqs8fR7ffMQCPabkio19E1HyAjPKXWvZhZfsEAnmtbx1d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=A8SdnuzY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pgGINRdA; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2E17211400FA;
	Tue,  5 Mar 2024 11:32:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 05 Mar 2024 11:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm1; t=1709656336; x=
	1709742736; bh=6l285yO6SumF56rDdMfLu5SKNuqZg2rVZIvbyL2k2BA=; b=A
	8SdnuzYJGaXbdWUdJ+PSgE2BryZ9iNej8TjYTDd3Ymh2Mc4phWdDj5CAOaz4AKaZ
	Pyivn+LxudPB2jyo6rhKEIIEA+UFvpQWYvQPr7Y8V8zlrOAeyU6gve6NNVwMWPkv
	jqnAjwMDcUTsIYlf+bks0XnuXsJ7uUMZwwhc3aEXBAkldeZKBYjGSSz3xxhHlYax
	Zug0Hvx5uKx51mBtFsqq057nQKKKoUnDtBQooyOpNIJkztFLFs8fEw6SnP11xp9B
	dAPXrsZZl4S3KJoyX2GIRG8cyigcUnjXM1EXLCftRzvb3FzBZXLAeKUJ4OwnItGV
	3Zcjkbhn4pwFPEQLO1oBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1709656336; x=1709742736; bh=6
	l285yO6SumF56rDdMfLu5SKNuqZg2rVZIvbyL2k2BA=; b=pgGINRdA7K+YCaJwT
	neOMX3paB4tUiUZGiRKSDl8zAfH61KMyvp4C/75dHDmDwjwfAz/6HCATObc7ltoQ
	2t7jZeluRdT3MVsYqqvp6dHFKTJTfjT6ZmSVC7DhaHFwsSKqg4C/4jdBtvr5Hjy9
	+pVMPLxm/PcXjEqgPiYpt5n7bZBSbA3ZEe8bRXd1v1Z2vNtWPvGr/YA+QPKteoyF
	jB5Q2JIM176OV8E3UWPH98OgZLuuzYZsW9kFnXNNHLxC3a0ll6guxRzkYWHlkJv8
	XJoAit3ZiqPP+HaE7o+DlWEwtq6OMnnL8dbZD1SJ0BE5gALMFQ3yRzA0bjsT0AdT
	d4iqA==
X-ME-Sender: <xms:D0nnZV05adDuTrAqYxSbxHIt7OiJJG91WLz-ZLxv10Lf_vWVry7cLw>
    <xme:D0nnZcEWCRYpxwat4xMIzp4GIjDepiRg-MvsufzhRPOEpnGw9quOYJuFI3rG-8S6U
    D8wN0DqG_McECZeBw>
X-ME-Received: <xmr:D0nnZV5unNvBeaGalfoJYzdc9ngvQqjwOmXTgUthpuWKc4zjSx1puWzNhdr7wNT2Zf3v9vxGxdMsmnd3uWLuS_47xW5Aib_LjCGqE8nWkIJ8HM_71oFgAY3G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkfforhggtgfgsehtkeertdertdejnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeetudevhe
    etheehieetiefhjeevjeeltdfgvdeiueeiudetffdtvedthfetvedtffenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:D0nnZS3eTpQs5V4JNfoOR8qI50_Ch__tCIVDQz2gRQ3XZEOmK2YMhQ>
    <xmx:D0nnZYHL8BRmWSQ6KMp2QeRrx6FTd_uj8hV1Omib-PFTWinS5kx6mw>
    <xmx:D0nnZT8oLztouUaFoNO-QFVixYiIQegU_drLADE4OO23ZpI5qai7wA>
    <xmx:EEnnZQ9AlVnze0Vc4kOzc2YZ7uCF4kmklsEoTkHL5YjQPkw0yLrNqA>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Mar 2024 11:32:14 -0500 (EST)
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
Date: Tue,  5 Mar 2024 11:32:13 -0500
Message-ID: <20240305163213.95119-1-zi.yan@sent.com>
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


