Return-Path: <stable+bounces-172482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE50B321A7
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 19:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB25A062AD
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 17:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2DC1FAC4B;
	Fri, 22 Aug 2025 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ja0wRWB9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684E030F533
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755884630; cv=none; b=I9Y4jTe8X01kwuVtwU5nmnprk4zsqqhUxsofIlKFbHDJNHpXLg8dzbwAjHFE403btv+9u1LeuK6w8kuTtmGLZw9/1/pqwyedv9R9wjEtGOyt+50h3qhQwQYsj3vYTI8HyGFAAQuqHvSM5+UhFnXHAgLAQsdpYDqeOid+0TFEqsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755884630; c=relaxed/simple;
	bh=5hlwDkfKtqJQJkoUbtCjT0Mf/nfVjTueaCzQU1lEUfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNzTIoAqmMxKDoFpHEAhQYXyHfQXpC2hVEkLZaPCIhEtY8n0SDmo6k0xMhL5RrpEmoAM4TmfpU9JZzcq/4tmiFCo2iV5zZvbfX1VwXlg3epKEFW+MNG8VC8e01B+gK9WwyNhacOVr2Gu8NJMr66Wx0/k1RMC2Ule8U1u0ubzrPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ja0wRWB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A06DC4CEED;
	Fri, 22 Aug 2025 17:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755884629;
	bh=5hlwDkfKtqJQJkoUbtCjT0Mf/nfVjTueaCzQU1lEUfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ja0wRWB9V6zz0//ubzuosbiHOtBAmT4D7CQdSXoMGM1fCh137fgGgr+sYYCnKebx3
	 TryEWEZnANTzLlt4UyyoSFj9cASLPDFxj2XAsoTugnX1KiNTlKkR46/eZedd9IVoQ5
	 WK2XSiDHtG5H/TnSv2mYYhk2skVh3QBqwRrLo8xCzCrLQAzxW2YrH4Ovv4R+pfKUBq
	 bPiIZ8ywjF3tl0fy5QWpokRdIq+hW9lb3Zdgk1eoAV0aH9jzid60BUUpefyVTcNmIO
	 S40osa/jxkAcWrj27nopKKkXjz2gsGVGdmwymZzSC7UH9K6TA+doiT+noCiNLrr0bi
	 w1Ovv2WvGFrwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] scsi: ufs: exynos: Fix programming of HCI_UTRL_NEXUS_TYPE
Date: Fri, 22 Aug 2025 13:43:47 -0400
Message-ID: <20250822174347.1341004-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082138-unruly-sabbath-faae@gregkh>
References: <2025082138-unruly-sabbath-faae@gregkh>
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
[ Adjusted path from drivers/ufs/host to drivers/scsi/ufs ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufs-exynos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-exynos.c b/drivers/scsi/ufs/ufs-exynos.c
index 3bc7121921ce..3fd024c487ef 100644
--- a/drivers/scsi/ufs/ufs-exynos.c
+++ b/drivers/scsi/ufs/ufs-exynos.c
@@ -850,8 +850,8 @@ static int exynos_ufs_post_link(struct ufs_hba *hba)
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


