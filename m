Return-Path: <stable+bounces-143201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC43AB3477
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D22189856C
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F335225A33C;
	Mon, 12 May 2025 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r6WZhodg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3835255F5A
	for <stable@vger.kernel.org>; Mon, 12 May 2025 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747044317; cv=none; b=fcDlmrLJ7eYHYCRDGtkNbN1VlEUxLHNpoaXnpvKIxmkY4u9tA44kk8F8Fm9AA5VAdfvWNJjKGN1y6RDsjYGTgjMerWsbhv3X8KyPQPTTtE2qSuSzMmIK8RzKJV/ileIQgZ3NLay953e8gNBxhr8G2s0VMmgCYHfY+xn+yCymmUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747044317; c=relaxed/simple;
	bh=mIZUfBRcqNYyNE3K83vDCMXpXw4NK2IA9HPrK8EY/xc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Eeof6Tw8yLoUkRnebQwCTUo9IKG80Nhy0DZDHY+mC5UgDFLLCSOgJhdtu6nVkNDojv5Jls8lU6WQD5PdRMToCfIK0b81DM/vlDUt61Bfsf51d0T5FmpqwK2npb61S8wnCCkceKEa0oJtVR4Ec9nm5DjDfDw82t69hWxV7FrlrLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r6WZhodg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3950FC4CEE7;
	Mon, 12 May 2025 10:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747044317;
	bh=mIZUfBRcqNYyNE3K83vDCMXpXw4NK2IA9HPrK8EY/xc=;
	h=Subject:To:Cc:From:Date:From;
	b=r6WZhodgYUNXzVjdvPXWGmjJcar6fX89aGs/ypiy6wC1KN3E6f+r3vjWD9UcX+HFJ
	 4b9wDaxw1G0jSXKAVitKh/fxNH51cKqmAKFz77eH/2bIFBogF4r+/3A84iCjIuVOqY
	 4F5U88oO23/IdKj8x9rG+uEslmh5IJ9McBQaEntM=
Subject: FAILED: patch "[PATCH] iio: light: opt3001: fix deadlock due to concurrent flag" failed to apply to 6.12-stable tree
To: luca.ceresoli@bootlin.com,Jonathan.Cameron@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 12:05:15 +0200
Message-ID: <2025051215-economist-traffic-fa57@gregkh>
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
git cherry-pick -x f063a28002e3350088b4577c5640882bf4ea17ea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051215-economist-traffic-fa57@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f063a28002e3350088b4577c5640882bf4ea17ea Mon Sep 17 00:00:00 2001
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 21 Mar 2025 19:10:00 +0100
Subject: [PATCH] iio: light: opt3001: fix deadlock due to concurrent flag
 access

The threaded IRQ function in this driver is reading the flag twice: once to
lock a mutex and once to unlock it. Even though the code setting the flag
is designed to prevent it, there are subtle cases where the flag could be
true at the mutex_lock stage and false at the mutex_unlock stage. This
results in the mutex not being unlocked, resulting in a deadlock.

Fix it by making the opt3001_irq() code generally more robust, reading the
flag into a variable and using the variable value at both stages.

Fixes: 94a9b7b1809f ("iio: light: add support for TI's opt3001 light sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Link: https://patch.msgid.link/20250321-opt3001-irq-fix-v1-1-6c520d851562@bootlin.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 65b295877b41..393a3d2fbe1d 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -788,8 +788,9 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 	int ret;
 	bool wake_result_ready_queue = false;
 	enum iio_chan_type chan_type = opt->chip_info->chan_type;
+	bool ok_to_ignore_lock = opt->ok_to_ignore_lock;
 
-	if (!opt->ok_to_ignore_lock)
+	if (!ok_to_ignore_lock)
 		mutex_lock(&opt->lock);
 
 	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
@@ -826,7 +827,7 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 	}
 
 out:
-	if (!opt->ok_to_ignore_lock)
+	if (!ok_to_ignore_lock)
 		mutex_unlock(&opt->lock);
 
 	if (wake_result_ready_queue)


