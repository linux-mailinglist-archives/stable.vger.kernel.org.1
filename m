Return-Path: <stable+bounces-73865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0AA9706E2
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 13:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129991F20C27
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 11:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D5D1531F6;
	Sun,  8 Sep 2024 11:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wqv0Leeh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133E514C5AE
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 11:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725794947; cv=none; b=itHwmZ/NHW3WzqTX9yO+r7LTwx8kBB2+WDI3Bw9L+FezoKi2mDm0A2cD+B4SE42/vVtmy5RyzX8vPfFOfil5Ja9EFTrFYnuh2mwhqd2tAXi3pw9DDq07ZpJRHT06ai1GzSyVnNVllufgOsxC/jUJPHqaDUFaoX9KSOlwBLRMwjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725794947; c=relaxed/simple;
	bh=HRu93YBXa0zNpVfZEwuE8h4Hn3NVChCLTFASh5Wwv6M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Kl/Jwn6xPLnmxClxwKJv1/1qPmGsxPKIU+u/+AVzGN6YnFTS1wkQ+gX4oNtKwmYtn0M94kG2vX8bbxO9A/bvUFyfGB9NfjtWB1x9TKXsMV1rkwf+c4II83m9xexx46OCsuTJfjD0YFyrPka1W+MnXacyvJ36DgCHqULmRRNkgBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wqv0Leeh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91124C4CEC3;
	Sun,  8 Sep 2024 11:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725794946;
	bh=HRu93YBXa0zNpVfZEwuE8h4Hn3NVChCLTFASh5Wwv6M=;
	h=Subject:To:Cc:From:Date:From;
	b=wqv0LeehQozU/kXN9leAsOQ1zR2S6pDAHSFyJnoZZLYvajiBvFYNxNctvZgbVil6h
	 iQLQgNYHsbHqUGiqkynOkC6/R3C2b5Y+kfUJGMZF5SLwqm6sd5rRQm2easw7toVW2K
	 6grn3SLAXSghrLm9HlANgmfJzB9YGoCveGKGHG5s=
Subject: FAILED: patch "[PATCH] mmc: cqhci: Fix checking of CQHCI_HALT state" failed to apply to 4.19-stable tree
To: sh8267.baek@samsung.com,adrian.hunter@intel.com,ritesh.list@gmail.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 13:28:54 +0200
Message-ID: <2024090853-flogging-deepen-eabe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x aea62c744a9ae2a8247c54ec42138405216414da
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090853-flogging-deepen-eabe@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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


