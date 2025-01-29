Return-Path: <stable+bounces-111075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CDCA21835
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 08:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6CF71885CE2
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 07:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFAB1799F;
	Wed, 29 Jan 2025 07:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="exZKDNeG"
X-Original-To: stable@vger.kernel.org
Received: from mail.crpt.ru (mail1.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0732419580F
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 07:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738135965; cv=none; b=aMKiG+36aEIkWTGTleNVI+q1pnnfDjX7kP6igzPQyqhhbclUxx0HoMach/dzqkspnO3JzLSwxX/H5Lb8tK1qoOlclq/KagyMeMHtP4D1WOOMbE2aZ49qTrqIcXRF5cgVdqOG5Kf7FqdzwZ08DvkKZN2k8+7Nv9vNqcg0bpgTpiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738135965; c=relaxed/simple;
	bh=FEYL0mrtY+vInharmoJfMjO8xg849oDJ9LuBpBQ0d14=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XCjqbniaQQPkHjQS5jywi9rlFD+lfETj7Q/Nqd537hTEpyjVvzI3uiBI/tYrX5lunzR+fMMYwvRsZNILRM5Gd6Z0ZC5BBu6O2hdEpp3b4052RuubFOIuEYTrMNsvLZ00uB05V6RWWdtPsuauy+pxGimIbRJV28jB2ZG7mp37HC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=exZKDNeG; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.3])
	by mail.crpt.ru  with ESMTP id 50T7WVdd003128-50T7WVdf003128
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Wed, 29 Jan 2025 10:32:31 +0300
Received: from EX2.crpt.local (192.168.60.4) by ex1.crpt.local (192.168.60.3)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 29 Jan
 2025 10:32:30 +0300
Received: from EX2.crpt.local ([192.168.60.4]) by EX2.crpt.local
 ([192.168.60.4]) with mapi id 15.01.2507.044; Wed, 29 Jan 2025 10:32:30 +0300
From: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>
To: "lvc-patches@linuxtesting.org" <lvc-patches@linuxtesting.org>
CC: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] RDMA/erdma: Check page size value for erdma
Thread-Topic: [PATCH] RDMA/erdma: Check page size value for erdma
Thread-Index: AQHbch/0C00vzFhugUuiD7AdvPKzPg==
Date: Wed, 29 Jan 2025 07:32:30 +0000
Message-ID: <20250129073224.22599-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX1.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 1/28/2025 10:00:00 PM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 192.168.60.3
X-FE-Policy-ID: 2:4:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=70EYxwwxnNhuxUo7/vu8mCEfLaaBHSKBasdyvZotAho=;
 b=exZKDNeGVQy6C8+FvxYVYOk6+hqE5+Jdl7IzH7xFup5HtptMiCyAnpEZSZ1C6RTcYtQ6PZepRi/0
	zizZoGA3zOJAYRTZ9QA3hzXuGIY9uE3KQCz1/qPtU8TvMBa14db2B9iHEldB5IDtIt9LpYmL5yVD
	mf3kZRV5DRSaydNPODvlSWgB1aTIZLKuHcQf2wwHLHbLb9ie8kS2t07wM3Rg1RKSOd7q6c/ZyTPT
	0CQ/flYxHB/tOL5LqOwiPg0FH14TqkQHI9ppdDK1aB1Frn1Ao/c8kwzFUPbK+Lvc1H54n2WLPZ00
	ppht5xh7kqAAfcUnj6gZxnKX8IRd+VtvCw79Iw==

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

The function ib_umem_find_best_pgsz may return a value of zero.=20
If this occurs, the function ib_umem_num_dma_blocks could attempt=20
to divide by zero, resulting in a division by zero error.

To avoid this, please add a check to ensure that the variable=20
is not zero before performing the division.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 6d1782919dc9 ("drm/cma: Introduce drm_gem_cma_dumb_create_internal()=
")
Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband=
/hw/erdma/erdma_verbs.c
index 51d619edb6c5..7ad38fb84661 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -781,6 +781,10 @@ static int get_mtt_entries(struct erdma_dev *dev, stru=
ct erdma_mem *mem,
 	mem->page_size =3D ib_umem_find_best_pgsz(mem->umem, req_page_size, virt)=
;
+	if (!mem->page_size) {
+		ret =3D -EINVAL;
+		goto error_ret;
+	}
 	mem->page_offset =3D start & (mem->page_size - 1);
 	mem->mtt_nents =3D ib_umem_num_dma_blocks(mem->umem, mem->page_size);
 	mem->page_cnt =3D mem->mtt_nents;
 	mem->mtt =3D erdma_create_mtt(dev, MTT_SIZE(mem->page_cnt),
 				    force_continuous);
--=20
2.43.0

