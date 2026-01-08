Return-Path: <stable+bounces-206391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D9931D04C33
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 18:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7433630633B8
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 16:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773122E8E16;
	Thu,  8 Jan 2026 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7TAsFjp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357762FB616;
	Thu,  8 Jan 2026 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891229; cv=none; b=MJUEZE1eJeHS1+dmRjxNDdz73aCI3nkxXYQMofsk1DLkWo0P78FEGQzuSQV7Rq7Qq0Mzx9G0cXVfLXxV+oo1ToMdqCtJYOkpfy5ccYsxkNM+c/DhQTHgkCatDQjWjWtE25hX4r+Y/MCe6S+OM3/hakh07xzYlTfImoHhK2cGsow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891229; c=relaxed/simple;
	bh=FvVFkhq3ih/7Pr5tX1hi0ZB/aEynWF5iQIiO6C5sTes=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DR+qcuanxWiuzIVODyCGxMDe5+pkGqbr0dev885hSm+elJA9tOwC97UrDbQCc9aYao2zpwZRTxxHR2xL1klIouWgrTU0WaVCMGDm5ikLH3SqLjZiam/yBGnkFKZu/T9DoKJlzikgGaJ2COC+906dxK1ucAw6ILfg8cKp1Zq2hyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7TAsFjp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB259C116D0;
	Thu,  8 Jan 2026 16:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767891228;
	bh=FvVFkhq3ih/7Pr5tX1hi0ZB/aEynWF5iQIiO6C5sTes=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I7TAsFjpCZ8ixhLH8eLruCaFKaf3RDtHdYJ5YZpjqtMJjXzAI9agXVWUucZWg2mtI
	 yEZsq0fESmmtj9c/oh9eCoQu122ZDqT0Oe+jfMRQucdik3iVkRZbjN9oy9lDVnYHHj
	 /O0c9Ev7BZN+UECrtL5qcDE3YNhR2jaW6QOY9jW2/Gx5HICXH+XRAwj/sjRj0ettFC
	 mZ1yZiMt+OjyRJqsumJpyOJmOoPUROI+uaHs3hxpfqa/BU8U+UVexDGU/LXqhkfFCN
	 JxBNlOAQSV7RM0dyNhty7rnKJHNVcfwFSwySEefWHpqu29PSyQ4kIxAWq5sncy3Uac
	 xVkEXdP3kMMfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 789033A54A3D;
	Thu,  8 Jan 2026 16:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] atm: Fix dma_free_coherent() size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176789102528.3716059.7973685974047061916.git-patchwork-notify@kernel.org>
Date: Thu, 08 Jan 2026 16:50:25 +0000
References: <20260107090141.80900-2-fourier.thomas@gmail.com>
In-Reply-To: <20260107090141.80900-2-fourier.thomas@gmail.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, 3chas3@gmail.com,
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Jan 2026 10:01:36 +0100 you wrote:
> The size of the buffer is not the same when alloc'd with
> dma_alloc_coherent() in he_init_tpdrq() and freed.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v2] atm: Fix dma_free_coherent() size
    https://git.kernel.org/netdev/net/c/4d984b0574ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



