Return-Path: <stable+bounces-99958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304E59E76BB
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F079718845B8
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA351F63F5;
	Fri,  6 Dec 2024 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgkI8ftQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E569206274
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505080; cv=none; b=tycdmWq0Knb2y/cqazZ3XvaEjpVpxw1LAlaHVnGEjrkEg9MBWTAEL3DM3KhovUJ4rUHCqGKf3Gcf08nFqVoR3ujuYqniJHXzcUscZHRYqUKq/X8EWPhOGGSlCrf5cvVJ7TvSx4mhE3H/+hSHOzeZQRVMiwhGvOShDZixs0u+SgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505080; c=relaxed/simple;
	bh=KippTng9uNvseksHxh5YSrYJ2sgboQetaImGRrpzJ5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rE3NEKoaDPsU+6oUIRCHiwaER9n/SEkEac3QBJDNw368scIpnyLppIuMu8gVvYunNCil645HMPnqmKPm0hm+2zR9Q6UcVKjDFkrYLevAnS8C+sNi6NpTkNXTxMYv9UAI9v57h1gt0pj5xW6w2SaDscCnvDhb+mUr1a7gtKPWs6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgkI8ftQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A9CC4CED1;
	Fri,  6 Dec 2024 17:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505080;
	bh=KippTng9uNvseksHxh5YSrYJ2sgboQetaImGRrpzJ5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RgkI8ftQR/rxDFjU2RDVl5ytaE6R8ykpJ2ktKGQt/zSexp+/kIMAcmo51d3U6VlaG
	 BZOB2mqZNwXnPkXympJPQ3iZZNyHMaXovq2lTFJoppA5r5M3f83VCQWf8Jtcy2yr3x
	 xDQK2NbtfYkSgAzJq0hoyZKsnSUgTjxziEbcZsA643FaaX4XFhQvF42MkbvrBcjF5J
	 9+6nFyG+gTWhciPJ+5HPeMtjmYd71S/05siZTG1a83xMlAACpiRvCjKoiU52gbrlSo
	 YU62A6awWmuRQdVbHUJLOs0Rq2DJxVaoobhQBL0cdNFLLVKlZOSSc0JJ8OXrhnBsAF
	 V6JnlW8i8g81A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] media: mtk-vcodec: potential null pointer deference in SCP
Date: Fri,  6 Dec 2024 12:11:18 -0500
Message-ID: <20241206113950-8598fb69a6400cb1@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206091657.154070-1-jianqi.ren.cn@windriver.com>
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
1:  53dbe08504442 ! 1:  27bb87502a715 media: mtk-vcodec: potential null pointer deference in SCP
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

