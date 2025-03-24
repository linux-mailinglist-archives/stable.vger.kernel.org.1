Return-Path: <stable+bounces-125926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DED62A6DEC8
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712B51662BD
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 15:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD6525D533;
	Mon, 24 Mar 2025 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LK1/bWOl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F14A2A1BA
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830356; cv=none; b=YAYbBbxc9P+OUKJwWKgdpcNll6pCCQufp3NDTzhYOBujdipEVmO4yAJ6sgXEmOBNntm0QKFjGDUgNFGg1c1faKsCXLgU9G/YNd7cnMF44+6EoX1vkpwCQS4k5UJ5e2vB2WsMQULuw8aSfJdabej5gGumqdKkU3QnI1RZu+OuFTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830356; c=relaxed/simple;
	bh=xSaHfv4+e0UUNSorC5BIknTeaNjMyrIZwH0F3FZOmbo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ANWmUb+J+pryQqk9zqIo+dixNIY8Qq9Ahyi1LLiTUbPPN2PEfIc22uaEK7paqYferZKvYzTxfncrza/yxqZs6DhSL2wtsGr4ouNVAs6vvLSmZjLoDh20scSdTq2Kt0WU9Vg5DCUt5UnggcZzyvFpukT2CtweHE/I3gtFAexerTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LK1/bWOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED4AC4CEDD;
	Mon, 24 Mar 2025 15:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742830356;
	bh=xSaHfv4+e0UUNSorC5BIknTeaNjMyrIZwH0F3FZOmbo=;
	h=Subject:To:Cc:From:Date:From;
	b=LK1/bWOlK4+J/k2oAX0JeuhlkiQ5e+0lcsQ4e5+Yo8YxuSUvNEDJ/TrfVEY0KC3eL
	 yd1yCHUOwBWy2r17CJk+mHK0qocpL/WmAZquudTRGdh1M/p50RI0Dqu+P0fz+sfp6B
	 KeVgOxR28N/odQXvo/Bs6b/Hdto8xgvaC2b03vrg=
Subject: FAILED: patch "[PATCH] mmc: sdhci-brcmstb: add cqhci suspend/resume to PM ops" failed to apply to 5.15-stable tree
To: kamal.dasu@broadcom.com,florian.fainelli@broadcom.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Mar 2025 08:31:13 -0700
Message-ID: <2025032413-email-washer-d578@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 723ef0e20dbb2aa1b5406d2bb75374fc48187daa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032413-email-washer-d578@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 723ef0e20dbb2aa1b5406d2bb75374fc48187daa Mon Sep 17 00:00:00 2001
From: Kamal Dasu <kamal.dasu@broadcom.com>
Date: Tue, 11 Mar 2025 12:59:35 -0400
Subject: [PATCH] mmc: sdhci-brcmstb: add cqhci suspend/resume to PM ops

cqhci timeouts observed on brcmstb platforms during suspend:
  ...
  [  164.832853] mmc0: cqhci: timeout for tag 18
  ...

Adding cqhci_suspend()/resume() calls to disable cqe
in sdhci_brcmstb_suspend()/resume() respectively to fix
CQE timeouts seen on PM suspend.

Fixes: d46ba2d17f90 ("mmc: sdhci-brcmstb: Add support for Command Queuing (CQE)")
Cc: stable@vger.kernel.org
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://lore.kernel.org/r/20250311165946.28190-1-kamal.dasu@broadcom.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 0ef4d578ade8..48cdcba0f39c 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -503,8 +503,15 @@ static int sdhci_brcmstb_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	int ret;
 
 	clk_disable_unprepare(priv->base_clk);
+	if (host->mmc->caps2 & MMC_CAP2_CQE) {
+		ret = cqhci_suspend(host->mmc);
+		if (ret)
+			return ret;
+	}
+
 	return sdhci_pltfm_suspend(dev);
 }
 
@@ -529,6 +536,9 @@ static int sdhci_brcmstb_resume(struct device *dev)
 			ret = clk_set_rate(priv->base_clk, priv->base_freq_hz);
 	}
 
+	if (host->mmc->caps2 & MMC_CAP2_CQE)
+		ret = cqhci_resume(host->mmc);
+
 	return ret;
 }
 #endif


