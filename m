Return-Path: <stable+bounces-13588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 353C5837CF2
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7E951F25CF6
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55C915CD43;
	Tue, 23 Jan 2024 00:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TxObmVcu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E3115B31D;
	Tue, 23 Jan 2024 00:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969756; cv=none; b=c15qPexIVFuoLl/fDgQ416UrsimjGQeeayoJkwZQKPjOYMvUyfbsFhNIXWRy4SVxMMgO6ZhBIaEflh/6m3kV6KdoHu4btcBBtR1vsbTI6mjUauGp/ES+gqmPEIAYcY6ONyU/lQ9E8yjD5dp2DJlysIePhFzGAGAFflaC1Z5y9qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969756; c=relaxed/simple;
	bh=bmd1k1GbqvXjO13pTeTWeYqkYBKlK3qNsde4vwY2kAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8OD2yVhdq6IJkdXN821uxFDy6j1dPnseBwg1NohTApGKUyhXpaLiRuE0jtTCf6ii3qEBHXMiMlyUYTdefqFMoFgrzlXfFEQu3l9Q2woOGFThmM+M7aNmzo5iy1tVBYNfWZENlo8EV4aSDCq2U2BnFX4J9+UEsYFv+5x66lImm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TxObmVcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5555DC43390;
	Tue, 23 Jan 2024 00:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969756;
	bh=bmd1k1GbqvXjO13pTeTWeYqkYBKlK3qNsde4vwY2kAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TxObmVcuiSHHa/FVAcR/W3mLUyyke2uI9vGfaAxuoNCMepGaX1akW5Q5R89rtioYr
	 YHJmDb1koPamzYj5RiBkzrK8zOdub0GsIN/1qiblupwtG5pLbtuLIOALtIzq78DWsl
	 OuOGiJr2buFT0Cfp7G3Jhk+PMx1Wi+tt5vR1cbe8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nam Cao <namcao@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 6.7 431/641] fbdev: flush deferred work in fb_deferred_io_fsync()
Date: Mon, 22 Jan 2024 15:55:35 -0800
Message-ID: <20240122235831.475935107@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nam Cao <namcao@linutronix.de>

commit 15e4c1f462279b4e128f27de48133e0debe9e0df upstream.

The driver's fsync() is supposed to flush any pending operation to
hardware. It is implemented in this driver by cancelling the queued
deferred IO first, then schedule it for "immediate execution" by calling
schedule_delayed_work() again with delay=0. However, setting delay=0
only means the work is scheduled immediately, it does not mean the work
is executed immediately. There is no guarantee that the work is finished
after schedule_delayed_work() returns. After this driver's fsync()
returns, there can still be pending work. Furthermore, if close() is
called by users immediately after fsync(), the pending work gets
cancelled and fsync() may do nothing.

To ensure that the deferred IO completes, use flush_delayed_work()
instead. Write operations to this driver either write to the device
directly, or invoke schedule_delayed_work(); so by flushing the
workqueue, it can be guaranteed that all previous writes make it to the
device.

Fixes: 5e841b88d23d ("fb: fsync() method for deferred I/O flush.")
Cc: stable@vger.kernel.org
Signed-off-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/core/fb_defio.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -132,11 +132,7 @@ int fb_deferred_io_fsync(struct file *fi
 		return 0;
 
 	inode_lock(inode);
-	/* Kill off the delayed work */
-	cancel_delayed_work_sync(&info->deferred_work);
-
-	/* Run it immediately */
-	schedule_delayed_work(&info->deferred_work, 0);
+	flush_delayed_work(&info->deferred_work);
 	inode_unlock(inode);
 
 	return 0;



