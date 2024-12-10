Return-Path: <stable+bounces-100340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1B89EABA7
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34DC28A605
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9147231C97;
	Tue, 10 Dec 2024 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rKytNaXF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D4433985
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822093; cv=none; b=asDWw2mTWfUjYA3C3iJTgR+2AOPGbV77PUb28e6pZI2sy0gFQMnvUvSrTIvTwBpQlsWrBN7X8YR6uZ+WHXp5jG0p+xI0oDafoXFw2OcmVYigsw3pGo1TCvQxp3xU/dMwpgWef94E3V2dUS46uyAF+zjbajXwza3ELPZZk+iOShg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822093; c=relaxed/simple;
	bh=PXxbHI/dwyZaQTSgN2Rn9VAeMo24Sh+SNJtZ5eNvHng=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZKGjWQYo5P5yTfUT+Jh1GCO/6cJxQslsNsyO1HLmBcgihJM4ymhxV2OfCsa50TSfEte1c+aEuEr2i04QikmLooc8FyJK3WYVD+0y0dBU/OMrONqT9DEMt/O+9INje0su/jGvqEeewkgstyuAAGjTOxoP8oteifzSLuBYfdg57fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rKytNaXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC28C4CEDD;
	Tue, 10 Dec 2024 09:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733822093;
	bh=PXxbHI/dwyZaQTSgN2Rn9VAeMo24Sh+SNJtZ5eNvHng=;
	h=Subject:To:Cc:From:Date:From;
	b=rKytNaXFw9k4QK6QSuGHpNdDO3J79l3jePeU2MGIdaCxo7S/aVMAba69Z52tx40lq
	 BGnvYwLBZE//L+FOJUafdHg79G2d8duJmac59HRFUOFonNLzV/my9tn9D2iv4JhzYR
	 +LbJy0L0Un9v0j+EJhyAo34qOiW/iuTCCyxhocDc=
Subject: FAILED: patch "[PATCH] scsi: ufs: pltfrm: Dellocate HBA during" failed to apply to 6.1-stable tree
To: mani@kernel.org,beanhuo@micron.com,bvanassche@acm.org,manivannan.sadhasivam@linaro.org,martin.petersen@oracle.com,peter.wang@mediatek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:14:06 +0100
Message-ID: <2024121005-overrate-pulp-88b3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 897df60c16d54ad515a3d0887edab5c63da06d1f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121005-overrate-pulp-88b3@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 897df60c16d54ad515a3d0887edab5c63da06d1f Mon Sep 17 00:00:00 2001
From: Manivannan Sadhasivam <mani@kernel.org>
Date: Mon, 11 Nov 2024 23:18:34 +0530
Subject: [PATCH] scsi: ufs: pltfrm: Dellocate HBA during
 ufshcd_pltfrm_remove()

This will ensure that the scsi host is cleaned up properly using
scsi_host_dev_release(). Otherwise, it may lead to memory leaks.

Cc: stable@vger.kernel.org # 4.4
Fixes: 03b1781aa978 ("[SCSI] ufs: Add Platform glue driver for ufshcd")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20241111-ufs_bug_fix-v1-5-45ad8b62f02e@linaro.org
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
index b8dadd0a2f4c..505572d4fa87 100644
--- a/drivers/ufs/host/ufshcd-pltfrm.c
+++ b/drivers/ufs/host/ufshcd-pltfrm.c
@@ -534,6 +534,7 @@ void ufshcd_pltfrm_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(&pdev->dev);
 	ufshcd_remove(hba);
+	ufshcd_dealloc_host(hba);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 }


