Return-Path: <stable+bounces-254706-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SByGLnWuF2qiNAgAu9opvQ
	(envelope-from <stable+bounces-254706-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 04:54:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD275EBFF7
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 04:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7CE6312483F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 02:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE0A21D3F5;
	Thu, 28 May 2026 02:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5U7ChHy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67AE2DF153
	for <stable@vger.kernel.org>; Thu, 28 May 2026 02:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779936538; cv=none; b=ZkCNw9/FiNCihn24NNtkFvHV+JEesPHDRTjzXHZl9j6wpEw/R6aLTLz56FMCxA/Mf8noG8UjFatF3a8nS4rfCQ6KhZeG3CK5f8v+vRjqnVGnJbLW/aXiGKDr3F5lYO1X6jmr8LkHYAvPV2hnpoELED80jHmsyNSXlxBNrkuVWB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779936538; c=relaxed/simple;
	bh=4ILmcE2UVRvUA5w/bCMsuoZ6029LYusklIg66JvviMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DUY0+IISAPQ6eonJ53k3y8h10smJKv6QkkPlQ7qdJcdUV/oxu7CIbZ6n6HHBKWG5zGC2fTJZYWuvTry83OUiQg5eH/88bacaHvLnfDvcR79DYNuTngnviORBGLgEPXPlhjrsuvlzFu4fz9Cbv36J5QTfyGcKaA4S48E6tBZmpAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5U7ChHy; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c8025f1c227so9409159a12.2
        for <stable@vger.kernel.org>; Wed, 27 May 2026 19:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779936536; x=1780541336; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdZHIVC8VqdiF0LxnTx3Ka4A/RjNztw5bpRG2RMXPPI=;
        b=T5U7ChHyEZhxolxb0MDGheEdL2EnsmL94QT1nbR4/jfJv3CfiyzggSxIVzszeOVtdw
         IL9/fhUf1pHx2ZfARCbIRcw1fYW/smBXRp/1hqvNZ/2YbrDSjjXi2r1O+OYfsX3iE+lj
         Q7FdHlLkao4e6kEHZ9kKBrQzHXZMtu2BH3jJAWFgv+OzeSBY/PP1UZTJYNRJq1gMtxhk
         pNFk7Ytfe0lZMoI1RdZ+HUWf1PBFDDDwCdcjrsS1xGNo6XFbH82ZiGH7kpm/ri1wPUmY
         25TWRxYM3Csw+e/YrVkc2UYMmH7NTNiKCkpHbQbrDUHfsmwIohUb1lomLhje3CgO4pP3
         hIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779936536; x=1780541336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UdZHIVC8VqdiF0LxnTx3Ka4A/RjNztw5bpRG2RMXPPI=;
        b=D3P3VxVHoT2tRYIKlbLDrf3TNjt/SJgrWk/NgLfs6tzFUP1gdW0n0Q0LC+EMXx14yh
         z1xIJpjs0cwd95Y78BnCHj5O3nL5iF1j7PkxKeTBc+OmQusbGV4VFDFaUkRIw7QKG6WQ
         zIuv8hexI8KQAlaDvq5ZQ1FQsrhx3NKLRYTd9DXr7DqFIGkdeTxotW/Yc/+ldTkT3nvq
         HU5qdeIxE+TC6n/7CbVT8SWtJPB+SjbnYn7N8y+pKNaMWi5yI136omZ/Zc8KBsDSeLkN
         n1vti2USsZkFrjpSfub/VgQISQmJmM7Ga9Td2wnxEawwobbccoDqyahM1t9mgQttrQaY
         Orag==
X-Forwarded-Encrypted: i=1; AFNElJ+9bi4H/rcSbP3Y5EwkTWaU0Eso8gGs7aUerqwYAeSWNKQ+5ejkbh1EErLe5iJpK7tDZ4MvwhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCSkWfAK1CpA25OY+nrNlchZMyMWP6VbDZGBXSduubD7ws+xXa
	6pwwdI7RdrJUftYOQ2Aw20w8MNcVAAYjJ25btiPJm497QA/Y3M1FiQUr
X-Gm-Gg: Acq92OHk2wpiw0if/bH/qWZL+aBxeoQ1N4SWhpLMpE6DIBLS6nz9w7g3dPeGLLkGUZM
	w6btfK6S2yfoMpBcVcrWBSWAaPD+ei1RvpzKSk9GvtRhpPLS/k7Nykol5xY4VMOrHTss+M/eRuB
	pqodS+itGYcL+Dr7J+OX9iwoo1fXu8gEMrH2epyiXU/Yl1Vy/hk+HV2F75yBUjpyX0v4a9q1S7T
	P6J35i1SRPufs6cr9zJ3daUDdC66yu+MLim5QjvkCEpN0u5tTnXG9fsms/jyvGPdPkPxKD6KlgJ
	+FS7cos7bL/oHtZo6mSHYwXZHLEZt4bBF3xNFnqZqq+eXDMHowvtLW//yu+iv9HAQ5mAIe5QuGo
	qYJ+yLoDCNOTxdYHE750FEDX/Ok6ZY6RDP4kUYncrFTNZmjEaDbQo8LRsITI8kiKYtGPDb40dbq
	Cs85h+glQTen/mGMeuUfR+s6cnKBpxFadHQA==
X-Received: by 2002:a05:6a00:238b:b0:835:5aa3:2dab with SMTP id d2e1a72fcca58-8415f1236aemr26567785b3a.6.1779936536313;
        Wed, 27 May 2026 19:48:56 -0700 (PDT)
Received: from [127.0.0.1] ([116.80.91.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841f3cbcddbsm366877b3a.4.2026.05.27.19.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 19:48:56 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
Date: Thu, 28 May 2026 10:48:44 +0800
Subject: [PATCH v3 1/2] zram: fix use-after-free in
 zram_bvec_write_partial()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-zram-v3-1-cab86eef8764@gmail.com>
References: <20260528-zram-v3-0-cab86eef8764@gmail.com>
In-Reply-To: <20260528-zram-v3-0-cab86eef8764@gmail.com>
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Yisheng Xie <xieyisheng1@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Cunlong Li <shenxiaogll@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779936530; l=1542;
 i=shenxiaogll@gmail.com; s=20260517; h=from:subject:message-id;
 bh=4ILmcE2UVRvUA5w/bCMsuoZ6029LYusklIg66JvviMc=;
 b=KynYLGaGfZewjfo8RGU3mhyIy/vlwWxgy9oFeOCxoXHK2kYgK2sfLrwnBPEM449prqRHxV4Ff
 gobRxeZpMNpCc9MhH6mBms/BlpM1EFCtEHdF4CNUFQvLFVvO0SNxIr4
X-Developer-Key: i=shenxiaogll@gmail.com; a=ed25519;
 pk=SKFifnqPdsvsjuhUiq+Y9vtCdhyZ/LrRcfYn8eRq6AE=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254706-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lst.de,vger.kernel.org,kvack.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shenxiaogll@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,chromium.org:email,lst.de:email]
X-Rspamd-Queue-Id: 2DD275EBFF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

zram_read_page() picks the sync or async backing device read path
based on whether the parent bio is NULL.  zram_bvec_write_partial()
passes its parent bio down, so for ZRAM_WB slots the read is
dispatched asynchronously and zram_read_page() returns 0 while the
bio is still in flight.  The caller then runs memcpy_from_bvec(),
zram_write_page() and __free_page() on the buffer, leaving the
async read to write into a freed page.

zram_bvec_read_partial() was switched to NULL in commit 4e3c87b9421d
("zram: fix synchronous reads") for the same reason; the
write_partial counterpart was missed.

Fixes: 8e654f8fbff5 ("zram: read page from backing device")
Cc: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Cunlong Li <shenxiaogll@gmail.com>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index aebc710f0d6a..b23a8bbb687c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2333,7 +2333,7 @@ static int zram_bvec_write_partial(struct zram *zram, struct bio_vec *bvec,
 	if (!page)
 		return -ENOMEM;
 
-	ret = zram_read_page(zram, page, index, bio);
+	ret = zram_read_page(zram, page, index, NULL);
 	if (!ret) {
 		memcpy_from_bvec(page_address(page) + offset, bvec);
 		ret = zram_write_page(zram, page, index);

-- 
2.30.2


