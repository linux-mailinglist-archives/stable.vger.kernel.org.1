Return-Path: <stable+bounces-13056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F204837A58
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E331C237B7
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4FB12BF27;
	Tue, 23 Jan 2024 00:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2T7LR1S+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5DA12BF15;
	Tue, 23 Jan 2024 00:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968905; cv=none; b=m9AQmhnsALbdkOMprKaNs6+Z4z1s6jimxToKg/uLyvO7tvkcYeFdzvfkYEMObX1Y74vRjtRJzPOr+SIacYj0hceoUjK/Krfe1k5lZ44knD57lly6aAl14oDEhXD+YB7QoYQA1iHyXus/yO8t7u9a9MySqBt/uijsJ2yraAmUrrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968905; c=relaxed/simple;
	bh=qjOIJ2SHuAn2yw7IUrL2QdfLUr52cnFf78O61TrVbRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iggM4johoXDR+8hPu9Z6GD2saIEeEWsv+E6IjbFb6ySp+HRjTnSrqQorOZptuBDdAxLXLA+KItQuBGeEzTNSBmqXv1WKooojxvZMlx+QpSiTKT36H2fgOMhqdTd877dX4kBOu0ArDlYzXZ43qq0fSdOp1aLXR++q+q3Z+FG1DB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2T7LR1S+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B71C43390;
	Tue, 23 Jan 2024 00:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705968904;
	bh=qjOIJ2SHuAn2yw7IUrL2QdfLUr52cnFf78O61TrVbRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2T7LR1S+127JAeSA8vuCWGIbUIkNuoZuQVC0XSfWRUof68Kj1BqJbhVqibIzGmgxI
	 JGjMctSC13XumPN8yo75nGxANnYKKj20CpDl2VRVYf1jUIF3wOWUhXq/cTzIONbyzB
	 EkZKM8Fk5ypwnEBtihjGkOOF/bFZts4PE8oKm2CY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yihang Li <liyihang9@huawei.com>,
	Xiang Chen <chenxiang66@hisilicon.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 091/194] scsi: hisi_sas: Replace with standard error code return value
Date: Mon, 22 Jan 2024 15:57:01 -0800
Message-ID: <20240122235723.142303138@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235719.206965081@linuxfoundation.org>
References: <20240122235719.206965081@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yihang Li <liyihang9@huawei.com>

[ Upstream commit d34ee535705eb43885bc0f561c63046f697355ad ]

In function hisi_sas_controller_prereset(), -ENOSYS (Function not
implemented) should be returned if the driver does not support .soft_reset.
Returns -EPERM (Operation not permitted) if HISI_SAS_RESETTING_BIT is
already be set.

In function _suspend_v3_hw(), returns -EPERM (Operation not permitted) if
HISI_SAS_RESETTING_BIT is already be set.

Fixes: 4522204ab218 ("scsi: hisi_sas: tidy host controller reset function a bit")
Signed-off-by: Yihang Li <liyihang9@huawei.com>
Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Link: https://lore.kernel.org/r/1702525516-51258-3-git-send-email-chenxiang66@hisilicon.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 4 ++--
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 7135bbe5abb8..9de27c7f6b01 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1577,10 +1577,10 @@ static int hisi_sas_controller_reset(struct hisi_hba *hisi_hba)
 		queue_work(hisi_hba->wq, &hisi_hba->debugfs_work);
 
 	if (!hisi_hba->hw->soft_reset)
-		return -1;
+		return -ENOENT;
 
 	if (test_and_set_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags))
-		return -1;
+		return -EPERM;
 
 	dev_info(dev, "controller resetting...\n");
 	hisi_sas_controller_reset_prepare(hisi_hba);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index a86aae52d94f..c84d18b23e7b 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3365,7 +3365,7 @@ static int hisi_sas_v3_suspend(struct pci_dev *pdev, pm_message_t state)
 	}
 
 	if (test_and_set_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags))
-		return -1;
+		return -EPERM;
 
 	scsi_block_requests(shost);
 	set_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
-- 
2.43.0




