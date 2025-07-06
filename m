Return-Path: <stable+bounces-160308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF81DAFA4F8
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 13:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B1317E990
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 11:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5852080C4;
	Sun,  6 Jul 2025 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zRA5O0wI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E0C1ACEAC
	for <stable@vger.kernel.org>; Sun,  6 Jul 2025 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751802758; cv=none; b=C0V6dICGt7aEon50PRofPQNnTRFefHrZuazjsogdGVZQb5cIPXsJhY4aUgvSxR4kAPoZQZBH75BrDv93dkRbJMsvgFug+bhmI2Rirre2wVtsIQH4zzcbFAZjjb+F+5+ZgSOUsT22apZRo2g9wDP+tW6gQ0e20/ENxhQyNR+OP8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751802758; c=relaxed/simple;
	bh=3jtUxF1IDYkUDo/6dThLTeWL2vPTHciVWkEjHydE2wo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SExcmlLcHu7Z4/oUEiS5VYsWRKx0nmUhoj/uQGs1ZGalQ+rhBWy+DOaDn2ud6EivABmQpUjVsPZDVJfwgzCGT1jbd0SBWoDf06V1wCwUO7stCQcyVgSfx/FBvYcEzRhrH8fDYub6XYsZdrRcYdmV59/CpWfmSfrln8VKfqi64uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zRA5O0wI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB1CC4CEED;
	Sun,  6 Jul 2025 11:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751802757;
	bh=3jtUxF1IDYkUDo/6dThLTeWL2vPTHciVWkEjHydE2wo=;
	h=Subject:To:Cc:From:Date:From;
	b=zRA5O0wINTpfMHmmRd8JJS2m3eFJn2VjrKz5ZhJdbnH0JWOeLGtQOd1CSOHZXdMvR
	 PiX24+z2umnzBaCpPTFQrOv/ap6S+SG6nL5TXBA9uZg/ssjDl1YopFj4SJz3EdIOtm
	 pEuGvYuGEVbqJvbfMebrVmlZVA9gakEDu+PNOlR4=
Subject: FAILED: patch "[PATCH] mtk-sd: Prevent memory corruption from DMA map failure" failed to apply to 5.10-stable tree
To: mhiramat@kernel.org,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 06 Jul 2025 13:52:34 +0200
Message-ID: <2025070634-wrongness-claw-15a0@gregkh>
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
git cherry-pick -x f5de469990f19569627ea0dd56536ff5a13beaa3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025070634-wrongness-claw-15a0@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f5de469990f19569627ea0dd56536ff5a13beaa3 Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Thu, 12 Jun 2025 20:26:10 +0900
Subject: [PATCH] mtk-sd: Prevent memory corruption from DMA map failure

If msdc_prepare_data() fails to map the DMA region, the request is
not prepared for data receiving, but msdc_start_data() proceeds
the DMA with previous setting.
Since this will lead a memory corruption, we have to stop the
request operation soon after the msdc_prepare_data() fails to
prepare it.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Fixes: 208489032bdd ("mmc: mediatek: Add Mediatek MMC driver")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/174972756982.3337526.6755001617701603082.stgit@mhiramat.tok.corp.google.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index b1d1586cf1fc..b12cfb9a5e5f 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -853,6 +853,11 @@ static void msdc_prepare_data(struct msdc_host *host, struct mmc_data *data)
 	}
 }
 
+static bool msdc_data_prepared(struct mmc_data *data)
+{
+	return data->host_cookie & MSDC_PREPARE_FLAG;
+}
+
 static void msdc_unprepare_data(struct msdc_host *host, struct mmc_data *data)
 {
 	if (data->host_cookie & MSDC_ASYNC_FLAG)
@@ -1484,8 +1489,18 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	WARN_ON(!host->hsq_en && host->mrq);
 	host->mrq = mrq;
 
-	if (mrq->data)
+	if (mrq->data) {
 		msdc_prepare_data(host, mrq->data);
+		if (!msdc_data_prepared(mrq->data)) {
+			/*
+			 * Failed to prepare DMA area, fail fast before
+			 * starting any commands.
+			 */
+			mrq->cmd->error = -ENOSPC;
+			mmc_request_done(mmc_from_priv(host), mrq);
+			return;
+		}
+	}
 
 	/* if SBC is required, we have HW option and SW option.
 	 * if HW option is enabled, and SBC does not have "special" flags,


