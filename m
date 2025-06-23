Return-Path: <stable+bounces-157178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F1EAE52C5
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F8A4A6CD5
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C91B1AAA1C;
	Mon, 23 Jun 2025 21:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KTmBRXkZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D964414;
	Mon, 23 Jun 2025 21:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715228; cv=none; b=ivbYT6rrnEcFRLU2Kk++2i6+MOo0peRux2JHMIJRKI3DD5Si60Emgkhd1Ms7uG2hHhTMaIz/prDZu3UuGFqgpgjZSXb01zcLMmCe4V6/jz2RHL/N8Vz4aJS9h+c4bDqr+Du0e6nVNbw8vUlRG5n1LPWT52R3zuPfRFezCquBFYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715228; c=relaxed/simple;
	bh=XI5PfZtWYeLU2rpVoRQnIxODHMBRJCk/FE5r5ZDBRa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JiyvZZ4rKstGmIM7aRkFyVhO2w8qvROn4kc9kvCD9P9mu+EOKwTBqOyA4kF0J2HlZHKdK/wq27kaFc2gvJwgHBRDPrEXHfd+PGj5nrhmU/q3veWUquSDHTWj+bMz/Vggka2y4ElsTwlrKGfg0BE1UI20KOL2/1MhzLyfGzOXacQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KTmBRXkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93996C4CEEA;
	Mon, 23 Jun 2025 21:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750715227;
	bh=XI5PfZtWYeLU2rpVoRQnIxODHMBRJCk/FE5r5ZDBRa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KTmBRXkZLSQtBvCheOp3dME1xMXc3ZjVVt5zkCDGsDKBt864HhjoCpZiCLThtFYo9
	 icwvX0dfNh3GytJvKks3N8pS5XlN6oQMEznl37+wJyS23MqUb6CkmvnBFWwOVN5WLZ
	 rCbrKpcUC0W3IkxC1mY9k3dtuxwBhr2ZA7dQTcrE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Penglei Jiang <superman.xpt@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.6 207/290] io_uring: fix task leak issue in io_wq_create()
Date: Mon, 23 Jun 2025 15:07:48 +0200
Message-ID: <20250623130633.151703208@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.910356556@linuxfoundation.org>
References: <20250623130626.910356556@linuxfoundation.org>
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

From: Penglei Jiang <superman.xpt@gmail.com>

commit 89465d923bda180299e69ee2800aab84ad0ba689 upstream.

Add missing put_task_struct() in the error path

Cc: stable@vger.kernel.org
Fixes: 0f8baa3c9802 ("io-wq: fully initialize wqe before calling cpuhp_state_add_instance_nocalls()")
Signed-off-by: Penglei Jiang <superman.xpt@gmail.com>
Link: https://lore.kernel.org/r/20250615163906.2367-1-superman.xpt@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io-wq.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -1206,8 +1206,10 @@ struct io_wq *io_wq_create(unsigned boun
 	atomic_set(&wq->worker_refs, 1);
 	init_completion(&wq->worker_done);
 	ret = cpuhp_state_add_instance_nocalls(io_wq_online, &wq->cpuhp_node);
-	if (ret)
+	if (ret) {
+		put_task_struct(wq->task);
 		goto err;
+	}
 
 	return wq;
 err:



