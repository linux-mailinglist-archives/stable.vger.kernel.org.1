Return-Path: <stable+bounces-81379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40269933D7
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 18:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9DB1C225D3
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 16:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322A31DC04E;
	Mon,  7 Oct 2024 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qPjd5HjT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41DA1DBB1D
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319778; cv=none; b=YVF47aA7G6HEWW9rsdMYuEM8RCWSTsyni6iYPhga0pee2fR2nCPPJdmQzJR8PP9Lm/IguvZZI4WZZUlglfBheWhO5nq8QeQWuPl/maYNuR/t1kPVT94RyYMbNBAIY7nOOmgZva9gY0nnhU3xbbKs/bOQOtWqqsLwsCKfzhooiXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319778; c=relaxed/simple;
	bh=HZuc+B54pfeyzbWxTzuO8TINgmIG4JCX5Oney41eIZc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nc/1cV1jOba4jSn6Ly9vzyASCP8vafAJoJUX1DahjC4KOJyNesUpMZLeg5gOf126qeLJtByK//yB7/M6TYKx1dKcp9qxDVQUicT5SrVf0Zq3Sta3fZJ6c33K9zvvp3AVklfLomnPT/LBPUKXTzhlo6cLmS6/EO2GsKvJpwh72ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qPjd5HjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCA6C4CEC6;
	Mon,  7 Oct 2024 16:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728319777;
	bh=HZuc+B54pfeyzbWxTzuO8TINgmIG4JCX5Oney41eIZc=;
	h=Subject:To:Cc:From:Date:From;
	b=qPjd5HjTROue0Lf0dsH/vr6g1MD+NPq7U1rPZJcHKZnfgM0x0pJeB/UoO89BGaudj
	 HV/dqSgfvw0rPQP+kqIw0vHwqPONRifGN2vAJUjpFEt2SGECOb5CedMzm4FV0NtCqw
	 CYuhiRqaFrKqRxUVI10j9hHxoka0AJ5cFRjRdPco=
Subject: FAILED: patch "[PATCH] remoteproc: k3-r5: Delay notification of wakeup event" failed to apply to 6.10-stable tree
To: u-kumar1@ti.com,b-padhi@ti.com,mathieu.poirier@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 18:49:23 +0200
Message-ID: <2024100722-icon-afraid-744b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8fa052c29e509f3e47d56d7fc2ca28094d78c60a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100722-icon-afraid-744b@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

8fa052c29e50 ("remoteproc: k3-r5: Delay notification of wakeup event")
f3f11cfe8907 ("remoteproc: k3-r5: Acquire mailbox handle during probe routine")

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


