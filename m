Return-Path: <stable+bounces-121703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCD8A59323
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 12:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE59188F611
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 11:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0670222759B;
	Mon, 10 Mar 2025 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JH3G4PqZ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE9226556
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607707; cv=none; b=IcjW+6lONhpoJ7N0X4jF7tXACQql91p082/lPzgLvw+7rs24VSgMUNXd7A3oHq6CU7pOj+T4vameiPl8Iga/NiKG7bR+ls80RPZKO0q/cnZL2v9VM5Y/ScxC/np1YXQQDCo+VRUIkw+JjVLGBvpYHRnh0socWKyoxCiZN/vr7CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607707; c=relaxed/simple;
	bh=NxoMUgLmNNeeRjTpNBtNJBiiicL+10edgldQBT+XY9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IPjdsavrtDImFQPshWsfZXBLsxm22OfT42ZSJNG6MGxs1crZiH8IUIwqqnH++osWeW+YOovR17rfpDNy/Owiftqlb8UOjsfDk+r8lmLRX9FOlNvF5t7f1JbNpZXHfGBHYTQKVOuj3ziE19fxN4ND54FIfeLC3VvbFm90AEfBLVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JH3G4PqZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741607704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fT9w2XOzXjF2SoHSgAKOvBGlL/Ocqnje7zh5NOuAOsk=;
	b=JH3G4PqZmPln/J/J6dJ07SJA4APvUd4hKTkntnawjvYe/jQLDxDrSKKRSkkF+Z7SPI5Je0
	BSHECzeqnhzs8NIJPcwdM2oAAqTpE5eMVLLnFsJr5Gwvz1FpI7JU1+b3f5DNiM6wWo5+S4
	pP8A3xSJXgxGIlgvdgBh4DYBCD7O5CI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-_mAOt4IYOJK34Z7sz70pLA-1; Mon,
 10 Mar 2025 07:55:01 -0400
X-MC-Unique: _mAOt4IYOJK34Z7sz70pLA-1
X-Mimecast-MFC-AGG-ID: _mAOt4IYOJK34Z7sz70pLA_1741607700
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52A181955D66;
	Mon, 10 Mar 2025 11:55:00 +0000 (UTC)
Received: from localhost (unknown [10.72.120.24])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AFB1B195608F;
	Mon, 10 Mar 2025 11:54:58 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: dm-devel@lists.linux.dev,
	Ming Lei <ming.lei@redhat.com>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V2] block: make sure ->nr_integrity_segments is cloned in blk_rq_prep_clone
Date: Mon, 10 Mar 2025 19:54:53 +0800
Message-ID: <20250310115453.2271109-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Make sure ->nr_integrity_segments is cloned in blk_rq_prep_clone(),
otherwise requests cloned by device-mapper multipath will not have the
proper nr_integrity_segments values set, then BUG() is hit from
sg_alloc_table_chained().

Fixes: b0fd271d5fba ("block: add request clone interface (v2)")
Cc: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- rewords commit log(Christoph)
	- add fixes tag(Christoph)

 block/blk-mq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 40490ac88045..005c520d3498 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3314,6 +3314,7 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 		rq->special_vec = rq_src->special_vec;
 	}
 	rq->nr_phys_segments = rq_src->nr_phys_segments;
+	rq->nr_integrity_segments = rq_src->nr_integrity_segments;
 
 	if (rq->bio && blk_crypto_rq_bio_prep(rq, rq->bio, gfp_mask) < 0)
 		goto free_and_out;
-- 
2.47.0


