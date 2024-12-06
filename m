Return-Path: <stable+bounces-99959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FDC9E76BC
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135191884640
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110AF1F63FD;
	Fri,  6 Dec 2024 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="besYgDyS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5942206274
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505082; cv=none; b=hX1Y5json5Yz7hATu4nrGbPRCjlcubfbBLX+8mUQLMZ6wlvFf8P3RTZtgo3uA6mWYSx2t2CoCsfgInXM4Cb2mrzZahKoHwJBaz0zzLKZDx9CJuvFsi3/WEUmFN2H5pzv3neNQmCPCv4ToDTAFhZz2Re4NDAx/dFzMU3H0fU51u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505082; c=relaxed/simple;
	bh=GcqPtTG70QTuTgzeyaZOA7qofqGw1wy08zlQNQBSMnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZwH6dtEJ39520CKKyKg7pli6EOrqKPiV2OqBNbs5bF/54MGNG+gvTizsnSykNCO8nVeDEi4HY1Z/HSm3WuCk+dWALnhyxWM6iTONPzGX+x3TkgSpE77AnahhYky/grcP4j5SeEG+jpINLWs3rAQ0p7xBIhJflLOvFxj1h/UWVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=besYgDyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC5DC4CED1;
	Fri,  6 Dec 2024 17:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505082;
	bh=GcqPtTG70QTuTgzeyaZOA7qofqGw1wy08zlQNQBSMnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=besYgDySMTiiM7lOfI57T5EPV/UCQZe6GxBCD0COOBZrY+hjfPlo9xRsaGDjCFteM
	 gYaPtVVFhzWeabT6sSbEe4ncfKFxR9nW9oVRhgSbsiZWVsApFHyqnokVKVKw724ski
	 9/uVGskrxrJKmRGC9HE5Ljl2K2Hs/VtBQifJiVcwucht9ZljHMOO8lFRC5OHrFNVqL
	 9DQ1D613Q/patItHDunw7CePbFAXTRzRZsusDFHqFcLud6vIzn2XoH/tvIeLoF7r/j
	 nURJX6Q9i+vT+X1s+ISbeNGT7mmU8Jl8R11tUAifsN5riGIMklM0l19Dux+8p2Ju5f
	 2xXYqzsU6NlBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@eng.windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] media: mediatek: vcodec: Handle invalid decoder vsi
Date: Fri,  6 Dec 2024 12:11:20 -0500
Message-ID: <20241206101302-c38e0bd25a209067@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206012712.593884-1-bin.lan.cn@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 59d438f8e02ca641c58d77e1feffa000ff809e9f

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@eng.windriver.com
Commit author: Irui Wang <irui.wang@mediatek.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 1c109f23b271)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  59d438f8e02ca < -:  ------------- media: mediatek: vcodec: Handle invalid decoder vsi
-:  ------------- > 1:  b76bf4673f978 media: mediatek: vcodec: Handle invalid decoder vsi
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.1.y:
    drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c: In function 'vpu_dec_init':
    drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c:218:17: error: implicit declaration of function 'mtk_vdec_err'; did you mean 'mtk_vcodec_err'? [-Wimplicit-function-declaration]
      218 |                 mtk_vdec_err(vpu->ctx, "invalid vdec vsi, status=%d", err);
          |                 ^~~~~~~~~~~~
          |                 mtk_vcodec_err
    make[6]: *** [scripts/Makefile.build:250: drivers/media/platform/mediatek/vcodec/vdec_vpu_if.o] Error 1
    make[6]: Target 'drivers/media/platform/mediatek/vcodec/' not remade because of errors.
    make[5]: *** [scripts/Makefile.build:503: drivers/media/platform/mediatek/vcodec] Error 2
    make[5]: Target 'drivers/media/platform/mediatek/' not remade because of errors.
    make[4]: *** [scripts/Makefile.build:503: drivers/media/platform/mediatek] Error 2
    make[4]: Target 'drivers/media/platform/' not remade because of errors.
    make[3]: *** [scripts/Makefile.build:503: drivers/media/platform] Error 2
    make[3]: Target 'drivers/media/' not remade because of errors.
    make[2]: *** [scripts/Makefile.build:503: drivers/media] Error 2
    make[2]: Target 'drivers/' not remade because of errors.
    make[1]: *** [scripts/Makefile.build:503: drivers] Error 2
    make[1]: Target './' not remade because of errors.
    make: *** [Makefile:2009: .] Error 2
    make: Target '__all' not remade because of errors.

