Return-Path: <stable+bounces-14356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BA2838090
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9998D1C296BC
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7C912FF7F;
	Tue, 23 Jan 2024 01:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KYnEyJ3/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB97812FF73;
	Tue, 23 Jan 2024 01:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971798; cv=none; b=cpDRJc4Su8jh98tz+SBd6d5IveHXszOdUZWeCgPShzGbn3w15KO1GGKM7EDdgkGxNSuiR6TAG1CIhh8+VZgV1ro4sD4igpVEqMQsmpwINeEKO2P2sfLe5feE6zxwfNV7LhSog9FqqQvuAJ4fsYp3JsyjF18EOWS6Qf7VV9WYSIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971798; c=relaxed/simple;
	bh=8vXtOfw4CQlwIwKxrLHPJh+IqYg561vnkN0oHEcN1N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aq7RL3jjQBFMfZzHIJ0LMef74KL0krwSZ6PqLXizGhd+QHLDKZyHUZptFYpxrGKkkxzMqDgzTnikRePRez5tyjjJ5+DP5PBwB51jGKuaHqsA19moR1mFXFjPNk+cKgvHC1KLS6ciXjSeQ+eZfq15bHvcOr+KsNn08nzrLSSoz9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KYnEyJ3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A69C433F1;
	Tue, 23 Jan 2024 01:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971797;
	bh=8vXtOfw4CQlwIwKxrLHPJh+IqYg561vnkN0oHEcN1N4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KYnEyJ3/4PS22K+wmyw1QjoXfL6D74/hnDPVX0GHmOtO5iJaEzMvNGCQizIvVtreJ
	 WCA4+6vzWvN6ePUcFORpN5d1xu+D6q0bxQgzqp5ZlRdt+AeyJPs1Ik8TJm0lwh+GPV
	 c4a5v8A1VC4gAbJj1/XwBDdRra9/XqSTGxVDn+pI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	xingwei lee <xrivendell7@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.10 224/286] io_uring/rw: ensure io->bytes_done is always initialized
Date: Mon, 22 Jan 2024 15:58:50 -0800
Message-ID: <20240122235740.705716800@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235732.009174833@linuxfoundation.org>
References: <20240122235732.009174833@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit 0a535eddbe0dc1de4386046ab849f08aeb2f8faf upstream.

If IOSQE_ASYNC is set and we fail importing an iovec for a readv or
writev request, then we leave ->bytes_done uninitialized and hence the
eventual failure CQE posted can potentially have a random res value
rather than the expected -EINVAL.

Setup ->bytes_done before potentially failing, so we have a consistent
value if we fail the request early.

Cc: stable@vger.kernel.org
Reported-by: xingwei lee <xrivendell7@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3485,14 +3485,17 @@ static inline int io_rw_prep_async(struc
 	struct iovec *iov = iorw->fast_iov;
 	int ret;
 
+	iorw->bytes_done = 0;
+	iorw->free_iovec = NULL;
+
 	ret = io_import_iovec(rw, req, &iov, &iorw->iter, false);
 	if (unlikely(ret < 0))
 		return ret;
 
-	iorw->bytes_done = 0;
-	iorw->free_iovec = iov;
-	if (iov)
+	if (iov) {
+		iorw->free_iovec = iov;
 		req->flags |= REQ_F_NEED_CLEANUP;
+	}
 	iov_iter_save_state(&iorw->iter, &iorw->iter_state);
 	return 0;
 }



