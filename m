Return-Path: <stable+bounces-100193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 330ED9E98F8
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2640281FA2
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FC323313D;
	Mon,  9 Dec 2024 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huNF87nc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43EA15575F
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754909; cv=none; b=LF2UnXSV0tZrycSEZ18xKfIC1WsjwsOG1SpxK8d+/xRKB4PmaMR3JNhYDHBg5tx3k5qXwMZPlgSw6QWj19Y7vesq3tHgno3WKWHk/jOd2vwamNBiBZDyIRFWhqipvQHc3MYDTROikd3jh5K9O/8qvni5+LzMIN5jyvxhuZROlHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754909; c=relaxed/simple;
	bh=porh5bd462oBhy02hxGEs7vPpVOCuif32lpASj5S01I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtfOgsK8ae98kYJXUWuj2u8f2iHRi55g1BUs70lybmvoepPsH1RAhgrt0TJh4m4qHxEJH1zllIY1ZTQjK8NLF3J8R45K/WEdJsbSfEXUHFGqnKBp4bZAgTSKKPMQFCP9fZwKh3OWYXEF8KQINv4gpFtNNZBXyUNC+iewTR76f+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huNF87nc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B4CC4CED1;
	Mon,  9 Dec 2024 14:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733754909;
	bh=porh5bd462oBhy02hxGEs7vPpVOCuif32lpASj5S01I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=huNF87ncgimDLxn4rbEPqV8GEuvOe3TZ1Nrc8px08dJlLRSf5qwZy4ahZZJjyXgYA
	 t5oqiREXPTlWlbxrzezkGLQNr5FhsVWX3YvgoX5VuAwZQDWnQLF/1Xtm1hz5FglpyF
	 6C/LVDD3P3cYbTG9Ub4j00iIvqc22pRGkaLBW38Td7EVbTauFR8oGnc1nxswMy6pAS
	 tv1XUovspHgj6Y5KiYj+RaeiNC1zMI42c8Fi++p9uFWYTjoCTUiKCgmmHJ+u2DSNjk
	 EGS+qINI/EF6UDW8IEdblkiK0yIc5KR2b8++lJCcSnpomWnReXC4c0neNgoxuPzkSs
	 YJ6SIEOI6D75g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy-ld Lu <andy-ld.lu@mediatek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] mmc: mtk-sd: Fix error handle of probe function
Date: Mon,  9 Dec 2024 09:35:07 -0500
Message-ID: <20241208091447-3908abfbe515d1e8@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241208063407.19633-1-andy-ld.lu@mediatek.com>
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

Found matching upstream commit: 291220451c775a054cedc4fab4578a1419eb6256


Status in newer kernel trees:
6.12.y | Present (different SHA1: da15282c09f8)

Note: The patch differs from the upstream commit:
---
1:  291220451c775 ! 1:  3be3d0e967f10 mmc: mtk-sd: Fix error handle of probe function
    @@ Commit message
         Cc: stable@vger.kernel.org
         Message-ID: <20241107121215.5201-1-andy-ld.lu@mediatek.com>
         Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
    +    (cherry picked from commit 291220451c775a054cedc4fab4578a1419eb6256)
     
      ## drivers/mmc/host/mtk-sd.c ##
     @@ drivers/mmc/host/mtk-sd.c: static int msdc_drv_probe(struct platform_device *pdev)
    @@ drivers/mmc/host/mtk-sd.c: static int msdc_drv_probe(struct platform_device *pde
      					     GFP_KERNEL);
      		if (!host->cq_host) {
      			ret = -ENOMEM;
    --			goto release_mem;
    +-			goto host_free;
     +			goto release;
      		}
      		host->cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
    @@ drivers/mmc/host/mtk-sd.c: static int msdc_drv_probe(struct platform_device *pde
      		host->cq_host->ops = &msdc_cmdq_ops;
      		ret = cqhci_init(host->cq_host, mmc, true);
      		if (ret)
    --			goto release_mem;
    +-			goto host_free;
     +			goto release;
      		mmc->max_segs = 128;
      		/* cqhci 16bit length */
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

