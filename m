Return-Path: <stable+bounces-167310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A15B22FA3
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D7E188A6A1
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DAE2FDC3D;
	Tue, 12 Aug 2025 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sj9AWGCV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4266D268C73;
	Tue, 12 Aug 2025 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020383; cv=none; b=Q01PeLfoNJ87ZsSzxgJO1bDe9K20F5Zusug9sGYRHmzZYGkyOORSrimcduqSYqW0IxVroFPBdMjaU71f4jKWWp3WnD0a7JaMnEX+mQ2itSW9AvPoK9ahX20flr/ypiI39ed8316l3Zorcc3ahLYm4V7XXV1ups5BiwMH/hpPt4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020383; c=relaxed/simple;
	bh=0GccDuBkTVuIZeBAcGdRB/P2P2pouwiRx+SXsIwULLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0so1SNsKoMG9Y7STw6bGb1LUCyZTUMoBR4M785ji5ZGkoadeIkb70xZU3EzvIJ20biWMgzAQkhTGH7e/2xSng+FSRqv4fZTAC/xCyxjYl+00rXI39YlRVMuFSmnZuxUYB3qlVi+fRZBGYQXi6SVF1gETa9MbjZ+7lnsWocUIv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sj9AWGCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D627C4CEF0;
	Tue, 12 Aug 2025 17:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755020382;
	bh=0GccDuBkTVuIZeBAcGdRB/P2P2pouwiRx+SXsIwULLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sj9AWGCVz7pAoHHQtuLQH03oWevBEV62LqJeYf7Kg6p/Lmhc3G6fRjGzcwSJZbj4g
	 V7TQlrBschQVgzFJFd/kl7jFlBbXTDw8xGlUe9KLBcJWTHCWa8RTdk8+0DmLPRpkmK
	 G70UECaLmQgVwhsyLXNoPRCEZcGN/Kziqf42jH44=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 065/253] ublk: use vmalloc for ublk_devices __queues
Date: Tue, 12 Aug 2025 19:27:33 +0200
Message-ID: <20250812172951.499104393@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
References: <20250812172948.675299901@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Caleb Sander Mateos <csander@purestorage.com>

[ Upstream commit c2f48453b7806d41f5a3270f206a5cd5640ed207 ]

struct ublk_device's __queues points to an allocation with up to
UBLK_MAX_NR_QUEUES (4096) queues, each of which have:
- struct ublk_queue (48 bytes)
- Tail array of up to UBLK_MAX_QUEUE_DEPTH (4096) struct ublk_io's,
  32 bytes each
This means the full allocation can exceed 512 MB, which may well be
impossible to service with contiguous physical pages. Switch to
kvcalloc() and kvfree(), since there is no need for physically
contiguous memory.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20250620151008.3976463-2-csander@purestorage.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/ublk_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f2a99e5d304d..3a7c42f76d89 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1391,7 +1391,7 @@ static void ublk_deinit_queues(struct ublk_device *ub)
 
 	for (i = 0; i < nr_queues; i++)
 		ublk_deinit_queue(ub, i);
-	kfree(ub->__queues);
+	kvfree(ub->__queues);
 }
 
 static int ublk_init_queues(struct ublk_device *ub)
@@ -1402,7 +1402,7 @@ static int ublk_init_queues(struct ublk_device *ub)
 	int i, ret = -ENOMEM;
 
 	ub->queue_size = ubq_size;
-	ub->__queues = kcalloc(nr_queues, ubq_size, GFP_KERNEL);
+	ub->__queues = kvcalloc(nr_queues, ubq_size, GFP_KERNEL);
 	if (!ub->__queues)
 		return ret;
 
-- 
2.39.5




