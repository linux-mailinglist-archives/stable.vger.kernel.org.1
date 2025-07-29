Return-Path: <stable+bounces-165032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F46B1478D
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 07:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8394A7AE7E0
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 05:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C3F1E520E;
	Tue, 29 Jul 2025 05:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eX88Y/zY"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A567E2147E5
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 05:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753766506; cv=none; b=R5HruAP7aZFaqC3MJKd7WrBHAvLss8gspRqlygISrmYmoMZ/U4gtYmRpzQrE2Jti3p5DEmhA//7Ple9eDS05nkJDEq3jM5VJICGl9avP5a0/zqg0IdTQkGqwM7lm0JiAC3NWJ+aJ29MP7WkdF7Bq+7RFriSMN0AY3Gr88FoiVYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753766506; c=relaxed/simple;
	bh=gN8omh9+jZRnT2WyX5FyUkbqpxQzn9dfqD1XgXawL5U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sUVasYjWN+NV09tqWs/6/UIXzzx5JtlafB612hl8WrhRZzUJ760B5MD2LDgpdEEXSJrilUWEq1w0wEAxlc8s1Cb1C35GfVJO3dNRxgI3vLfnvyv3xRpgrAgV1fOTJnhXBokwQiGmxQp275EvZw8XIvE1kVDw8wI5RduzUvBtsSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eX88Y/zY; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-70736b2ea12so12387366d6.1
        for <stable@vger.kernel.org>; Mon, 28 Jul 2025 22:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753766503; x=1754371303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yCNWGElp5pC1atxEbdepPd2VdGD7IrJ4GQmz0sudHLw=;
        b=eX88Y/zYhqfoyxvNv8Nl8NEA/MBUwjWDZIYZ5jP939333qitX7ppAUNGCwJ1V/kOqM
         H94Ux0Eindx1YffIyevjP3RJMzwu2oi+PDb8gcHEZnQ+RGSBe9U165FMkuN2yIuLejwQ
         /6Gbkn5Pk29MG402AZNA0sPyIcoWPNKBQBzx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753766503; x=1754371303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCNWGElp5pC1atxEbdepPd2VdGD7IrJ4GQmz0sudHLw=;
        b=cNYMAJH1PSHa9/HtEjnAHltQstf/jT7H7SXHKEPF5KUIPvrhQNufudbwn1btG+ZEZ6
         jNkgu4ZYW/tU4zRkoHMIrixAIdMYiFONdVIo2upzRVPayqg97stnPJjH/Nstoyc208/t
         tp48AWn0794XfaFBuSVDeKPPLH3lcuY7AlAzgnFm4XsZ/j3rE7b0WQE4yN6H0PPf6HSa
         LaBISXlXlA80dDkBh1xy3LDUB7OrQmoEQ4wy5aTLqIWlv9FejhPcfE4U5hL21gmzisIM
         mwNtxruPzA9asx4uQ4ZZfYwJLqPtwWIcRhNBZ1et1VinHyeyNkMDIWkpUvzGJQSmQ4o8
         OwKg==
X-Gm-Message-State: AOJu0YyhBiFGE5Tx3+GPYbMYnxxHYqv1SMwcScraXH1r/5eTiXFoOity
	4NAHUBkgtbQo3H2l6qZYKzO14/d4zTqbqI7STVt7qLW5aecpOaa6ToTDZmEiBuQFcPI873EWzNq
	eQUp4ABgDMmUG0+GaU56zQ9quJIuW6vjW5Cr/e29unKHC3zE3cjU9fPrn52fGaBhNcwgH3aRkmT
	yIwc2AyNEbQrXxt3pssBpCOurbg9c1c0xalHH0HxO+AoGXjx9jq23LdzD2
X-Gm-Gg: ASbGnctGYMZC5huvetqVocJnMhYRPnyNmfuW3mP0ZA+NMiY8Xz9UWCQ/Ow02Rd8LoYy
	5G3OiMsW7VS2yawhSnUjLdCjbQFbHSnPX5kJkcQRNqUzS56sXd2SMfgsiUvlkmfbtuZqymHHaSL
	7ChEReflG2z49vFAaGO3uGH73E06M/EeVP4zqPgD8qnpTrwwFnVdrsyharC1wEheEMackCA2CPP
	NSI2UlL1+vpSU3952WhOoGnvDG7krlNx6LN8ln0sqcEisXQD4ZjNsp0G40hb0L2xU5CJ6b2hRDo
	OspMqHCBqeOC1WxQxo5osfXK5DkV+4UCC3OyT5Dkpn27tRxRVM2GCjyXbcrrG1VRJzk+GQxKaNz
	5jAUmruTIsj3Akjj+2tG3CBn40jlJBRb8IoRJmFzzPUVVbO73BHkK8nVWM8vTG2eOWCr76x3MjP
	xHJtw2aVJ/sQ==
X-Google-Smtp-Source: AGHT+IF/SW2bBwaEzMPz1p7KR+YUAhGTkvxxeMNF+awmsUxOwYCQHqsob47D0nMgbULN58Y1tyFZrQ==
X-Received: by 2002:a05:6214:dcc:b0:707:1654:cf90 with SMTP id 6a1803df08f44-707204b8fb9mr198625856d6.2.1753766503088;
        Mon, 28 Jul 2025 22:21:43 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7075e3208d1sm1260226d6.72.2025.07.28.22.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 22:21:42 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	tapas.kundu@broadcom.com,
	axboe@kernel.dk,
	linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Yu Kuai <yukuai3@huawei.com>,
	tj@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10] block: don't call rq_qos_ops->done_bio if the bio isn't  tracked
Date: Mon, 28 Jul 2025 22:09:01 -0700
Message-Id: <20250729050901.98518-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit a647a524a46736786c95cdb553a070322ca096e3 ]

rq_qos framework is only applied on request based driver, so:

1) rq_qos_done_bio() needn't to be called for bio based driver

2) rq_qos_done_bio() needn't to be called for bio which isn't tracked,
such as bios ended from error handling code.

Especially in bio_endio():

1) request queue is referred via bio->bi_bdev->bd_disk->queue, which
may be gone since request queue refcount may not be held in above two
cases

2) q->rq_qos may be freed in blk_cleanup_queue() when calling into
__rq_qos_done_bio()

Fix the potential kernel panic by not calling rq_qos_ops->done_bio if
the bio isn't tracked. This way is safe because both ioc_rqos_done_bio()
and blkcg_iolatency_done_bio() are nop if the bio isn't tracked.

Reported-by: Yu Kuai <yukuai3@huawei.com>
Cc: tj@kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20210924110704.1541818-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on 5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 88a09c31095f..7851f54edc76 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1430,7 +1430,7 @@ void bio_endio(struct bio *bio)
 	if (!bio_integrity_endio(bio))
 		return;
 
-	if (bio->bi_disk)
+	if (bio->bi_disk && bio_flagged(bio, BIO_TRACKED))
 		rq_qos_done_bio(bio->bi_disk->queue, bio);
 
 	/*
-- 
2.40.4


