Return-Path: <stable+bounces-149475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78098ACB31C
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A44D19458EB
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAAB239E73;
	Mon,  2 Jun 2025 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dA8gSodR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD651E0DD8;
	Mon,  2 Jun 2025 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874073; cv=none; b=DEIZt7Yg6d1Lwd+/qy/tAi3cs4G/Y+0SpF4Vw/tn654Ths+zspxLY4Ef9DLlFhPEwy15VJnVO0KZGAKJE4+u4YdK0fTulRFRW7VvI1hasV/dl7hWTUkwDRT4h1CS0QEEaUGqc/Fa3rFEUfSvDI2z7xSRHJ++T037ty22pr2sjzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874073; c=relaxed/simple;
	bh=t3HM6bWE2Zn1UaHD8oMIOjbzEee1qC8UNa5tRxH8uyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLldJTuKlyb7uhXSv13U8VWiq55wwaeHYCYf8JI5ni87sL/MmtNaBEY3XfLv7HPFq/FDefEYnm5PyV5lO2PjS2CcIEEQIosy+Kx26mu1aZOZ3agdK2u7ZVDALDZVtZr8RBvpjW0xi+xmnHvYX8A7DBS3gKng/KU1yOFSBAknjPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dA8gSodR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CFBC4CEF0;
	Mon,  2 Jun 2025 14:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748874073;
	bh=t3HM6bWE2Zn1UaHD8oMIOjbzEee1qC8UNa5tRxH8uyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dA8gSodRe+H489PSO63T8Wkc1rztHz8Jjl5JTzQl5HtA497yq9x3tB2qMCuH782Tf
	 vWp9OucocDuNmcdGp3gM6M4CcVtmBnoEWqjFD+KRQHreZ4yCQy/dwm2QRamMCVCkpy
	 C6u/ZP7WvsqDmrzbyldKIAPyfRNxvB2+U4xQIfnw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 349/444] io_uring: fix overflow resched cqe reordering
Date: Mon,  2 Jun 2025 15:46:53 +0200
Message-ID: <20250602134355.099528638@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
References: <20250602134340.906731340@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Begunkov <asml.silence@gmail.com>

[ Upstream commit a7d755ed9ce9738af3db602eb29d32774a180bc7 ]

Leaving the CQ critical section in the middle of a overflow flushing
can cause cqe reordering since the cache cq pointers are reset and any
new cqe emitters that might get called in between are not going to be
forced into io_cqe_cache_refill().

Fixes: eac2ca2d682f9 ("io_uring: check if we need to reschedule during overflow flush")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/90ba817f1a458f091f355f407de1c911d2b93bbf.1747483784.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/io_uring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index db592fa549b73..43b46098279a1 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -701,6 +701,7 @@ static void __io_cqring_overflow_flush(struct io_ring_ctx *ctx)
 		 * to care for a non-real case.
 		 */
 		if (need_resched()) {
+			ctx->cqe_sentinel = ctx->cqe_cached;
 			io_cq_unlock_post(ctx);
 			mutex_unlock(&ctx->uring_lock);
 			cond_resched();
-- 
2.39.5




