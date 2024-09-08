Return-Path: <stable+bounces-73864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8A49706E3
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 13:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FC07B21337
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 11:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D227C1531ED;
	Sun,  8 Sep 2024 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vOQK3r0Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AD714C5AE
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725794944; cv=none; b=YuMwI70QNIJZcvOH4Juc/+IwLxfxzzwZVUIDO3GF3+wzCWIuWnzWmkxhLr0ah6Lh1p+/TnBKQWbvL+nPtJGQPnECig26aB7FwCf+1zuE8XBYThGMnKgcRtGVYCAv3wN8Z90nnZ43YITpMRJGc0wY0BWcy88fDiIqzxuHYE+VIPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725794944; c=relaxed/simple;
	bh=iwPd4VB5k8RIYuNwBb+gPy72Nqai4VOeKnN/SRz8mrE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M1ied4e59mdMeq9Hv1k6ioVqd0S5wgdttHtP/2FLTCs1EN0XaTw/iFuPzXdUgNGx+E1vrFvOwoQ+S9+jysNTosR1id4l6xlIzu5tZrdknPZvyY8fhYmJLzn/ACwNeLIDhVFa4MkH7Nkde9Eur9rIVHlCuGu7gB+wSNJswvWH38c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vOQK3r0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91D2C4CEC3;
	Sun,  8 Sep 2024 11:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725794944;
	bh=iwPd4VB5k8RIYuNwBb+gPy72Nqai4VOeKnN/SRz8mrE=;
	h=Subject:To:Cc:From:Date:From;
	b=vOQK3r0QG55fY26NvbS0VxXkL2RClO+EqdqIM3QaGAnmTCNu3sgvhfXqO05LxlE4e
	 YbP8vx3ql6UdQTrXsTx94TDJEP3J0wocx5VUrdGTAD1h+NJi5nYmFr3ma7eDzX6bNl
	 YX3Bj2uiSfa74LxY3abFg2FtmEVQ1KS5nkv7s7ys=
Subject: FAILED: patch "[PATCH] mmc: cqhci: Fix checking of CQHCI_HALT state" failed to apply to 5.4-stable tree
To: sh8267.baek@samsung.com,adrian.hunter@intel.com,ritesh.list@gmail.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 13:28:53 +0200
Message-ID: <2024090853-unweave-borrowing-7c2a@gregkh>
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
git cherry-pick -x aea62c744a9ae2a8247c54ec42138405216414da
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090853-unweave-borrowing-7c2a@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


