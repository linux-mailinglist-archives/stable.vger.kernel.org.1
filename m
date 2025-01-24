Return-Path: <stable+bounces-110418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 600E1A1BD00
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 20:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C66188FE19
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 19:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97812248B7;
	Fri, 24 Jan 2025 19:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rX7qMs3m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87B12248AC
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 19:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737748329; cv=none; b=acg75sFCi9tG3ol3dPFATk2d9MSs3uHogeevB1VGeYkM+mGoNDhdCjgg1D8qE58LWagARwNuwXF7e6IbriowFYI6h31OZocbjP5pH2nEj1JCHuveIO1SlE+ut1OHPFkq6fWMKBV9XkFgu4AU3YEVjP+bw+v8Va95Ja0D1XoM6Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737748329; c=relaxed/simple;
	bh=5dpiqjtXXnf/2ZE+4HCZgmok71b4wCICeHRKrVovT20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RwmheGmJ6+C6lqUInZmwPuQZp1+PTAoCimsTnQOMrn9mb39tTNEJHh3ohtpa13C2fjmwulLe8oHRuhFH2D/CTug/T0P8aFxZ4Qccmn0z92MTr2RecjbI0uMXSoQGZ9oV+0ciyXtAlP7YozndczvlxHaH21WSsVvNDpVdzSsrw3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rX7qMs3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C359C4CED2;
	Fri, 24 Jan 2025 19:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737748329;
	bh=5dpiqjtXXnf/2ZE+4HCZgmok71b4wCICeHRKrVovT20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rX7qMs3mt9150ZMI3TaPKL/PTcHEiFN/Pb3DmsKcESMNLMfN08KCo/FC7wpYxrr7g
	 mO+j6f/Spe1/em0dH/PMczcnbKSjAtHGKvn+8ax8dQ5mOhA5rAMgNiVgOF79CfhUZs
	 ve+VYvfGimznAxdhjhFl1cMYk/RHEDNYrYn35VL4qArJKiWHfPXYxe32WL9lsN6fYN
	 4mMPnEKgC8LPBimmyUqXJKHBaQyBfpBYIBHsIpYX0H9ywpNQ836i7KhLTDoB5n7fi0
	 eWndbBZJJc/HKYHVVKj+CpnLlHphcCkyaa1NVQRQxeGLYEGtES/F4BNLoRP49V0koO
	 WiO07/qRIsLew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Imkanmod Khan <imkanmodkhan@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] media: mtk-vcodec: potential null pointer deference in SCP
Date: Fri, 24 Jan 2025 14:52:07 -0500
Message-Id: <20250124101700-0746914cb962f115@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250124040641.7431-1-imkanmodkhan@gmail.com>
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
Backport author: Imkanmod Khan<imkanmodkhan@gmail.com>
Commit author: Fullway Wang<fullwaywang@outlook.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: f066882293b5)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  53dbe08504442 ! 1:  992dd0827dc54 media: mtk-vcodec: potential null pointer deference in SCP
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
    +    [ To fix CVE: CVE-2024-40973, modified the file path from drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c
    +     to drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c and minor conflict resolution ]
    +    Signed-off-by: Imkanmod Khan <imkanmodkhan@gmail.com>
     
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

