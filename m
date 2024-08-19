Return-Path: <stable+bounces-69496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDF4956727
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F491C21A70
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A7C15D5CF;
	Mon, 19 Aug 2024 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wJUTa/0a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D3D15C134
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060019; cv=none; b=KIdOjJ7JoTBP0jjb8S/rT8TWqLzQFvEvZcJepLwBG3Adq/J28m4e26Iw668hJ6JoL633pyaz3EvvvKaCpIuDzMYJLRzhtjN/FSlZpO6WmWHVVOZMCyuDpUc9P0bFtN/5BaLx2vf+CUaKH5vipF8y6W7etSvY2CmsYanO3+yLXcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060019; c=relaxed/simple;
	bh=xwqSJ/gqo7EFlpGxb9awZ2mQRXKmJhY3micSmg6NU2M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ym1vd5upkrt3EfAJpypwawrDAL0izNbIv3BcznfZEd+HmddI8dhDUJM8CUOa1qtiw7Iv0SgPCBZ1pkceYq1BJ/1Z4ron8iC0Xme4ovPpNFCOhO4yWni+wCL0MEzAMbwLNC/XoQcmwNr/EbhQYh9lZsuNDLJXe9lzvS/6nRDYZ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wJUTa/0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C43C4AF09;
	Mon, 19 Aug 2024 09:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724060018;
	bh=xwqSJ/gqo7EFlpGxb9awZ2mQRXKmJhY3micSmg6NU2M=;
	h=Subject:To:Cc:From:Date:From;
	b=wJUTa/0a0L4IGTdmWT/c9gIfEiyHGrUHAkFIvlXN1YNPqLlHhZoDllrKepSbMkDwk
	 +4t7v0rqNbAe5BcPNPTFLPKFeYC02HVp5g+4SQCPDY39LCnQ3RyLvVsRe/Xf722JQd
	 4f+9bV0fKFFWfLzRtN0LS4dSq9Xc18czwJ9NGtdM=
Subject: FAILED: patch "[PATCH] dm suspend: return -ERESTARTSYS instead of -EINTR" failed to apply to 5.15-stable tree
To: mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:33:26 +0200
Message-ID: <2024081925-voting-handwrite-258d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1e1fd567d32fcf7544c6e09e0e5bc6c650da6e23
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081925-voting-handwrite-258d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

1e1fd567d32f ("dm suspend: return -ERESTARTSYS instead of -EINTR")

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
 


