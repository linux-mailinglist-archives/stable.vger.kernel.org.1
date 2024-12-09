Return-Path: <stable+bounces-100199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC789E98FE
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B951282523
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEA81ACEB8;
	Mon,  9 Dec 2024 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzikjFic"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6B523313D
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754922; cv=none; b=ZnznTXER3Myfrc+arigayXW/h3GZYLbiA3gNyTOLF1mT3+hZFM2heTgqpUmYoYPEmye3NJKHWi5mPSa2WZXGzWArRdXrmW13wZbmGFA4HMAkI7evXf0p7Br6YJMYgfjVpSfkfiCDmzEPeDevhtX5VKPcdsqWXfuxSRGxB/hDwbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754922; c=relaxed/simple;
	bh=9STTZG8Ajz7+VWo8MTPg2Jac7j5x5ITAICmgmDc5vG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QiUON5NEJTpWHMHsdVOHcHBV2woITHEBIyIilM6ZhwRYEL7SZUQvzYd1T8X9qFbu+C7FaYvdKWdzqn+6ew6Phw3Um7gVurGniHeGn0xTI6+7JyvcC65PlVVmqq8f9bN3EFzv7a/u/PizQmqwgq1Cp+HYFqlEEp5dPgunJ1UoqPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzikjFic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BC2C4CED1;
	Mon,  9 Dec 2024 14:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733754922;
	bh=9STTZG8Ajz7+VWo8MTPg2Jac7j5x5ITAICmgmDc5vG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XzikjFic6QhJDHbA/iBoN5N4BxLujuWXc+LOUafHrqvqATK04q8VZ5t6cfCLBdnEU
	 pUn+G8BGt6FfaJ4aI5fT2JSE2MCfv8pTHudHP6yg6Dv+dA57Y3oweQV0nkqTvx+QgY
	 V718GF7Ld1SZ1PBkx+G16jC5BfpxBHDMRkQ6efsh+62FtjduZWA/jJ1UuYob6myFqP
	 5W2LpyONO2gHuiTOKRS2MWXjskgr3Pv9ZcfG2f13V5w+jtGJrDZpTDw7KNSdlcdbsB
	 YN8ny2S9abWvxVZQSt0cpIsKSUQgCaJ8pDck6tstnSf1KtdwLQvPo0JvAzg7L/U51Z
	 f4Z30mo5gxB+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] media: mtk-vcodec: potential null pointer deference in SCP
Date: Mon,  9 Dec 2024 09:35:20 -0500
Message-ID: <20241209081319-fba532978a5cf17d@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241209065413.3427435-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 53dbe08504442dc7ba4865c09b3bbf5fe849681b

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Fullway Wang <fullwaywang@outlook.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: f066882293b5)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  53dbe08504442 ! 1:  a7928268320f3 media: mtk-vcodec: potential null pointer deference in SCP
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
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
     
    - ## drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c ##
    -@@ drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c: struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(void *priv, enum mtk_vcodec_fw_use
    + ## drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c ##
    +@@ drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c: struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(struct mtk_vcodec_dev *dev)
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
| stable/linux-6.1.y        |  Success    |  Success   |

