Return-Path: <stable+bounces-40147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C1D8A90AC
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 03:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1376E1C21B24
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 01:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3420339ACD;
	Thu, 18 Apr 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgkRsR9d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D584779E1;
	Thu, 18 Apr 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713403829; cv=none; b=aau1tKDD8CkKdq0VTzMkUI8vAEV8XacYUYij8+/Fu9dsCvlpqCDPZprZmMJ1ofbZU9tVJwPy0h7S0L4FcMNviORQFZhJZCWxVHgIuH4h+1iQEoURqxjeXlkGrQtk+5jFwuYdICKrHsDlIMHzyNDzBighzavYiz8HhMU6tEoiQQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713403829; c=relaxed/simple;
	bh=gZOT/mOu2CyMDoG/ag0UuuhYX4Sj3DH7kUHqY72aNOo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iNRsZqPslfcTvNaw5kB30r2QZM5lLjhNQGx4tiEUqLGCAbMKSIRNhQhiECOpevMRho7bLHrlweGDwZ1vlGZPjZJuE5WLAs+3fMHoXt5N0hCQLdD4zW/Rq9t3Wa/IQNnvVd6xJZOA8kcCjvabR6atY4fcRLtRo9XmbLo1YcbsV38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgkRsR9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7777BC2BD11;
	Thu, 18 Apr 2024 01:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713403829;
	bh=gZOT/mOu2CyMDoG/ag0UuuhYX4Sj3DH7kUHqY72aNOo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FgkRsR9dWmawSa+lnBNBzm7D5ZM9RlrEERfvyTaUHRx/3rWYNT0Q8O8cZvmCQAYJI
	 m/F7LaRFVd4roG2p6Bpd3t8ibrTf7ke9/7lTm5M2j8R7WWmhgAJ21zW9m4t/t9WLEv
	 w2cScYoGJM3m+/uHE0Py9Yg5Ct99El7TsOmElrO8ZyHpFvN2jvgMLxzHVEVaRSgiXo
	 efrbo/t2d6i1G1nwRKr9hy6bd/dRys/4Af9/wnMDI1UtCN+8W8budnEZTFzUwPL0xa
	 R9pDdKiZHvSl6ESvQE9eSlPrK0X7K552vSqzZM24EZ2QEt/s18ncUpQ2z3oO9pZKTl
	 iUSO1jhT7aI2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BCFEC43619;
	Thu, 18 Apr 2024 01:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2 v3] USB: serial: option: add Lonsung U8300/U9300 product
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171340382937.22183.3670134253557534621.git-patchwork-notify@kernel.org>
Date: Thu, 18 Apr 2024 01:30:29 +0000
References: <20240415142625.1756740-1-coiaprant@gmail.com>
In-Reply-To: <20240415142625.1756740-1-coiaprant@gmail.com>
To: Coia Prant <coiaprant@gmail.com>
Cc: linux-usb@vger.kernel.org, larsm17@gmail.com, stable@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Apr 2024 07:26:25 -0700 you wrote:
> Update the USB serial option driver to support Longsung U8300/U9300.
> 
> For U8300
> 
> Interface 4 is used by for QMI interface in stock firmware of U8300, the
> router which uses U8300 modem. Free the interface up, to rebind it to
> qmi_wwan driver.
> Interface 5 is used by for ADB interface in stock firmware of U8300, the
> router which uses U8300 modem. Free the interface up.
> The proper configuration is:
> 
> [...]

Here is the summary with links:
  - [1/2,v3] USB: serial: option: add Lonsung U8300/U9300 product
    (no matching commit)
  - [2/2,v3] net: usb: qmi_wwan: add Lonsung U8300/U9300 product
    https://git.kernel.org/netdev/net-next/c/bc1b7f02c8fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



