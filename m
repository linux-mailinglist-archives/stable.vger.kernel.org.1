Return-Path: <stable+bounces-4078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BB08045E7
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C540282B75
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE25A6FAF;
	Tue,  5 Dec 2023 03:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cLtLcwq5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7069B611E;
	Tue,  5 Dec 2023 03:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC598C433C8;
	Tue,  5 Dec 2023 03:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746561;
	bh=Yr12GtE8xkSbq8noYz6mWJoAa7idNC3wfZHYY0dAzwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cLtLcwq51sShDsPurePQxtpGww3OmXn51E4B0j5WesX/xWei6GYiLD3k00JtK/LgQ
	 uhcxgsRijbd+s/FNuNpISXqGVyLjUfkuBq9TCnG1uR3zpmlAQxYpe+xvZHAXT9PO+z
	 LpPiiAUUrE/SkszNgkwNe1JYDBRtFr38HQOYi0gc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.6 071/134] io_uring: enable io_mem_alloc/free to be used in other parts
Date: Tue,  5 Dec 2023 12:15:43 +0900
Message-ID: <20231205031540.008875217@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
References: <20231205031535.163661217@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit edecf1689768452ba1a64b7aaf3a47a817da651a upstream.

In preparation for using these helpers, make them non-static and add
them to our internal header.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |    4 ++--
 io_uring/io_uring.h |    3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2659,7 +2659,7 @@ static int io_cqring_wait(struct io_ring
 	return READ_ONCE(rings->cq.head) == READ_ONCE(rings->cq.tail) ? ret : 0;
 }
 
-static void io_mem_free(void *ptr)
+void io_mem_free(void *ptr)
 {
 	if (!ptr)
 		return;
@@ -2771,7 +2771,7 @@ static void io_rings_free(struct io_ring
 	}
 }
 
-static void *io_mem_alloc(size_t size)
+void *io_mem_alloc(size_t size)
 {
 	gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_ZERO | __GFP_NOWARN | __GFP_COMP;
 	void *ret;
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -86,6 +86,9 @@ bool __io_alloc_req_refill(struct io_rin
 bool io_match_task_safe(struct io_kiocb *head, struct task_struct *task,
 			bool cancel_all);
 
+void *io_mem_alloc(size_t size);
+void io_mem_free(void *ptr);
+
 #if defined(CONFIG_PROVE_LOCKING)
 static inline void io_lockdep_assert_cq_locked(struct io_ring_ctx *ctx)
 {



