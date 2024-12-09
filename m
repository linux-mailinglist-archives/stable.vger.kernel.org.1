Return-Path: <stable+bounces-100196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CFE9E98FC
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE5F167545
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C463E1B0403;
	Mon,  9 Dec 2024 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKH+RElT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8478E23313D
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754915; cv=none; b=kO2OSXbshYGY+nMhYrszADwCZj60TGx1qeoakGKdG19IGMrxGQJv6Ii+K84KaK1knDdiSUHK56ie7PnJhQ4bl2U9Y5JItT33MiZACV2cc4b18zo45OkfRL9hyF3oAbRtRqwIOmLC8hQg4dMmljYZcE93Az7U5pd8Bf5I1dPatJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754915; c=relaxed/simple;
	bh=LY6PValsi7F9LnPyEcdCMG6R1a+Y40j8Pek5Nn2q+vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcwSoKPMwAjoAkIj+saNyczsv7bF26+ebVwVJ0ba3B/ax48JRlwGFFfY643mL73eo8+xbsYhh/IKhJyMaTP+3Qljrxlzqzxlffeco0hr9cwhUX1bLNvzuN4BA+nEVPlp3fxcV1YfUWz1S/F4aMgo6b8ZKtvsN2Ax+JMx2v3gMIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKH+RElT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA62C4CED1;
	Mon,  9 Dec 2024 14:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733754915;
	bh=LY6PValsi7F9LnPyEcdCMG6R1a+Y40j8Pek5Nn2q+vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fKH+RElTLLqVkWLY1+ut37yDC78aI8SoI6DKKBB7dHBMfciHM0m6pF6dkP2IeG6Ef
	 2Hg7paJa6De5gjyNeh1XR6CFA2Xp46U/nicKErxMYrey1MqIdkXGvs2nfhtWFV4q6q
	 biDl6y/4smckqGns8CfVnDKfQLiY4RqM48Gj0Bko9Sm4PO86Gfh5PR89aCHn3+NJe9
	 enlvlvyltRxqMulBEEc+ep4HIjSkt3w3ECcSMppSEXUTFQ6SED0E3fBsF028NSM0A1
	 14nZJx25c61SXCt9zyQOOFUIE5pkoxAcUkkm+MRTS56XVpEE3Xh2aK3NCoorZk2b1z
	 hZjZ4JuuGzgFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1.y 1/2] drm/ttm: Make sure the mapped tt pages are decrypted when needed
Date: Mon,  9 Dec 2024 09:35:13 -0500
Message-ID: <20241209082525-a0e062063bffb83d@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241209094904.2547579-2-ajay.kaher@broadcom.com>
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

The upstream commit SHA1 provided is correct: 71ce046327cfd3aef3f93d1c44e091395eb03f8f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Ajay Kaher <ajay.kaher@broadcom.com>
Commit author: Zack Rusin <zack.rusin@broadcom.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: de125efb3bae)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  71ce046327cfd ! 1:  fcdf2063a135c drm/ttm: Make sure the mapped tt pages are decrypted when needed
    @@ Metadata
      ## Commit message ##
         drm/ttm: Make sure the mapped tt pages are decrypted when needed
     
    +    commit 71ce046327cfd3aef3f93d1c44e091395eb03f8f upstream.
    +
         Some drivers require the mapped tt pages to be decrypted. In an ideal
         world this would have been handled by the dma layer, but the TTM page
         fault handling would have to be rewritten to able to do that.
    @@ Commit message
         Cc: linux-kernel@vger.kernel.org
         Cc: <stable@vger.kernel.org> # v5.14+
         Link: https://patchwork.freedesktop.org/patch/msgid/20230926040359.3040017-1-zack@kde.org
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
    +    Signed-off-by: Ye Li <ye.li@broadcom.com>
    +    Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
     
      ## drivers/gpu/drm/ttm/ttm_bo_util.c ##
     @@ drivers/gpu/drm/ttm/ttm_bo_util.c: pgprot_t ttm_io_prot(struct ttm_buffer_object *bo, struct ttm_resource *res,
    @@ drivers/gpu/drm/ttm/ttm_tt.c
      #include <linux/module.h>
      #include <drm/drm_cache.h>
     +#include <drm/drm_device.h>
    - #include <drm/drm_util.h>
    - #include <drm/ttm/ttm_bo.h>
    - #include <drm/ttm/ttm_tt.h>
    + #include <drm/ttm/ttm_bo_driver.h>
    + 
    + #include "ttm_module.h"
     @@ drivers/gpu/drm/ttm/ttm_tt.c: static atomic_long_t ttm_dma32_pages_allocated;
      int ttm_tt_create(struct ttm_buffer_object *bo, bool zero_alloc)
      {
    @@ include/drm/ttm/ttm_tt.h: struct ttm_tt {
      	 * set by TTM after ttm_tt_populate() has successfully returned, and is
      	 * then unset when TTM calls ttm_tt_unpopulate().
     @@ include/drm/ttm/ttm_tt.h: struct ttm_tt {
    - #define TTM_TT_FLAG_ZERO_ALLOC		BIT(1)
    - #define TTM_TT_FLAG_EXTERNAL		BIT(2)
    - #define TTM_TT_FLAG_EXTERNAL_MAPPABLE	BIT(3)
    -+#define TTM_TT_FLAG_DECRYPTED		BIT(4)
    + #define TTM_TT_FLAG_ZERO_ALLOC		(1 << 1)
    + #define TTM_TT_FLAG_EXTERNAL		(1 << 2)
    + #define TTM_TT_FLAG_EXTERNAL_MAPPABLE	(1 << 3)
    ++#define TTM_TT_FLAG_DECRYPTED		(1 << 4)
      
    --#define TTM_TT_FLAG_PRIV_POPULATED	BIT(4)
    -+#define TTM_TT_FLAG_PRIV_POPULATED	BIT(5)
    + #define TTM_TT_FLAG_PRIV_POPULATED  (1U << 31)
      	uint32_t page_flags;
    - 	/** @num_pages: Number of pages in the page array. */
    - 	uint32_t num_pages;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

