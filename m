Return-Path: <stable+bounces-121677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E57A58F3D
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 10:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E971418878E7
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 09:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B073221F13;
	Mon, 10 Mar 2025 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OTGW3UN2"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D2A1361
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598188; cv=none; b=gOXyMyYGgCr/FY+2DUcfmJyp54vExv+bMyXOBth42WDqP1sZDOEsAinjvi51osogzd734+aWKiZPO1f1tHO0TJUWpHXvtKK3fOlH5bpCCG1oZbfaWJm6/aHsiiFnCDFL/i5HCuzg82JN4y0ilgycCzuYfmLOK1BmEOI5OjqdgX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598188; c=relaxed/simple;
	bh=j/2Hy4clFrckMjtEZF1Tq32bqKe4GusaZ8+plIUuhdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IZ1iyZDU5nxRjmIxrBigRx6WX8QnJstlPUuLwdYt0nN0ja9vTCFEIyDCgVl4i2CfywMOI+9NRBUd963Fq/z10h/10sCL05DCCA5hnGtQuLLhqWr1Y8mMwYFSCbZQgiyah6BvLa1amOp1bj122Fzzo79yfs2Knu158BOANF/AZZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OTGW3UN2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741598185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iqH5sQhQgNCBmrsNGoSMQgNgdnc53Pyacipz5oblkxI=;
	b=OTGW3UN2apvqmAsNAmHwF6/f2dZpkh/NjicmDxaCXnv4yiRX9ttSrL1bD7Yt5pV4vyb65Z
	5gsKIi9nppqmaRSfn2HwkK1+sQtYbkTtpHA0LzhO/56m/eeSPzWram2zDpkvMvjPaghc0F
	mszVdoBAyTvCyurw0fV7CctOy0t3lVs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-FShKbrLpOaKJdXm6nMCKsw-1; Mon,
 10 Mar 2025 05:16:21 -0400
X-MC-Unique: FShKbrLpOaKJdXm6nMCKsw-1
X-Mimecast-MFC-AGG-ID: FShKbrLpOaKJdXm6nMCKsw_1741598181
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C90191954216;
	Mon, 10 Mar 2025 09:16:20 +0000 (UTC)
Received: from localhost (unknown [10.72.120.24])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 421B61956095;
	Mon, 10 Mar 2025 09:16:18 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: dm-devel@lists.linux.dev,
	Ming Lei <ming.lei@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH] block: make sure ->nr_integrity_segments is cloned in blk_rq_prep_clone
Date: Mon, 10 Mar 2025 17:16:10 +0800
Message-ID: <20250310091610.2010623-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Make sure ->nr_integrity_segments is cloned in blk_rq_prep_clone(),
otherwise zero ->nr_integrity_segments will be observed in
sg_alloc_table_chained(), in which BUG() is hit.

Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
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


