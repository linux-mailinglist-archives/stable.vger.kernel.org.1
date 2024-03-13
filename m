Return-Path: <stable+bounces-27569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A0887A513
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 10:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77481C2105C
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 09:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9D9FC16;
	Wed, 13 Mar 2024 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="P8LEkXod"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E7B1B943
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710322652; cv=none; b=kFZgi5gKWY8s5t4Vd82f9AJYM2qAPifCMN0xDnTUQsoHyB8gDDb6i4js70yQZHJHI0jdUIazd+Qqdrenw5oFqhtdqk7nLYi417Ab8+w9ZPYEqEKg3VIJnJ9A1dZ51cuN1hhbEZtgS1xUsgEY01FO9+k5QtO5dO/lCVGkoGII5wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710322652; c=relaxed/simple;
	bh=+LcApEg+vJPDJwGPrHqvqQ7dveEeuw2Pgfbgx5VJouo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=c6ME1obja8tAS+1pHiPcn2dL97vtFE11E/oICcbltIRzu6BvdKx15NZLTHQJaETdjVISc69gek2JgAFQwOcL7/NUpGOpzNjTUbQhXG6AcXB/fFJZdNHj0i4QtWGzulW4Rbwcf8YtbcdHhTkjFrA2AXbd0r4B7JHDQ2JRQkRGxnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=P8LEkXod; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240313093726epoutp02af223fbf3f6f8e868eaa72a0fb8124b7~8SWK_r9fo1193011930epoutp02_
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 09:37:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240313093726epoutp02af223fbf3f6f8e868eaa72a0fb8124b7~8SWK_r9fo1193011930epoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710322646;
	bh=z08h1lCgV6Ps5471i14pREUyZQdGTMiu44USx+m44z4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=P8LEkXodxmABu/VM93K3DcmMyg5TweyAOsLsQTKtRFS7D3pAFuKapgQIiR6yEmRIZ
	 7LaPLwhfUHL0cS/xsn8MnqeBfYZg1MeBeV1H5n1DtM0guBj4E+Wj94atbOu5wi8EpX
	 qmTWrXOdhKTrw8LvgA4IFaGLlL86juFvqPp2QsCE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240313093726epcas1p14e14ab3a2b4c86db66f5fa7d3a175ae5~8SWKq3fM90818308183epcas1p19;
	Wed, 13 Mar 2024 09:37:26 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.223]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Tvlm61vp9z4x9Py; Wed, 13 Mar
	2024 09:37:26 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	7D.28.10211.6D371F56; Wed, 13 Mar 2024 18:37:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240313093725epcas1p353a6346547d3bb31feee7d82e57f32f9~8SWJyj46c1031710317epcas1p37;
	Wed, 13 Mar 2024 09:37:25 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240313093725epsmtrp1801519f374800ee1e383a8aee6639a5d~8SWJx8NwE1994619946epsmtrp1y;
	Wed, 13 Mar 2024 09:37:25 +0000 (GMT)
X-AuditID: b6c32a38-6d3fd700000027e3-e9-65f173d6d11a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	09.BD.07368.5D371F56; Wed, 13 Mar 2024 18:37:25 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.34]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240313093725epsmtip2e59399e21d4d156c0abffcdabbfd3da0~8SWJkAbIe1720817208epsmtip2W;
	Wed, 13 Mar 2024 09:37:25 +0000 (GMT)
From: Sunmin Jeong <s_min.jeong@samsung.com>
To: s_min.jeong@samsung.com, youngjin.gil@samsung.com,
	sj1557.seo@samsung.com
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] f2fs: mark inode dirty for FI_ATOMIC_COMMITTED flag
Date: Wed, 13 Mar 2024 18:37:21 +0900
Message-Id: <20240313093721.1059566-1-s_min.jeong@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRmVeSWpSXmKPExsWy7bCmge614o+pBs+v8VosaP3NYrHl3xFW
	iwUbHzFazNj/lN2BxaNvyypGj8+b5AKYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
	DS0tzJUU8hJzU22VXHwCdN0yc4AWKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIK
	zAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM5b0fGEr+Mtd8X7TAeYGxnMcXYycHBICJhLXfv5i
	62Lk4hAS2MEosWHzUVYI5xOjxKR3U6Ccb4wSBz78ZIZpmd03HaplL6PE0sPr2eFalr4/yg5S
	xSagI/Fw6m2WLkYODhEBf4mL3U4gYWYBKYl1nw6xgdjCAh4SXa3PWUBsFgFViUvLFrOC2LwC
	dhLvWtvZIZbJS8y89J0dIi4ocXLmExaIOfISzVtnM4PslRBYxi5xdOFeRogGF4m3G6ZDXSos
	8er4FqhBUhIv+9ug7GKJo/M3sEM0NzBK3Ph6EyphL9Hc2swGcjSzgKbE+l36EMv4JN597WEF
	CUsI8Ep0tAlBVKtKdD9aArVKWmLZsYNQUzwkPk2aDWYLCcRK9Fw5wj6BUW4WkhdmIXlhFsKy
	BYzMqxjFUguKc9NTiw0LTOAxmZyfu4kRnMC0LHYwzn37Qe8QIxMH4yFGCQ5mJRHeOsWPqUK8
	KYmVValF+fFFpTmpxYcYTYGBOpFZSjQ5H5hC80riDU0sDUzMjEwsjC2NzZTEec9cKUsVEkhP
	LEnNTk0tSC2C6WPi4JRqYKp7llq74FnyuXbT0v9XKnkLuqffrchMerlYMKNvgg3XDR/vmW1d
	eo/fLj5vySrXmiXCXBt71iZ7z87nH/bYl94UKq16cEUsljXxUM8Gt9ZTj+WVM0LS1B4qzRKd
	fkv1qGflue8u2248r/3aukbtcOT6/9LHlDYbHDpa4tH1X0bfoJg55K7xl7W3+gtmHjSd6STy
	eVamxwSvlZtCL3A853xWs9LQyUJHqyz885H6yDK30+3Pih5yTdQQVJEJ27zAqadmJ4PQlHKm
	r29n6kU9TWh9+8/51alS3ycT+zotdac4yAuWXYhuVBSdrOH9TGmt9C+xBwxnN8iwR+xgFog8
	fyWx26n7kxvbuwefgoQClFiKMxINtZiLihMBLe4XkukDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjluLIzCtJLcpLzFFi42LZdlhJXvdq8cdUg8U75S0WtP5msdjy7wir
	xYKNjxgtZux/yu7A4tG3ZRWjx+dNcgFMUVw2Kak5mWWpRfp2CVwZS3q+sBX85a54v+kAcwPj
	OY4uRk4OCQETidl909m6GLk4hAR2M0pcfn6cpYuRAyghLXHsTxGEKSxx+HAxSLmQwAdGiQff
	IkBsNgEdiYdTb7OA2CICgRLL3pxmBbGZBaQk1n06xAZiCwt4SHS1PgerYRFQlbi0bDFYDa+A
	ncS71nZ2iBPkJWZe+s4OEReUODnzCQvEHHmJ5q2zmScw8s1CkpqFJLWAkWkVo2RqQXFuem6y
	YYFhXmq5XnFibnFpXrpecn7uJkZwkGlp7GC8N/+f3iFGJg7GQ4wSHMxKIrx1ih9ThXhTEiur
	Uovy44tKc1KLDzFKc7AoifMazpidIiSQnliSmp2aWpBaBJNl4uCUamDifbP90/Msjj3tqbuz
	75a2PKsrVrpb3iXQkz/vOcOTaB5Jo7gGob3ZzA8NHd+uq+O8v6cm17swdqrJwxXRK7z8KoWy
	XKTPr9xxhG37OnmeVnGJkKzws+tXsCypa0+S1K1ouJ4stI5vGavfFYad7+5H7zxpyaup+eWG
	9NMFu4JPNbE+frB2kdu5ve8NPgYyNd1X2pf4mqe8c+e5sg3b1d+fL9g3JybG9esH1z3SHJH1
	Hk0TEjbpfJyYeZl/ffiixV0lMS4LbdTets+d/i5yav2Ze3GcHy+vv3U5WE9vvfXURfwrEya8
	+57x/9Cifvc3TVWbFrSuP7b67ovk+TPLDr7farQ+74KfxNd7G+3buszvK7EUZyQaajEXFScC
	AKKuptWhAgAA
X-CMS-MailID: 20240313093725epcas1p353a6346547d3bb31feee7d82e57f32f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240313093725epcas1p353a6346547d3bb31feee7d82e57f32f9
References: <CGME20240313093725epcas1p353a6346547d3bb31feee7d82e57f32f9@epcas1p3.samsung.com>

In f2fs_update_inode, i_size of the atomic file isn't updated until
FI_ATOMIC_COMMITTED flag is set. When committing atomic write right
after the writeback of the inode, i_size of the raw inode will not be
updated. It can cause the atomicity corruption due to a mismatch between
old file size and new data.

To prevent the problem, let's mark inode dirty for FI_ATOMIC_COMMITTED

Atomic write thread                   Writeback thread
                                        __writeback_single_inode
                                          write_inode
                                            f2fs_update_inode
                                              - skip i_size update
  f2fs_ioc_commit_atomic_write
    f2fs_commit_atomic_write
      set_inode_flag(inode, FI_ATOMIC_COMMITTED)
    f2fs_do_sync_file
      f2fs_fsync_node_pages
        - skip f2fs_update_inode since the inode is clean

Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Cc: stable@vger.kernel.org #v5.19+
Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
---
 fs/f2fs/f2fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 543898482f8b..a000cb024dbe 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3039,6 +3039,7 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
 	case FI_INLINE_DOTS:
 	case FI_PIN_FILE:
 	case FI_COMPRESS_RELEASED:
+	case FI_ATOMIC_COMMITTED:
 		f2fs_mark_inode_dirty_sync(inode, true);
 	}
 }
-- 
2.25.1


