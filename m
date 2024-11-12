Return-Path: <stable+bounces-92220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EE09C517D
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71FAB1F21E56
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 09:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA7A20C02B;
	Tue, 12 Nov 2024 09:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vFM8NQ8E"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBD1209F4A
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 09:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731402507; cv=none; b=kgBqf+P94lrszkZ62GqhT/P8ZGjh23E9YaOwA7X9gPipP40gQa/2DVLRksXe4XkNCSKjaSF0XOHnhgK/z5mKNqdf+7TJw/A9czINYZDEccq3xcUSj8qTOcqhhXSLl94khzWE24SNPYfXvc+uphdAGp4dbrGgmJepcD1Uj8UOCTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731402507; c=relaxed/simple;
	bh=S1558sC7K7SNLvFrxopPAYYIQfwYpDyfqK5JGVLvFI0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JIY/CHnAXG81kRk7Lh00kf96wijo28kHEEwRDfR3xS7fJCVdGOUBP7Pf9sf7Hxdcx21YWEvYudAg3qffLUDgiFDtUBUBpsL3FE7qP1upph92Ddsr3Ou/sqCr0TMzSZ0LRF1fVaC/Z57hYbJBd0gdNGiYqLf5nqtcNcxOppJuFPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vFM8NQ8E; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731402505; x=1762938505;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b/LVFc/ynmQzr5DOuxZeTzgV+hwDUoUO+3cXjo8B+lc=;
  b=vFM8NQ8EbU2KZc0lxqUQGcX6m/+jbkVytiFO9i0i4qPQl9q+hD/00RwQ
   VhNl7LmkqqddQpuEUpkF2gzl/WHeKdEWnu2UzrJZ33iCzEpOXUfYEeR1l
   +hwVA1Q5txHOFMkIdQwDKrkklxGi3vE4w/XURSi/SIm3LyTz0moiQtGpU
   k=;
X-IronPort-AV: E=Sophos;i="6.12,147,1728950400"; 
   d="scan'208";a="146572323"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 09:08:23 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:28349]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.21.103:2525] with esmtp (Farcaster)
 id f72cb613-798e-4223-b995-dce90baef3d5; Tue, 12 Nov 2024 09:08:23 +0000 (UTC)
X-Farcaster-Flow-ID: f72cb613-798e-4223-b995-dce90baef3d5
Received: from EX19D008EUA003.ant.amazon.com (10.252.50.155) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 12 Nov 2024 09:08:22 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D008EUA003.ant.amazon.com (10.252.50.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 12 Nov 2024 09:08:22 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Tue, 12 Nov 2024 09:08:21 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com [10.253.65.58])
	by email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com (Postfix) with ESMTP id F03C7A0155;
	Tue, 12 Nov 2024 09:08:20 +0000 (UTC)
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 85BBD224AB; Tue, 12 Nov 2024 09:08:20 +0000 (UTC)
From: Hagar Hemdan <hagarhem@amazon.com>
To:
CC: <stable@vger.kernel.org>, Hagar Hemdan <hagarhem@amazon.com>, "Maximilian
 Heyne" <mheyne@amazon.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1] io_uring: fix possible deadlock in io_register_iowq_max_workers()
Date: Tue, 12 Nov 2024 09:08:18 +0000
Message-ID: <20241112090818.10908-1-hagarhem@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

commit 73254a297c2dd094abec7c9efee32455ae875bdf upstream.

The io_register_iowq_max_workers() function calls io_put_sq_data(),
which acquires the sqd->lock without releasing the uring_lock.
Similar to the commit 009ad9f0c6ee ("io_uring: drop ctx->uring_lock
before acquiring sqd->lock"), this can lead to a potential deadlock
situation.

To resolve this issue, the uring_lock is released before calling
io_put_sq_data(), and then it is re-acquired after the function call.

This change ensures that the locks are acquired in the correct
order, preventing the possibility of a deadlock.

Suggested-by: Maximilian Heyne <mheyne@amazon.de>
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
Link: https://lore.kernel.org/r/20240604130527.3597-1-hagarhem@amazon.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[Hagar: Modified to apply on v6.1]
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
---
 io_uring/io_uring.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 92c1aa8f3501..4f0ae938b146 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3921,8 +3921,10 @@ static __cold int io_register_iowq_max_workers(struct io_ring_ctx *ctx,
 	}
 
 	if (sqd) {
+		mutex_unlock(&ctx->uring_lock);
 		mutex_unlock(&sqd->lock);
 		io_put_sq_data(sqd);
+		mutex_lock(&ctx->uring_lock);
 	}
 
 	if (copy_to_user(arg, new_count, sizeof(new_count)))
@@ -3947,8 +3949,11 @@ static __cold int io_register_iowq_max_workers(struct io_ring_ctx *ctx,
 	return 0;
 err:
 	if (sqd) {
+		mutex_unlock(&ctx->uring_lock);
 		mutex_unlock(&sqd->lock);
 		io_put_sq_data(sqd);
+		mutex_lock(&ctx->uring_lock);
+
 	}
 	return ret;
 }
-- 
2.40.1


