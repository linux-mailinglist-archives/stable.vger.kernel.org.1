Return-Path: <stable+bounces-30057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A5088893D
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 03:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D779286B43
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 02:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668C920A07E;
	Sun, 24 Mar 2024 23:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bko9vNPg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A456209E09;
	Sun, 24 Mar 2024 23:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321576; cv=none; b=LpHQcUsxaHw2OLfxaM1RJ5fomloTlqHWbLfxh7d+NFvu/kGbbcFQhU7YH5Cw91SY2Uu2uHDwe/93SxMmPDYc9q40antpcLxpGzOxwSsvvjQ/i1HRJUzW/j/2DkVHsmkMrMPhUbQ0+sxeNDYljRnL6uydvudEmhiqLyEWLZ/AKeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321576; c=relaxed/simple;
	bh=wGZxg1q8yDgJDNdNmNtLHsHwcPMgXz5yMjq37oyCMdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WaoxZgP+55lMnEqAVQkw6rST2VQz1qw9mTq93Mpi1DZTFzzt72bFjkxHS2MiQQRqkOeinwARH3AdP9/h0Z7eZyypSl1OG68lh3TDR/sw3r+mDEMHtt6gQKWkaCK4LeQTNwt5vAWDYiPPW467FCaqg/q/UO/K6yspFEXeBS61ozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bko9vNPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901A9C433B2;
	Sun, 24 Mar 2024 23:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321575;
	bh=wGZxg1q8yDgJDNdNmNtLHsHwcPMgXz5yMjq37oyCMdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bko9vNPg2bAsoeDUot8HFOuHwWOt3K/G5IHMd2k2fBoeUVqc/WzUU8V3V4y/4TVaP
	 zvjMwPUrval4g2UZ8gYsdlDYguL6M9pMKWu9ZREMcSEoizyIXsvnCjyyfk4hBIBc3e
	 Op2FnvBWcRW83fV+CfdU7V0KOP/2NFFUcySi7Q19zXE4epOXUnM/KjLn9wUKRe3hmU
	 PFhXtCeanR8D1LdNH+XWCTohzAyfKW2O67+ljadXKMuZe66OBNII9wQSJrkW1vXLv6
	 uKwjRukjvYiryhYFzxXe1ELWQObHVm9+a9m68tFzqVRrys+eb5twIQKXprQloVPxub
	 k9Z1fudAKrBqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 303/638] Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()
Date: Sun, 24 Mar 2024 18:55:40 -0400
Message-ID: <20240324230116.1348576-304-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[ Upstream commit 56d074d26c5828773b00b2185dd7e1d08273b8e8 ]

The optional variants for the gpiod_get() family of functions return NULL
if the GPIO in question is not associated with this device. They return
ERR_PTR() on any other error. NULL descriptors are graciously handled by
GPIOLIB and can be safely passed to any of the GPIO consumer interfaces
as they will return 0 and act as if the function succeeded. If one is
using the optional variant, then there's no point in checking for NULL.

Fixes: 6845667146a2 ("Bluetooth: hci_qca: Fix NULL vs IS_ERR_OR_NULL check in qca_serdev_probe")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_qca.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index f9abcc13b4bcd..f2d4985e036e4 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2295,7 +2295,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
-		if (IS_ERR_OR_NULL(qcadev->bt_en) &&
+		if (IS_ERR(qcadev->bt_en) &&
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855)) {
 			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
@@ -2304,7 +2304,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
 					       GPIOD_IN);
-		if (IS_ERR_OR_NULL(qcadev->sw_ctrl) &&
+		if (IS_ERR(qcadev->sw_ctrl) &&
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855 ||
 		     data->soc_type == QCA_WCN7850))
@@ -2326,7 +2326,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	default:
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
-		if (IS_ERR_OR_NULL(qcadev->bt_en)) {
+		if (IS_ERR(qcadev->bt_en)) {
 			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
 			power_ctrl_enabled = false;
 		}
-- 
2.43.0


