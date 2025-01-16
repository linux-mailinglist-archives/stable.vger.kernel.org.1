Return-Path: <stable+bounces-109199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F215A12FAC
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 01:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4091632D7
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 00:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19CC8F6E;
	Thu, 16 Jan 2025 00:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTjT2m7G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712C579EA
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 00:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987177; cv=none; b=mm//muLY1bOyTPxJsVkpITohrNsPg7MpP2OBm/E9PmHjX2yl7BPzmg60ZrjW1xmz6j6SXhiLsS8vjIRI+50DwiWiJf69f5zjZdQYowsCSRhds10hPZuxh8lA2RF7K3PsXqLWARJYED2HKW54BYvt9y/JUPKwa3bRQY3P7FrQhEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987177; c=relaxed/simple;
	bh=29WS5KCfjLslFBEfHrkCZ2O9hDkV9jKzpAFgK8TIZak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KYkbNQWLYtpNHFMHVF4ilnNG5Dwrj9RJmkZA/WwqfB0gZ25JnxJpqu9F2gZ8ts6bX2Y7E76oHkwza/MRoUfBCdLtVR41KeJXPsUHrN/tlwnH+3Pm+t/6dQ55owNS15TlttwhGnitcotQGhys9cfXx1EuzVj2To/QWbE9UZsI1AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTjT2m7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9EAC4CED1;
	Thu, 16 Jan 2025 00:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736987177;
	bh=29WS5KCfjLslFBEfHrkCZ2O9hDkV9jKzpAFgK8TIZak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZTjT2m7G6PUCSgZRJJXHX6xHIuufr28pq/6c4hle+jD3mvQ2mDSDfZuYSFAOBe6jP
	 Vx4S69QwWn9yvB2pM4YRIfjGsjaTK3DqjINR/C4+AMqxvwJBUwT7KUmkqCsmVFznLC
	 /36K7uuTgVK9eFyz4Z0crzKJFq9ZVImNvBrc5a9TTNbEyzH5IRL9pW6MqAUTXZ7WPX
	 vC3YX10Ao8dM2EOWaeU5EjzvQmOk7endAyOW8aoWN19n6Mx5TgR2qfHQ6+ZDipcyVi
	 YFBBV1Voc/ykSeByU91Pngb0rIp9i9uI5L3GY06ZVHcLJx8ljhQu+eFe5ZZjXsk6x8
	 JZvgLHYBoD62Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: lanbincn@qq.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] iio: adc: rockchip_saradc: fix information leak in triggered buffer
Date: Wed, 15 Jan 2025 19:26:12 -0500
Message-Id: <20250115160752-76c31c33af684113@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_D8E19A36BCE6EAA35572DF7A17470906AD05@qq.com>
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
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  38724591364e ! 1:  8c80b13ef02b iio: adc: rockchip_saradc: fix information leak in triggered buffer
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
| stable/linux-5.10.y       |  Success    |  Success   |

