Return-Path: <stable+bounces-92219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B53DD9C5161
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ACE9283042
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 09:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2230920B1FE;
	Tue, 12 Nov 2024 09:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ImD9pMFV"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AF21F7092
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731402136; cv=none; b=cseyLsjWIZdNYFo8bBTPqDr/fymjXQ5vzFnfAyFQqNIjhI5ZX+zCBgbENH5ZhAKBnz11aAFwIlE3/5BhUsIWaXCaZzgO5L1Qe5ySuzIlyMNwCFrmUOiFeYCvTgtTAEXRd6wOvJ+esrSDMv+N5NOX8KbdvALq/hjxPc+1ss9YtsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731402136; c=relaxed/simple;
	bh=H3JWPwTEzGJVHWV497VE5Cd4t2buRa5Sn+RT1MowOOM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nnRxWjlrO99nVJrXNaC5ypIXDT8iAH/UArGROMv0RzTnSWEfkdDZiqf+tEfRLjcICt2lnjvFIVHjqA0dZl0Di1e918f1S8ShGh3WPACzg0gckGZzLD36puPfe86SuVqZQT5Gtnq7pmXSQvhkxB/CGiis2QUH3RuRgYBVPlArh6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ImD9pMFV; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731402136; x=1762938136;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=omfcnd2vd6LKyZ6mo7Fq4Mi7qbuibUAF++k6a9e85D4=;
  b=ImD9pMFVmdcv1dS5rrA+HCksk4qcHCemm76Sx6NzNwg2MUnduJjWZlgq
   P5roO0fqkTsebNNUXVctbRLHUEXZlo3pQDgRgMtbA47KVBZt/rhxxIOVS
   qCSOoR+cm7/VX0PgU6tZ6xg6QZxSjf2V+WC6RhmbavFDCXz62hFUuHmkD
   Y=;
X-IronPort-AV: E=Sophos;i="6.12,147,1728950400"; 
   d="scan'208";a="351547571"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 09:02:13 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:25073]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.35.184:2525] with esmtp (Farcaster)
 id 0e32a6ca-e47e-4a75-bc34-ea48e970eedb; Tue, 12 Nov 2024 09:02:11 +0000 (UTC)
X-Farcaster-Flow-ID: 0e32a6ca-e47e-4a75-bc34-ea48e970eedb
Received: from EX19D008EUC003.ant.amazon.com (10.252.51.205) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 12 Nov 2024 09:02:11 +0000
Received: from EX19MTAUWB002.ant.amazon.com (10.250.64.231) by
 EX19D008EUC003.ant.amazon.com (10.252.51.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 12 Nov 2024 09:02:10 +0000
Received: from email-imr-corp-prod-pdx-all-2b-a57195ef.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Tue, 12 Nov 2024 09:02:09 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com [10.253.65.58])
	by email-imr-corp-prod-pdx-all-2b-a57195ef.us-west-2.amazon.com (Postfix) with ESMTP id 67590A0226;
	Tue, 12 Nov 2024 09:02:09 +0000 (UTC)
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id EFAE3224B8; Tue, 12 Nov 2024 09:02:08 +0000 (UTC)
From: Hagar Hemdan <hagarhem@amazon.com>
To:
CC: <stable@vger.kernel.org>, Hagar Hemdan <hagarhem@amazon.com>, "Maximilian
 Heyne" <mheyne@amazon.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.6] io_uring: fix possible deadlock in io_register_iowq_max_workers()
Date: Tue, 12 Nov 2024 09:02:06 +0000
Message-ID: <20241112090206.4446-1-hagarhem@amazon.com>
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
[Hagar: Modified to apply on v6.6]
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
---
 io_uring/io_uring.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 484c9bcbee77..70dd6a5b9647 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -4358,8 +4358,10 @@ static __cold int io_register_iowq_max_workers(struct io_ring_ctx *ctx,
 	}
 
 	if (sqd) {
+		mutex_unlock(&ctx->uring_lock);
 		mutex_unlock(&sqd->lock);
 		io_put_sq_data(sqd);
+		mutex_lock(&ctx->uring_lock);
 	}
 
 	if (copy_to_user(arg, new_count, sizeof(new_count)))
@@ -4384,8 +4386,11 @@ static __cold int io_register_iowq_max_workers(struct io_ring_ctx *ctx,
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


