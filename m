Return-Path: <stable+bounces-69495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DCE956723
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F74A283322
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C467615D5B8;
	Mon, 19 Aug 2024 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ei/H4Tg1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841D3158551
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060016; cv=none; b=TCQCQswkh0hjinhmCVZwfDSPL7OLO2iK186b75dQLto9IELfWbSX5NVhodFGu6LuuZKD5vV2hAlp2LtGrSLNHnEw8+O9D7UhTjtrp8jSSw8hgDL8kUVP9i6BtPBz7P8F+9S7srd7sPLATDwiN5llLvnU3dG7PdkTVpbuc4T0w3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060016; c=relaxed/simple;
	bh=P732QaUdwAed5AD3LTVf45qQbH6ukf5ScdzH4WFjRl0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OVFayV55KYTyvoDZx9Fa+MmyBi1w+jVByZbdAn9Wk0FU6QKwiiZjkuCm8KWeNLYnOKB1lhDbxOyj4FD9C5zlLnQRFrxLBc31buhsqa5BaPmrxdxTuQaF9UkvCZ+dhV77Zf4NKgZU1VLJzsDD6/Q8CPnEjZXiMe2SPwjFof3Gjp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ei/H4Tg1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BED9C32782;
	Mon, 19 Aug 2024 09:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724060016;
	bh=P732QaUdwAed5AD3LTVf45qQbH6ukf5ScdzH4WFjRl0=;
	h=Subject:To:Cc:From:Date:From;
	b=Ei/H4Tg1EROST4kX0FasYdg9RJhFSsH7xJjuJePlDXbVnKEoRZpxHK4gHjikYzy2w
	 fFF96VrwP227IC67V/jqa2gLeA94FEwn4pzwtH94yPPna7TfX/nNsHVn4SvBiEap1b
	 PtLx+Kfbn4D8CX8TcdXE/xEeeGiH6cVbLr/G8IH0=
Subject: FAILED: patch "[PATCH] dm suspend: return -ERESTARTSYS instead of -EINTR" failed to apply to 5.10-stable tree
To: mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:33:26 +0200
Message-ID: <2024081926-dumpling-ecard-9941@gregkh>
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
git cherry-pick -x 1e1fd567d32fcf7544c6e09e0e5bc6c650da6e23
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081926-dumpling-ecard-9941@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
 


