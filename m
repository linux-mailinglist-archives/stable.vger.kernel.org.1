Return-Path: <stable+bounces-164364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F598B0E97D
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 06:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FB76C787E
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 04:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD64212D67;
	Wed, 23 Jul 2025 04:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxKsrMsw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9059C1DA23;
	Wed, 23 Jul 2025 04:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753244058; cv=none; b=qkwZ+C/K4tKCeXdpIE1UUR+HplIfuw+Bux2qlIyUN73Nkvkgo+wcv13pNn2KUIwCQA/JqzrqyvKGAAH+gvmaAWW7QwpbFZjZyf/B1DITJHV6wJ5u9OmGxsF30D/vH0tWSiGL6oB6dbrf/F8M2B1f+qaskj4Bx6agrOziog3AoHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753244058; c=relaxed/simple;
	bh=LfCvVTNncyI+L5GWkBACZBAP9t3HVvfRp0+7jgztVKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEGcCu8Bkyu+JVjbUH+cJjMEwW8WPgf6DRq9DcI9EKEKfYR4ilZTt0/Py89dwtCyFaq0qyBlIxXCf+7WiDC1WK7/TIJOJ2slX6MRCtHj4SwzYXpBe28YZGTBd2jhO5YdvUsMv6UPSiWbsctcTc5eMsGUbKS0DCbh07+M3aKvvl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxKsrMsw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D71C4CEE7;
	Wed, 23 Jul 2025 04:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753244057;
	bh=LfCvVTNncyI+L5GWkBACZBAP9t3HVvfRp0+7jgztVKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fxKsrMswqYJH8+j6y3yO5jFVs/Er5KQlLrf+oEk9G4n6Hz97KZAg6XhIYQS9w+gWR
	 DDuij8/rFoEHhYrXY7BQhMKBIEBvGggh+tYsaNDFmBfebWZk5lA+xFgwKTj+8zv4Kb
	 NnNNRkPrGbo3rc71tOfq3ZX8TzK6sP1ZLPYARQLfzC0Xaqo3cdYolpLNOPdIQa2Zt2
	 Np9lQCu5LVjpouseO7ZcMpsRQabakEqb6U2Z99pBLcJ4qTHu03goqE3wI8o++O8yon
	 P9gWi0xP+seY8Kn3hOldCO5rP48t9K2DHIYxgPgw59cACOQa3CHcusQRuhsEpyCEht
	 I6gJw4cijaETQ==
Date: Tue, 22 Jul 2025 23:14:16 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Orson Zhai <orsonzhai@gmail.com>, David Airlie <airlied@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
	Simona Vetter <simona@ffwll.ch>, stable@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Kevin Tang <kevin.tang@unisoc.com>, devicetree@vger.kernel.org,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Maxime Ripard <mripard@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: sprd,sharkl3-dpu: Fix missing
 clocks constraints
Message-ID: <175324405446.1118889.12773496556755624286.robh@kernel.org>
References: <20250720123003.37662-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720123003.37662-3-krzysztof.kozlowski@linaro.org>


On Sun, 20 Jul 2025 14:30:04 +0200, Krzysztof Kozlowski wrote:
> 'minItems' alone does not impose upper bound, unlike 'maxItems' which
> implies lower bound.  Add missing clock constraint so the list will have
> exact number of items (clocks).
> 
> Fixes: 8cae15c60cf0 ("dt-bindings: display: add Unisoc's dpu bindings")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!


