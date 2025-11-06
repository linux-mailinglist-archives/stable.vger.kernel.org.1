Return-Path: <stable+bounces-192610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E84C3B2EB
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 14:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04B664FC164
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 13:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33F4310629;
	Thu,  6 Nov 2025 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqW8MBO9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9362F4A04;
	Thu,  6 Nov 2025 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435075; cv=none; b=ptuBvQUyIwWPqeaL2S+pSfYPMn/MHw/sdRLcXCq81GdL/QaXw3V7c5M7/LEHgmG5dBhiY2cbbN5T1Fmmalxmx9tJmjwfs6H9mFNV3KiP/OPOS27ERhuoPAg+Aacl1+osBSQXO4kTcbKSixXyAMD+PT6nsbVSmETuoUnf3BhTqIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435075; c=relaxed/simple;
	bh=PeFLS4MBNGrvqg0hctEGxyULL+gpF5i9ShirCDWvB8s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fhrzOcVV2YAcfAJvqiTtSBo5iH4NnsNbmDkbaS40DY1nrRDVIaz32I1c3QponPyDpB5XDdM34u5Vgxx9qqmsT0AGcX9b1CtFjlx+3Gasgf3tfL7qAvIKd8nFE957ajYE0jVRJ74wQxJv0bBDALDjLtXxgYVWTJ6bH4mN0VMqo7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqW8MBO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B26C116C6;
	Thu,  6 Nov 2025 13:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762435075;
	bh=PeFLS4MBNGrvqg0hctEGxyULL+gpF5i9ShirCDWvB8s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bqW8MBO9kt+eMQLC+kLBxAtHEhegKEfMPvzBAB/w0vnGGe+5QXemExJgDM5nWBkCa
	 N4A+YA7xUwe4u5PkkUcaCxh9Hp6oUU8IIYNsB9nhr7t0DAeHsjM2BSyQUwL5S9z7lh
	 BPyEsGK57SNkZApHpZIsqKKExDdcZYKBiUwGF0iMd/kUOFk3zEDN84DvBsld6Jy24Q
	 DQTbC8TnLh/gD8nKWKn5bFwhheckDER9EoYTbJ5uBB13YBQ3MC6w8B3kUrM7RL6q9t
	 Wf5CMfaTxsxJSl6wF7lzK41lubuq9v3uQ9zH4gsRkYM8/kaKCMiWj6SQaJlhT0IeK5
	 wuiPI4WbqxFhw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: stable@vger.kernel.org
In-Reply-To: <20251023101939.67991-2-krzysztof.kozlowski@linaro.org>
References: <20251023101939.67991-2-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [RFT PATCH] mfd: max77620: Fix potential IRQ chip
 conflict when probing two devices
Message-Id: <176243507327.1833794.15963365133999992020.b4-ty@kernel.org>
Date: Thu, 06 Nov 2025 13:17:53 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Thu, 23 Oct 2025 12:19:40 +0200, Krzysztof Kozlowski wrote:
> MAX77620 is most likely always a single device on the board, however
> nothing stops board designers to have two of them, thus same device
> driver could probe twice. Or user could manually try to probing second
> time.
> 
> Device driver is not ready for that case, because it allocates
> statically 'struct regmap_irq_chip' as non-const and stores during
> probe in 'irq_drv_data' member a pointer to per-probe state
> container ('struct max77620_chip').  devm_regmap_add_irq_chip() does not
> make a copy of 'struct regmap_irq_chip' but store the pointer.
> 
> [...]

Applied, thanks!

[1/1] mfd: max77620: Fix potential IRQ chip conflict when probing two devices
      commit: a65059b3e91b811aff2ccfd53578e06384779ef7

--
Lee Jones [李琼斯]


