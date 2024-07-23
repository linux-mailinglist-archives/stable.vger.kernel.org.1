Return-Path: <stable+bounces-61110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6D293A6EA
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 20:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4FA81F22D7C
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 18:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF50158A08;
	Tue, 23 Jul 2024 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WLgbvKZM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC97C15821E;
	Tue, 23 Jul 2024 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721760003; cv=none; b=NMOTD952G3kcOTedeCNIjtqS+uUysd13Lst6HgvnQ/KOkIXC4uVgiVnQBCuUMdQQ8QsowLtEUYDnaTD9i15ZioD0MaIdOvRscj4pAnjJxCedHbwxWh8pwoP4UNQ+n4DceBUWfql3nVMGMk/2RwcpQNC1XP8U28q4Uz6DpuO5TcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721760003; c=relaxed/simple;
	bh=um3+wd9CsmITOo1/uG4PMmwne/rmxfoU6T8kwoyg5+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cr8Q6ZxOjFZNy1tP5sbQ9CBpb3A90qWgW9Xw7zBQ3mhl4DjQnzM8Pv82pExxsJuEe7zyDzBwEycZNsVkDbfkWbWfYnZhqEOstexn8gXRHYQZ1+gkCgqeVm+iELi0e61xTZmhhmH+Qn3nl6Kz7ULpSLAc/hh68WpdCdjVLOPbuLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WLgbvKZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0F4C4AF0A;
	Tue, 23 Jul 2024 18:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721760003;
	bh=um3+wd9CsmITOo1/uG4PMmwne/rmxfoU6T8kwoyg5+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WLgbvKZMB66YcthTybHZ3hGQC+aHqrW3GtQz/pi3qO9pYLNXVuab0HJdk6Fw6rfJY
	 BR+DUh6jD4EqrmyRHQrb3HmfiDPL+zzVolr67u9BXKmGmxB7tOAk545JuUEupZDQ3e
	 QRxHtbgKUgKDhD1CaoZ7E9oYNC/BpQtW4C89sv04=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 039/163] null_blk: fix validation of block size
Date: Tue, 23 Jul 2024 20:22:48 +0200
Message-ID: <20240723180144.983666637@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723180143.461739294@linuxfoundation.org>
References: <20240723180143.461739294@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Hindborg <a.hindborg@samsung.com>

[ Upstream commit c462ecd659b5fce731f1d592285832fd6ad54053 ]

Block size should be between 512 and PAGE_SIZE and be a power of 2. The current
check does not validate this, so update the check.

Without this patch, null_blk would Oops due to a null pointer deref when
loaded with bs=1536 [1].

Link: https://lore.kernel.org/all/87wmn8mocd.fsf@metaspace.dk/

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20240603192645.977968-1-nmi@metaspace.dk
[axboe: remove unnecessary braces and != 0 check]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/null_blk/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 620679a0ac381..26e2c22a87e1c 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1810,8 +1810,8 @@ static int null_validate_conf(struct nullb_device *dev)
 		dev->queue_mode = NULL_Q_MQ;
 	}
 
-	dev->blocksize = round_down(dev->blocksize, 512);
-	dev->blocksize = clamp_t(unsigned int, dev->blocksize, 512, 4096);
+	if (blk_validate_block_size(dev->blocksize))
+		return -EINVAL;
 
 	if (dev->use_per_node_hctx) {
 		if (dev->submit_queues != nr_online_nodes)
-- 
2.43.0




