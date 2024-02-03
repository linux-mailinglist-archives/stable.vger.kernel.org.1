Return-Path: <stable+bounces-18455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5B28482CA
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17C01C21525
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF0B4E1D8;
	Sat,  3 Feb 2024 04:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tlOItv2G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1B615AD9;
	Sat,  3 Feb 2024 04:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933811; cv=none; b=dxxhlqrhYYySGnQEYnjk9y9TnLrUzhcH7inLBLxrdetyLwHh7GRPFmUw4DUO1fPoMqsGtuuL2kV/IXRoEe1z2KqtMdTQgmBmuRgb5CImtvGufRoJrOlUvD7cJl9KzQF8QsYWffacNkOZPwpSXu4CfnBL5MrJe+yP1TcB/Sol/zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933811; c=relaxed/simple;
	bh=IQw6wR4/impwDcqSLp58o2KliyVTucn5fYL5dLnIseU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxaHf0Gn+IGTRQCFmKXO2g/cw4thIJRpJJtaYWLf/abJduuamiK1Ah4QQRrOR4wmQ3vz1WnGnLKDbXxUvAfNVgTcrAvnv0nDzpj081vgj5UbxiFtWaRuQOIzOam0QUhBM5ObONbE4dOcy9G2EYK2iuSjhUIqHDP9nYJWM8cdl+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tlOItv2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412A4C433F1;
	Sat,  3 Feb 2024 04:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933811;
	bh=IQw6wR4/impwDcqSLp58o2KliyVTucn5fYL5dLnIseU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tlOItv2GhTRKCs5Ayo6ecLo2jveo54ib8Y9PgIEQxjw2gkC+NclJRH8ghEkipLwt2
	 NHWAIgIj1hV5pJ+TJJ+9rmPyGbX88ulilb0b51f1/FouC8aHUEsMNbMilg+WBe7COn
	 ZHlm27s8PwvLseUb0PWc4ZGd1WASXcHGrCYy2WnE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yihang Li <liyihang9@huawei.com>,
	Xiang Chen <chenxiang66@hisilicon.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 128/353] scsi: hisi_sas: Set .phy_attached before notifing phyup event HISI_PHYE_PHY_UP_PM
Date: Fri,  2 Feb 2024 20:04:06 -0800
Message-ID: <20240203035407.773942797@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035403.657508530@linuxfoundation.org>
References: <20240203035403.657508530@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yihang Li <liyihang9@huawei.com>

[ Upstream commit ce26497c745d0541aec930d5211b431a1c26af97 ]

Currently in directly attached scenario, the phyup event
HISI_PHYE_PHY_UP_PM is notified before .phy_attached is set - this may
cause the phyup work hisi_sas_bytes_dmaed() execution failed and the
attached device will not be found.

To fix it, set .phy_attached before notifing phyup event.

Signed-off-by: Yihang Li <liyihang9@huawei.com>
Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Link: https://lore.kernel.org/r/1702525516-51258-2-git-send-email-chenxiang66@hisilicon.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 6d8577423d32..b56fbc61a15a 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -1605,6 +1605,11 @@ static irqreturn_t phy_up_v3_hw(int phy_no, struct hisi_hba *hisi_hba)
 	}
 
 	phy->port_id = port_id;
+	spin_lock(&phy->lock);
+	/* Delete timer and set phy_attached atomically */
+	del_timer(&phy->timer);
+	phy->phy_attached = 1;
+	spin_unlock(&phy->lock);
 
 	/*
 	 * Call pm_runtime_get_noresume() which pairs with
@@ -1618,11 +1623,6 @@ static irqreturn_t phy_up_v3_hw(int phy_no, struct hisi_hba *hisi_hba)
 
 	res = IRQ_HANDLED;
 
-	spin_lock(&phy->lock);
-	/* Delete timer and set phy_attached atomically */
-	del_timer(&phy->timer);
-	phy->phy_attached = 1;
-	spin_unlock(&phy->lock);
 end:
 	if (phy->reset_completion)
 		complete(phy->reset_completion);
-- 
2.43.0




