Return-Path: <stable+bounces-62700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1396940D96
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B541F22240
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58F7194C75;
	Tue, 30 Jul 2024 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wcc9qkxQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86459194C72
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331717; cv=none; b=mElvQNRpJCljB656yihM+dVjlVbpwWGmzeG1sM2ZVqVncGF3QZebBjmSU8NS+tUTDSGp8vgRMoTM7EnIlXqWBpDV56j/plmSCrmrLvLwy1EliPxGUGt0lbZp2JMw/UQ9XL9X7jU2+bh6cYxVJdIiCBIfVhfLBD5UFz0x07vROg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331717; c=relaxed/simple;
	bh=N/bIb091f8PoJKhxoAmYcBLkuqDZa9MfoxAsSqbcg/k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=g1wc6C7iqiB0u0L+3ZMYAYZNX397jnY6oezT/V+dmArTB2emdZ/ENTYHKlLmU8awoyyKryMETf8z68mFmIw+eGtYhkRKv6ihKpX2Uf0AnoDzpPWNiLnOYRWclcE6w12zzTM8V8s1BQcCsOw1traf4l6qR4KJjdBlO0Yb2k8LxGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wcc9qkxQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF479C32782;
	Tue, 30 Jul 2024 09:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722331717;
	bh=N/bIb091f8PoJKhxoAmYcBLkuqDZa9MfoxAsSqbcg/k=;
	h=Subject:To:Cc:From:Date:From;
	b=wcc9qkxQo7FU/TQrKhuJaXhopRw8Z5EbmucdyXB/MuLSMYhDIUt/5Nc+QRXB4589e
	 z70AFtYEQhiWxVItOYik7Xq22uqLMR2CRinekGlAkxs0T8cipWH+AlmKAtBvbZgCgF
	 QfyP0DEJtt9idOsUgohfSqGK4ODtBUKysh433jAY=
Subject: FAILED: patch "[PATCH] perf: imx_perf: fix counter start and config sequence" failed to apply to 6.10-stable tree
To: xu.yang_2@nxp.com,Frank.Li@nxp.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 11:28:34 +0200
Message-ID: <2024073034-defender-boastful-74f0@gregkh>
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
git cherry-pick -x ac9aa295f7a89d38656739628796f086f0b160e2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073034-defender-boastful-74f0@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

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
 


