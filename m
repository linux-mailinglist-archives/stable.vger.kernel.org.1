Return-Path: <stable+bounces-155085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2B5AE1900
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 12:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABB01BC1285
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666C528137A;
	Fri, 20 Jun 2025 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IS06Hafd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EC8101EE
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 10:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415662; cv=none; b=A55eUSsWDpkUYae4i8pyriCkLGFxdES49qGPvU7X4+qTavkoBi9yO9GKmxWJjZuQTHcBEpwZjaY5xfQ4GmrG1TWlqGKWhjqDvmd4GiirUHv2WQ/rVQE5tcaJiF7sLmV9l3FDzmDScMdQcIIUN96HT6a56ibZGl9MdJ9FCZS8Jfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415662; c=relaxed/simple;
	bh=kTTyXtIfplM1okkGBDl1GPe/LxSWa9+OMyQwN5dPMXQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cWubGh4CvpCzeyFcno0hDN/UUef/ENqsVgpRc9JrPdNU2z8EmVUrb/62A9idsZs6GZVZroCXVrS75VbC2jWvPHwY0Gk6ruyb2ERhajukPWjjRZsfcYx4dgiEjd/zn3HnBNtWPenlpXO8IS3Z9FQjKhesk05RJAkLkgunQpSQ3Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IS06Hafd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284C4C4CEE3;
	Fri, 20 Jun 2025 10:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750415661;
	bh=kTTyXtIfplM1okkGBDl1GPe/LxSWa9+OMyQwN5dPMXQ=;
	h=Subject:To:Cc:From:Date:From;
	b=IS06HafdZqJapRl9Lb2Oq1bQSKr0nZ6+EI+jI8xkAgYgFa/Fq5hf6VZw6U9+rkeua
	 tBXdsJ6SvQIHztg+3LsNvRz/2PEfX0gIBtRP3ITftY6czHvIBlCXFmkslCW0Kmw2w+
	 B4DbHaxRgeI9052cluh4bBHjHxVHDrUfKZKC94qs=
Subject: FAILED: patch "[PATCH] io_uring/zcrx: fix area release on registration failure" failed to apply to 6.15-stable tree
To: asml.silence@gmail.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 12:34:18 +0200
Message-ID: <2025062018-ahead-armory-59ac@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0ec33c81d9c7342f03864101ddb2e717a0cce03e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062018-ahead-armory-59ac@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0ec33c81d9c7342f03864101ddb2e717a0cce03e Mon Sep 17 00:00:00 2001
From: Pavel Begunkov <asml.silence@gmail.com>
Date: Tue, 27 May 2025 18:07:33 +0100
Subject: [PATCH] io_uring/zcrx: fix area release on registration failure

On area registration failure there might be no ifq set and it's not safe
to access area->ifq in the release path without checking it first.

Cc: stable@vger.kernel.org
Fixes: f12ecf5e1c5ec ("io_uring/zcrx: fix late dma unmap for a dead dev")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/bc02878678a5fec28bc77d33355cdba735418484.1748365640.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 0c5b7d8f8d67..21c816c3bfe0 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -366,7 +366,8 @@ static void io_free_rbuf_ring(struct io_zcrx_ifq *ifq)
 
 static void io_zcrx_free_area(struct io_zcrx_area *area)
 {
-	io_zcrx_unmap_area(area->ifq, area);
+	if (area->ifq)
+		io_zcrx_unmap_area(area->ifq, area);
 	io_release_area_mem(&area->mem);
 
 	kvfree(area->freelist);


