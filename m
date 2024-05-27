Return-Path: <stable+bounces-46688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4018D0AD6
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B601F22493
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3AE15FD10;
	Mon, 27 May 2024 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aDn+S0DT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0641754B;
	Mon, 27 May 2024 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836597; cv=none; b=I/EJuMCb+xH5pS+xESHl427gDXhSbw12QSWKo86nV1OxV9hGB0qP8GpJKXtlDOVAog7J5xLUhBQmd12Dk6uEsF0Wjg+uY64p2x13IkNpBYDnCAfkHJ/y6dnSb0OTglpOxV9bHPSRFBp08zF21v2MDAQo3rNMD+jLxKmqDfq4KBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836597; c=relaxed/simple;
	bh=tODK13eHxYEm9XIqDaPxE4uwk1jiuNHLvwphV4B8xmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJy6vFaP8Mhmd3u7akxAh/YoijABqBs90SnYJWv1N00rKyTW3ASlWp3RAaTXxXV1JT22GtmFPskbQsw8g0kxU+6/tnKiHtwmGf5N79ZjBRsjVD0Ywbcz8/FD6lLe5s9dMJzEHIxRGmqHVc2PjQ+foPKMd0rSUAkhi/4yHVrIE7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aDn+S0DT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE54C2BBFC;
	Mon, 27 May 2024 19:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716836597;
	bh=tODK13eHxYEm9XIqDaPxE4uwk1jiuNHLvwphV4B8xmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aDn+S0DTmyOxS9NjGQ/WqrSyry7Rqjq7bjtyt7cLaKtVczsHPY7E8RvVRJ+WuJXiV
	 o/3f5KwW3wvpRISX81xluUnV2HiQEb25u9EEU3kS06GL2PBLG6rHch6H7lcfS0mZmF
	 A5fFcVeWxi/OllEQZ4PAss/mZetUMFGXqahUTUII=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 116/427] qed: avoid truncating work queue length
Date: Mon, 27 May 2024 20:52:43 +0200
Message-ID: <20240527185612.656770144@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 954fd908f177604d4cce77e2a88cc50b29bad5ff ]

clang complains that the temporary string for the name passed into
alloc_workqueue() is too short for its contents:

drivers/net/ethernet/qlogic/qed/qed_main.c:1218:3: error: 'snprintf' will always be truncated; specified size is 16, but format string expands to at least 18 [-Werror,-Wformat-truncation]

There is no need for a temporary buffer, and the actual name of a workqueue
is 32 bytes (WQ_NAME_LEN), so just use the interface as intended to avoid
the truncation.

Fixes: 59ccf86fe69a ("qed: Add driver infrastucture for handling mfw requests.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20240326223825.4084412-4-arnd@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
index c278f8893042b..8159b4c315b5d 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -1206,7 +1206,6 @@ static void qed_slowpath_task(struct work_struct *work)
 static int qed_slowpath_wq_start(struct qed_dev *cdev)
 {
 	struct qed_hwfn *hwfn;
-	char name[NAME_SIZE];
 	int i;
 
 	if (IS_VF(cdev))
@@ -1215,11 +1214,11 @@ static int qed_slowpath_wq_start(struct qed_dev *cdev)
 	for_each_hwfn(cdev, i) {
 		hwfn = &cdev->hwfns[i];
 
-		snprintf(name, NAME_SIZE, "slowpath-%02x:%02x.%02x",
-			 cdev->pdev->bus->number,
-			 PCI_SLOT(cdev->pdev->devfn), hwfn->abs_pf_id);
+		hwfn->slowpath_wq = alloc_workqueue("slowpath-%02x:%02x.%02x",
+					 0, 0, cdev->pdev->bus->number,
+					 PCI_SLOT(cdev->pdev->devfn),
+					 hwfn->abs_pf_id);
 
-		hwfn->slowpath_wq = alloc_workqueue(name, 0, 0);
 		if (!hwfn->slowpath_wq) {
 			DP_NOTICE(hwfn, "Cannot create slowpath workqueue\n");
 			return -ENOMEM;
-- 
2.43.0




