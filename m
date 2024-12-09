Return-Path: <stable+bounces-100200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 943309E98FF
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7432F1673DE
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F691B0413;
	Mon,  9 Dec 2024 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDmwlPj5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4368B23313D
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754924; cv=none; b=ai9rJ61t0XYEGmPSLJ/Qec04RXmlLJ6tvwowmoCF8Fqt64c9gq1gxCIaHzmq8CpneA+Terl4Sp0B1omlsFLu8fue7IWwu7TBKSgAw3D5k2EcFrv2KyFj/tGbIwEDgEsUKofOHCO09Tu1P+92/BtxuGIOPQ8pGjcq51Uq2bFl/i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754924; c=relaxed/simple;
	bh=lZfkZ8QgRmVWR1qWXdvKAakeETwWf3Gw2Xj6EyI2ggQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gaQxOs0FgNLjQaR4LxLEvzSTqFRm4RHRZtTbmDhUoqWu6PB87jAeRF4H2NiC5cwuRnDGeFqwrwpmtqna1uc6vdYd5bv0PzZ4WszX9MEE+Rn8z1KtJGsAp7Es/rt/QjUW+9eHlWdPU9Bws0ybZupT/wgkN8Ei3HYe3nHVDgm1KTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDmwlPj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93688C4CED1;
	Mon,  9 Dec 2024 14:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733754924;
	bh=lZfkZ8QgRmVWR1qWXdvKAakeETwWf3Gw2Xj6EyI2ggQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BDmwlPj5r1KZvzImKNMHKAcI15oXWLP0tpqVYiabfK0JVnFSJH2rmS3d0YBqEacFi
	 DzNiavLYxS1cL2dTBXZEgDfBXZuYGmdRKvji5dBJefL4pth1xCQaVA/TuPIaxW8I7s
	 ppplAaYQrYBIPEkrDBtJR3zebLnFygJWzt29yYXWzLpo2TMnTKPOSYmkwj/X1XnRkc
	 uSrgFiSD/oNVXinYS5V39H4IWjS2Ato9r+SwToyfEJh/TmMNiRSS/MzY0i0rj/WkU3
	 yyzxvYzHFMnYamagkRbI2d+MkTf4QwBYfCcA+/OFTarWKtbK58Bth9Z2WOPqXnguxT
	 PJsQoUZzW4nbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy-ld Lu <andy-ld.lu@mediatek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] mmc: mtk-sd: Fix MMC_CAP2_CRYPTO flag setting
Date: Mon,  9 Dec 2024 09:35:22 -0500
Message-ID: <20241208092303-4fe741a5d2e50a9b@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241208083221.21514-1-andy-ld.lu@mediatek.com>
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

Found matching upstream commit: 2508925fb346661bad9f50b497d7ac7d0b6085d0


Status in newer kernel trees:
6.12.y | Present (different SHA1: 6b751bd44d86)

Note: The patch differs from the upstream commit:
---
1:  2508925fb3466 < -:  ------------- mmc: mtk-sd: Fix MMC_CAP2_CRYPTO flag setting
-:  ------------- > 1:  551a0cf3a8980 mmc: mtk-sd: Fix MMC_CAP2_CRYPTO flag setting
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

