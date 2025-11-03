Return-Path: <stable+bounces-192110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24451C29B63
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 01:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AFE24E1F48
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 00:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32D61C5D77;
	Mon,  3 Nov 2025 00:48:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFD813C3F2;
	Mon,  3 Nov 2025 00:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762130918; cv=none; b=Xxl6Jff036E7WqaNGdcXbSJ9nsdTTIPymX+8/2pKYmKzGKV+7i7VtCcWEvVKAtSGG2qL5KyxZv3PrXVHg7cAArxj9uFewXM0IvFIkcEKPS8kuHQOtJHZupsQSSyJK8bubeEOpOk+kDXn3xRecyTYmxCm/Fikv5XXfO/EW543MHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762130918; c=relaxed/simple;
	bh=LWTd1yc63iz5dTRYv0VkKU6FmoBTGXAInd6quG3CZj4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CrtyjG9iuo8jMwyPLxtjeEawSCySKC6oGlkaDf3j2Q+ksYhC+FJZctCeHyS95dcVxjCQlgMUky+BX8wkaDuloKex/Y90klZaLRYTI0+JFytLg3LelbsHZNwVPIag2zc+p7gm7xTXCJ41vn2LvKTGGGhPUAmw6KVZU/WCXirMdWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D2CC4AF0C;
	Mon,  3 Nov 2025 00:48:37 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 3CED2180CB9; Mon, 03 Nov 2025 01:48:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Lee Jones <lee@kernel.org>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: stable@vger.kernel.org
In-Reply-To: <20251023102905.71535-2-krzysztof.kozlowski@linaro.org>
References: <20251023102905.71535-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] power: supply: max77705: Fix potential IRQ chip
 conflict when probing two devices
Message-Id: <176213091324.301408.11975062916698702054.b4-ty@collabora.com>
Date: Mon, 03 Nov 2025 01:48:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 23 Oct 2025 12:29:06 +0200, Krzysztof Kozlowski wrote:
> MAX77705 charger is most likely always a single device on the board,
> however nothing stops board designers to have two of them, thus same
> device driver could probe twice. Or user could manually try to probing
> second time.
> 
> Device driver is not ready for that case, because it allocates
> statically 'struct regmap_irq_chip' as non-const and stores during
> probe in 'irq_drv_data' member a pointer to per-probe state
> container ('struct max77705_charger_data').  devm_regmap_add_irq_chip()
> does not make a copy of 'struct regmap_irq_chip' but stores the pointer.
> 
> [...]

Applied, thanks!

[1/1] power: supply: max77705: Fix potential IRQ chip conflict when probing two devices
      commit: 1cb053ea2e1dedd8f2d9653b7c3ca5b93c8c9275

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


