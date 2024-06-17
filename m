Return-Path: <stable+bounces-52501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8C290B0D5
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 16:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8231C2111B
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 14:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ECF18DE15;
	Mon, 17 Jun 2024 13:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+x7NBmg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B2218DE0B;
	Mon, 17 Jun 2024 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630784; cv=none; b=GIRNw0f954hMrEYCKXyRHfB0tnf1+Cynptj2xS1YSPlo1OQIgzbgPyNhfDWzYgjwdkYXcpOAcbksGrQqVVZK1WSrgowbSqokU24E3UAjfDJcYYFguStG5JoKPUI6OLH0N5pmOk+MM0E0V7Y4ovJhghXtjov3Yed9DxiU+QC5ELc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630784; c=relaxed/simple;
	bh=zHjJf4OWe8e97IUJG1XK+iHWdvna9Yj45AE+/I2wCvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ky59/7BQ+RXdNuvppunzTVJDKwi9GmM6bk1IwLW9FfnjBQGgou3HakotGdscmH0w3h2m8ZYy7+bHaSn5clgm14/ABltgUmyZtkl36U06XrJnayGpw18kEVicIl8CN5o9coZcHlXn1SkfIAqaQ0w4E0jw/i03+CzPHmsOZ0OfhU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+x7NBmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662F0C4AF1C;
	Mon, 17 Jun 2024 13:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630784;
	bh=zHjJf4OWe8e97IUJG1XK+iHWdvna9Yj45AE+/I2wCvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X+x7NBmgboQpZxjhxaJjUyUVZGvLWkdsAts8z5FrJPALmoX2cphFXzp0DTIWkPNSR
	 dZLtyB7DHvDKVgCuccrwKkmat0uXuYxNBE+xTv6EWVoIpYIRnxd4oO8ugBp01cdxru
	 220qeJ2HTCIOhwQqI2KxJeTCFfEp2C5KPUJX5rwdZM9NNH01mA5WznFalK7Ckb+SBI
	 5+6B4vL2F89tTLe+HtppusPYOw7yYERkkF4DW50B/8sudH2MHPnWeCIygHpSdypU0a
	 lTDY2a05mDGACxl7pkmsuJ/o3nKCw8m2ST4IbfDoG+YVhc41CcnzhOBt1rMOoT5d68
	 lqqXHmUrn5ILA==
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
Subject: [PATCH AUTOSEL 5.15 04/21] scsi: qedf: Set qed_slowpath_params to zero before use
Date: Mon, 17 Jun 2024 09:25:41 -0400
Message-ID: <20240617132617.2589631-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132617.2589631-1-sashal@kernel.org>
References: <20240617132617.2589631-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.161
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
index 1900acfee88ed..690d3464f8766 100644
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


