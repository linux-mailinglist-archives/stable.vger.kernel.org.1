Return-Path: <stable+bounces-203357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C7ACDB973
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 08:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3657B300F585
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 07:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E489132ABC6;
	Wed, 24 Dec 2025 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiaG+Qoz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FD226FDBF;
	Wed, 24 Dec 2025 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766561545; cv=none; b=ZoyXVKa8AolXPbqLhCxpizdEjB2d1RtZEb5tAU2cLlNPvdF1LONo7+ExEOqf4zjaCeK4V8ebr/URdBY7ikePze016A5UlkYs/wNVicHA0z3qla4faPyOmJ70WMLw0FZQox2HYZboHoFbqfteISFYJpfklIbqh6I5yvnQ59YXNZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766561545; c=relaxed/simple;
	bh=BR3UWpciDbuo91EGSVtusYswTqy1wClc4k6RyWd0jvg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sEdjEJ2SqIYcZWbzLy4wYHAt3QYm8dhxvHxUYvLPX+SaV3TAJNrU4UvTdSKkSZH2I67F/Pa9ul4Ai2mKAzbirM9rAENTcGb92eFAV6ORiPJITBfQ2Ny9C4J0oNdiO3xT0XvmGqjwDCo7Ns1xMAY6RyatqKbsYK+Zd9GkpiPk92w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiaG+Qoz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678C9C4CEFB;
	Wed, 24 Dec 2025 07:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766561545;
	bh=BR3UWpciDbuo91EGSVtusYswTqy1wClc4k6RyWd0jvg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LiaG+Qoz5X1OPzwDsdbFvgnHLJBWWMGiPSGKdq1x78zDMF+QKnTJLMtgcPUpdTuTT
	 QR0DcecR1H5j0iRRNtUhphFTuLpztG0BSvUrow/Piniy5RZlmoBfF5RSuaNYhWyXCq
	 6f35jsOL8x5cjE0V0Iz326M55GHEoFI+n8ktx/qZflvd/K4SSmdnpg8UaamIEZCdj+
	 Giw1zQ47/QD/ins8EsJGNrP1kaIpChq0pOMnqe2x8GqIcd9Z30KsqVhF4ZEN6hW10d
	 lp/9K2G53neN1yX6gScythcYH/jLheWkGb+mlSfOqMXYacC9LvrkOk1PpWV79q7sGn
	 7zVkD+fEqMuDw==
From: Vinod Koul <vkoul@kernel.org>
To: jckuo@nvidia.com, kishon@kernel.org, thierry.reding@gmail.com, 
 jonathanh@nvidia.com, Wayne Chang <waynec@nvidia.com>
Cc: haotienh@nvidia.com, linux-phy@lists.infradead.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20251212032116.768307-1-waynec@nvidia.com>
References: <20251212032116.768307-1-waynec@nvidia.com>
Subject: Re: [PATCH 1/1] phy: tegra: xusb: Explicitly configure
 HS_DISCON_LEVEL to 0x7
Message-Id: <176656154202.817702.8391206381480779242.b4-ty@kernel.org>
Date: Wed, 24 Dec 2025 13:02:22 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 12 Dec 2025 11:21:16 +0800, Wayne Chang wrote:
> The USB2 Bias Pad Control register manages analog parameters for signal
> detection. Previously, the HS_DISCON_LEVEL relied on hardware reset
> values, which may lead to the detection failure.
> 
> Explicitly configure HS_DISCON_LEVEL to 0x7. This ensures the disconnect
> threshold is sufficient to guarantee reliable detection.
> 
> [...]

Applied, thanks!

[1/1] phy: tegra: xusb: Explicitly configure HS_DISCON_LEVEL to 0x7
      commit: b246caa68037aa495390a60d080acaeb84f45fff

Best regards,
-- 
~Vinod



