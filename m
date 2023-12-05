Return-Path: <stable+bounces-4219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D81804690
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D395C2814FF
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E8B79E3;
	Tue,  5 Dec 2023 03:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U6xWPHTH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201446FAF;
	Tue,  5 Dec 2023 03:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907F5C433C7;
	Tue,  5 Dec 2023 03:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746948;
	bh=lVf4k4AoAEgCLoJnikyg9T9ytLjCVyHbOSEtjG7OLa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U6xWPHTHG4RWjxzFX6kmxfEeVFej1YXc7Dc4twNmq7E/QbjQ2qCvgGk7wwUz4DnQd
	 WHwGmLa7+ShZYe/dkLeByTcRjO17qUPs5E0TdtPzhwsrJD9Lxz/yax4P1EgJ4XAEgm
	 SMkwVHJCl2Pu1D0fVu696dt86sqdaEDyUilhqaX8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@chromium.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <avri.altman@wdc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 69/71] mmc: cqhci: Fix task clearing in CQE error recovery
Date: Tue,  5 Dec 2023 12:17:07 +0900
Message-ID: <20231205031521.874088071@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031517.859409664@linuxfoundation.org>
References: <20231205031517.859409664@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 1de1b77982e1a1df9707cb11f9b1789e6b8919d4 ]

If a task completion notification (TCN) is received when there is no
outstanding task, the cqhci driver issues a "spurious TCN" warning. This
was observed to happen right after CQE error recovery.

When an error interrupt is received the driver runs recovery logic.
It halts the controller, clears all pending tasks, and then re-enables
it. On some platforms, like Intel Jasper Lake, a stale task completion
event was observed, regardless of the CQHCI_CLEAR_ALL_TASKS bit being set.

This results in either:
a) Spurious TC completion event for an empty slot.
b) Corrupted data being passed up the stack, as a result of premature
   completion for a newly added task.

Rather than add a quirk for affected controllers, ensure tasks are cleared
by toggling CQHCI_ENABLE, which would happen anyway if
cqhci_clear_all_tasks() timed out. This is simpler and should be safe and
effective for all controllers.

Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
Cc: stable@vger.kernel.org
Reported-by: Kornel Dulęba <korneld@chromium.org>
Tested-by: Kornel Dulęba <korneld@chromium.org>
Co-developed-by: Kornel Dulęba <korneld@chromium.org>
Signed-off-by: Kornel Dulęba <korneld@chromium.org>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Link: https://lore.kernel.org/r/20231103084720.6886-7-adrian.hunter@intel.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/cqhci.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index deae330441788..a17b87fa26351 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -1017,28 +1017,28 @@ static void cqhci_recovery_finish(struct mmc_host *mmc)
 
 	ok = cqhci_halt(mmc, CQHCI_FINISH_HALT_TIMEOUT);
 
-	if (!cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT))
-		ok = false;
-
 	/*
 	 * The specification contradicts itself, by saying that tasks cannot be
 	 * cleared if CQHCI does not halt, but if CQHCI does not halt, it should
 	 * be disabled/re-enabled, but not to disable before clearing tasks.
 	 * Have a go anyway.
 	 */
-	if (!ok) {
-		pr_debug("%s: cqhci: disable / re-enable\n", mmc_hostname(mmc));
-		cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
-		cqcfg &= ~CQHCI_ENABLE;
-		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
-		cqcfg |= CQHCI_ENABLE;
-		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
-		/* Be sure that there are no tasks */
-		ok = cqhci_halt(mmc, CQHCI_FINISH_HALT_TIMEOUT);
-		if (!cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT))
-			ok = false;
-		WARN_ON(!ok);
-	}
+	if (!cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT))
+		ok = false;
+
+	/* Disable to make sure tasks really are cleared */
+	cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
+	cqcfg &= ~CQHCI_ENABLE;
+	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
+
+	cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
+	cqcfg |= CQHCI_ENABLE;
+	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
+
+	cqhci_halt(mmc, CQHCI_FINISH_HALT_TIMEOUT);
+
+	if (!ok)
+		cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT);
 
 	cqhci_recover_mrqs(cq_host);
 
-- 
2.42.0




