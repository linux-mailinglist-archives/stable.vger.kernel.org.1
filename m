Return-Path: <stable+bounces-100663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC4F9ED1ED
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E6D285781
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0CF1DDC11;
	Wed, 11 Dec 2024 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0KhrEQu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7E21A707A
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934772; cv=none; b=bx74kv7Adop5HN6ul2TcZ0ifVvo6+9roJN5+vW/IVD81+cXlURAJu87HMijIAFlpysy49mqI730kTgPp4ae6K+Zt3HI6E3ISGXEMlwIbA/daTOsezAHSu6z/gNnKHs8cI+FoKl0Yib/BDPlI79PTioBRDk44J38xV0lDF+B5n/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934772; c=relaxed/simple;
	bh=A5y+fsvWiJ0caIkA2UDvnJsE0KYCEqXm13TiRsjvTWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEBHHJsigBhAw8HJ5ihR6j9GbFhrMHljdWKzyCq0P2NpZL4w8KrnWRV/RJXyg2D2prH9JMImbXsgzcryPjK9/nMAaWjmWmzpMgy1CLnW0fcXZAuyr9PkrLFVylxYBKXROG054wxnDliQ1yKGd19J6NR3JVGzvQTxJDyE0G+Y6wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0KhrEQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47292C4CED4;
	Wed, 11 Dec 2024 16:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934772;
	bh=A5y+fsvWiJ0caIkA2UDvnJsE0KYCEqXm13TiRsjvTWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V0KhrEQuzcVD8ruJ75pgUx0LqKlNf0YhDP+ZOlKEylEcQi9ei6HONqyTdWISXHplj
	 gsc6f2jUHE1x6tB82NCbONAhaMdJCDqtXpAvQ737uzf0yYjQWMyyeZNyqTPnzB+fTb
	 UtQoAUAy7iiSvEMeVX6aRZsrUjDh19Za2wH0F4g6xPb2Js3IuugvuEyQPSbOjsbmBu
	 eDuFJII4shimY9GioHJB25rmBUWxZQPzVjJe2+EkPTA0HxL1H6x9X/pLPxd5oqXoex
	 JQgcxKunbG47ruG36xkd6bm1FXqwD4FSPn9oSYnyxQcRr2GoZ1Dn6tJftkbh/M2BKV
	 A2npTgMXMmB2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] media: mtk-vcodec: potential null pointer deference in SCP
Date: Wed, 11 Dec 2024 11:32:47 -0500
Message-ID: <20241211091544-dec032dbdc53f310@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211100249.2069678-1-jianqi.ren.cn@windriver.com>
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
1:  53dbe08504442 ! 1:  bf4f75ffd6422 media: mtk-vcodec: potential null pointer deference in SCP
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

