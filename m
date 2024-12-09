Return-Path: <stable+bounces-100210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8ED9E990B
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527CF167652
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8431F1ACEC9;
	Mon,  9 Dec 2024 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADWEIT8/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ECD1B4234
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754945; cv=none; b=NZO0iFq4O2TCDMODWSE3FlVc13ScUqjtO/KBcM41ocmdaa1hy93GepNN7I7wude2VPA1SLeE4OHhxrWefgXCwicyIfR0tYtdB7nx8h7GSovMF+R1o8kV9dvr2rHtkBIK+5j3kbCUOgIKCI199vbMEpyeSPwXtAj8bReHK92KTm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754945; c=relaxed/simple;
	bh=j+TYK9NMybYoQ/Ouq4D2S5Dor3GtYJ8FLRq1aL8DdJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqyYGoglmf39j0wKkM14mtzIWqjxY2HIUbneaBMW3foJ4VuNWgJirejmgoOBzScMP5q+1RNxEf2+PxkqWjH6IN+GiCIKtCUI+tSg2wKeTpfglzfV4f8pzV1iZ6AUQwzdxBymibq7IpkvRla7tt8TbsQACIrOR8Cos6QMj8u/28Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADWEIT8/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6511C4CED1;
	Mon,  9 Dec 2024 14:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733754945;
	bh=j+TYK9NMybYoQ/Ouq4D2S5Dor3GtYJ8FLRq1aL8DdJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ADWEIT8/O2c8yIuZny9BRhVUzM7AEcLKxywPw2hoWnxbIlQhwk2khOv0tPLjDu6uo
	 KiDs/1DYK5ffHUq4lszXswG78IHzHq5Aa+2nJtryN7aEQr69vF86ZgpFSVgmrgdv4r
	 VrI3aP3/DaGVgKiqC59r+ZVPOGkkQniU1fMY3kmuzjzgxoXZlhDKtRchUcRy26WhmM
	 k42gvxX6aIReXPnmvZLTQwhSzWI3c2wV+6nwEI2lXUZMSJo1XZywEmHSAxcPb7lwPp
	 evuu/uivPutcoA52RZA8blVglFcrwLJvMPf27aut1qA2hpLDKag/JgeQPAImz06AM8
	 A4rsFMt+x0s2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy-ld Lu <andy-ld.lu@mediatek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] mmc: mtk-sd: Fix error handle of probe function
Date: Mon,  9 Dec 2024 09:35:43 -0500
Message-ID: <20241208093119-1367d58b0f6149bb@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241208085517.22063-1-andy-ld.lu@mediatek.com>
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
6.6.y | Present (different SHA1: 359c7e5ed332)

Note: The patch differs from the upstream commit:
---
1:  291220451c775 ! 1:  5a73d6712ce59 mmc: mtk-sd: Fix error handle of probe function
    @@ Commit message
         make sure the clocks be disabled after probe failure.
     
         Fixes: ffaea6ebfe9c ("mmc: mtk-sd: Use readl_poll_timeout instead of open-coded polling")
    -    Fixes: 7a2fa8eed936 ("mmc: mtk-sd: use devm_mmc_alloc_host")
         Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>
         Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
| stable/linux-6.6.y        |  Success    |  Success   |

