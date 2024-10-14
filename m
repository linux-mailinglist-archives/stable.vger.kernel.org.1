Return-Path: <stable+bounces-84300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3711399CF7B
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D186A1F231A5
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EE91ADFF1;
	Mon, 14 Oct 2024 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bhfiQyqu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08801A76A5;
	Mon, 14 Oct 2024 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917537; cv=none; b=U9CCoaBA6+5D3u+oteJgRr0FJAVwX3RMN6r9H2pP5OAL3g1gEc84X5TXR9aURcKSOutHNMjp1VqmeTESkiycN4d1jGgmFCYzJfV7agniKmNotaE3N8+YmdGNv1C5KqnlcwKeWF3ttHVfv7DOk+xoP++/oZE7Pkp+DbZv9uQW+mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917537; c=relaxed/simple;
	bh=XWPrMZgVwbQwsU8/8iepyUbjJG6LjUxCUjSEZWnCrsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmlNrOnsRKSk0+wJ++4vobrew/XpdEfdQR+HDLBf3qAZEvQeXXs1SwV1/X/766g/AJFHZ9WXX3MyGY4fVp9rfxQ0IHfItZzyU4596SofzcP+w6KLh7FYB+SdVk5RH2XrH5ax9Gr0vkezuyEGeGjR3PC+/u1BcsrAF0LEEbPHwSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bhfiQyqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54E9C4CEC3;
	Mon, 14 Oct 2024 14:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728917537;
	bh=XWPrMZgVwbQwsU8/8iepyUbjJG6LjUxCUjSEZWnCrsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bhfiQyquvbdFeavuhcy0Dvuwfb1Q6+Eq84YBx5+d15Muu6lZApq0scuEF07ybeHZe
	 OSJmla0jF1pvFkPpuDE+S2lIVtRTR9XjUyj8gPknIsU9GkHQvTExDK8siZ2HE0blR/
	 kGdECpWQFzcnQRyY0n+00C8ztuUOaqoiedUM6X4k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josef Bacik <josef@toxicpanda.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 062/798] nbd: fix race between timeout and normal completion
Date: Mon, 14 Oct 2024 16:10:16 +0200
Message-ID: <20241014141220.377327466@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit c9ea57c91f03bcad415e1a20113bdb2077bcf990 ]

If request timetout is handled by nbd_requeue_cmd(), normal completion
has to be stopped for avoiding to complete this requeued request, other
use-after-free can be triggered.

Fix the race by clearing NBD_CMD_INFLIGHT in nbd_requeue_cmd(), meantime
make sure that cmd->lock is grabbed for clearing the flag and the
requeue.

Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Yu Kuai <yukuai3@huawei.com>
Fixes: 2895f1831e91 ("nbd: don't clear 'NBD_CMD_INFLIGHT' flag if request is not completed")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20240830034145.1827742-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5c4be8dda253c..1f3cd5de41172 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -181,6 +181,17 @@ static void nbd_requeue_cmd(struct nbd_cmd *cmd)
 {
 	struct request *req = blk_mq_rq_from_pdu(cmd);
 
+	lockdep_assert_held(&cmd->lock);
+
+	/*
+	 * Clear INFLIGHT flag so that this cmd won't be completed in
+	 * normal completion path
+	 *
+	 * INFLIGHT flag will be set when the cmd is queued to nbd next
+	 * time.
+	 */
+	__clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
+
 	if (!test_and_set_bit(NBD_CMD_REQUEUED, &cmd->flags))
 		blk_mq_requeue_request(req, true);
 }
@@ -445,8 +456,8 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req)
 					nbd_mark_nsock_dead(nbd, nsock, 1);
 				mutex_unlock(&nsock->tx_lock);
 			}
-			mutex_unlock(&cmd->lock);
 			nbd_requeue_cmd(cmd);
+			mutex_unlock(&cmd->lock);
 			nbd_config_put(nbd);
 			return BLK_EH_DONE;
 		}
-- 
2.43.0




