Return-Path: <stable+bounces-172036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E39B2F9B3
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C69178D1B
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B33D2DA76E;
	Thu, 21 Aug 2025 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qqOiMmLW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA72322756
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781675; cv=none; b=fRX8S5RNLVkBEo6R9m92Mwnu1lrGufdZvJ6k37fEP5mwwkEJ8c4x7iz+FJvaCNJ4DqjJ5uf+yQo/BaWX6oaSYyzJsQqk3+9VdNQiNwzYnmyqhHIzLtS0IqVj3B0DNJxv3LSyDBoNQcP3RHQf1hfc7b0Y0I+l+228F5Nv+YzM60k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781675; c=relaxed/simple;
	bh=O/R06yotY46fHOOphoLPm4fDiaeilbyvaGEXRCg0Fhk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=swRK/Y7kiGSs0MtI5AhcOTnhtunFXVuVTGmUWhy1V6sd5cRoIMb6d4OHkgTyJ8V+hGXvvNbSvnL/ZYdA6m9TWoMd7bUT4nekMn6g5Ms97+4Kfkzbc2rb/PrOLuexyCNZiLDFgu1Vi3sV2cuSdGZ8+zBqxTx53091ftmfij2N4eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qqOiMmLW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDC4C4CEED;
	Thu, 21 Aug 2025 13:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755781675;
	bh=O/R06yotY46fHOOphoLPm4fDiaeilbyvaGEXRCg0Fhk=;
	h=Subject:To:Cc:From:Date:From;
	b=qqOiMmLWH6lgDw4i2J4dR+JAC2kzb73Pex1aJSQS4nf5ZoRK3wrnnXHOHC9lScCmQ
	 LGeCjzbn09xZ4avr2U6jlpSQwke2wb67chRmzp9mFM/mlGsiGFsqBfN1YmU9tGnKT7
	 4SVEhX2nrv6TQr3eZcSmVSDo5cbpCvOwhcsCNIQk=
Subject: FAILED: patch "[PATCH] scsi: ufs: exynos: Fix programming of HCI_UTRL_NEXUS_TYPE" failed to apply to 5.15-stable tree
To: andre.draszik@linaro.org,bvanassche@acm.org,martin.petersen@oracle.com,peter.griffin@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:07:38 +0200
Message-ID: <2025082137-liver-glimpse-25bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 01aad16c2257ab8ff33b152b972c9f2e1af47912
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082137-liver-glimpse-25bf@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 01aad16c2257ab8ff33b152b972c9f2e1af47912 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
Date: Mon, 7 Jul 2025 18:05:27 +0100
Subject: [PATCH] scsi: ufs: exynos: Fix programming of HCI_UTRL_NEXUS_TYPE
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 3e545af536e5..f0adcd9dd553 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -1110,8 +1110,8 @@ static int exynos_ufs_post_link(struct ufs_hba *hba)
 	hci_writel(ufs, val, HCI_TXPRDT_ENTRY_SIZE);
 
 	hci_writel(ufs, ilog2(DATA_UNIT_SIZE), HCI_RXPRDT_ENTRY_SIZE);
-	hci_writel(ufs, (1 << hba->nutrs) - 1, HCI_UTRL_NEXUS_TYPE);
-	hci_writel(ufs, (1 << hba->nutmrs) - 1, HCI_UTMRL_NEXUS_TYPE);
+	hci_writel(ufs, BIT(hba->nutrs) - 1, HCI_UTRL_NEXUS_TYPE);
+	hci_writel(ufs, BIT(hba->nutmrs) - 1, HCI_UTMRL_NEXUS_TYPE);
 	hci_writel(ufs, 0xf, HCI_AXIDMA_RWDATA_BURST_LEN);
 
 	if (ufs->opts & EXYNOS_UFS_OPT_SKIP_CONNECTION_ESTAB)


