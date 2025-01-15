Return-Path: <stable+bounces-109077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D010A121B6
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21E697A12B5
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A0E1DB142;
	Wed, 15 Jan 2025 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eMtOUyBs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859C7248BB5;
	Wed, 15 Jan 2025 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938772; cv=none; b=MFtUTG7IflsArZxSdm21OEmYcmQnPQbQ1Zy+wjkBcO/bUxjth0fOtPJ5qdzlKAS73BwoTPI8AgSAmQeXu7lEtFsa3hTuRpz3mAmohabRF328YEpnS3kNAuX4/7aRjqrxOaaMqQ7PMZuJvpmFPVePt9OmnB3EhyNMK+JE+A88JTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938772; c=relaxed/simple;
	bh=C23+ACxZNYDw4+MtCa2Coa7OGbQcN3cK8sFtqH0yIFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hqhu8d0G/d1iZKdeAe3MuM7z4DRud+fhdzi+XO8sdL0FOdso6IFIEJd98UoNKFWOxuip3GJDJ15fq4GUlV5aiARXdQ0lqKdLFxrv0q5zMDj3IoPqe8Dh4ONSu/PmFxhe/ovcb2sYF7lCEHn54mXg5wBijBzwF3iflArKwPX12Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eMtOUyBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BED9C4CEE7;
	Wed, 15 Jan 2025 10:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736938772;
	bh=C23+ACxZNYDw4+MtCa2Coa7OGbQcN3cK8sFtqH0yIFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eMtOUyBshb8pK4oFGgZEIzkwPfcAg+hV9aT7E5VK5wfW9rvFEzEDb5ilCoTEh0Fqg
	 VjJ9UP/x/6sicioV2Qz6XSwl1n5bsNRM0IRW1gGIoyp6ML4BsGUfaW2dRQvFQkZ/4D
	 O0vu/0HaamAQhKyxCIVCeP6dhVmfkIGtC3vEsqgQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Mazakas <christian.mazakas@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.6 076/129] io_uring/timeout: fix multishot updates
Date: Wed, 15 Jan 2025 11:37:31 +0100
Message-ID: <20250115103557.403293909@linuxfoundation.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115103554.357917208@linuxfoundation.org>
References: <20250115103554.357917208@linuxfoundation.org>
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

commit c83c846231db8b153bfcb44d552d373c34f78245 upstream.

After update only the first shot of a multishot timeout request adheres
to the new timeout value while all subsequent retries continue to use
the old value. Don't forget to update the timeout stored in struct
io_timeout_data.

Cc: stable@vger.kernel.org
Fixes: ea97f6c8558e8 ("io_uring: add support for multishot timeouts")
Reported-by: Christian Mazakas <christian.mazakas@gmail.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/e6516c3304eb654ec234cfa65c88a9579861e597.1736015288.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/timeout.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -413,10 +413,12 @@ static int io_timeout_update(struct io_r
 
 	timeout->off = 0; /* noseq */
 	data = req->async_data;
+	data->ts = *ts;
+
 	list_add_tail(&timeout->list, &ctx->timeout_list);
 	hrtimer_init(&data->timer, io_timeout_get_clock(data), mode);
 	data->timer.function = io_timeout_fn;
-	hrtimer_start(&data->timer, timespec64_to_ktime(*ts), mode);
+	hrtimer_start(&data->timer, timespec64_to_ktime(data->ts), mode);
 	return 0;
 }
 



