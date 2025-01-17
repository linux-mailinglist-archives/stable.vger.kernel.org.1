Return-Path: <stable+bounces-109384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77058A15237
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 15:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A502D167B32
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 14:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11581192D76;
	Fri, 17 Jan 2025 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDCRZ13S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B182E194C61;
	Fri, 17 Jan 2025 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737125590; cv=none; b=XRD9MLZ3gy/70w+iWal8EJ90LFYPRsawa3m9dcheV46/DsicB2wUvn/WovoFHu0+YsdTCtqqz7OoNRkw3ll6qFSpZlGHKt97FWDiP8UJH5EI6hwevsE/l7aOITe/oIymfjKu6IJ2nKFADnQvTWuIvqwxI8LZMJ+WbLTrshhkKcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737125590; c=relaxed/simple;
	bh=qPICGGmXk3wGKUXRWdyeAxtpan3lRT0CCj6/B61+bfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyTveodlvl8ZCZZsMS0Ap2hnSYntLtjO93lZ28iYTE+IQ/Zf5+dsthu3zVqA8AHLAIHWL+Lg7edFGXPm8G1ZwHg4pxhLCsfpl3ZWuWYVTSZmrL6KQBf+L169qWREGmRgSsmdw/+ceYAtyCvZCzaAt+HGuIfgOJrcfoX9VfVQfiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDCRZ13S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D0AC4CEE0;
	Fri, 17 Jan 2025 14:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737125590;
	bh=qPICGGmXk3wGKUXRWdyeAxtpan3lRT0CCj6/B61+bfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UDCRZ13SlnJoqqMvjQpAVB9rDbTuNfMII/oLuUOehpJw6d7QCy5jsrxMa8Z1hQ1TH
	 imO91WQ6ARX32JARtZzzpPI2Cud7ZAWyGbJjq5hgEvZXs57HkZUp1fN8C1cplFO4Uj
	 F/Ze8C3MxShaksS/iC6B4ocxVANjWEYCY8I+pJYlpmA4NTPGaFkADZRtsDsKa0PiGr
	 Sp2LIxbJS9HIJ2hRbK9p5WZ9NnbA0c23eON/nwFw0TnLczI20uT6Gcgj5VwT7Rprw+
	 S85aI9O+fH1vOLCklQEyaRA1oCUKdnbbGknFt9+vShHlUS0kYKCVHwdz9HeP9xo3fJ
	 se2Mcb4jDMpCg==
Date: Fri, 17 Jan 2025 08:53:08 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Oreoluwa Babatunde <quic_obabatun@quicinc.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>, devicetree@vger.kernel.org,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v5 0/3] of: fix bugs and improve codes
Message-ID: <173712558146.934412.15004894934387592525.robh@kernel.org>
References: <20250114-of_core_fix-v5-0-b8bafd00a86f@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114-of_core_fix-v5-0-b8bafd00a86f@quicinc.com>


On Tue, 14 Jan 2025 23:23:02 +0800, Zijun Hu wrote:
> This patch series is to fix bugs and improve codes for drivers/of/*.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> Changes in v5:
> - Drop 12 patches and add 1 patch
> - Correct based on Rob's comments
> - Link to v4: https://lore.kernel.org/r/20250109-of_core_fix-v4-0-db8a72415b8c@quicinc.com
> 
> Changes in v4:
> - Remove 2 modalias relevant patches, and add more patches.
> - Link to v3: https://lore.kernel.org/r/20241217-of_core_fix-v3-0-3bc49a2e8bda@quicinc.com
> 
> Changes in v3:
> - Drop 2 applied patches and pick up patch 4/7 again
> - Fix build error for patch 6/7.
> - Include of_private.h instead of function declaration for patch 2/7
> - Correct tile and commit messages.
> - Link to v2: https://lore.kernel.org/r/20241216-of_core_fix-v2-0-e69b8f60da63@quicinc.com
> 
> Changes in v2:
> - Drop applied/conflict/TBD patches.
> - Correct based on Rob's comments.
> - Link to v1: https://lore.kernel.org/r/20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com
> 
> ---
> Zijun Hu (3):
>       of: Do not expose of_alias_scan() and correct its comments
>       of: reserved-memory: Warn for missing static reserved memory regions
>       of: Correct element count for two arrays in API of_parse_phandle_with_args_map()
> 
>  drivers/of/base.c            | 7 +++----
>  drivers/of/of_private.h      | 2 ++
>  drivers/of/of_reserved_mem.c | 5 +++++
>  drivers/of/pdt.c             | 2 ++
>  include/linux/of.h           | 1 -
>  5 files changed, 12 insertions(+), 5 deletions(-)
> ---
> base-commit: c141ecc3cecd764799e17c8251026336cab86800
> change-id: 20241206-of_core_fix-dc3021a06418
> 
> Best regards,
> --
> Zijun Hu <quic_zijuhu@quicinc.com>
> 
> 
> 

Applied, thanks!


