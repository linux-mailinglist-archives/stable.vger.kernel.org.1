Return-Path: <stable+bounces-119535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D3BA445A7
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 17:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C50188B8C5
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 16:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9733118DB01;
	Tue, 25 Feb 2025 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PP5GD7Uh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58822189912
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500030; cv=none; b=MgtitYnghuzg6ng5ygjhsOqAqPlFrVL23MmSyDwwabGHt+jq4Z3U8kHhKzyP8k7Q835ZnLFRSWKh5KJFpBwee4mPfr4fFkACGAIsaFKigEtXUjWRcoYdvI/qP0KAoS2bXSLApNxEi1dGY/IAAOab9HLffMJnTUp/9TCV2t/m9H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500030; c=relaxed/simple;
	bh=NklLUqrwZKq0ic786XrRKGNgxYANmDSN0/wilLa1Fp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t8PFAe3AcIpd8yQOZpMBWxO6fRc8F0qu2g9nnZpPgsWS7F6/AqeO8LcpN958zeuKHa7JcDEFYG2SmRJd0DOUsZ1jSzAnKixaw82SBha4H81vNNFy/kzlKs9VV/p4L/RDR2QKAEhJFH/u4LZzAniwoPgQwbAhaC6HjK8T3YnAnrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PP5GD7Uh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3229C4CEE6;
	Tue, 25 Feb 2025 16:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740500030;
	bh=NklLUqrwZKq0ic786XrRKGNgxYANmDSN0/wilLa1Fp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PP5GD7UhLr4pBv6Pb6Q1JJFnYLuobcjdpBhBH3sCkAKm1AFNa4DBH+8Zy5MYHAY1x
	 OsXETJoEGY58MCveb0reOnD5THz9FbCcyXX+O08za7KjOCRaYnyLm133oA00ZzbrtK
	 ij97vK5pepkCZWKycPNUL956lMJR5S5nCKh2523lbHr4FRFmVjQOcBtblTmZZncpsF
	 YKdAx6N3/cgTRwpfTyq+EsTbM1kNAXJBqhITdfsss4WkYhB66clDodRh3f/F75N5Eb
	 GH4/4nz5PhLbszD8HSoIw+H+KkspWj+LI6hAMuJ1iA3ILtVCVUpeqYkDw+gF1y3L7H
	 2ozx/kd8YWdIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] media: mtk-vcodec: potential null pointer deference in SCP
Date: Tue, 25 Feb 2025 11:13:49 -0500
Message-Id: <20250225090623-3cd640547ba12888@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250225030847.3829454-1-jianqi.ren.cn@windriver.com>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 53dbe08504442dc7ba4865c09b3bbf5fe849681b

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Fullway Wang<fullwaywang@outlook.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: f066882293b5)

Note: The patch differs from the upstream commit:
---
1:  53dbe08504442 ! 1:  ffdac10bd60ef media: mtk-vcodec: potential null pointer deference in SCP
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
    +    [ To fix CVE-2024-40973, change the file path from drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c
    +     to drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c and minor conflict resolution ]
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
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

