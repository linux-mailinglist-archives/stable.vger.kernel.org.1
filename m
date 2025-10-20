Return-Path: <stable+bounces-187953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC09BEFC78
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 10:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87FDC4EF9F7
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 08:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914392C0F72;
	Mon, 20 Oct 2025 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s/wjycAJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9411E5714
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947242; cv=none; b=rCSGgh3cb5CFOjt0WEJURi+gwtOKc+XN+hXMubOynsUYiFBmlocg7Oc5wYZFjz+WvAu3KRSKhVaF7JcrXsAA9KQcoZRb2eMHGCxrXt44ccOCbEdCH1tFSPV2o6TsPMVzpv14KVhE9uC1OlizWw3xEt9ZZj+H22Psngqbj2xTN/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947242; c=relaxed/simple;
	bh=ONEryFghqwBSS7hol+dOW8gXU4re5KJpVxAQ0cMQWnA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=i33hZjAc5ArPXn1+DQG8IhncVyAz/a8CFjtjrs0qjIXkcKMky68kqDRHIXnDyqFyCAsonEHtXCp0ebiICqqn096PAQcur/j4S2IzdBluv0YlDiNm7zmAyL9qnCYYFwsnpfkd2REnjQRkFgk9YBWYu1RpVNO3w8O1toaM96dCuYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s/wjycAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C613AC113D0;
	Mon, 20 Oct 2025 08:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760947242;
	bh=ONEryFghqwBSS7hol+dOW8gXU4re5KJpVxAQ0cMQWnA=;
	h=Subject:To:Cc:From:Date:From;
	b=s/wjycAJaF3gDtWtYdN7x/CuYF9k+IwkhV5Fn57VHsUoKZJeeKIiSJ87TTMVnxRpX
	 NdxMzpZyzrR27nZNBafVOVCwlgjelP3w7ql5ASlFLQatirPxUsmbv2EQmKtU1qVPyc
	 kNYejD/mJorJBnjL5CfzAZY3fREdex+FBuW57OZU=
Subject: FAILED: patch "[PATCH] Revert "io_uring/rw: drop -EOPNOTSUPP check in" failed to apply to 6.12-stable tree
To: axboe@kernel.dk,carnil@debian.org,kevin@xf.ee
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Oct 2025 10:00:39 +0200
Message-ID: <2025102039-bonelike-vocation-0372@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 927069c4ac2cd1a37efa468596fb5b8f86db9df0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102039-bonelike-vocation-0372@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 927069c4ac2cd1a37efa468596fb5b8f86db9df0 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Mon, 13 Oct 2025 12:05:31 -0600
Subject: [PATCH] Revert "io_uring/rw: drop -EOPNOTSUPP check in
 __io_complete_rw_common()"

This reverts commit 90bfb28d5fa8127a113a140c9791ea0b40ab156a.

Kevin reports that this commit causes an issue for him with LVM
snapshots, most likely because of turning off NOWAIT support while a
snapshot is being created. This makes -EOPNOTSUPP bubble back through
the completion handler, where io_uring read/write handling should just
retry it.

Reinstate the previous check removed by the referenced commit.

Cc: stable@vger.kernel.org
Fixes: 90bfb28d5fa8 ("io_uring/rw: drop -EOPNOTSUPP check in __io_complete_rw_common()")
Reported-by: Salvatore Bonaccorso <carnil@debian.org>
Reported-by: Kevin Lumik <kevin@xf.ee>
Link: https://lore.kernel.org/io-uring/cceb723c-051b-4de2-9a4c-4aa82e1619ee@kernel.dk/
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/rw.c b/io_uring/rw.c
index 08882648d569..a0f9d2021e3f 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -542,7 +542,7 @@ static void __io_complete_rw_common(struct io_kiocb *req, long res)
 {
 	if (res == req->cqe.res)
 		return;
-	if (res == -EAGAIN && io_rw_should_reissue(req)) {
+	if ((res == -EOPNOTSUPP || res == -EAGAIN) && io_rw_should_reissue(req)) {
 		req->flags |= REQ_F_REISSUE | REQ_F_BL_NO_RECYCLE;
 	} else {
 		req_set_fail(req);


