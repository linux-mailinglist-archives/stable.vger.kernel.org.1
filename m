Return-Path: <stable+bounces-4522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FA78047D8
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02860B20CDA
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ED879E3;
	Tue,  5 Dec 2023 03:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0pYL6bae"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBB06AC2;
	Tue,  5 Dec 2023 03:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AC9C433C7;
	Tue,  5 Dec 2023 03:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747775;
	bh=S+iqyH9VtEDat5sZSroRjlX902Kbc9y4iaMhPtRbYZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0pYL6baeoXlNxRzFfyM+ITcQQhPd5Zi3BDg1Z5PRgqACE4W0olkdWfkBkhnWHQQqk
	 J7YB4c2n+sKOH8GoC/JF8kDHdHjMMzqGLtM/77/TryRBWZt/V82upocbFCDJgFXwIa
	 i6ziQCqNUkgoJqPxJa3IC8a7K0L/JO1UPDkXaTMU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 39/67] r8169: prevent potential deadlock in rtl8169_close
Date: Tue,  5 Dec 2023 12:17:24 +0900
Message-ID: <20231205031522.075500900@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031519.853779502@linuxfoundation.org>
References: <20231205031519.853779502@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 91d3d149978ba7b238198dd80e4b823756aa7cfa ]

ndo_stop() is RTNL-protected by net core, and the worker function takes
RTNL as well. Therefore we will deadlock when trying to execute a
pending work synchronously. To fix this execute any pending work
asynchronously. This will do no harm because netif_running() is false
in ndo_stop(), and therefore the work function is effectively a no-op.
However we have to ensure that no task is running or pending after
rtl_remove_one(), therefore add a call to cancel_work_sync().

Fixes: abe5fc42f9ce ("r8169: use RTNL to protect critical sections")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://lore.kernel.org/r/12395867-1d17-4cac-aa7d-c691938fcddf@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index d4de5ec690e50..84fb739679298 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4744,7 +4744,7 @@ static int rtl8169_close(struct net_device *dev)
 	rtl8169_down(tp);
 	rtl8169_rx_clear(tp);
 
-	cancel_work_sync(&tp->wk.work);
+	cancel_work(&tp->wk.work);
 
 	free_irq(pci_irq_vector(pdev, 0), tp);
 
@@ -5000,6 +5000,8 @@ static void rtl_remove_one(struct pci_dev *pdev)
 	if (pci_dev_run_wake(pdev))
 		pm_runtime_get_noresume(&pdev->dev);
 
+	cancel_work_sync(&tp->wk.work);
+
 	unregister_netdev(tp->dev);
 
 	if (tp->dash_type != RTL_DASH_NONE)
-- 
2.42.0




