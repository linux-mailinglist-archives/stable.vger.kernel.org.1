Return-Path: <stable+bounces-143867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72C1AB4278
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1BB53ADF74
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00FF2C108D;
	Mon, 12 May 2025 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6gd69wl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4932C1084
	for <stable@vger.kernel.org>; Mon, 12 May 2025 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073144; cv=none; b=Jifs0agu3wTvDXGckLAxdwY+EBwvdi/TFqOEMlBC0cT33XkRJQioETJDsXUMKXJvZNiKGLUZocZQYvBMybP2PSwURYb+OcQkghiLbg07eQHB61JbDKvpoypv6HmXlfI/ps1F7xWk9Au0PJmgJYELrEfZXViuqOZi2uoqiaRQqQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073144; c=relaxed/simple;
	bh=kTKYvPC43p5A4OxlXh74C/vNaOqWHRrjAL8hXv5WXWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmehUybVBctDvrtdKB4Lqy2pp2NiitOff9hcUqcq+sxPrynNpxm4r1ehbIqZY/MMhHsI5rgmBwZLl1mKvlbVttHgngf3lGESVdXSaFYYFw1GUowQ7azDK8mZ3DKEDoe3YmWkRiqtckfFh34tyesLVZhuEw1AO+A0aZIza7EC0us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6gd69wl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB77AC4CEE9;
	Mon, 12 May 2025 18:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073144;
	bh=kTKYvPC43p5A4OxlXh74C/vNaOqWHRrjAL8hXv5WXWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O6gd69wle7uLoPo/hpYZV5/7Ynb5XMgTRSOR2EJ0w85cwKPoqerjjObhMtmro4pSX
	 Tdr9M3Xc4Grh0Lr0bDvzu/l40YsMqnaIE3ahm0VAfbAhJZTV1/PxoS+2AREvheHgXl
	 ZiqFKk0061ngLByDCOjv20KteROBuko9xLzyyWJy9EA//HL95NyzH++ke0QdMHBaND
	 VTVR0sEJF1LZhU36hnZk8SEKl7Ymtz5Z1Zat7/D1zHqOu45A5CNJ1oBxvyX01cZpDT
	 cxc/SBDYX2FPyo9ctA2I747IppmsagA3pBpZtXjh/G7IBjENV6CAbUDR0eNocMa8om
	 Dkb/9Bl5H7HQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jianqi.ren.cn@windriver.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] media: mtk-vcodec: potential null pointer deference in SCP
Date: Mon, 12 May 2025 14:05:40 -0400
Message-Id: <20250511211340-9266be1f36cef753@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250509092805.3242802-1-jianqi.ren.cn@windriver.com>
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

Found fixes commits:
4936cd5817af media: mediatek: vcodec: Fix a resource leak related to the scp device in FW initialization

Note: The patch differs from the upstream commit:
---
1:  53dbe08504442 ! 1:  99d7258da8569 media: mtk-vcodec: potential null pointer deference in SCP
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
| stable/linux-5.15.y       |  Success    |  Success   |

