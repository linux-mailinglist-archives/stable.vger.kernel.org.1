Return-Path: <stable+bounces-81378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DD99933D8
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 18:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8976CB26B8A
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 16:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B03B1DC180;
	Mon,  7 Oct 2024 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V3hOKy9N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADAC1DBB1D
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319774; cv=none; b=ikNobbSHLS95gPqKOEjRdDMNPf0CjAzljML0JQB4xaCfDz7t/vAlVMqS9qBBDHSegGnmsSc9+ajIM2huRcSruZS16ylwWY9AlML54dGmm3OBlnVYmWFafaTOvA5JzB1/8rO1IOJgL1Giyvhq2RS5XbXzxuBLF2A7ucBT2vKxUzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319774; c=relaxed/simple;
	bh=2ar5xpUivN0uhPP4eqovv+F+WJPjxE4vJccixAyp/Ts=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IgjrWFnD5mwct6dHIh+dleAQt/iW0dNUnEoZgARR0FPPw/LIH9RHQHPOcXsJ4k44Oe8T4BMWJJCPaNwwqGj1XPz3TMRK+2n/a0FucqXNp8uaZcgCvSDTS4mVgcM9pPQjcGQiDGSS0KPvdrZLbpXJ3o4/fTbXwlNZGeVgoytr2fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V3hOKy9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C212BC4CEC6;
	Mon,  7 Oct 2024 16:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728319774;
	bh=2ar5xpUivN0uhPP4eqovv+F+WJPjxE4vJccixAyp/Ts=;
	h=Subject:To:Cc:From:Date:From;
	b=V3hOKy9NnKOPLLxJFtk8Onp+FSxxkeMysnwBdu0bTWktznGQJqkJCeqGcLxM3Sv7+
	 59NEBTobLf5gmKFj02Zgv45/XlS/3TqUK8z9mSwzaIjyaUvLnlyKoPdfbwqoRipxmC
	 +0txR7jRA1KM0AFnYldQwBtTUdESsPYi8eb/+ces=
Subject: FAILED: patch "[PATCH] remoteproc: k3-r5: Delay notification of wakeup event" failed to apply to 6.6-stable tree
To: u-kumar1@ti.com,b-padhi@ti.com,mathieu.poirier@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 18:49:23 +0200
Message-ID: <2024100723-unbutton-eldercare-a61f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8fa052c29e509f3e47d56d7fc2ca28094d78c60a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100723-unbutton-eldercare-a61f@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

8fa052c29e50 ("remoteproc: k3-r5: Delay notification of wakeup event")
f3f11cfe8907 ("remoteproc: k3-r5: Acquire mailbox handle during probe routine")
3c8a9066d584 ("remoteproc: k3-r5: Do not allow core1 to power up before core0 via sysfs")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8fa052c29e509f3e47d56d7fc2ca28094d78c60a Mon Sep 17 00:00:00 2001
From: Udit Kumar <u-kumar1@ti.com>
Date: Tue, 20 Aug 2024 16:20:04 +0530
Subject: [PATCH] remoteproc: k3-r5: Delay notification of wakeup event

Few times, core1 was scheduled to boot first before core0, which leads
to error:

'k3_r5_rproc_start: can not start core 1 before core 0'.

This was happening due to some scheduling between prepare and start
callback. The probe function waits for event, which is getting
triggered by prepare callback. To avoid above condition move event
trigger to start instead of prepare callback.

Fixes: 61f6f68447ab ("remoteproc: k3-r5: Wait for core0 power-up before powering up core1")
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
[ Applied wakeup event trigger only for Split-Mode booted rprocs ]
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240820105004.2788327-1-b-padhi@ti.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index 0a9fe53dd40d..60bd2042b0c6 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -469,8 +469,6 @@ static int k3_r5_rproc_prepare(struct rproc *rproc)
 			ret);
 		return ret;
 	}
-	core->released_from_reset = true;
-	wake_up_interruptible(&cluster->core_transition);
 
 	/*
 	 * Newer IP revisions like on J7200 SoCs support h/w auto-initialization
@@ -587,6 +585,9 @@ static int k3_r5_rproc_start(struct rproc *rproc)
 		ret = k3_r5_core_run(core);
 		if (ret)
 			return ret;
+
+		core->released_from_reset = true;
+		wake_up_interruptible(&cluster->core_transition);
 	}
 
 	return 0;


