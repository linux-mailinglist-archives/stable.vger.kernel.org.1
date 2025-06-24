Return-Path: <stable+bounces-158208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8A7AE58CA
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 02:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422E2480CB4
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D3B7B3E1;
	Tue, 24 Jun 2025 00:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYo+416U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A191179A3;
	Tue, 24 Jun 2025 00:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750726179; cv=none; b=pjdXW3/tovEnX2Q3eE3ew2SO1zw5S3q8c83mGqtw1CbtdvdC4zROTAQrM2jCt46sOCFjyFn1dUpAoWST/Ca38RsTekGR7REe97HWZ19ffcIrxRkRlF2zUkDwoAkQFICjPDJLP/+4xZXdbJ7YPxjo2yV/I8zboNrMZ8+oHSsXf8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750726179; c=relaxed/simple;
	bh=auJG+ebWPdigAZon0xUkAP9Sh4i7/1apI4ycMMIuwnI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KLibBksurPbZpUsODMEFA0geGg7Hdrzbcmomqo//AzyXjfF994hOirN29bOdm6fDKnQVJO3TdYzywpQPP6lSEKqshGL1+06SEmt/oyBr7nl+Gexw1Tx/kiQEjKPx8DfC8x/KPpZQ3JBNOKThx08Q7HFxzGZsuGLreSBiSLihzhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYo+416U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00414C4CEEA;
	Tue, 24 Jun 2025 00:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750726179;
	bh=auJG+ebWPdigAZon0xUkAP9Sh4i7/1apI4ycMMIuwnI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tYo+416UzkF5unLO+5cq/IgT7Fws78hZETuwzulH0wPGHZK9jye0wFAUDVS89xI1D
	 zZ4v8aCjXZGEAPo9GMvVOxF9jlWeLmSiNklzmwyuKjAPty2zHZwbrPueF25qMv/EYr
	 inQ4HZKZB0SUdDaIZOpuwp5NwhMy6ton90LNxLQslz8cjYlE+GlV/+RIixbc9hjdpF
	 OQMEb60IPneshvBC9mbd0uKnhuNJH3qvUOLB7KQ9Au2+e8bbu7h/pM6MPf5C6vjat5
	 dhl9NLupsVecmwzPx4nbWScAvg2UBv+Mb+t6dTbHuOdx8KUDkmCJz7wsWXgu49UG6k
	 njFyy5C3Iuypg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E6739FEB7D;
	Tue, 24 Jun 2025 00:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: export boot_cpu_hartid
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175072620601.3349808.417584899603480594.git-patchwork-notify@kernel.org>
Date: Tue, 24 Jun 2025 00:50:06 +0000
References: <20250617125847.23829-1-klarasmodin@gmail.com>
In-Reply-To: <20250617125847.23829-1-klarasmodin@gmail.com>
To: Klara Modin <klarasmodin@gmail.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 conor.dooley@microchip.com, valentina.fernandezalanis@microchip.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@dabbelt.com>:

On Tue, 17 Jun 2025 14:58:47 +0200 you wrote:
> The mailbox controller driver for the Microchip Inter-processor
> Communication can be built as a module. It uses cpuid_to_hartid_map and
> commit 4783ce32b080 ("riscv: export __cpuid_to_hartid_map") enables that
> to work for SMP. However, cpuid_to_hartid_map uses boot_cpu_hartid on
> non-SMP kernels and this driver can be useful in such configurations[1].
> 
> Export boot_cpu_hartid so the driver can be built as a module on non-SMP
> kernels as well.
> 
> [...]

Here is the summary with links:
  - riscv: export boot_cpu_hartid
    https://git.kernel.org/riscv/c/c5136add3f9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



