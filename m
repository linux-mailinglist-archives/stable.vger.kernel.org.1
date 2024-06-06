Return-Path: <stable+bounces-48939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFC08FEB2F
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144CD28639C
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FF31A2FD2;
	Thu,  6 Jun 2024 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q5/BuRZk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F8B1A2FC7;
	Thu,  6 Jun 2024 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683221; cv=none; b=svNmhyvBF+l1e/K/r2Qk5G6lRXqRPzqR894GSxfF9vnOlsF1jfueoJgB/5n8GZoGFMWNCjbCVxuouCntCzNs+7pwmS6lz24vm9Gx2p8+pjcMaZK9eVnCCHoIkVOWp8IoopQBk8Hx4SCNIBJt07Nc2puDlPQxvXMwQcD3uqdEuu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683221; c=relaxed/simple;
	bh=LbGhJiFHKE1WOHhucHovKABe95GYHRmHsznbxMJrSqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOIlNOBJmsMFf28Xd5US9ozCXGbv4MoWhM7R2JAnnByoV+evVLzWDgaaIQUTYqLXtPdLl9IaxJHZ8HTlGdzZdn+LNuK7Tb/9zRNKremOLX3mlYK+A/Ve9WegOCnH4ILUSxTJk1zOgSxjeFJKWCjkgOn8jz6rVNg61LY7K4XFPd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q5/BuRZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8195FC32786;
	Thu,  6 Jun 2024 14:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683221;
	bh=LbGhJiFHKE1WOHhucHovKABe95GYHRmHsznbxMJrSqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q5/BuRZkIyMjeAFzPoXc+GwAmav62fmxcUGMkxfeGf3P5xmbIp83JlqJucj/240VN
	 RWYFWd+YZIp32rzvI1HqPVZbJHZOF76wcsdP3iU7BT7Y90he7Nma2SvPv4Ql4LL7Om
	 67SnrYmG/kBb6m7mHv1ac9UDzAhCZ7IBMPluPWJI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 141/744] qed: avoid truncating work queue length
Date: Thu,  6 Jun 2024 15:56:53 +0200
Message-ID: <20240606131736.937625529@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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




