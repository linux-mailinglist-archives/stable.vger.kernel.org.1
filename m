Return-Path: <stable+bounces-95719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8765B9DB908
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 14:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26563B23B92
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 13:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C131A9B51;
	Thu, 28 Nov 2024 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXjPvyox"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E4319CD01
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801393; cv=none; b=S596yaXM5P/XAU+tXvUOK7UT7jLlcxvuQv1pZ2V+1ymSOGThFyPPTsVoq2VpfNtAShGVmXC/VE7UX/bgvYxi8dqCbiAam7mJz3mu7OPV+daXGH9vkosPMqmK+LCAcL9ACvwiDRS1b7TTtNH5eiPtrB39mrnQXx9F30q/pKqE8a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801393; c=relaxed/simple;
	bh=UC4qgeq/DsEqRcQKwurO4zvH3JPGilksCc3g4FveDsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPLUFURM+K8k5hOysq+88NJYsV9GJOKpCcqjSJqGOpJ/lD8KSJHGHFcfJlvbM6jpcNi4BTSaMvHy8YZjllHK3gpo+RscE7p/nMe1aism/F3VFQx9I/tZqb9O2vYS+7x+81PZi466FHOlLlcBxSxDdzp3R0xp+kl++w/FmEfd2fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXjPvyox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36DAC4CECE;
	Thu, 28 Nov 2024 13:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732801393;
	bh=UC4qgeq/DsEqRcQKwurO4zvH3JPGilksCc3g4FveDsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AXjPvyoxnjV4Yt23vZjWMd5t5kYXYrGopKLMJ9fJLbAgFSbcrXvz4JTyhw54Px2DM
	 GBSD+chFi3cIOGsuAD/CL2pluiCg98Mw3vjJAmhwW/4FirffYenHAEWT9TIs7Bp4nf
	 nEOAIB0Yi6h5UKsUBzVo+1snThUMqDBFVG8+Y5Ap3vgphVF3Y00+BkN9GLxX7kcucP
	 XBm2PbdQqaETjbRFt68ZAQ6KJP1j/T9ucANHYan1bWM6pEkeTNY6j6wwbQzJ5kWCfE
	 mhfz4xjoBNipax8/MNNkckypy7u5TUKYgIPt4SpYLJ3lvXvYvyZ3VpOIFoGPzgPj0E
	 ux9jdG+oWwQhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@eng.windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] mailbox: mtk-cmdq: Move devm_mbox_controller_register() after devm_pm_runtime_enable()
Date: Thu, 28 Nov 2024 07:57:01 -0500
Message-ID: <20241128070719-70d1dd32a5a5e720@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241128082930.1988659-1-bin.lan.cn@eng.windriver.com>
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

Note: The patch differs from the upstream commit:
---
--- -	2024-11-28 07:03:31.668427430 -0500
+++ /tmp/tmp.wAGCAEZAC5	2024-11-28 07:03:31.661714582 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit a8bd68e4329f9a0ad1b878733e0f80be6a971649 ]
+
 When mtk-cmdq unbinds, a WARN_ON message with condition
 pm_runtime_get_sync() < 0 occurs.
 
@@ -30,15 +32,16 @@
 Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
 Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
 Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
+Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
 ---
  drivers/mailbox/mtk-cmdq-mailbox.c | 12 ++++++------
  1 file changed, 6 insertions(+), 6 deletions(-)
 
 diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
-index f1dfce9e27f5e..4bff73532085b 100644
+index 4d62b07c1411..d5f5606585f4 100644
 --- a/drivers/mailbox/mtk-cmdq-mailbox.c
 +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
-@@ -689,12 +689,6 @@ static int cmdq_probe(struct platform_device *pdev)
+@@ -623,12 +623,6 @@ static int cmdq_probe(struct platform_device *pdev)
  		cmdq->mbox.chans[i].con_priv = (void *)&cmdq->thread[i];
  	}
  
@@ -51,9 +54,9 @@
  	platform_set_drvdata(pdev, cmdq);
  
  	WARN_ON(clk_bulk_prepare(cmdq->pdata->gce_num, cmdq->clocks));
-@@ -722,6 +716,12 @@ static int cmdq_probe(struct platform_device *pdev)
- 	pm_runtime_set_autosuspend_delay(dev, CMDQ_MBOX_AUTOSUSPEND_DELAY_MS);
- 	pm_runtime_use_autosuspend(dev);
+@@ -642,6 +636,12 @@ static int cmdq_probe(struct platform_device *pdev)
+ 		return err;
+ 	}
  
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
| stable/linux-6.6.y        |  Success    |  Success   |

