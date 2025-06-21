Return-Path: <stable+bounces-155212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D6CAE2819
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 10:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED623BC225
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 08:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328CB1DDC11;
	Sat, 21 Jun 2025 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUpeB40r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4398149C41
	for <stable@vger.kernel.org>; Sat, 21 Jun 2025 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750495858; cv=none; b=gBkwhmtKJfT7jAJJpivbefDRrKNzJ1rHiuRscjIY4iQ1dSE5DWEyTTystIKOa2nDuITSbAsReSA2hRw+VuWRX7jbpWtBweO9Idi71w+plIdAvpn3+RdreGtmys/QUwhXoQvxEeCptF2xPyA3HzZeK4KDF/p5Hn8pcwDHEkZQGrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750495858; c=relaxed/simple;
	bh=bdk9AzITYZNKidQLywXtKl2m4H2AZsjQnbAq0zed1/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NcBiZxSsR3UavfBzqQRVdmEWnxgi0P2WDMKbjxbvorUas6nLo0jVp1SJigEcY8xWyWguFXLg2JzmmLi4uZncQoK4SnkTWPq5mL8EjLzdNAKewKj08Z5EQTa0StWiT2WFnCZyGC4Et2knZ3mbPVFdwJm33OzMu4yeHfiXh9Oxx+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUpeB40r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC5CC4CEE7;
	Sat, 21 Jun 2025 08:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750495857;
	bh=bdk9AzITYZNKidQLywXtKl2m4H2AZsjQnbAq0zed1/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SUpeB40rdXZ/eI7nf4NPTjUNOfilpXjRPNY3kOAr2B0D/ATeV0LYjaTH+IoL+xfZz
	 q8XHRZF4jaGocvPJ2r+irTPjrrshRrnLkUalSAKDZIUtim3aa/LvVXtqDvTBWcXE8E
	 Y9TTF0xk1OkcnxI/8XgfSf6NFcSexZMbxnxBvC9VaK9QbR22Hc/dMbsqmZfxNiBL+D
	 RtkzQK1+ioZGuKJQ+DFSqRxEveWBIdf8YwEn/yc3fqMjE0rlBwaHN25XHUe4Ppg5WL
	 DmEzI2aZXJRIdL/n5gqNLUSnv/Gky2vUoZpfD2UKLH1Y8WGnBRqWqxhKi1m74zSl5V
	 1UEoOuBr0L0Bw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sean@geanix.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] iio: accel: fxls8962af: Fix temperature calculation
Date: Sat, 21 Jun 2025 04:50:56 -0400
Message-Id: <20250621015616-ea35166620894623@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250620101638.4137650-1-sean@geanix.com>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 16038474e3a0263572f36326ef85057aaf341814

Status in newer kernel trees:
6.15.y | Present (different SHA1: b0df531da1ef)

Note: The patch differs from the upstream commit:
---
1:  16038474e3a02 ! 1:  fe42ce37a0ddf iio: accel: fxls8962af: Fix temperature calculation
    @@ Commit message
         Signed-off-by: Sean Nyekjaer <sean@geanix.com>
         Link: https://patch.msgid.link/20250505-fxls-v4-1-a38652e21738@geanix.com
         Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    (cherry picked from commit 16038474e3a0263572f36326ef85057aaf341814)
     
      ## drivers/iio/accel/fxls8962af-core.c ##
     @@
    + #include <linux/property.h>
      #include <linux/regulator/consumer.h>
      #include <linux/regmap.h>
    - #include <linux/types.h>
     +#include <linux/units.h>
      
      #include <linux/iio/buffer.h>
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

