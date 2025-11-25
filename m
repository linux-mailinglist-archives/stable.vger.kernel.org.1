Return-Path: <stable+bounces-196892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDEEC84D0F
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 12:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5522034FC37
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 11:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B431C31A563;
	Tue, 25 Nov 2025 11:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOAU2BZA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6231A072;
	Tue, 25 Nov 2025 11:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764071447; cv=none; b=EjlXIo6Qm4b9tnoatoVuOqNs63oh2qJnrN53A7WlhaUNIHdn5sqFulorYHQbTVBaNaI6H1/JWbJf8beLFDzf2nGv3rhhP1goZ38INDaqyLmhGOSMP9QPHHFE5uzVCduf2NO4hKQeFGycha7KIc7VNexRRqHtHluHiF079IV/apY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764071447; c=relaxed/simple;
	bh=CpPzwekMGgCzvwTeVf51o7CcNKdjbwD8VmHT0kEezjI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fhZcqP+CYiEj5WUsrItRC0Vwuq/hrNjKiRLrUWQ+E6GIqlGJYs4mgpFc+Kp2a+sbUgyile4RN/NQIsUabSQz52HixLPcU5RZBGFkIZU5nRf2tyE9J5p/X2qao+9lkuHET7UQ9zdcc7NDEUTVKDhpZx1I4khgjvSheF2sArNojek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOAU2BZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D755CC2BCC4;
	Tue, 25 Nov 2025 11:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764071446;
	bh=CpPzwekMGgCzvwTeVf51o7CcNKdjbwD8VmHT0kEezjI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VOAU2BZAR8P1V0hB4axC0nHsMSN9vBBlylBXwiv0OUOxbjsQ9DZjPYwggqkgPpWAT
	 3PwFvGTT+lxQi6Y3WqEio403QyeKi0/iiDSRJ0l2c6s8j6XJ5SVvK+b0nPxN5SSfSa
	 j/1livoVl8Qu58ut477eBkgJf/UViXTveHIlIG3HP2DGHt9VDDE/zAdKjJQ+Sr4z8W
	 8xxcjhKYoSBYHCdYyFHrgYDj1ROu1dRb0TtczwJMdzUXyOKXLvTOPT1Kcq1vA1G+Sr
	 lVdQMtR3jbma2Y267SKzGRyaU1uIMLOm/qw8ZN1rpk+HliRgtLcL2tR85tatpbkqjA
	 wRdJzHwRqjyDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A38943A8D14E;
	Tue, 25 Nov 2025 11:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] atm/fore200e: Fix possible data race in
 fore200e_open()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176407140950.699740.8085485835918845656.git-patchwork-notify@kernel.org>
Date: Tue, 25 Nov 2025 11:50:09 +0000
References: <20251120120657.2462194-1-hanguidong02@gmail.com>
In-Reply-To: <20251120120657.2462194-1-hanguidong02@gmail.com>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: 3chas3@gmail.com, pabeni@redhat.com, horms@kernel.org, kuba@kernel.org,
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 20 Nov 2025 20:06:57 +0800 you wrote:
> Protect access to fore200e->available_cell_rate with rate_mtx lock in the
> error handling path of fore200e_open() to prevent a data race.
> 
> The field fore200e->available_cell_rate is a shared resource used to track
> available bandwidth. It is concurrently accessed by fore200e_open(),
> fore200e_close(), and fore200e_change_qos().
> 
> [...]

Here is the summary with links:
  - [net,v3] atm/fore200e: Fix possible data race in fore200e_open()
    https://git.kernel.org/netdev/net/c/82fca3d8a4a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



