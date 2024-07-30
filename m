Return-Path: <stable+bounces-62761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B5F940FC8
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01FDD281128
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 10:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9231A08B2;
	Tue, 30 Jul 2024 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XEI5rkTW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5C419F478
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335867; cv=none; b=fjH35LnLeNnu1x5YpVKFrBfspRACKvzl355OiVhaF8V13dxwzvf4OQjvFIiPy3w1A3W9jSIuRL0EwloJOKXSPzpLWR7U7i1NfpRbhkmovH+eKSAuX9FBLBFoi+rSnVgbpq1yXhvt6cYVHiEPUBjbsDk+PYVSSgPu53mqW+fYBJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335867; c=relaxed/simple;
	bh=Dc1gBDNw7vk0FWEpQOhno/aH0D6ZmCxklmNlIzBxbWs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a+t+E/7MQmX1Y9ExgnWWomuKRRBpO4hXcNjNE6sEKP9LJHK0Q2vHvLczcPgQ149rjCo73wOxr0jC2Ak5x3ct6JvYgHsQMN3gLn8cb3D3D484k4BuI/puNelR10fPngDFfvGdj6BGpbDSco2SZTubg8XUsOYif6WiOgJP8ApWD8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XEI5rkTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80852C4AF0B;
	Tue, 30 Jul 2024 10:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722335867;
	bh=Dc1gBDNw7vk0FWEpQOhno/aH0D6ZmCxklmNlIzBxbWs=;
	h=Subject:To:Cc:From:Date:From;
	b=XEI5rkTWmiTn51TXjWuU64QSPqnXEW2faZmD3v8A0+YRjHWREDpvVCYym3SOcZvil
	 2A51KXPgeWLe5zaJi7yEfpmCW2mCiHkUH/r7NBfKxDz85aujUhEVgCFe1SQwpwPwdP
	 ZIiAKwmtefWlSfZN1lrYdqYlfVl19y0D0BH6qZGc=
Subject: FAILED: patch "[PATCH] remoteproc: stm32_rproc: Fix mailbox interrupts queuing" failed to apply to 5.10-stable tree
To: gwenael.treuveur@foss.st.com,arnaud.pouliquen@foss.st.com,mathieu.poirier@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 12:34:24 +0200
Message-ID: <2024073024-ruined-frightful-2dc2@gregkh>
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
git cherry-pick -x c3281abea67c9c0dc6219bbc41d1feae05a16da3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073024-ruined-frightful-2dc2@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

c3281abea67c ("remoteproc: stm32_rproc: Fix mailbox interrupts queuing")
35bdafda40cc ("remoteproc: stm32_rproc: Add mutex protection for workqueue")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c3281abea67c9c0dc6219bbc41d1feae05a16da3 Mon Sep 17 00:00:00 2001
From: Gwenael Treuveur <gwenael.treuveur@foss.st.com>
Date: Tue, 21 May 2024 18:23:16 +0200
Subject: [PATCH] remoteproc: stm32_rproc: Fix mailbox interrupts queuing

Manage interrupt coming from coprocessor also when state is
ATTACHED.

Fixes: 35bdafda40cc ("remoteproc: stm32_rproc: Add mutex protection for workqueue")
Cc: stable@vger.kernel.org
Signed-off-by: Gwenael Treuveur <gwenael.treuveur@foss.st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Link: https://lore.kernel.org/r/20240521162316.156259-1-gwenael.treuveur@foss.st.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 88623df7d0c3..8c7f7950b80e 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -294,7 +294,7 @@ static void stm32_rproc_mb_vq_work(struct work_struct *work)
 
 	mutex_lock(&rproc->lock);
 
-	if (rproc->state != RPROC_RUNNING)
+	if (rproc->state != RPROC_RUNNING && rproc->state != RPROC_ATTACHED)
 		goto unlock_mutex;
 
 	if (rproc_vq_interrupt(rproc, mb->vq_id) == IRQ_NONE)


