Return-Path: <stable+bounces-109188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6BAA12FA1
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 01:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E84516366A
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 00:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FE8A94A;
	Thu, 16 Jan 2025 00:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mv8ciT7R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8E079EA
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 00:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987131; cv=none; b=IRh6rtz6A5q1DI87on4Ff4k43oOv9qct7K0l0aS6SyeNz32+TlJVPehECn1gRuejseUTRcp6o+FvrVtoxVDdqYqKH0Is8ewKkoYuawgNs8QwFMKwD6AZlZFwYRKo9eoK5hq9J3gBrgHntl2oDjNjrdQGpQ0hsQ3EnPqbxKH/eWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987131; c=relaxed/simple;
	bh=O6dwwzQaJ/+UzO/iyJx0qlZPaXcrkbMRCH1XPsTxEgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sgr95V2+xPuE0fp0PDMRdr1rb52yGKaRFe72NAZcyohKMgCJ9PO2361kzaL8X5kDGAbLXXOrkfhXNsfW/56iQ5gdoS6Vi1RFyUvZ64i6aEGtMzzEwAkI3dxB9ZGRn91fLf6iOuPaqZmEdEOseSYD7gth/l3KMwjPXXZbnqjYfgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mv8ciT7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54717C4CED1;
	Thu, 16 Jan 2025 00:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736987130;
	bh=O6dwwzQaJ/+UzO/iyJx0qlZPaXcrkbMRCH1XPsTxEgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mv8ciT7R7RihtMKjiSeeEBv/Jm3ojqzW+7wwo+YNkdAUxSDF0OSMGVNLsQXxZlAOc
	 rXF9xh1Fmr538HK1o4tZfdAh6V7VE5J+khGJcmVKkzTGvShzaPoPsVBjwLKI+0V75l
	 30H5ROJZuJW3wI8bzI75/FeN1U1kxoTiNTHu8u1cOcnULZqOCN0fgcNJ/HF9uOt1EM
	 ep8n6H9/PVAapaD+gnKwgJWyAyF8HHhraqy5m5dtlByqC/iLWUM4IqNaBM3rnUJCLJ
	 UyespxucL7JvaIB8iBCdwnJvALpphLKKQ/mlbOZBJcLTFwjLznypb+ixSLNhkvBGZc
	 BG+Rv2CM619xw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: lanbincn@qq.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] iio: adc: rockchip_saradc: fix information leak in triggered buffer
Date: Wed, 15 Jan 2025 19:25:27 -0500
Message-Id: <20250115154930-304504c5fec90893@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_72F5138E2C8C53C3392D4E4DF0C796A48006@qq.com>
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

The upstream commit SHA1 provided is correct: 38724591364e1e3b278b4053f102b49ea06ee17c

WARNING: Author mismatch between patch and upstream commit:
Backport author: lanbincn@qq.com
Commit author: Javier Carrasco<javier.carrasco.cruz@gmail.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 4291becc8b99)
6.6.y | Present (different SHA1: 0b5e30f0aceb)
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  38724591364e ! 1:  bc61bac32997 iio: adc: rockchip_saradc: fix information leak in triggered buffer
    @@ Metadata
      ## Commit message ##
         iio: adc: rockchip_saradc: fix information leak in triggered buffer
     
    +    commit 38724591364e1e3b278b4053f102b49ea06ee17c upstream.
    +
         The 'data' local struct is used to push data to user space from a
         triggered buffer, but it does not set values for inactive channels, as
         it only uses iio_for_each_active_channel() to assign new values.
    @@ Commit message
         Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
         Link: https://patch.msgid.link/20241125-iio_memset_scan_holes-v1-4-0cb6e98d895c@gmail.com
         Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    (cherry picked from commit 38724591364e1e3b278b4053f102b49ea06ee17c)
    +    Signed-off-by: Bin Lan <lanbincn@qq.com>
     
      ## drivers/iio/adc/rockchip_saradc.c ##
     @@ drivers/iio/adc/rockchip_saradc.c: static irqreturn_t rockchip_saradc_trigger_handler(int irq, void *p)
    @@ drivers/iio/adc/rockchip_saradc.c: static irqreturn_t rockchip_saradc_trigger_ha
      
     +	memset(&data, 0, sizeof(data));
     +
    - 	mutex_lock(&info->lock);
    + 	mutex_lock(&i_dev->mlock);
      
    - 	iio_for_each_active_channel(i_dev, i) {
    + 	for_each_set_bit(i, i_dev->active_scan_mask, i_dev->masklength) {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

