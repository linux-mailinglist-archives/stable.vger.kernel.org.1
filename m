Return-Path: <stable+bounces-3741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7152E8023E7
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15121B209CC
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 12:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5B2DF51;
	Sun,  3 Dec 2023 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yf302V7w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6394B3D79
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 12:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFE8C433C9;
	Sun,  3 Dec 2023 12:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701608060;
	bh=7DboV8SMnapLdl3Q3Gzc82ZqRU6bwo++lLq7W9l8kps=;
	h=Subject:To:Cc:From:Date:From;
	b=Yf302V7wzi+v1dehDG9p8iYi7quvzLLRfOCHZNofFdSqXU+EWyaBNqlENdr690BAp
	 gJmatL2nF9DxO10dv1w1I7lajSXJUZvngobpDAReC7T1Vi9+ZNGMjEuuKSgKmWK7xy
	 tyZ8PsGjeo06cXFCpNEBRKZkwaAPv2fN52wk8NUs=
Subject: FAILED: patch "[PATCH] mmc: cqhci: Warn of halt or task clear failure" failed to apply to 5.4-stable tree
To: adrian.hunter@intel.com,avri.altman@wdc.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 Dec 2023 13:54:08 +0100
Message-ID: <2023120307-copilot-direction-48f9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 35597bdb04ec27ef3b1cea007dc69f8ff5df75a5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120307-copilot-direction-48f9@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

35597bdb04ec ("mmc: cqhci: Warn of halt or task clear failure")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 35597bdb04ec27ef3b1cea007dc69f8ff5df75a5 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Fri, 3 Nov 2023 10:47:19 +0200
Subject: [PATCH] mmc: cqhci: Warn of halt or task clear failure

A correctly operating controller should successfully halt and clear tasks.
Failure may result in errors elsewhere, so promote messages from debug to
warnings.

Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Link: https://lore.kernel.org/r/20231103084720.6886-6-adrian.hunter@intel.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index 15f5a069af1f..948799a0980c 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -942,8 +942,8 @@ static bool cqhci_clear_all_tasks(struct mmc_host *mmc, unsigned int timeout)
 	ret = cqhci_tasks_cleared(cq_host);
 
 	if (!ret)
-		pr_debug("%s: cqhci: Failed to clear tasks\n",
-			 mmc_hostname(mmc));
+		pr_warn("%s: cqhci: Failed to clear tasks\n",
+			mmc_hostname(mmc));
 
 	return ret;
 }
@@ -976,7 +976,7 @@ static bool cqhci_halt(struct mmc_host *mmc, unsigned int timeout)
 	ret = cqhci_halted(cq_host);
 
 	if (!ret)
-		pr_debug("%s: cqhci: Failed to halt\n", mmc_hostname(mmc));
+		pr_warn("%s: cqhci: Failed to halt\n", mmc_hostname(mmc));
 
 	return ret;
 }


