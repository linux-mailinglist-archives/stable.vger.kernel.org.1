Return-Path: <stable+bounces-62701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C87940D97
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED8C1F22AFA
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6613C194C85;
	Tue, 30 Jul 2024 09:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DGaczzUM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27442194C7B
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 09:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331726; cv=none; b=OCjKF6dfyv03CjGoLxNIdWdfTO3DUx5sRttbd+fsMjjRN1aOkrzgd4Hv7nm1jLrlhpOyDFValnYf3lOzBI1rNUgtjgkttqe2cFbCb5gMxcZMY5sDgPGIQyVeR3VD7Te1qOXyidQvbyV7QFzUxSOaXsvK0NV7pqY6R32XWjYE2ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331726; c=relaxed/simple;
	bh=1U3rsEwSj4qKfc6w4QMFC1EtVZfX25y2tPfhAvsoeXY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KvZQo82oWHDDdhQh8LwiKmdOXcM2Z9YlUxk9Vv+WjHJtNLBNuq94NLyzGDWH42O+PAwwIsYmtC3aEhaY/5Wit+UOEGUHS2Zjdk7sy4dksumAhTQDAUPNkvTbCXovElMCW/cwAt5JEoMYdjfP7L0nxXw3Q/vac7P87za7xfhasms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DGaczzUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1DEC4AF0B;
	Tue, 30 Jul 2024 09:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722331726;
	bh=1U3rsEwSj4qKfc6w4QMFC1EtVZfX25y2tPfhAvsoeXY=;
	h=Subject:To:Cc:From:Date:From;
	b=DGaczzUMJi6SCiBFdexQRMcx/LKS1tODJE70Ty5ct1tpZB12Gd5wsU2U6b2ecY075
	 9KaLFq+Nqyr/Vw7wIXShC8BphtDygzPb3MavINMTByC7EfS9Cmjy0M0Cq+5D015xyc
	 D2wHNZppEaROJb8NJT26okPBEnvGQuAbzHPVvub4=
Subject: FAILED: patch "[PATCH] perf: imx_perf: fix counter start and config sequence" failed to apply to 6.6-stable tree
To: xu.yang_2@nxp.com,Frank.Li@nxp.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 11:28:35 +0200
Message-ID: <2024073034-senator-fringe-8188@gregkh>
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
git cherry-pick -x ac9aa295f7a89d38656739628796f086f0b160e2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073034-senator-fringe-8188@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

ac9aa295f7a8 ("perf: imx_perf: fix counter start and config sequence")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ac9aa295f7a89d38656739628796f086f0b160e2 Mon Sep 17 00:00:00 2001
From: Xu Yang <xu.yang_2@nxp.com>
Date: Wed, 29 May 2024 16:03:55 +0800
Subject: [PATCH] perf: imx_perf: fix counter start and config sequence

In current driver, the counter will start firstly and then be configured.
This sequence is not correct for AXI filter events since the correct
AXI_MASK and AXI_ID are not set yet. Then the results may be inaccurate.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Fixes: 55691f99d417 ("drivers/perf: imx_ddr: Add support for NXP i.MX9 SoC DDRC PMU driver")
cc: stable@vger.kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Link: https://lore.kernel.org/r/20240529080358.703784-5-xu.yang_2@nxp.com
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 5433c52a9872..7b43b54920da 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -541,12 +541,12 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	hwc->idx = counter;
 	hwc->state |= PERF_HES_STOPPED;
 
-	if (flags & PERF_EF_START)
-		ddr_perf_event_start(event, flags);
-
 	/* read trans, write trans, read beat */
 	imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
 
+	if (flags & PERF_EF_START)
+		ddr_perf_event_start(event, flags);
+
 	return 0;
 }
 


