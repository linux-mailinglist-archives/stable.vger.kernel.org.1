Return-Path: <stable+bounces-52541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5930990B18C
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 16:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D821FB3CEA7
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 14:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698BD1BD8EC;
	Mon, 17 Jun 2024 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APAXreI/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238431BD8E5;
	Mon, 17 Jun 2024 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630880; cv=none; b=rFHS9BxWY12SImQYjwitiBgA1HemLbkmFusfCotV9jUZwf6HCMWgjzPxsaGL6bIXmMFzM6RIFg4twEOjS37y5D2OT9UGTUsoIjVV33UjxrCtFyxV7YCZcbPC0gHnXae8wRkQgydWDAOwtsOMKyWi6AvHUg429VTHp09901RvMlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630880; c=relaxed/simple;
	bh=mrr1/gnGhxIFsA7Wmc+9BmFIO5sb64qepIbcGbCrJak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bx96pEkfm2PFplPKkdl9L41eOLAALBdbnS5YYgA4MpzcqQVizgaf1O0QumEkf/J7FVmJyTakKg28qDJbHtGF6Jfi9rSojJ8Uv5CbvgyXu4njGF4OVR2c+9g3+L8FTIxhDedNtu4G9tWtgWUaco5CYWTuXqFHwzagLtcXGx0FFcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APAXreI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E437FC2BD10;
	Mon, 17 Jun 2024 13:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630880;
	bh=mrr1/gnGhxIFsA7Wmc+9BmFIO5sb64qepIbcGbCrJak=;
	h=From:To:Cc:Subject:Date:From;
	b=APAXreI/DLlu6Diw2J4vUoPIGeco199lAoQQhqFOTZLcRHXLF+FfyPWMRkT2whfpo
	 jw3RV0txevqq4quZSOOcYQsR6kRAUY52O1koS5v3oTnHNLV+DR+WlZaqHLYanoET8M
	 RAKcD0ibK681AAZQsKNkB2EcccOOthHG2p7Wjysz98PLw2SSyYfxQDQ0EsalAzfTQt
	 GI0eP1Az10ewoYVtT0dZAOB8XIozZXxGpzR5f8CrHHy4dPBbzxRoxJ3Fjh6JfBNVcV
	 fS0W6VmYMuvy5WGd0Z+/2u36xbd4CsGLFUoIv6tMKLt44639SShczfyIX9NALpxFpk
	 gE8BY22nQrL5g==
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
Subject: [PATCH AUTOSEL 4.19 1/9] scsi: qedf: Set qed_slowpath_params to zero before use
Date: Mon, 17 Jun 2024 09:27:46 -0400
Message-ID: <20240617132757.2590643-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.316
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
index 01e27285b26ba..33fb0e1926831 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -3101,6 +3101,7 @@ static int __qedf_probe(struct pci_dev *pdev, int mode)
 	}
 
 	/* Start the Slowpath-process */
+	memset(&slowpath_params, 0, sizeof(struct qed_slowpath_params));
 	slowpath_params.int_mode = QED_INT_MODE_MSIX;
 	slowpath_params.drv_major = QEDF_DRIVER_MAJOR_VER;
 	slowpath_params.drv_minor = QEDF_DRIVER_MINOR_VER;
-- 
2.43.0


