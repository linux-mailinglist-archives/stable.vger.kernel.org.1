Return-Path: <stable+bounces-100338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B96349EABA6
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFAC016357B
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B3E230D2C;
	Tue, 10 Dec 2024 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fi2W5hw4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1320433985
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822089; cv=none; b=FB8pB24y949Un9Qt0TptjFIFl/uKclozSm+qgIEXTeX9aZyf6hMA0jegx/6nVawXUvN6wGG9hwC8lG+P0PDHA+Fx0an7mkewAWuE2N9FvX4tG1KOoeiMatR/7chf8TaQOoL6HOgM0jnoSTYjFjbXxLniV0mFnuyuNtFo2nG+V+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822089; c=relaxed/simple;
	bh=EzUmlflTcpLkeUVgY42tcAY9ZCMUu5DCGZZkXfrVnZ4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HFWJU1ZUN4Pc9umw+WnN48FtM2GeGmyX6IbvzF/qU1b1E5SJRc1dPdWoLogd8/3dtrZW8pEac3M/p+tJOD+F5gPtaIqZCSBnkiMpNjrkco9TbpLP/ueFCqbkGFVe/KXHBdayXZwjswMY1YMMxD/SaArp52FYGCBxXDNYdUz5oZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fi2W5hw4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46050C4CEDD;
	Tue, 10 Dec 2024 09:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733822088;
	bh=EzUmlflTcpLkeUVgY42tcAY9ZCMUu5DCGZZkXfrVnZ4=;
	h=Subject:To:Cc:From:Date:From;
	b=fi2W5hw4USjousWkTAtzAxgtW/4KjPdbNsFcZHQgi2pm1iAnUjktcj2XxL068J3LH
	 35hEIro1ECfbdGmuwCRkVwgUIHuEXMxsTAsDA/HjE/R2+iWqJUenxPPQK8/FBjgsy7
	 Foe6sv/qC1e9GOa70oB1bvAyLcS/AR6zaz7Z8CqI=
Subject: FAILED: patch "[PATCH] scsi: ufs: pltfrm: Dellocate HBA during" failed to apply to 6.6-stable tree
To: mani@kernel.org,beanhuo@micron.com,bvanassche@acm.org,manivannan.sadhasivam@linaro.org,martin.petersen@oracle.com,peter.wang@mediatek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:14:05 +0100
Message-ID: <2024121004-freeware-secluded-c0d6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 897df60c16d54ad515a3d0887edab5c63da06d1f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121004-freeware-secluded-c0d6@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


