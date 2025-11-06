Return-Path: <stable+bounces-192566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 641C0C38D26
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 03:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF501A252D3
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 02:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A0322ACEF;
	Thu,  6 Nov 2025 02:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3dt2/sh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110C421CC58;
	Thu,  6 Nov 2025 02:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395036; cv=none; b=KA+xLCONulr8sICyKtDUSdjvFDUXzxAtxjIBhwllDMbgvtqIkuGxR1QPfxMe0474huUgIQ2iQpWQWFTLEJuz/Hy3N8wGLBpXmsB+CMY4gMw0XhpKTPJ9h4sILw0VHpjJ9ECSLFRIoVNEYiKF+/JpuFlHDkGJQJ1NLOTKJjZOUG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395036; c=relaxed/simple;
	bh=8NMnlGeu5P7aXBqXZ6R3aSnpd/pSss82sG9jkVLxDrU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BL307P1aT60xh4oHw2cr2LokbpKqUVoagCrbV7b/A/y7kSQcdm/oF+nvy6L/5bdr5O2c+lK2wCDGmDvPqGY2r2KJ1QPx4cF3a1sLA0RQw3SVTH3x/FSqXaI46LyKGSSlnM6chUKVsvX959b6VFzb7Z9QDVLJywlz2pe76WpDvq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3dt2/sh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78122C4CEF5;
	Thu,  6 Nov 2025 02:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762395035;
	bh=8NMnlGeu5P7aXBqXZ6R3aSnpd/pSss82sG9jkVLxDrU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U3dt2/sh3hsJwAkBDnLmxL6IZmMPR0WviqbpUKW0x1vZkctmK9nu05VEyFqwc2OvO
	 OHpdF6WNMtHJdW95brtKU4QjbXy3wWiYeMSbq8fg4KTjV+i3Xi/k/pyW8HhyKnxuoL
	 Vc9xOQtEi0xRruTnpTj07d6NN0eZWGOhfIKRtwIomGQmHTP+z15KEl22TkuAn38l5W
	 oUPrc7VdP0E/w6KUlo4N+ryu+VftxJ51vfqQYsDAI0SKOgtvuuD20ZzVUBVOrKEeWT
	 qABz6cNMAQmwA26MiL9VNofioKSJ7+Y6TO+gvYSCQGR6UXw4IRTvZ/J2Foe3+kWIv7
	 AO3M1oYG1fydQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF18380AAF5;
	Thu,  6 Nov 2025 02:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: libwx: fix device bus LAN ID
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176239500875.3834029.13790801882949409610.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 02:10:08 +0000
References: <B60A670C1F52CB8E+20251104062321.40059-1-jiawenwu@trustnetic.com>
In-Reply-To: <B60A670C1F52CB8E+20251104062321.40059-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 mengyuanlou@net-swift.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Nov 2025 14:23:21 +0800 you wrote:
> The device bus LAN ID was obtained from PCI_FUNC(), but when a PF
> port is passthrough to a virtual machine, the function number may not
> match the actual port index on the device. This could cause the driver
> to perform operations such as LAN reset on the wrong port.
> 
> Fix this by reading the LAN ID from port status register.
> 
> [...]

Here is the summary with links:
  - [net] net: libwx: fix device bus LAN ID
    https://git.kernel.org/netdev/net/c/a04ea57aae37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



