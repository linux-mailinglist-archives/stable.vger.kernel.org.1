Return-Path: <stable+bounces-155224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575E2AE2822
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 10:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0CBD17CBFA
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 08:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E5B1DE2A0;
	Sat, 21 Jun 2025 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNqJtZr2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786761C8629
	for <stable@vger.kernel.org>; Sat, 21 Jun 2025 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750495940; cv=none; b=cQ+lP0qE9Gi3u3+qHFZJ6mPVGC0mAdGxWU2nZNlWXQksBIuRBMjYCg9y98wcEkfxFUWb1JoCkRJQCkLu4fKCKvZmd17EBvq2A5nAbbl0MFs4VVMa7xZur2l/64Qo9jT4T88Zwwqhym6Odpd1G4Dk0lHiS0MX/+omL0Rn/BO91z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750495940; c=relaxed/simple;
	bh=zPtxM6kaUHGhS1vtYxse5Xw/C9oOopxByJ40z0NmmUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGqeZuBAvrwX4OZbq4v8659898pTnXNSwd4i8xb+g3UQwoq4ksEiRGD9te3JiZGAEEdM2GagV0GZiqHBbp+S0K8ljsnMiNS+4i/kvl+QO74+BzFqHOs3wXRnsJa0Pnb81m6JDArdCwx665umcpnVRDy0e52bl6TWUE2ojG/MLwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNqJtZr2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E331EC4CEE7;
	Sat, 21 Jun 2025 08:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750495940;
	bh=zPtxM6kaUHGhS1vtYxse5Xw/C9oOopxByJ40z0NmmUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jNqJtZr2YviEb3iwt37CD/jocrjEziZblmhMVYlF9wVg7uZbKuQ6cZU7kTJKV37q1
	 IqODhLrclhE9g8sYu3YpT32vhieIH2GRN8NjKnglfKM8OIqc5wZW8PfufXLgrHPFgZ
	 WpUAHw39a8o/QFEAr52skp1BlhJ8j6Lpy1S//MVfwik9Xi7WVHVaiPEzSic8Wf9xG8
	 cl//PBj9Anh6OT9om2IvP3eWm4w4JXstov5hpVASaSidvq31jMkKy9E+sUBITBmkHY
	 gmTiZ7FMQxBazTyUcQALZdezJ3SfZWR4SEUFPHZdeG6DGwG2gNjGSlJw2O/zffpvt6
	 S8crWx4SgCBUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sean@geanix.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] iio: accel: fxls8962af: Fix temperature calculation
Date: Sat, 21 Jun 2025 04:52:18 -0400
Message-Id: <20250620234127-364b21949ff5b59b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250620101904.10740-1-sean@geanix.com>
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
6.12.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  16038474e3a02 ! 1:  08702bd93754a iio: accel: fxls8962af: Fix temperature calculation
    @@ Commit message
         Signed-off-by: Sean Nyekjaer <sean@geanix.com>
         Link: https://patch.msgid.link/20250505-fxls-v4-1-a38652e21738@geanix.com
         Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    (cherry picked from commit 16038474e3a0263572f36326ef85057aaf341814)
     
      ## drivers/iio/accel/fxls8962af-core.c ##
     @@
    + #include <linux/pm_runtime.h>
      #include <linux/regulator/consumer.h>
      #include <linux/regmap.h>
    - #include <linux/types.h>
     +#include <linux/units.h>
      
      #include <linux/iio/buffer.h>
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

