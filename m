Return-Path: <stable+bounces-43935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 073058C5053
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB3D1F2107C
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDC613C692;
	Tue, 14 May 2024 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bYtaZAP3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA7C13B59A;
	Tue, 14 May 2024 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683181; cv=none; b=SGH8ehClKkI+JhMR3llYUVzuTIZwH6gcW5ApZhGnuWrz3KAwA7JVkwwF3B5h3aePgzmwfab8Uc7MWqD5DbmVLNcx6VsjCOUAYUHyZ1vF/bGJyXpRCsZR864VGr7g6C5IwEe1MYXIN6yAHcxQj/mhDT7OWDgv9u+p5LP++XKMrWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683181; c=relaxed/simple;
	bh=mFG6ood5AqhaAWjZwJweb864OUF00cmo1E7YyqXSOkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SwtPIhKMPYhCRuy7um+WwEauiothV4UI/i9qMx4CIhHXYaXGjFvG4Hb+Kl2pBjS6bauYn2RoPlOINKJnrgMDrkeH1kkaLh7H9FilBb8VoERuzNc0V9Jzew5Hfvgga90FPSkDEehgG7XerX5dUDRqAywQZYBbtg1875GDfhcoHqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bYtaZAP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB80BC2BD10;
	Tue, 14 May 2024 10:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715683181;
	bh=mFG6ood5AqhaAWjZwJweb864OUF00cmo1E7YyqXSOkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bYtaZAP3CtFf9eGdnsipJEUF0i+6oHPQgMVDz6cIwk+nr1GD+ljkXkqYw22VbDhmO
	 ztdeEy1nvq+Ttm7JQ4YcLa4nJa2aFTwvAYqJNAMCSU6m+A+JuXSDg4Fr6Jj41fejFy
	 o4iKiR/KeE8IiyjwkMXtmkQZWED18xC1DV8KCwNQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xingui Yang <yangxingui@huawei.com>,
	Xiang Chen <chenxiang66@hisilicon.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 148/336] scsi: hisi_sas: Handle the NCQ error returned by D2H frame
Date: Tue, 14 May 2024 12:15:52 +0200
Message-ID: <20240514101044.189640128@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiang Chen <chenxiang66@hisilicon.com>

[ Upstream commit 358e919a351f2ea4b412e7dac6b1c23ec10bd4f5 ]

We find that some disks use D2H frame instead of SDB frame to return NCQ
error. Currently, only the I/O corresponding to the D2H frame is processed
in this scenario, which does not meet the processing requirements of the
NCQ error scenario.  So we set dev_status to HISI_SAS_DEV_NCQ_ERR and abort
all I/Os of the disk in this scenario.

Co-developed-by: Xingui Yang <yangxingui@huawei.com>
Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Link: https://lore.kernel.org/r/20240402035513.2024241-2-chenxiang66@hisilicon.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index b56fbc61a15ae..86112f234740d 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2244,7 +2244,15 @@ slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
 	case SAS_PROTOCOL_SATA | SAS_PROTOCOL_STP:
 		if ((dw0 & CMPLT_HDR_RSPNS_XFRD_MSK) &&
 		    (sipc_rx_err_type & RX_FIS_STATUS_ERR_MSK)) {
-			ts->stat = SAS_PROTO_RESPONSE;
+			if (task->ata_task.use_ncq) {
+				struct domain_device *device = task->dev;
+				struct hisi_sas_device *sas_dev = device->lldd_dev;
+
+				sas_dev->dev_status = HISI_SAS_DEV_NCQ_ERR;
+				slot->abort = 1;
+			} else {
+				ts->stat = SAS_PROTO_RESPONSE;
+			}
 		} else if (dma_rx_err_type & RX_DATA_LEN_UNDERFLOW_MSK) {
 			ts->residual = trans_tx_fail_type;
 			ts->stat = SAS_DATA_UNDERRUN;
-- 
2.43.0




