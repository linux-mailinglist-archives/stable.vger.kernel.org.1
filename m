Return-Path: <stable+bounces-143852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E9BAB421F
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70EB1656A9
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C902BE7A2;
	Mon, 12 May 2025 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiHa4Ja8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6F12BE115
	for <stable@vger.kernel.org>; Mon, 12 May 2025 18:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073126; cv=none; b=GBuzwU4Os6a2Z0y6E2BQLAujivOVDM7DCJ9OOXhOMWch8EONg1SdfhPxiv3VmBJ4CfZOEW6f475yMQOsi+DfsDQVkDIz2MM8eqwiL5xTTCRBacBSBbpP3fojYiIT8WUr4qXe15NCavXQ6fvOWNmdEPXBcMkFMyLxeQD9eRxlI60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073126; c=relaxed/simple;
	bh=dPTYXMPlRtkWZKSNoggZCCBOGBYGzIqi8Rs3iaHooAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QaSk8G+kEYV9oqPGSXIAN1jbaKirjtJunZoHTc2FPOyZ2wkm63nDDU4/xC21EKw13WYTLgGqJq0AttvjWLbgC9Kg7TLV5XMDzXH01dZfQvkrNGgDD9T0Stqs6/CWHirXhoaI6hHPLH+u5Y58MMGqZhp7HVm5F2XaNWOjoFB6teg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiHa4Ja8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DF0C4CEE9;
	Mon, 12 May 2025 18:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073126;
	bh=dPTYXMPlRtkWZKSNoggZCCBOGBYGzIqi8Rs3iaHooAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZiHa4Ja8JiFiJ5dV8bbLw8mdegaQN8bRvQ5O4b2hhH7uI7wYsnUwkgkIvXM0uzjQ4
	 Wjh2o6cZCLtidn1drt4982lX5VfUf+F5wz6ohfMfpiOnG4vNBPjXF3zAXwedh7/cZd
	 EiwN1hssQQsY7ksd38d94Pe0KoShYn6l0KBPHTjpfy0sHhnQ9iBdrNqGOAvLj4t2/M
	 LISRrSrsV9yCnsU+0Twj3sDhp057Kl7BYZhEuKTb8igXPr8pe4yY84rKgoQ/w3Faar
	 wsCwmiYmkD+Ji8t8uY8rWuvUnRqR6jSxARtKyhq8ampaVOoTjAg6QkFMQ7yTCDwNGT
	 5+8A6giw3xDiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jianqi.ren.cn@windriver.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] media: mtk-vcodec: potential null pointer deference in SCP
Date: Mon, 12 May 2025 14:05:23 -0400
Message-Id: <20250511233443-fd85878732c2ccda@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250509092603.3242559-1-jianqi.ren.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 53dbe08504442dc7ba4865c09b3bbf5fe849681b

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Fullway Wang<fullwaywang@outlook.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: f066882293b5)
6.1.y | Present (different SHA1: eeb62bb4ca22)
5.15.y | Not found

Found fixes commits:
4936cd5817af media: mediatek: vcodec: Fix a resource leak related to the scp device in FW initialization

Note: The patch differs from the upstream commit:
---
1:  53dbe08504442 ! 1:  7a9362aa9e1f4 media: mtk-vcodec: potential null pointer deference in SCP
    @@ Metadata
      ## Commit message ##
         media: mtk-vcodec: potential null pointer deference in SCP
     
    +    [ Upstream commit 53dbe08504442dc7ba4865c09b3bbf5fe849681b ]
    +
         The return value of devm_kzalloc() needs to be checked to avoid
         NULL pointer deference. This is similar to CVE-2022-3113.
     
         Link: https://lore.kernel.org/linux-media/PH7PR20MB5925094DAE3FD750C7E39E01BF712@PH7PR20MB5925.namprd20.prod.outlook.com
         Signed-off-by: Fullway Wang <fullwaywang@outlook.com>
         Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
    +    [Minor conflict resolved due to code context change.]
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
    - ## drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c ##
    -@@ drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c: struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(void *priv, enum mtk_vcodec_fw_use
    + ## drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c ##
    +@@ drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c: struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(struct mtk_vcodec_dev *dev)
      	}
      
    - 	fw = devm_kzalloc(&plat_dev->dev, sizeof(*fw), GFP_KERNEL);
    + 	fw = devm_kzalloc(&dev->plat_dev->dev, sizeof(*fw), GFP_KERNEL);
     +	if (!fw)
     +		return ERR_PTR(-ENOMEM);
      	fw->type = SCP;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

