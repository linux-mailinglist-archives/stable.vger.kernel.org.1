Return-Path: <stable+bounces-92224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C819C529A
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEC89B26A9E
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 09:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7AA20DD78;
	Tue, 12 Nov 2024 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UHMWgGAK"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2BA1AAE06
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404221; cv=none; b=DRWpWfxEhw5vWTM6sjNx4D5qunExdCT/SNd9PfaiEqFBynj5VZqR8ZsNZ3rR1fWMrMwCgp1vZ9EnQzTK0KZHnRBwFPgLX2Vzl54XxgCFDbpL4FTY76XQ9D7knKjrXHOOkb0qLJOG7mShhR+KGWIZ5dpL6yfNr8wY8wGwnq+nNX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404221; c=relaxed/simple;
	bh=ZirD2o+EJXQAC2ksTSN6gD3A64U3kcldn5ThTjC+T20=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z+TgF9LTKJewG09tUtaBfeQmKEZKQe+j0OosCMtI7gCnzy5iZfOvO0YlxmWT6lIKAARdXgeLrxRyAE7gnCgOIMMF7BxCMwAy7qf3LTl8h9A35aV92Cot/mqoKvT2L1Pc3HgtdYhbOgKYO1lvOmltB04mncLKzHqUqmHtgcwHjRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UHMWgGAK; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731404220; x=1762940220;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TITFaZOUOb9OmX8WSSXkmylCpMEuOe9AT4h680Vqef8=;
  b=UHMWgGAKE3xkLyDPtF0oMWnkijwS7TWV0J/niHiPZ5qKqUxty+yCUR7X
   h5XKBA6p34FtKN+LEm0UKl4ClNPavcko+Y0/HbWulzihP06VDudl1Flnp
   /8abQBo1VTVgAMLIZR9YyqrJ3wJ9NNFwLrt9kDmpiCMlsAx0g5ATVzZk4
   g=;
X-IronPort-AV: E=Sophos;i="6.12,147,1728950400"; 
   d="scan'208";a="673250461"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 09:36:37 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:14651]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.5.109:2525] with esmtp (Farcaster)
 id 4c26cf57-edf6-4644-ad5e-cf2d10f481d4; Tue, 12 Nov 2024 09:36:35 +0000 (UTC)
X-Farcaster-Flow-ID: 4c26cf57-edf6-4644-ad5e-cf2d10f481d4
Received: from EX19D008EUA004.ant.amazon.com (10.252.50.158) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 12 Nov 2024 09:36:35 +0000
Received: from EX19MTAUWB002.ant.amazon.com (10.250.64.231) by
 EX19D008EUA004.ant.amazon.com (10.252.50.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 12 Nov 2024 09:36:34 +0000
Received: from email-imr-corp-prod-iad-all-1a-47ca2651.us-east-1.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Tue, 12 Nov 2024 09:36:34 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com [10.253.65.58])
	by email-imr-corp-prod-iad-all-1a-47ca2651.us-east-1.amazon.com (Postfix) with ESMTP id D914040411;
	Tue, 12 Nov 2024 09:36:33 +0000 (UTC)
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 9440720D8F; Tue, 12 Nov 2024 09:36:33 +0000 (UTC)
From: Hagar Hemdan <hagarhem@amazon.com>
To:
CC: <stable@vger.kernel.org>, Hagar Hemdan <hagarhem@amazon.com>, "Maximilian
 Heyne" <mheyne@amazon.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.10] io_uring: fix possible deadlock in io_register_iowq_max_workers()
Date: Tue, 12 Nov 2024 09:36:31 +0000
Message-ID: <20241112093631.6864-1-hagarhem@amazon.com>
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
[Hagar: Modified to apply on v5.10]
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


