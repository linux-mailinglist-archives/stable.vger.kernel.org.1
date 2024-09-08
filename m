Return-Path: <stable+bounces-73863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 936789706E1
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 13:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BECAB213AD
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 11:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D182E1531ED;
	Sun,  8 Sep 2024 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aYJeDeIr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9197114C5AE
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725794935; cv=none; b=NKmjUf516FXqrH7IMJyAwZAhl4ocfVywMBzxAVC7c6BMyqSLwYrGmbY5GMcBkOUGXHCbQUD5wUVx7rd36bkf6fUdNgKQt7nAzq3c9LjNTNUrn7sGDoADjfXAD+1wxYzhhVIqgAyrZxmhBZAhvYu1IpZWK4pmVydOJ5uou4lBlpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725794935; c=relaxed/simple;
	bh=Z0zAUD/rciWMOiOjbUargSF1WbhjhiyrV69z89HuYYI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=htLJwbOiohtwkTVPDeUTVw13krxFT24ZXnEh34mWaKN4KNaf4fZapaK5qfZD/HKMI1oOYMByuIs+QX4kf+LZm6CHVWVDAxWBgL3KxZz8Lx9ihrbVavuindxpjloYaebPaUF5hWFUT6gaodGpqaZgfAGFMUKWYZN+JSWV6RXrob0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aYJeDeIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF5CC4CEC3;
	Sun,  8 Sep 2024 11:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725794935;
	bh=Z0zAUD/rciWMOiOjbUargSF1WbhjhiyrV69z89HuYYI=;
	h=Subject:To:Cc:From:Date:From;
	b=aYJeDeIrgW6EwOx1iIDkeJlcn3gFaFJMJ4/zAN5N1L1V0wZes3thTNvjd5Iz8ewqe
	 fmwxpk+g/fJ5udFSrIMoLvt1MX9XKp5Cen+ZQVmUbfvNB+4hNN5HHXM3LcdpSydAkE
	 x47XmfYJD0kHtwJMfPlCOhsqg7BzeoHjTne87QXQ=
Subject: FAILED: patch "[PATCH] mmc: cqhci: Fix checking of CQHCI_HALT state" failed to apply to 5.10-stable tree
To: sh8267.baek@samsung.com,adrian.hunter@intel.com,ritesh.list@gmail.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 13:28:52 +0200
Message-ID: <2024090852-importer-unadorned-f55b@gregkh>
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
git cherry-pick -x aea62c744a9ae2a8247c54ec42138405216414da
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090852-importer-unadorned-f55b@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

aea62c744a9a ("mmc: cqhci: Fix checking of CQHCI_HALT state")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aea62c744a9ae2a8247c54ec42138405216414da Mon Sep 17 00:00:00 2001
From: Seunghwan Baek <sh8267.baek@samsung.com>
Date: Thu, 29 Aug 2024 15:18:22 +0900
Subject: [PATCH] mmc: cqhci: Fix checking of CQHCI_HALT state

To check if mmc cqe is in halt state, need to check set/clear of CQHCI_HALT
bit. At this time, we need to check with &, not &&.

Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
Cc: stable@vger.kernel.org
Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>
Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20240829061823.3718-2-sh8267.baek@samsung.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index c14d7251d0bb..a02da26a1efd 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -617,7 +617,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		cqhci_writel(cq_host, 0, CQHCI_CTL);
 		mmc->cqe_on = true;
 		pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
-		if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT) {
+		if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT) {
 			pr_err("%s: cqhci: CQE failed to exit halt state\n",
 			       mmc_hostname(mmc));
 		}


