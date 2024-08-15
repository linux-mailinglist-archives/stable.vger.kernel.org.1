Return-Path: <stable+bounces-68181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D12F2953100
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4B61C20314
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4085114AD0A;
	Thu, 15 Aug 2024 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EftYF0mQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22C519E7F6;
	Thu, 15 Aug 2024 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729750; cv=none; b=QYkJLXpWXrY2Bbo1aFV+qTycrt9yJ5/ZFey092qRKczjeys1vHqL0B5lYNy26ROwPQ5UQT+fqaOU7a3svtGr0Q0QvdbyT/dXXa2J1frN3HmLmJ+UckwScz/VYfaP1eVpW/qQnZytnQ5YYyoYbo1v/JViHeiSECgwUjYypcVWZhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729750; c=relaxed/simple;
	bh=aVpoIqL53eqHeIijD+lDBWN8l1Qq8FQ/m9u1U12dSJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hn/1QeMDWRBxDmJBjdaTPJjSzIAAjj4LchtGQW6Nfu3gaW2OjzbZfXgCh8Fgnw+JUdAtbr/SC170sRek7dbW8V+OvDGECmCOJHtnIyPO+H2pVYTg2O1KAMiWfMSpw8aJXJn1Db61WsFEDP5hYZ+Kk/I9X67cShkSiKpWRsCOw7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EftYF0mQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F12C32786;
	Thu, 15 Aug 2024 13:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723729749;
	bh=aVpoIqL53eqHeIijD+lDBWN8l1Qq8FQ/m9u1U12dSJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EftYF0mQOg1FztBoJ/Af5rfto4QFOOz7GqTpyo0MtWpET69SzMQlhMqWSFx3NMVku
	 UFPFfMYAUEzO/DWMTc8zWQPcxj7+A3o8LndEQL1/ehinzDLrNg651EHT/HJUq4zKhP
	 x21obQnmU6YgmyY6on4vjgy1gJi+SoUOKXjQGlk4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15 194/484] io_uring: tighten task exit cancellations
Date: Thu, 15 Aug 2024 15:20:52 +0200
Message-ID: <20240815131948.908251359@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
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

From: Pavel Begunkov <asml.silence@gmail.com>

commit f8b632e89a101dae349a7b212c1771d7925f441b upstream.

io_uring_cancel_generic() should retry if any state changes like a
request is completed, however in case of a task exit it only goes for
another loop and avoids schedule() if any tracked (i.e. REQ_F_INFLIGHT)
request got completed.

Let's assume we have a non-tracked request executing in iowq and a
tracked request linked to it. Let's also assume
io_uring_cancel_generic() fails to find and cancel the request, i.e.
via io_run_local_work(), which may happen as io-wq has gaps.
Next, the request logically completes, io-wq still hold a ref but queues
it for completion via tw, which happens in
io_uring_try_cancel_requests(). After, right before prepare_to_wait()
io-wq puts the request, grabs the linked one and tries executes it, e.g.
arms polling. Finally the cancellation loop calls prepare_to_wait(),
there are no tw to run, no tracked request was completed, so the
tctx_inflight() check passes and the task is put to indefinite sleep.

Cc: stable@vger.kernel.org
Fixes: 3f48cf18f886c ("io_uring: unify files and task cancel")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/acac7311f4e02ce3c43293f8f1fda9c705d158f1.1721819383.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -9856,8 +9856,11 @@ static void io_uring_cancel_generic(bool
 	atomic_inc(&tctx->in_idle);
 	do {
 		io_uring_drop_tctx_refs(current);
+		if (!tctx_inflight(tctx, !cancel_all))
+			break;
+
 		/* read completions before cancelations */
-		inflight = tctx_inflight(tctx, !cancel_all);
+		inflight = tctx_inflight(tctx, false);
 		if (!inflight)
 			break;
 



