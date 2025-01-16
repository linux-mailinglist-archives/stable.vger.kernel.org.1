Return-Path: <stable+bounces-109279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85404A13C7A
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 15:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFB50161C28
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 14:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D0A24A7C9;
	Thu, 16 Jan 2025 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoGIOV1K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C6F22AE49
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038404; cv=none; b=E/H+mKBTv4gweNsn+hk2FLCFXHYskuN6XLGBkDt3OpaQEktmr2Nyw6/RDljG5YjgYelqf5ZzrAesICgn3bCWrJjOMep/eSZY3rHnKtvtVlTYTuaGXWZulZk6BgBHEqOApcq7vVOWEn7SKkcD0XzMmzAn0QQmTk45aLnU/r+MSe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038404; c=relaxed/simple;
	bh=8JsNwlWSiYW6ObIkLV5p958qwXc2cAspoxpyu/LQ2Cg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T1oqyvDjItHooSb9G8ibGED5akWrPSELUV+GBpP50ffc8wz/xpqOuW+4AdZWWvrWnNMr9Q8MdTu2Jj3tltOj6pB2qhHfSl4uu3FzE6Ai4Jf/668MT2JNMiP524G+aiP/G5CUDUQq/+F66xJy9LIYTIsUFdI9qcUpxye2YEMS8Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoGIOV1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E54AC4CED6;
	Thu, 16 Jan 2025 14:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737038404;
	bh=8JsNwlWSiYW6ObIkLV5p958qwXc2cAspoxpyu/LQ2Cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VoGIOV1KeHaBonqyVp2e8VDyItrgkXqe63jpLuAOCdl/TYD7UBaTsoLWDr8bAQKVl
	 J3wXBWOCCPWx5S+U2I8MVal1OH8nnJlOigjgiHrA2UxBOLNc25dLrqk14D5VCn2SYw
	 onJbom5vm8/P5WEKQwNEU3r2D2tsQoOWl/YBIlBRzgc4jRSQYcXTDVkJC7PkW/RMcp
	 3whZUBpUhZCc+PeqioiTmAPD4j1YDnsvgKhOsAbwqzx6MnaRjGeBDEjTB8yZvlt4HD
	 +GDIaDdGK4YZIszDABvcAUMsBpu9lP6RNgFOrk8ty0rk24nf3ZbPVHlckWu1YrL97+
	 T54PItuHfAzfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: lanbincn@qq.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] wifi: ath10k: avoid NULL pointer error during sdio remove
Date: Thu, 16 Jan 2025 09:39:59 -0500
Message-Id: <20250116090430-1d197a98aa08f3a0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_FA36A0C6E3834FF2D95A12671766AE418505@qq.com>
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

The upstream commit SHA1 provided is correct: 95c38953cb1ecf40399a676a1f85dfe2b5780a9a

WARNING: Author mismatch between patch and upstream commit:
Backport author: lanbincn@qq.com
Commit author: Kang Yang<quic_kangyang@quicinc.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 543c0924d446)
6.6.y | Present (different SHA1: b35de9e01fc7)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  95c38953cb1e ! 1:  a366b20bb8ca wifi: ath10k: avoid NULL pointer error during sdio remove
    @@ Metadata
      ## Commit message ##
         wifi: ath10k: avoid NULL pointer error during sdio remove
     
    +    commit 95c38953cb1ecf40399a676a1f85dfe2b5780a9a upstream.
    +
         When running 'rmmod ath10k', ath10k_sdio_remove() will free sdio
         workqueue by destroy_workqueue(). But if CONFIG_INIT_ON_FREE_DEFAULT_ON
         is set to yes, kernel panic will happen:
    @@ Commit message
         Reviewed-by: David Ruth <druth@chromium.org>
         Link: https://patch.msgid.link/20241008022246.1010-1-quic_kangyang@quicinc.com
         Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
    +    Signed-off-by: Bin Lan <lanbincn@qq.com>
     
      ## drivers/net/wireless/ath/ath10k/sdio.c ##
     @@
       * Copyright (c) 2004-2011 Atheros Communications Inc.
       * Copyright (c) 2011-2012,2017 Qualcomm Atheros, Inc.
       * Copyright (c) 2016-2017 Erik Stromdahl <erik.stromdahl@gmail.com>
    -- * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
     + * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
       */
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

