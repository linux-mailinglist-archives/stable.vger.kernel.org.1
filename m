Return-Path: <stable+bounces-69498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F729956729
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C45828305C
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8029143C63;
	Mon, 19 Aug 2024 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z2ktL+9I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9537215D5C8
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060025; cv=none; b=hGx+/9T0zWtfoW2AC8b7s+tPZ+jUjlu6gWUsfFJOvrhWskX65gKDGTHOZWzSO8jex0zD/qwtD5JWNUPtzSwK8arPAoearkmuZsq2qGFLPtyTZ+xlYH6Il9773ajTZDav0gvoarJXhEKL4qrcULn38FmkpV+C+wtKeHRs4n5mKK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060025; c=relaxed/simple;
	bh=1Ac2Fxq90/luJH/f14PWbAFIV9ytlzN001BCwGRalME=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kwmaIwm2YMqhAX6qvYD6gf+WOdy2r+VbrQ6yg9zYv0k2LzOd6vByPEK9rD3+yZfHITM/vfd9vUg4Mc5yUQYx3cmWEfS1HKU1HCb7SYFl0xBI22XokcP+5K3W5dUwfYAm5KoSbaw/aDP2MWFgNoEje2mxk1gEVolueb+hd/28X84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z2ktL+9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D519C32782;
	Mon, 19 Aug 2024 09:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724060025;
	bh=1Ac2Fxq90/luJH/f14PWbAFIV9ytlzN001BCwGRalME=;
	h=Subject:To:Cc:From:Date:From;
	b=Z2ktL+9I2pT9lKgWj6PkSEXFrOaQ6exZhyhImg4cizRbI2Cbn7+7zsApkKge0QTeb
	 4+6G56NAUcb2HsfpPcq3rTyCfSX+NLjKsE12ZDla07g6o93hGgRgJALFebozYu9xZn
	 TjK43xasqfdCf+DK/1blP1Gx6BbkqSrLpYS6HbGs=
Subject: FAILED: patch "[PATCH] dm suspend: return -ERESTARTSYS instead of -EINTR" failed to apply to 4.19-stable tree
To: mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:33:28 +0200
Message-ID: <2024081927-smoky-refrain-8af1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 1e1fd567d32fcf7544c6e09e0e5bc6c650da6e23
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081927-smoky-refrain-8af1@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

1e1fd567d32f ("dm suspend: return -ERESTARTSYS instead of -EINTR")
85067747cf98 ("dm: do not use waitqueue for request-based DM")
087615bf3acd ("dm mpath: pass IO start time to path selector")
5de719e3d01b ("dm mpath: fix missing call of path selector type->end_io")
645efa84f6c7 ("dm: add memory barrier before waitqueue_active")
3c94d83cb352 ("blk-mq: change blk_mq_queue_busy() to blk_mq_queue_inflight()")
c4576aed8d85 ("dm: fix request-based dm's use of dm_wait_for_completion")
b7934ba4147a ("dm: fix inflight IO check")
6f75723190d8 ("dm: remove the pending IO accounting")
dbd3bbd291a0 ("dm rq: leverage blk_mq_queue_busy() to check for outstanding IO")
80a787ba3809 ("dm: dont rewrite dm_disk(md)->part0.in_flight")
ae8799125d56 ("blk-mq: provide a helper to check if a queue is busy")
6a23e05c2fe3 ("dm: remove legacy request-based IO path")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1e1fd567d32fcf7544c6e09e0e5bc6c650da6e23 Mon Sep 17 00:00:00 2001
From: Mikulas Patocka <mpatocka@redhat.com>
Date: Tue, 13 Aug 2024 12:38:51 +0200
Subject: [PATCH] dm suspend: return -ERESTARTSYS instead of -EINTR

This commit changes device mapper, so that it returns -ERESTARTSYS
instead of -EINTR when it is interrupted by a signal (so that the ioctl
can be restarted).

The manpage signal(7) says that the ioctl function should be restarted if
the signal was handled with SA_RESTART.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 97fab2087df8..87bb90303435 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2737,7 +2737,7 @@ static int dm_wait_for_bios_completion(struct mapped_device *md, unsigned int ta
 			break;
 
 		if (signal_pending_state(task_state, current)) {
-			r = -EINTR;
+			r = -ERESTARTSYS;
 			break;
 		}
 
@@ -2762,7 +2762,7 @@ static int dm_wait_for_completion(struct mapped_device *md, unsigned int task_st
 			break;
 
 		if (signal_pending_state(task_state, current)) {
-			r = -EINTR;
+			r = -ERESTARTSYS;
 			break;
 		}
 


