Return-Path: <stable+bounces-172474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5745B3211C
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 19:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91622B04C86
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 17:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DE83126D0;
	Fri, 22 Aug 2025 17:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxdJNrG2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4633214AD2D
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755882409; cv=none; b=A/Hn+zHxM3+Ggprv4dUBVYZBRcyvpA4HfLjE38TzxeKRfYVV8RAO3Ocks+JN/Hbed/BICCAC/PmTgI8++Mun4UNxifMd9cnYlClxE4TMIMj097xgXRIIYsNFml+7l3KeOcoOACneRCOneo/S9hhA6BoJZwDrnq7EshCaj8hHgVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755882409; c=relaxed/simple;
	bh=4ugULoPLpaPpB7LAl96zEw0blX41lSjC2sA1GMcE2wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqhFHScjnHjxC70C+Hok2TQDO1h1LfZXoeb40LTjRRZg64qeFpW43+MpMzx0/YymB+ndIwK1sUgUXa9vBvp7ZEPdJ7NAFZsKkfnz125Nv2YKLPUhPr50h6d6Vm/A+kBIWsLByEnhwQ8e/mKwHK7J88xq2S6dk1cFpYXnO5F1UNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxdJNrG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E57C4CEED;
	Fri, 22 Aug 2025 17:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755882408;
	bh=4ugULoPLpaPpB7LAl96zEw0blX41lSjC2sA1GMcE2wE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JxdJNrG2NEkl9EhpgDigpSc8otMTXPwjPv9b41lK1MJHnUahlyYQ3qviAmsblSuqP
	 SgV8vVoRuoJrjRRdovX8wCG4gDZEcCTf2dkigMj2n3wY/BDIwheRRITq/PrLCq6pRQ
	 9vMos1whK2Ft+gam9T53YeBZwH3AkSnP4+vBWbp4z5QxSnaeowjxk/3yycdAd8ORBC
	 oFxn9Wty1DoVltU4FSbslzV+5LQS0H5iWIKIprWwznhuEdND3rsIiZijmHJ47ClmRz
	 /KJq69WcB8ojV64HV9p6jbabK1ZzQ8n8YUxNHZYhiWzcY1HkYnnqQZDmcVMxuAR1l+
	 cWLRib3CLqgpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] scsi: ufs: exynos: Fix programming of HCI_UTRL_NEXUS_TYPE
Date: Fri, 22 Aug 2025 13:06:46 -0400
Message-ID: <20250822170646.1321395-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082137-sinister-shadiness-a5da@gregkh>
References: <2025082137-sinister-shadiness-a5da@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: André Draszik <andre.draszik@linaro.org>

[ Upstream commit 01aad16c2257ab8ff33b152b972c9f2e1af47912 ]

On Google gs101, the number of UTP transfer request slots (nutrs) is 32,
and in this case the driver ends up programming the UTRL_NEXUS_TYPE
incorrectly as 0.

This is because the left hand side of the shift is 1, which is of type
int, i.e. 31 bits wide. Shifting by more than that width results in
undefined behaviour.

Fix this by switching to the BIT() macro, which applies correct type
casting as required. This ensures the correct value is written to
UTRL_NEXUS_TYPE (0xffffffff on gs101), and it also fixes a UBSAN shift
warning:

    UBSAN: shift-out-of-bounds in drivers/ufs/host/ufs-exynos.c:1113:21
    shift exponent 32 is too large for 32-bit type 'int'

For consistency, apply the same change to the nutmrs / UTMRL_NEXUS_TYPE
write.

Fixes: 55f4b1f73631 ("scsi: ufs: ufs-exynos: Add UFS host support for Exynos SoCs")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
Link: https://lore.kernel.org/r/20250707-ufs-exynos-shift-v1-1-1418e161ae40@linaro.org
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[ Adapted context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/host/ufs-exynos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index e981f1f8805f..17db3f8c8c51 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -1028,8 +1028,8 @@ static int exynos_ufs_post_link(struct ufs_hba *hba)
 	hci_writel(ufs, 0xa, HCI_DATA_REORDER);
 	hci_writel(ufs, PRDT_SET_SIZE(12), HCI_TXPRDT_ENTRY_SIZE);
 	hci_writel(ufs, PRDT_SET_SIZE(12), HCI_RXPRDT_ENTRY_SIZE);
-	hci_writel(ufs, (1 << hba->nutrs) - 1, HCI_UTRL_NEXUS_TYPE);
-	hci_writel(ufs, (1 << hba->nutmrs) - 1, HCI_UTMRL_NEXUS_TYPE);
+	hci_writel(ufs, BIT(hba->nutrs) - 1, HCI_UTRL_NEXUS_TYPE);
+	hci_writel(ufs, BIT(hba->nutmrs) - 1, HCI_UTMRL_NEXUS_TYPE);
 	hci_writel(ufs, 0xf, HCI_AXIDMA_RWDATA_BURST_LEN);
 
 	if (ufs->opts & EXYNOS_UFS_OPT_SKIP_CONNECTION_ESTAB)
-- 
2.50.1


