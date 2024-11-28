Return-Path: <stable+bounces-95716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBC49DB905
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 14:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B634F2817E9
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 13:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A311A9B2B;
	Thu, 28 Nov 2024 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+9HHgXG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F441A29A
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801382; cv=none; b=KFlFUvj7P9kvVrY6mTTjxuHwB+uT2eVyIy6J/sp6lkBCvm0S5WRTULr/EGE/44QR8bgCiKSnPv9GQtaHFrgYMYTLWknhqR20G80a5HngDBsrt639u/IKDDrrtCdbGHUqwIJXbdPjFLV93TlThzQaSJPtZWCzdVJJ9qaVkpV2jv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801382; c=relaxed/simple;
	bh=NVFra1fNk3aMk8jTPEdToqxUwBF4Im+g+K3sy1r2ooY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A25RXeQntTtNsnmr5b8JxFJ0NGHqks+DY+vzMnb7CKzaSlLKtcY52UW8qmyRx05d3/IqyV2pyEnjsx0d4PqlK2uD6ZiRaxczfY2YJB8WDOhI1pu3loG9g8vc2v9uyS3s8GxkMXTOvrUFTPLhBsDVUVmniHekjlVFa0NDFuGIBuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+9HHgXG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F02C4CECE;
	Thu, 28 Nov 2024 13:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732801381;
	bh=NVFra1fNk3aMk8jTPEdToqxUwBF4Im+g+K3sy1r2ooY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A+9HHgXG/fl3XuUcwytBXWUszefeOrpPkkRHaDX8s8gT/BbUBAibl4LoSZ1M2QeoC
	 mv9/LShu0KvTJLJHh93cdwkfeWMpzsfvQ0RvXrT/Ypfgl2pzkKqn08voRucvYZCo3N
	 5oWV3OHg9Ar9KrkkErg/o4BOQpA8IpOfsAH9TawGbyPU66qHy1eNqoL+iR7SC5j9Jr
	 kdLjqUNiemgWRDNiwb1Thm4jRVEK8CdXze2J+mctNBKHAWrRvpM7ggOIvhjTRvblfq
	 giYYB9mBL33k6zDE3JZai3lOa5vyQDN95jDStDIrKyAFnhCMVyFB+rPEv3Ub/uXkzQ
	 UlLmGOfUOl+tA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@eng.windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] mailbox: mtk-cmdq: Move devm_mbox_controller_register() after devm_pm_runtime_enable()
Date: Thu, 28 Nov 2024 07:56:50 -0500
Message-ID: <20241128070252-af28747f6c4e6101@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241128085637.2673640-1-bin.lan.cn@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: a8bd68e4329f9a0ad1b878733e0f80be6a971649

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@eng.windriver.com
Commit author: Jason-JH.Lin <jason-jh.lin@mediatek.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-28 06:59:19.502388170 -0500
+++ /tmp/tmp.fqdcq45T9f	2024-11-28 06:59:19.497067744 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit a8bd68e4329f9a0ad1b878733e0f80be6a971649 ]
+
 When mtk-cmdq unbinds, a WARN_ON message with condition
 pm_runtime_get_sync() < 0 occurs.
 
@@ -30,15 +32,17 @@
 Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
 Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
 Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
+[ Resolve minor conflicts ]
+Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
 ---
  drivers/mailbox/mtk-cmdq-mailbox.c | 12 ++++++------
  1 file changed, 6 insertions(+), 6 deletions(-)
 
 diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
-index f1dfce9e27f5e..4bff73532085b 100644
+index 9465f9081515..3d369c23970c 100644
 --- a/drivers/mailbox/mtk-cmdq-mailbox.c
 +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
-@@ -689,12 +689,6 @@ static int cmdq_probe(struct platform_device *pdev)
+@@ -605,18 +605,18 @@ static int cmdq_probe(struct platform_device *pdev)
  		cmdq->mbox.chans[i].con_priv = (void *)&cmdq->thread[i];
  	}
  
@@ -50,10 +54,9 @@
 -
  	platform_set_drvdata(pdev, cmdq);
  
- 	WARN_ON(clk_bulk_prepare(cmdq->pdata->gce_num, cmdq->clocks));
-@@ -722,6 +716,12 @@ static int cmdq_probe(struct platform_device *pdev)
- 	pm_runtime_set_autosuspend_delay(dev, CMDQ_MBOX_AUTOSUSPEND_DELAY_MS);
- 	pm_runtime_use_autosuspend(dev);
+ 	WARN_ON(clk_bulk_prepare(cmdq->gce_num, cmdq->clocks));
+ 
+ 	cmdq_init(cmdq);
  
 +	err = devm_mbox_controller_register(dev, &cmdq->mbox);
 +	if (err < 0) {
@@ -64,3 +67,6 @@
  	return 0;
  }
  
+-- 
+2.34.1
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

