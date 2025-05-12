Return-Path: <stable+bounces-143204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A01AB347B
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5517616DCEB
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D05A25A64C;
	Mon, 12 May 2025 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mWWFANU7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0103255F5A
	for <stable@vger.kernel.org>; Mon, 12 May 2025 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747044327; cv=none; b=ayuuHKyUTRQxIcP2Y+wtiU69liwUShOHXYq0/auv6Bv37o3ZXX9qbB3P1byv4pDQx7X0wOcxW/zrQRgKtbiD9tcRNd8Mf2TInZecePOOPPN1gz88/wnVnqtcIJq5nctIdIjk5bJecdQQi+zDKpZmc8ugpBms5cK+W53kvl4HzOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747044327; c=relaxed/simple;
	bh=24s3FulvKpRbgTvXxucE0jo4Jba7Eue2k/wQTOX5z/M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=P+PZDUWzbhjEQu9cxSVqjuZZahhMjjn50WJa+s1Adjomcy6dvipOhtVsVG4iq17MpGIn+CI0Dq3yyPWAdm0wH0MK6XqlwAHjynXsOtNVoi9dmZ67dSwA9YPcySk3ptYODS0hLMZhA36NTTlFigDakI+VGQ4VRAJcEV5ubJlp+Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mWWFANU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631AEC4CEE7;
	Mon, 12 May 2025 10:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747044326;
	bh=24s3FulvKpRbgTvXxucE0jo4Jba7Eue2k/wQTOX5z/M=;
	h=Subject:To:Cc:From:Date:From;
	b=mWWFANU77lEsaNib1ZG8TpgaEJfxUKrZXQpYnXxtRJt5PR4gGCHv07S1TNvPwJRDn
	 uEcmnjWu3gF+p5oALO0YW2Kg1Wt9E/wU4VRPVUp5vgYNlf8ZlkaiaeMASjOwpu4nLP
	 6ISrYau4Vn7D/4ck9+r+3qJoSkg/qkTHJRy4bEs4=
Subject: FAILED: patch "[PATCH] iio: light: opt3001: fix deadlock due to concurrent flag" failed to apply to 6.1-stable tree
To: luca.ceresoli@bootlin.com,Jonathan.Cameron@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 12:05:16 +0200
Message-ID: <2025051216-daily-camera-c269@gregkh>
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
git cherry-pick -x f063a28002e3350088b4577c5640882bf4ea17ea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051216-daily-camera-c269@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


