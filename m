Return-Path: <stable+bounces-92221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5559C51D8
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE19CB299D8
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 09:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92FA20D502;
	Tue, 12 Nov 2024 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="I2nZFdPr"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCEC20D4FC
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731402694; cv=none; b=TrH0vEleNNv2j7dJpA3dcrBNAK0i9g1X2ZouMSO2cYoRgCwsheXHSXQhu9pmu3uK3EZjIgcYhbMkIvUcN1wT/+wVrExVE60mSS7KVjYfd62gs6KqdRmMXBaezKcvlZCNoln55lOrBbqq8uWceUGVvT9+B0kvNdWx+2DNgRYVoAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731402694; c=relaxed/simple;
	bh=W8m+6fSpXeQFs3UIIt6qtKjibam6UMZnexl27U5QBRU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H2UhEYNa09UDQN/L5TlRdbI9tHqxozGU9q2fQw8Nc01DM/8fe2d8KcqsDTd9t0ifu7AXjNlzeygSpvITbUE17kIsc57CvQOOEGn/fL6OP6PBoZNig1I/HVEM/am+BeOKr7j+Mr5wN+M3wC+jXCK3w/feT3jl9jQRy46vn8FKNek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=I2nZFdPr; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731402693; x=1762938693;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C1NtDIscJ0EAhxy8jVMvSyWUgTzy+StQK+oE3RmQVcc=;
  b=I2nZFdPr8qj4N9AnQgyNuPr7OVJfUiUP4oaADA8t5OtOpreVLJjVqbDP
   sgUhutvIFwGt9Ticf4KviQLbf4v4HGxQIvh0f3pCIISs3lAwuZyBIwhcv
   3URngrn0WjlHyeDDIeAMHH818PbndMhhaPkFI9smFYEQdV8OBE29QFJ+E
   Y=;
X-IronPort-AV: E=Sophos;i="6.12,147,1728950400"; 
   d="scan'208";a="146573246"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 09:11:32 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:11768]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.32.210:2525] with esmtp (Farcaster)
 id f570f716-cc1c-4220-ab7e-c33925370abf; Tue, 12 Nov 2024 09:11:31 +0000 (UTC)
X-Farcaster-Flow-ID: f570f716-cc1c-4220-ab7e-c33925370abf
Received: from EX19D008EUA003.ant.amazon.com (10.252.50.155) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 12 Nov 2024 09:11:29 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D008EUA003.ant.amazon.com (10.252.50.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 12 Nov 2024 09:11:29 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-ecca39fb.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Tue, 12 Nov 2024 09:11:28 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com [10.253.65.58])
	by email-imr-corp-prod-pdx-1box-2b-ecca39fb.us-west-2.amazon.com (Postfix) with ESMTP id CC0B0804BC;
	Tue, 12 Nov 2024 09:11:28 +0000 (UTC)
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 62E4F224AB; Tue, 12 Nov 2024 09:11:28 +0000 (UTC)
From: Hagar Hemdan <hagarhem@amazon.com>
To:
CC: <stable@vger.kernel.org>, Hagar Hemdan <hagarhem@amazon.com>, "Maximilian
 Heyne" <mheyne@amazon.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15] io_uring: fix possible deadlock in io_register_iowq_max_workers()
Date: Tue, 12 Nov 2024 09:11:24 +0000
Message-ID: <20241112091124.13816-1-hagarhem@amazon.com>
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
[Hagar: Modified to apply on v5.15]
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
---
 io_uring/io_uring.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index f1ab0cd98727..3dbc704c7001 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -10818,8 +10818,10 @@ static int io_register_iowq_max_workers(struct io_ring_ctx *ctx,
 	}
 
 	if (sqd) {
+		mutex_unlock(&ctx->uring_lock);
 		mutex_unlock(&sqd->lock);
 		io_put_sq_data(sqd);
+		mutex_lock(&ctx->uring_lock);
 	}
 
 	if (copy_to_user(arg, new_count, sizeof(new_count)))
@@ -10844,8 +10846,11 @@ static int io_register_iowq_max_workers(struct io_ring_ctx *ctx,
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


