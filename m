Return-Path: <stable+bounces-118740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0265A41ACF
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C396316BB93
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA5924C67F;
	Mon, 24 Feb 2025 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FrQWQIld"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C60524A04A
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392700; cv=none; b=qYzmfC4h3JH0zYrzAJtbD0pAUhZg816hmt+CKg0OFYS2nUT5LvEFo84SCQeL7mrn+zCWoV1Vw9rBbXLLf3Zak3CEEWMzIODcSzJ189x9acoiiniMSUR+fLOBu5QXAY4EV8ijKZPUNhkNuArjIwM0l7YhDTZZjmuZ/8iIW68oAXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392700; c=relaxed/simple;
	bh=13rslM+8xxFOriV4CC/AaDFQ2rvhqjdQ9tj2hRig0Bs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=I906Oe/5bPXOMgZk905mYmKNcGZ4TGJkf6AbhXHiNCfYkAR1bTMay0iCqbRHPD1aLGNnt0mmxGvPpMy/az6Ky57iVk5Zb4cNcEUSMLK84werHGFvFH3J0DUefigFopBrqiz14H0H1D0S9kOeXI8+cyuKud2h0N6ZkkmJloI/Vvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FrQWQIld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A13C4CEE6;
	Mon, 24 Feb 2025 10:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740392699;
	bh=13rslM+8xxFOriV4CC/AaDFQ2rvhqjdQ9tj2hRig0Bs=;
	h=Subject:To:Cc:From:Date:From;
	b=FrQWQIld+f+zVKu/Fe2eg5s0Dr1MpvrlkgENKs+4rBhQ4q19kjQrUms+7n7JzMMLV
	 f0cRgPTWxkNSmIg+6XpS/i1HgpHvkvS6Z8r65Bf3/Cv0IlbTEWUso5UXpZv9s1cd7w
	 /uxcMXbKCvRPjytJy45ClaXT0eSss285LYn6jm2E=
Subject: FAILED: patch "[PATCH] io_uring: prevent opcode speculation" failed to apply to 5.10-stable tree
To: asml.silence@gmail.com,axboe@kernel.dk,lizetao1@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Feb 2025 11:24:41 +0100
Message-ID: <2025022441-refined-barrack-4d1f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1e988c3fe1264708f4f92109203ac5b1d65de50b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025022441-refined-barrack-4d1f@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1e988c3fe1264708f4f92109203ac5b1d65de50b Mon Sep 17 00:00:00 2001
From: Pavel Begunkov <asml.silence@gmail.com>
Date: Fri, 14 Feb 2025 22:48:15 +0000
Subject: [PATCH] io_uring: prevent opcode speculation

sqe->opcode is used for different tables, make sure we santitise it
against speculations.

Cc: stable@vger.kernel.org
Fixes: d3656344fea03 ("io_uring: add lookup table for various opcode needs")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Reviewed-by: Li Zetao <lizetao1@huawei.com>
Link: https://lore.kernel.org/r/7eddbf31c8ca0a3947f8ed98271acc2b4349c016.1739568408.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 263e504be4a8..29a42365a481 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2045,6 +2045,8 @@ static int io_init_req(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		req->opcode = 0;
 		return io_init_fail_req(req, -EINVAL);
 	}
+	opcode = array_index_nospec(opcode, IORING_OP_LAST);
+
 	def = &io_issue_defs[opcode];
 	if (unlikely(sqe_flags & ~SQE_COMMON_FLAGS)) {
 		/* enforce forwards compatibility on users */


