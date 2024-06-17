Return-Path: <stable+bounces-52473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDF490B06C
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 15:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C0D28B255
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 13:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524B21662F6;
	Mon, 17 Jun 2024 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGfF9fTS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4FA1662EA;
	Mon, 17 Jun 2024 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630706; cv=none; b=GEJeA+NrydPWoMwCJ3ZOpIH6Q7cRZE+y89S3brNZKHzxlx2VUyOs4Bqxo/hyh4C6V/GyYTtnK0gSeWsqyxEmv9RIGx8kkxzIau2/8jgVNnie+PXKnvg3XSJY9/o0i+23SoQsULm9U45mczn68FFSWRyT7NhenOtu5lPOHKqo20E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630706; c=relaxed/simple;
	bh=KB1BAl9JtSHkWwfh6blSRPpQynzr/Uzdt8CT05pJZH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Daok6IYqIyOv6AN3fKSl7Tur7trtMxLCAr3vBdialDxwqSdYCuu29hxGTx+Jbzn0LNoSiTxlSSl/J6iSwalyaMJn6fwE9LtJ7xpN4+vS9P4wTDB2qgKPYig6/euWcjYQF1AzYH8w2U5BHvIFOixd2PubDCF7DtT4yyWKR+QxR0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGfF9fTS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A46AC4AF4D;
	Mon, 17 Jun 2024 13:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630705;
	bh=KB1BAl9JtSHkWwfh6blSRPpQynzr/Uzdt8CT05pJZH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sGfF9fTS6JJ0WU9Udhvw9r8wlFcVIfkoJKIPCZIEOKojr0RpMSLmBUBqRBxXKWNn4
	 3ocf83qAuq7mjM21YFiKxdJz1HPN6zimyeJ6sC4U0/TXhORxm+uFH3fzHCvwJ2krXO
	 8esRZHBp09x1zCmx573d7YCh2Roa/Bddu53DJ4n77opWxEnTIkaFORTa8w3o32OmBO
	 1NG1Y31xfX5YY0YktfraOFt2OuyJo8ViXNOSFEZ79UCWL8mWK4IxcO8sfPAyxu2gQI
	 x4i81trZpjzk5qeYwOlrofPk8H4PM9V39a023wT6JFUFPuN0xhDciuwFUTEHPJTCH2
	 61VPJUTSVHsmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Saurav Kashyap <skashyap@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	jhasan@marvell.com,
	GR-QLogic-Storage-Upstream@marvell.com,
	James.Bottomley@HansenPartnership.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/29] scsi: qedf: Set qed_slowpath_params to zero before use
Date: Mon, 17 Jun 2024 09:24:09 -0400
Message-ID: <20240617132456.2588952-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132456.2588952-1-sashal@kernel.org>
References: <20240617132456.2588952-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.94
Content-Transfer-Encoding: 8bit

From: Saurav Kashyap <skashyap@marvell.com>

[ Upstream commit 6c3bb589debd763dc4b94803ddf3c13b4fcca776 ]

Zero qed_slowpath_params before use.

Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20240515091101.18754-4-skashyap@marvell.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qedf/qedf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index 524807f9f4eb1..179967774cc8c 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -3477,6 +3477,7 @@ static int __qedf_probe(struct pci_dev *pdev, int mode)
 	}
 
 	/* Start the Slowpath-process */
+	memset(&slowpath_params, 0, sizeof(struct qed_slowpath_params));
 	slowpath_params.int_mode = QED_INT_MODE_MSIX;
 	slowpath_params.drv_major = QEDF_DRIVER_MAJOR_VER;
 	slowpath_params.drv_minor = QEDF_DRIVER_MINOR_VER;
-- 
2.43.0


