Return-Path: <stable+bounces-155134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A298FAE1E2C
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 17:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2189E4C0A44
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 15:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDB52BDC19;
	Fri, 20 Jun 2025 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lXcUSwv6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DB52BDC0A
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432224; cv=none; b=YiftKS2V1wWtyhGEJvLVLj5vpVPYBi6Jk5neklnFXuJ8mrA6IA31X2qyIClZOiJBz/S0T0N9Evao0ek/SxOWePyAtZW3n6Osqs7R6eFVBfK6GFl4hN5Cc5uyIbteSFTREl5dXxxdQ+lRCS9az2Tnay+Adb6au0BZNeu7nnuJ0vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432224; c=relaxed/simple;
	bh=qDaOlwOq245EYRiMvkAVdijTZyXSYq9W90qLLx4m0O0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=h58+VmAqiA3x83KISGbSAXreC0mvUfPQk/w0BVFBP9TMt1zZuEUGnmkgRAJbcDhH9Sx5Khnf0ZpGdBVkBflcU9B/r3upYYn44wcZ5MceOimJbQEnjCt4YN0D0DsS+7Cy/9LdwgU+NJ0ZI6LYNHRC7NKKK2Xydf3KQFrWJuU/v6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lXcUSwv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D005C4CEE3;
	Fri, 20 Jun 2025 15:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750432223;
	bh=qDaOlwOq245EYRiMvkAVdijTZyXSYq9W90qLLx4m0O0=;
	h=Subject:To:Cc:From:Date:From;
	b=lXcUSwv6z/ZVEHWp5T+bVfDt9dgta6/QrM2cFccA5cBPs97YDbB1tpqx/mu8h35Mb
	 k0ptsTv5RDNRVw4yj4hxOfxvP5qFaHLbGyMMkZZ6ZAqjDKCNOPd1ZXep7NnATeMoV9
	 PH9ItvdkAOKd56btsaN4uUDHFH2p6VrlpYWgLULQ=
Subject: FAILED: patch "[PATCH] nvme: always punt polled uring_cmd end_io work to task_work" failed to apply to 6.1-stable tree
To: axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 17:10:12 +0200
Message-ID: <2025062012-veggie-grout-8f7e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9ce6c9875f3e995be5fd720b65835291f8a609b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062012-veggie-grout-8f7e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9ce6c9875f3e995be5fd720b65835291f8a609b1 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Fri, 13 Jun 2025 13:37:41 -0600
Subject: [PATCH] nvme: always punt polled uring_cmd end_io work to task_work

Currently NVMe uring_cmd completions will complete locally, if they are
polled. This is done because those completions are always invoked from
task context. And while that is true, there's no guarantee that it's
invoked under the right ring context, or even task. If someone does
NVMe passthrough via multiple threads and with a limited number of
poll queues, then ringA may find completions from ringB. For that case,
completing the request may not be sound.

Always just punt the passthrough completions via task_work, which will
redirect the completion, if needed.

Cc: stable@vger.kernel.org
Fixes: 585079b6e425 ("nvme: wire up async polling for io passthrough commands")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 0b50da2f1175..6b3ac8ae3f34 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -429,21 +429,14 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 	pdu->result = le64_to_cpu(nvme_req(req)->result.u64);
 
 	/*
-	 * For iopoll, complete it directly. Note that using the uring_cmd
-	 * helper for this is safe only because we check blk_rq_is_poll().
-	 * As that returns false if we're NOT on a polled queue, then it's
-	 * safe to use the polled completion helper.
-	 *
-	 * Otherwise, move the completion to task work.
+	 * IOPOLL could potentially complete this request directly, but
+	 * if multiple rings are polling on the same queue, then it's possible
+	 * for one ring to find completions for another ring. Punting the
+	 * completion via task_work will always direct it to the right
+	 * location, rather than potentially complete requests for ringA
+	 * under iopoll invocations from ringB.
 	 */
-	if (blk_rq_is_poll(req)) {
-		if (pdu->bio)
-			blk_rq_unmap_user(pdu->bio);
-		io_uring_cmd_iopoll_done(ioucmd, pdu->result, pdu->status);
-	} else {
-		io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
-	}
-
+	io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
 	return RQ_END_IO_FREE;
 }
 


