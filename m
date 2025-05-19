Return-Path: <stable+bounces-144860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D529ABBF4D
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 15:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94033A563A
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 13:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573E219B3CB;
	Mon, 19 May 2025 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z/FiNWn/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10796A94F
	for <stable@vger.kernel.org>; Mon, 19 May 2025 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747661786; cv=none; b=sSwwabUv8Is16flipihCMHoBjHI5DUGNlzPMBM9ebwdDE89bjuRh0hYG+Ve/XpMro4MvpxAfh1tlzscMza7jlzenGLAs7y/E3/d6nW0Q6CMdCDCgfkL4obwbnKAQoMaz5Xxp1NcUAqutpl6mdy0wRE1DXmzikWgSToMnkcRT73Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747661786; c=relaxed/simple;
	bh=d1xBakpHUdgjoQf0xOci0A74KXPs96pvN1/uPHjhzdQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AuhlT5Iefm3kIbjrnjGt/bVMg1vD/N9MCPrwdRUS7SfS08Tu4ZHLP/uLVQ3JkCfO1s7qToO1h9p1RiDHbDdVZzzrbbQilARmOmgSQ1p7jbUYp4SF7Lf7onzthxwtjkKkii3JE2upWkXIKqreBOijAiDsVjLv5fb+Fm1RAmJufC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z/FiNWn/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BFFC4CEE9;
	Mon, 19 May 2025 13:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747661785;
	bh=d1xBakpHUdgjoQf0xOci0A74KXPs96pvN1/uPHjhzdQ=;
	h=Subject:To:Cc:From:Date:From;
	b=z/FiNWn/ETqrHZc2yESfO9LhJd1QzQ706h92a/xqJlF18fO98xSlUoNyWb6qhgbTv
	 cRBnXarYHFJl4N3JJjCXESfyavg8SqaBDUAOzG/Q9FYqu8EAMrqnar9708y59JmVlL
	 pJub8Yjf6TjeYn8v/7BT0H7wSA+7mwhxTQpeUv94=
Subject: FAILED: patch "[PATCH] dmaengine: idxd: Add missing idxd cleanup to fix memory leak" failed to apply to 5.15-stable tree
To: xueshuai@linux.alibaba.com,dave.jiang@intel.com,fenghuay@nvidia.com,vinicius.gomes@intel.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 15:36:22 +0200
Message-ID: <2025051922-ozone-overpass-e4e1@gregkh>
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
git cherry-pick -x d5449ff1b04dfe9ed8e455769aa01e4c2ccf6805
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051922-ozone-overpass-e4e1@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d5449ff1b04dfe9ed8e455769aa01e4c2ccf6805 Mon Sep 17 00:00:00 2001
From: Shuai Xue <xueshuai@linux.alibaba.com>
Date: Fri, 4 Apr 2025 20:02:16 +0800
Subject: [PATCH] dmaengine: idxd: Add missing idxd cleanup to fix memory leak
 in remove call

The remove call stack is missing idxd cleanup to free bitmap, ida and
the idxd_device. Call idxd_free() helper routines to make sure we exit
gracefully.

Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Cc: stable@vger.kernel.org
Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/20250404120217.48772-9-xueshuai@linux.alibaba.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index f2b5b17538c0..974b926bd930 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -1335,6 +1335,7 @@ static void idxd_remove(struct pci_dev *pdev)
 	destroy_workqueue(idxd->wq);
 	perfmon_pmu_remove(idxd);
 	put_device(idxd_confdev(idxd));
+	idxd_free(idxd);
 }
 
 static struct pci_driver idxd_pci_driver = {


