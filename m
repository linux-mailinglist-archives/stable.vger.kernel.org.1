Return-Path: <stable+bounces-26816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 998AE872456
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 17:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54AFB28294D
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 16:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31904127B70;
	Tue,  5 Mar 2024 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="auvd2yZb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pNqemNbZ"
X-Original-To: stable@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD8885640
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709656190; cv=none; b=jx/wHDfB0DYb+5gTjvRmyXupjh+9A2WlnSTCqEm3ziJg+c6UJUk26GxL9r3feIJy2vVNMPo6zIdGw/5fLprfduWAYT+G5EhUlypHcgSVfe5Ryb2vCnxSNkucXC3uuH03ThURPM08oLNVgupZ2XeithWYNpq5tNKHKA4jpqJYD0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709656190; c=relaxed/simple;
	bh=GrINPCX8alv9YfPt1YaG8Pc8nLeEuAPvQMduzVzRI2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pbmqzBFoW7/5cFtMFeF3k8DuHn86+zDZnCrPO0jmyen+LEfGfSQXPSmBaAS4ZmjrxjyAcrQUcD/bpKGx+AaOUUhfKqJ5hSWKPD/CKbZu4Mxe7DCnWd7reygwv6xy9oI82Y2cY0dvABSNj2JnKAFymiYX5E+JsQhzdSDCUf/PKVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=auvd2yZb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pNqemNbZ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5A3901140163;
	Tue,  5 Mar 2024 11:29:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 05 Mar 2024 11:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm1; t=1709656188; x=
	1709742588; bh=n7c5roTq8gGe7Zdj/lBmtvHsdOPMMzS9iluivszAxX0=; b=a
	uvd2yZbwTCn09cqthFeDHdWNQofu24WCl6Myw1hvdOB7QPD3+n1dOBILUoXl4607
	/yBuKVIUtwsBDOVeCcTyojfjktADopfAF2J8H9IVoBET+yr3kHDeVwHVWB5gHgQu
	DWeo99lMFOCAufCwXMQCRFkp39Pgp3gT+zzY0DXMuf8gczX0jeM1Tg6ZImdLGxS7
	0jjNXFZG1lvDoCedI9yM5ngSfMpmPPIyG9I+jiytVUf3EOQN+gPA114WuLP9PP9d
	YAJfyZ/egJHJfiQ0RKuVaaikPgPwge+y4Uu7wOwHeSk+430OA2FIGCnBocWiAEdT
	rDZat6T78FAn1LXbsTxgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1709656188; x=1709742588; bh=n
	7c5roTq8gGe7Zdj/lBmtvHsdOPMMzS9iluivszAxX0=; b=pNqemNbZD+RLldtXf
	lR2UgKd40nsB2C8xwecE6bwaNBpVJxZuPXfoZjE0yATgVJO5gUg+l39vf0dBo84c
	mwVm6hJ/C3XfGvh/WC+TmQJ9rw6ENr5NPu9TSCZs5CO/6H1Q2mYKaExAxnvt8XUN
	F3AcnkRO2m4ssoR2M8bINmZ4qG6PxzBIWLasn04oC/OC+cTx6fjZITkv+DUEQOPA
	6WTUWwgr5rd8zXWFC+kNAXMJUKZn3HV7yJiBk3++uJGChCY7FzVHTZioxiPSzzJ/
	ScNpCO+Pu8lTkOh95McT0OMUHwu7ry3q/FOsG3cJq0YnPKKlwXKQ/YFmhGVLjfOb
	VSHdQ==
X-ME-Sender: <xms:fEjnZcNTDrmQys7gs7W4DTnf6hYz4qgFICBSqEhTcHmFTYfR35rljw>
    <xme:fEjnZS_4FEQlpZKDTwl9bnL3OoUog9owTr9vYsoeWBNWwO3nsiN9djdB2QjofmyY_
    t6NSmf37xtPiKUd4Q>
X-ME-Received: <xmr:fEjnZTQ-nFimjjPdGsV2397GEwraIx-8okW6-V_sl47cCy0BW6ziypO5awNBXu5zOf_1ls_C-26rrGpbzMsbFoJhYZWAtwC1zZXcDEaHiVgW0m0kk9b0waQk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkfforhggtgfgsehtkeertdertdejnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeetudevhe
    etheehieetiefhjeevjeeltdfgvdeiueeiudetffdtvedthfetvedtffenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:fEjnZUugPM-fw3IOYW3YqSth1FK1FfmFnNPTreAdocVQ-5Si_C-8rQ>
    <xmx:fEjnZUdmO8CqISyqnpAihsGwMIpzbtWHq4dUnwAtjoVx7S1RB0dFOQ>
    <xmx:fEjnZY3yiJOdZVCHT01WNcdF1U_emr1NGIrkd82Os2fAZqNwyjIjYw>
    <xmx:fEjnZVUYdM4Ki6UwWo9dPkztjggdvUbYmiu3OHELfPE7d_GPKD7oLw>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Mar 2024 11:29:47 -0500 (EST)
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
Date: Tue,  5 Mar 2024 11:29:46 -0500
Message-ID: <20240305162946.94199-1-zi.yan@sent.com>
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


