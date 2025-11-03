Return-Path: <stable+bounces-192215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB976C2CA64
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 16:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C708466352
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 15:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7810032E6B4;
	Mon,  3 Nov 2025 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgJKgTx0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332B43148D7;
	Mon,  3 Nov 2025 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181886; cv=none; b=sY0ZjfyniozoiNJPSE6AZCkOKMMrIt8zoNTI634mHtrrkNQsu95ShXl++Vj7nRiUNi1L6ykPi7vLrh8awyBAtKMeskkkblnoaFk8r7IFfMqqghvLusnDAUTKWeKbyHIvs0/H3QOselfZlBJGSXAIdwOGW1fvTc1qTtGW0CIxAPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181886; c=relaxed/simple;
	bh=CYDpxBvkVz9w2ysPRImaQH88dnUGKrKx1nckOa0sjFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JhVTNUI/jSTjoImiPzZBTks7frxNOrgOKp5duKRXGvrkrTGcxM9ViFBlQlzu1T0CZwwTQ4Wm1X+UJyZcPL123m7E/lTwGwdXELtlQiJmZ8H3I98/JjMaACBEqWZSZmyMQlYkSy5sHGUfb/jyggWd5t+ei8Psf7emW5oBowJl4N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgJKgTx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E27C116C6;
	Mon,  3 Nov 2025 14:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181882;
	bh=CYDpxBvkVz9w2ysPRImaQH88dnUGKrKx1nckOa0sjFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lgJKgTx0D1cKQoJDFMjvJqJx6QQPSDfq8+pfzwO5Pa6V8F6hSThZl9cneNLyBu/3t
	 vGVeaOXbGnoj3C9cJBZXYVD0C/hnXEo3J28CHk12gp1/6t2n6pozLUlQO0TRZCWNvd
	 Y7Z8JoQWBYGw58c4a8WUo/ygqCCIZzbwJrcCi8MeI/OxV2NdrAWTx8r1Kb0FvcexeC
	 rK4WoOxTFTn+j4KPiAryG0eevUyClnCjY901PFRGQ/zVmF2gTbr3k4oy4173Eu7yRQ
	 Uo+W4XAVKQ/KmOiXjbmmlrbop8sOlrYQRaA+YwWECtT4Uv5AwUwzr8O7stnIHF1dZZ
	 PpQnOT6kcIiCw==
From: Will Deacon <will@kernel.org>
To: mark.rutland@arm.com,
	robin.murphy@arm.com,
	james.clark@linaro.org,
	ilkka@os.amperecomputing.com,
	u.kleine-koenig@baylibre.com,
	bwicaksono@nvidia.com,
	suzuki.poulose@arm.com,
	Ma Ke <make24@iscas.ac.cn>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] perf: arm_cspmu: fix error handling in arm_cspmu_impl_unregister()
Date: Mon,  3 Nov 2025 14:57:47 +0000
Message-Id: <176217960447.2905062.12628399125158047270.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251022115325.25900-1-make24@iscas.ac.cn>
References: <20251022115325.25900-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 22 Oct 2025 19:53:25 +0800, Ma Ke wrote:
> driver_find_device() calls get_device() to increment the reference
> count once a matching device is found. device_release_driver()
> releases the driver, but it does not decrease the reference count that
> was incremented by driver_find_device(). At the end of the loop, there
> is no put_device() to balance the reference count. To avoid reference
> count leakage, add put_device() to decrease the reference count.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf: arm_cspmu: fix error handling in arm_cspmu_impl_unregister()
      https://git.kernel.org/will/c/970e1e41805f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

