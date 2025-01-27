Return-Path: <stable+bounces-110916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 083ABA200BA
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 23:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459B018850A6
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 22:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918091DC9BE;
	Mon, 27 Jan 2025 22:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5XpSJNp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C6E1DC9A8;
	Mon, 27 Jan 2025 22:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738017610; cv=none; b=l+O4AD5Pb6qjC8BDk/StXQZ7J/loADdoNPJm6Mz8ejA8HxOZaNl6b22eru3ld55JAsz4kh4qNRSxqa1GMAapIwoNyHy02Gh1csISFrcL2BuNo+TFSQ/7IK8A6sqv6EBed/ZGqBzLqmkR+6xw0PdplkIPPoCIXlLo4iBlsHNYfgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738017610; c=relaxed/simple;
	bh=gFEzHz1kzLWNohyv4pPvISRHlA7q66taBSyM3uaPg4Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=betEXwHy0RH0rg4OfwLaTyEFpbJbPiC0M5XaEHlmlEmEyq1lKacLPcdraPnmrGvlp2jcaEzZOVA2BVJzjRh4YDe876UXYmMFc1YXSknS/komCCFBjWwhmbuXu1tH+QNmGSUxRZHEX78bHCn7zNOYOb92VjbEE4e9Wsm5NqQmpGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5XpSJNp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182BEC4CEE3;
	Mon, 27 Jan 2025 22:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738017610;
	bh=gFEzHz1kzLWNohyv4pPvISRHlA7q66taBSyM3uaPg4Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R5XpSJNpVIKOOEoosiSsoLbd6ttCnFsK8Jc5iLeEzpfTmEYXzhZtSXtVc6bf694CT
	 3lELOHFaQg8B1o0Vb1Lu35tl4mXccOPBa/AdHWwR2si6bc6TX8MuF+1AznRpShLuNZ
	 NyDcs4hVxhdOriaCzaDT21v5FM+9AMBBMc5/MN6mCsiIonMU3ajoZHJwarg0RjYZfU
	 0sBp+I4FXCSewCXRt2h9up0iF8iPgIsghSLc6c3SwreUn/UgPPPPWh9jEThM5aRxOr
	 WBFXGpiPGEKOmTweW/ePcDFo8fkzmk8c58s4gQ44K7H1CzIHrJ+maTVUOgKAwByS4C
	 HVbVAfI2A4Txg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF76380AA63;
	Mon, 27 Jan 2025 22:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net] ptp: Ensure info->enable callback is always set
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173801763574.3245248.16939422208206942895.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jan 2025 22:40:35 +0000
References: <20250123-ptp-enable-v1-1-b015834d3a47@weissschuh.net>
In-Reply-To: <20250123-ptp-enable-v1-1-b015834d3a47@weissschuh.net>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Clinux=40weissschuh=2Enet=3E?=@codeaurora.org
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 john.stultz@linaro.org, arnd@arndb.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Jan 2025 08:22:40 +0100 you wrote:
> The ioctl and sysfs handlers unconditionally call the ->enable callback.
> Not all drivers implement that callback, leading to NULL dereferences.
> Example of affected drivers: ptp_s390.c, ptp_vclock.c and ptp_mock.c.
> 
> Instead use a dummy callback if no better was specified by the driver.
> 
> Fixes: d94ba80ebbea ("ptp: Added a brand new class driver for ptp clocks.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> [...]

Here is the summary with links:
  - [RESEND,net] ptp: Ensure info->enable callback is always set
    https://git.kernel.org/netdev/net/c/fd53aa40e65f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



