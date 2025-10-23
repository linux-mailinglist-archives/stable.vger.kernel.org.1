Return-Path: <stable+bounces-189168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD62C0391E
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 23:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3ADD54E7BF9
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 21:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0B72C21D4;
	Thu, 23 Oct 2025 21:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPOgB7Zb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157C12C0F81;
	Thu, 23 Oct 2025 21:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761255631; cv=none; b=TWMmO4wY0rXJ/NEHpNNR9lYOgwwJ0EPBamT1XYXsCF54XsIUchOe/qO5e1uJLNzO6v96QO4JPzq6zTt5cWJKFQWDu1t6md+scISNvDjLKYR6ynKHhg6/PvMfrSFO74asWERoePvtFoye2Sr4/TwHeTwrxF7lx7IYnKTPum/M7vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761255631; c=relaxed/simple;
	bh=d31fxEionGDqWxCah++7HR8uos8Wm0b0XhvSzDRCHT0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LJicgvsnIP/cJIEKoQYjy+6bSn1BVlWYolebqSGXBo0vfgBkL780udKUdZVQ2C/WB9gxWbrKTT3MP5aRMECmUZn8l38Ctec0a69CeBpDg+fkhnC6CudnCn2s6NGti6HI0AyQPD24TR66Eg2D5rKrbo8AKnH/95I65407O/+ziJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPOgB7Zb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A16C4CEE7;
	Thu, 23 Oct 2025 21:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761255630;
	bh=d31fxEionGDqWxCah++7HR8uos8Wm0b0XhvSzDRCHT0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qPOgB7ZbFrY3w8SGFNGEVY3qHsgEQZBaVWStjO8GytPOCuGTs/29Yix86h+nZvfw4
	 TlHBZgU1Hn+en1rzl/Qy8sbWF0La65GujMV1VETpdqkNL74GxoCPMjurny/1DPOOW/
	 gL0y6gsoWHQwS/kpdiCbkxKympGWiq3aKltAFsVm6AjC2kMH7lFQ2+lCKRrRB8ENLP
	 NB3s98if5mblIB7UGVc8x2+h7QKECOcv4BxXpax3MgVw6g2+MkVdwSkqkNAa8aOF5J
	 zKgVWeIa3OMC3KiDXzFVGWgY+utRJCsdNQS/zaajam7/I3VSpaDMkwaU7kZ0pcZKVv
	 L1neGlxRyU+rg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D41380A960;
	Thu, 23 Oct 2025 21:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: rfcomm: fix modem control handling
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176125561099.3260295.2414265996830531276.git-patchwork-notify@kernel.org>
Date: Thu, 23 Oct 2025 21:40:10 +0000
References: <20251023120530.5685-1-johan@kernel.org>
In-Reply-To: <20251023120530.5685-1-johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 23 Oct 2025 14:05:30 +0200 you wrote:
> The RFCOMM driver confuses the local and remote modem control signals,
> which specifically means that the reported DTR and RTS state will
> instead reflect the remote end (i.e. DSR and CTS).
> 
> This issue dates back to the original driver (and a follow-on update)
> merged in 2002, which resulted in a non-standard implementation of
> TIOCMSET that allowed controlling also the TS07.10 IC and DV signals by
> mapping them to the RI and DCD input flags, while TIOCMGET failed to
> return the actual state of DTR and RTS.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: rfcomm: fix modem control handling
    https://git.kernel.org/bluetooth/bluetooth-next/c/8d2c47aeb078

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



