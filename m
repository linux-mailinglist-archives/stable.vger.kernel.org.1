Return-Path: <stable+bounces-111276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DD0A22C98
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 12:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 955E916353B
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 11:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4C31BCA0C;
	Thu, 30 Jan 2025 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uAO+LhkT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3B01AB507
	for <stable@vger.kernel.org>; Thu, 30 Jan 2025 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738237094; cv=none; b=phFXRrEduRZfpTDT8hwW7zi/PLAkoKAiy4UFwhq3jmnNuiEMRbCyeezy+++EtsyMTSz3eFncH5ZKwkYxneHBdjV+nkD6b6dAehg1AvHr/0nXS8GJsYpDzyRLkGD0yfPAUAE4qiH09xKY0WYXKV8kyARYnv5OBcW4XIt7hvaIPww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738237094; c=relaxed/simple;
	bh=K+HIuDiWZkE3Sev+e00st9NThLCxzy8N/gsbd5Mg2Ig=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=t0IXy4otiwsPpcrkrC0SlLIj58OydTzo1T8w23CgxiqJyohawxM8I3TE7n7q+gUyq2phr8Gm3jKFonmrWKAnhuoLhOTIvLoFZaJZK7XRtY1QZTUBSmzihZF6ds/Pd5P8gmoNok1McTivkxreXAgaESRR+Mm9zzkFb30wKdHpN7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uAO+LhkT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9C6C4CED2;
	Thu, 30 Jan 2025 11:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738237094;
	bh=K+HIuDiWZkE3Sev+e00st9NThLCxzy8N/gsbd5Mg2Ig=;
	h=Subject:To:Cc:From:Date:From;
	b=uAO+LhkTjmShTeUG//Od89U7qM4Zr2p10JTma8isGJrQTB2jNkFxaCktTKDs3NHJS
	 U32wHq2Pkbd2ImSt7N8jx0JmEflF6RycYizyX8nIHlzryS7sn8kWnmHzOIYa8TI2+U
	 /13SPs+yatujdJzMN7flAB5BmM+CWwPW8dUvhCxs=
Subject: FAILED: patch "[PATCH] io_uring/rsrc: require cloned buffers to share accounting" failed to apply to 6.12-stable tree
To: jannh@google.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 30 Jan 2025 12:38:11 +0100
Message-ID: <2025013011-scenic-crazed-e3c8@gregkh>
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
git cherry-pick -x 19d340a2988d4f3e673cded9dde405d727d7e248
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025013011-scenic-crazed-e3c8@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 19d340a2988d4f3e673cded9dde405d727d7e248 Mon Sep 17 00:00:00 2001
From: Jann Horn <jannh@google.com>
Date: Tue, 14 Jan 2025 18:49:00 +0100
Subject: [PATCH] io_uring/rsrc: require cloned buffers to share accounting
 contexts

When IORING_REGISTER_CLONE_BUFFERS is used to clone buffers from uring
instance A to uring instance B, where A and B use different MMs for
accounting, the accounting can go wrong:
If uring instance A is closed before uring instance B, the pinned memory
counters for uring instance B will be decremented, even though the pinned
memory was originally accounted through uring instance A; so the MM of
uring instance B can end up with negative locked memory.

Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/r/CAG48ez1zez4bdhmeGLEFxtbFADY4Czn3CV0u9d_TMcbvRA01bg@mail.gmail.com
Fixes: 7cc2a6eadcd7 ("io_uring: add IORING_REGISTER_COPY_BUFFERS method")
Signed-off-by: Jann Horn <jannh@google.com>
Link: https://lore.kernel.org/r/20250114-uring-check-accounting-v1-1-42e4145aa743@google.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 964a47c8d85e..688e277f0335 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -928,6 +928,13 @@ static int io_clone_buffers(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx
 	int i, ret, off, nr;
 	unsigned int nbufs;
 
+	/*
+	 * Accounting state is shared between the two rings; that only works if
+	 * both rings are accounted towards the same counters.
+	 */
+	if (ctx->user != src_ctx->user || ctx->mm_account != src_ctx->mm_account)
+		return -EINVAL;
+
 	/* if offsets are given, must have nr specified too */
 	if (!arg->nr && (arg->dst_off || arg->src_off))
 		return -EINVAL;


