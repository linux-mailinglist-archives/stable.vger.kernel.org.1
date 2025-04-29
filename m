Return-Path: <stable+bounces-137414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4743AAA133A
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC784A0971
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEF423F413;
	Tue, 29 Apr 2025 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gHQv7AWX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE3424A047;
	Tue, 29 Apr 2025 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945996; cv=none; b=SL7yPkOWrxsZab/QuVi05Ekekqn2LIdGVM3zM7p4SSPPX/8zAdXLumSMdXsCL50TZuQGJ5B7vXSv7v9EqElLF7XXnkpUvXC5XbuJ3ao9bOK6mo7OfNKnAKQVakvZM47vXpZafrkoJKrRtcHQawehEuKzDF890AsZw2rK+hq33/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945996; c=relaxed/simple;
	bh=7tokVgwYApARNbfAynqbXIGa8m1Lf517gz0sh808bpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5CWbjaTTxH5RmtkpCwWDvqecKnfKoIyZMKJmjiauJyV9+2RCrqWlGbT1CaW2u4P4epzK7BpMjmX8ofbU62XTTBBcRh4qw8dfXQ6jOjcgVJ4PMa5cd9w7hw7NrBsyobffY//cB50snt01yOOJ3UV1ytldmA1EeEnLxgOwQje4KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gHQv7AWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3099C4CEE3;
	Tue, 29 Apr 2025 16:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745945996;
	bh=7tokVgwYApARNbfAynqbXIGa8m1Lf517gz0sh808bpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gHQv7AWX7Sk2W91UW9xu/U2IqlMX/a+8mpQul1tj5wEqi00VKVGP9j8u0/Qg2hI2I
	 F12fkKPesJyz/pyNOi11ytASHMXXZx1i1BWQQr6pbDyTHGZeYN1MJx+LpgdrORH08+
	 HvJAUQXQakpluCXqp9ZaQIAWjOJCgGXkZXdUWVVA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 089/311] ublk: comment on ubq->canceling handling in ublk_queue_rq()
Date: Tue, 29 Apr 2025 18:38:46 +0200
Message-ID: <20250429161124.692198974@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
References: <20250429161121.011111832@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 7e2fe01a69f6be3e284b38cfd2e4e0598a3b0a8f ]

In ublk_queue_rq(), ubq->canceling has to be handled after ->fail_io and
->force_abort are dealt with, otherwise the request may not be failed
when deleting disk.

Add comment on this usage.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20250327095123.179113-3-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: d6aa0c178bf8 ("ublk: call ublk_dispatch_req() for handling UBLK_U_IO_NEED_GET_DATA")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/ublk_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f615b9bd82f5f..fbc397efff175 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1314,6 +1314,11 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ublk_nosrv_should_queue_io(ubq) && unlikely(ubq->force_abort))
 		return BLK_STS_IOERR;
 
+	/*
+	 * ->canceling has to be handled after ->force_abort and ->fail_io
+	 * is dealt with, otherwise this request may not be failed in case
+	 * of recovery, and cause hang when deleting disk
+	 */
 	if (unlikely(ubq->canceling)) {
 		__ublk_abort_rq(ubq, rq);
 		return BLK_STS_OK;
-- 
2.39.5




