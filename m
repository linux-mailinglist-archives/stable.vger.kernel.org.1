Return-Path: <stable+bounces-44947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976118C5516
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34E14B2216E
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189045029A;
	Tue, 14 May 2024 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e8esQefd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA79948CCC;
	Tue, 14 May 2024 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687638; cv=none; b=Fen0XR1gRyQ0zzRpe1OEQDR4hEWbVIWGW3UGiuYTvxg0dgDAGm3ojwNw5lbQWfkdZabzboxQlLh7jKh2X2a//MLglLtvWxf1h16a+c9lXonDrKAeGijQRj9Cn7FCbFSBqM/3Jwi5rEdUkWDPQ18E5jn8pC816IOeyc2W1Tb+Jzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687638; c=relaxed/simple;
	bh=ns/cRTXp9EgeL3tGdEgZ2acR8cb8p9y18cFe/fOKwMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNLpPfFbelAeUtvA0Ou4wiiagxCmJey/YQqNo3Fqap5YN/r8chEL69mTHba80gKHoiaQ7wt+XOj7iPT2zqCt73HUnXEzj2fSqcLP3+BBqInY2xmQG7mqKJ3UU42EO7Aen03aBJrH015laD51jfT7+CtwOFxki595r0LNKwzWde4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e8esQefd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1C9C2BD10;
	Tue, 14 May 2024 11:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687638;
	bh=ns/cRTXp9EgeL3tGdEgZ2acR8cb8p9y18cFe/fOKwMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e8esQefdwFXxmSVM0OC4XlRsE9C0yLcHDoiebVJeC2xqu++xr0yyzW2oePNd1JcLl
	 cV1RHWC8hr9brV48kAZ2yWteaSx5/3zWmGLY0QidMcIWFZIgB6IzHGGoQq3SDdC1ej
	 TA1+oAG52oA6KMRMiWi9nIVz8KjJ0C01HD99r/9M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Julian Wiedmann <jwi@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 054/168] s390/qeth: dont keep track of Input Queue count
Date: Tue, 14 May 2024 12:19:12 +0200
Message-ID: <20240514101008.727930877@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101006.678521560@linuxfoundation.org>
References: <20240514101006.678521560@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit dc15012bb083c70502b625cf56fbf32b6cf17fe4 ]

The only actual user of qdio.no_input_queues is qeth_qdio_establish(),
and there we already have full awareness of the current Input Queue
configuration (1 RX queue, plus potentially 1 TX Completion queue).

So avoid this state tracking, and the ambiguity it brings with it.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 8a2e4d37afb8 ("s390/qeth: Fix kernel panic after setting hsuid")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_core.h      |  1 -
 drivers/s390/net/qeth_core_main.c | 17 +++++++----------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index e8c360879883b..71464e9ad4f82 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -545,7 +545,6 @@ static inline bool qeth_out_queue_is_empty(struct qeth_qdio_out_q *queue)
 struct qeth_qdio_info {
 	atomic_t state;
 	/* input */
-	int no_in_queues;
 	struct qeth_qdio_q *in_q;
 	struct qeth_qdio_q *c_q;
 	struct qeth_qdio_buffer_pool in_buf_pool;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index c1346c4e2242d..9b7f518395e16 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -354,8 +354,8 @@ static int qeth_cq_init(struct qeth_card *card)
 		qdio_reset_buffers(card->qdio.c_q->qdio_bufs,
 				   QDIO_MAX_BUFFERS_PER_Q);
 		card->qdio.c_q->next_buf_to_init = 127;
-		rc = do_QDIO(CARD_DDEV(card), QDIO_FLAG_SYNC_INPUT,
-			     card->qdio.no_in_queues - 1, 0, 127, NULL);
+		rc = do_QDIO(CARD_DDEV(card), QDIO_FLAG_SYNC_INPUT, 1, 0, 127,
+			     NULL);
 		if (rc) {
 			QETH_CARD_TEXT_(card, 2, "1err%d", rc);
 			goto out;
@@ -375,21 +375,16 @@ static int qeth_alloc_cq(struct qeth_card *card)
 			dev_err(&card->gdev->dev, "Failed to create completion queue\n");
 			return -ENOMEM;
 		}
-
-		card->qdio.no_in_queues = 2;
 	} else {
 		QETH_CARD_TEXT(card, 2, "nocq");
 		card->qdio.c_q = NULL;
-		card->qdio.no_in_queues = 1;
 	}
-	QETH_CARD_TEXT_(card, 2, "iqc%d", card->qdio.no_in_queues);
 	return 0;
 }
 
 static void qeth_free_cq(struct qeth_card *card)
 {
 	if (card->qdio.c_q) {
-		--card->qdio.no_in_queues;
 		qeth_free_qdio_queue(card->qdio.c_q);
 		card->qdio.c_q = NULL;
 	}
@@ -1492,7 +1487,6 @@ static void qeth_init_qdio_info(struct qeth_card *card)
 	card->qdio.default_out_queue = QETH_DEFAULT_QUEUE;
 
 	/* inbound */
-	card->qdio.no_in_queues = 1;
 	card->qdio.in_buf_size = QETH_IN_BUF_SIZE_DEFAULT;
 	if (IS_IQD(card))
 		card->qdio.init_pool.buf_count = QETH_IN_BUF_COUNT_HSDEFAULT;
@@ -5173,6 +5167,7 @@ static int qeth_qdio_establish(struct qeth_card *card)
 	struct qdio_buffer **in_sbal_ptrs[QETH_MAX_IN_QUEUES];
 	struct qeth_qib_parms *qib_parms = NULL;
 	struct qdio_initialize init_data;
+	unsigned int no_input_qs = 1;
 	unsigned int i;
 	int rc = 0;
 
@@ -5187,8 +5182,10 @@ static int qeth_qdio_establish(struct qeth_card *card)
 	}
 
 	in_sbal_ptrs[0] = card->qdio.in_q->qdio_bufs;
-	if (card->options.cq == QETH_CQ_ENABLED)
+	if (card->options.cq == QETH_CQ_ENABLED) {
 		in_sbal_ptrs[1] = card->qdio.c_q->qdio_bufs;
+		no_input_qs++;
+	}
 
 	for (i = 0; i < card->qdio.no_out_queues; i++)
 		out_sbal_ptrs[i] = card->qdio.out_qs[i]->qdio_bufs;
@@ -5198,7 +5195,7 @@ static int qeth_qdio_establish(struct qeth_card *card)
 							  QDIO_QETH_QFMT;
 	init_data.qib_param_field_format = 0;
 	init_data.qib_param_field	 = (void *)qib_parms;
-	init_data.no_input_qs            = card->qdio.no_in_queues;
+	init_data.no_input_qs		 = no_input_qs;
 	init_data.no_output_qs           = card->qdio.no_out_queues;
 	init_data.input_handler		 = qeth_qdio_input_handler;
 	init_data.output_handler	 = qeth_qdio_output_handler;
-- 
2.43.0




