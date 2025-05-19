Return-Path: <stable+bounces-144846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C14A0ABBEE7
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 15:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD33A1B614DA
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 13:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967791E2834;
	Mon, 19 May 2025 13:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BJdjqIDY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5683B4B1E5D
	for <stable@vger.kernel.org>; Mon, 19 May 2025 13:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747660583; cv=none; b=fRUxa66cwdtT5mmtBPWoDLQyU6u8aQXvsWosp4Lw1KS6WkcrJPABm28IrXBsv/+rzRasX/qkRI1l9/2mcJjq0+tgV7l0PB96/B4M/Qg9TbhBaTTGKEwCgq6DKERLrZo9H8w1fdKTGLbIahGKNJ4jWKcOTwJ3mzWPBIxPr2bDIp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747660583; c=relaxed/simple;
	bh=Wwrbw7K/YDwaXjzMfVdG1rTECx821CMQwxcFm98OtWI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CJeZPY908fMfa4O6S+qMnbNxAri5jGiz0zVA/vg2eV7Yaz0yCIsxPcszPzsrowyFeXaqubzLMCOvUU7F2DkrAAajCRAh4eTB3xdapNdnbLFmp6uuuJ8WyKcGoSsJZcdH1yHg9OTn8k6d8bf2i0Nf7zuX6n/btAzmVnHDeUJl/QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BJdjqIDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1293FC4CEE4;
	Mon, 19 May 2025 13:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747660582;
	bh=Wwrbw7K/YDwaXjzMfVdG1rTECx821CMQwxcFm98OtWI=;
	h=Subject:To:Cc:From:Date:From;
	b=BJdjqIDY57LTtG0DE/rrKW22Oqyr4QDWw1FDpMTm3Qr5mYlHETtr+A/d4ekk5bXaU
	 OGzkv0l/+aRDq8NqP2vvwIAROb2ctAVzyyGrZUIFumQMKt1YzOTd/wcgDloE5Tooo2
	 Jkw+A1IWW5EoSwBGRTTqQ0d6H1rRgoyQx+EiGug4=
Subject: FAILED: patch "[PATCH] dmaengine: idxd: fix memory leak in error handling path of" failed to apply to 5.10-stable tree
To: xueshuai@linux.alibaba.com,dave.jiang@intel.com,fenghuay@nvidia.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 15:16:19 +0200
Message-ID: <2025051919-legislate-uptake-1812@gregkh>
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
git cherry-pick -x 90022b3a6981ec234902be5dbf0f983a12c759fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051919-legislate-uptake-1812@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 90022b3a6981ec234902be5dbf0f983a12c759fc Mon Sep 17 00:00:00 2001
From: Shuai Xue <xueshuai@linux.alibaba.com>
Date: Fri, 4 Apr 2025 20:02:15 +0800
Subject: [PATCH] dmaengine: idxd: fix memory leak in error handling path of
 idxd_pci_probe

Memory allocated for idxd is not freed if an error occurs during
idxd_pci_probe(). To fix it, free the allocated memory in the reverse
order of allocation before exiting the function in case of an error.

Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Cc: stable@vger.kernel.org
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Link: https://lore.kernel.org/r/20250404120217.48772-8-xueshuai@linux.alibaba.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 302d8983ed8c..f2b5b17538c0 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -587,6 +587,17 @@ static void idxd_read_caps(struct idxd_device *idxd)
 		idxd->hw.iaa_cap.bits = ioread64(idxd->reg_base + IDXD_IAACAP_OFFSET);
 }
 
+static void idxd_free(struct idxd_device *idxd)
+{
+	if (!idxd)
+		return;
+
+	put_device(idxd_confdev(idxd));
+	bitmap_free(idxd->opcap_bmap);
+	ida_free(&idxd_ida, idxd->id);
+	kfree(idxd);
+}
+
 static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_data *data)
 {
 	struct device *dev = &pdev->dev;
@@ -1255,7 +1266,7 @@ int idxd_pci_probe_alloc(struct idxd_device *idxd, struct pci_dev *pdev,
  err:
 	pci_iounmap(pdev, idxd->reg_base);
  err_iomap:
-	put_device(idxd_confdev(idxd));
+	idxd_free(idxd);
  err_idxd_alloc:
 	pci_disable_device(pdev);
 	return rc;


