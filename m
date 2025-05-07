Return-Path: <stable+bounces-142076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A59AAE36C
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 16:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB6F3AAF8E
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 14:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3DF289E13;
	Wed,  7 May 2025 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qxHfdzrL"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6DF289815
	for <stable@vger.kernel.org>; Wed,  7 May 2025 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628966; cv=none; b=JgAwBdNeAEOm1T5odNafdTQkuf7rckJLCHiMjJ+oC2qsJmQka7//pz/fmUxdNvK9uMcnJqtv2Irpz5YWQEIUO9rUL+yu588fqGoBCxVbU2LBe09ZwrMGxOUZ6ObdosxUi5+jhUTjqRu2rapFc8eiBbTkVEWo0d1wQ1emdmqWRrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628966; c=relaxed/simple;
	bh=8HQ4gZal2ZKCAxamtVYVPeNNHi172dDK0dsNXjtksHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=uGeR6FagX00ri65eyt3Rqgz9BBOXupyJnXxhXEaH5FcZXy45QLJ+UGcPC07bq3TPn0567NGXx+U/LFqTHVtCrMf9O/OBooLupgZaGVEP7QO/GkAtgrRq1gAUVzAIwnPRCjPzmq4X4CXIV+IzP5SHIZTXL57DG59aBjO+pwx/+lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qxHfdzrL; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250507144243euoutp028a8d8e748581f19cbd41271eb4c0bfc0~9Rcm53HEj0434204342euoutp02i
	for <stable@vger.kernel.org>; Wed,  7 May 2025 14:42:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250507144243euoutp028a8d8e748581f19cbd41271eb4c0bfc0~9Rcm53HEj0434204342euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1746628963;
	bh=34R7cvqohrkjem3KZ8Do3QII04UQFGDnVLXvAbb0TTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qxHfdzrLNiqK+s2D0ewAC4E5e7veKqxvSE7DL5EKK6t5vTjknIMZaheK1VNuC7v48
	 ITU0s4jONjilEtP3kC7FRiOev2H9+C8n8ZujKNGTin4DaAy2g7OO0nPNC07HwGtnHn
	 BHZ87BORDiEHGUtfxUyC5I1yn75nnYM3YdcKbwWY=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250507144242eucas1p183cb5456d7caacc02d60e33c4878a84d~9RcmqWM__1893918939eucas1p1O;
	Wed,  7 May 2025 14:42:42 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250507144242eusmtip28e8268df9b948d8f2057ea2720b97455~9RcmFkT1N3184031840eusmtip2M;
	Wed,  7 May 2025 14:42:42 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Gerd Hoffmann
	<kraxel@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, Sumit
	Semwal <sumit.semwal@linaro.org>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, Gurchetan Singh <gurchetansingh@chromium.org>,
	Robin Murphy <robin.murphy@arm.com>, stable@vger.kernel.org
Subject: [PATCH v2 2/3] udmabuf: use sgtable-based scatterlist wrappers
Date: Wed,  7 May 2025 16:42:02 +0200
Message-Id: <20250507144203.2081756-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507144203.2081756-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250507144242eucas1p183cb5456d7caacc02d60e33c4878a84d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250507144242eucas1p183cb5456d7caacc02d60e33c4878a84d
X-EPHeader: CA
X-CMS-RootMailID: 20250507144242eucas1p183cb5456d7caacc02d60e33c4878a84d
References: <20250507144203.2081756-1-m.szyprowski@samsung.com>
	<CGME20250507144242eucas1p183cb5456d7caacc02d60e33c4878a84d@eucas1p1.samsung.com>

Use common wrappers operating directly on the struct sg_table objects to
fix incorrect use of scatterlists sync calls. dma_sync_sg_for_*()
functions have to be called with the number of elements originally passed
to dma_map_sg_*() function, not the one returned in sgtable's nents.

Fixes: 1ffe09590121 ("udmabuf: fix dma-buf cpu access")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 drivers/dma-buf/udmabuf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 7eee3eb47a8e..c9d0c68d2fcb 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -264,8 +264,7 @@ static int begin_cpu_udmabuf(struct dma_buf *buf,
 			ubuf->sg = NULL;
 		}
 	} else {
-		dma_sync_sg_for_cpu(dev, ubuf->sg->sgl, ubuf->sg->nents,
-				    direction);
+		dma_sync_sgtable_for_cpu(dev, ubuf->sg, direction);
 	}
 
 	return ret;
@@ -280,7 +279,7 @@ static int end_cpu_udmabuf(struct dma_buf *buf,
 	if (!ubuf->sg)
 		return -EINVAL;
 
-	dma_sync_sg_for_device(dev, ubuf->sg->sgl, ubuf->sg->nents, direction);
+	dma_sync_sgtable_for_device(dev, ubuf->sg, direction);
 	return 0;
 }
 
-- 
2.34.1


