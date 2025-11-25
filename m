Return-Path: <stable+bounces-196888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 751C9C84C5E
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 12:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6A23B1AEF
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 11:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234BB31A552;
	Tue, 25 Nov 2025 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIFXXtmT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C906F315776;
	Tue, 25 Nov 2025 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764070850; cv=none; b=h1YKTxNY7QtiaE57ZklRdjVgYaliXdtM8VnC8YpRe6CKvkqyHmBKhGMKHxxi+G6R83ENVB0wwi6UXa/q+g5OK7U0o6j1uGGTWanW/N6c0x6qXQvnemT+2tcNtaR56MEcn23079HkXeYZRET41MOdotN6hGeWewURtM09hc08BWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764070850; c=relaxed/simple;
	bh=hxfa3Wz6MKpJejE1ht5kl3ss5kF2RMA0erJFOXnjR5Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e8cauNu0xBbgwUpeNfygsB+Nznxw3fQj+xAv2TuzDT1gx+OPllh/Nz4wUnTLFEmrmVfXKQY9V7et6C8/UX15pV24U2AeGMH8Y/MGrdW8+Qa29phTIeN8+u6gxIRAAQefg77lyxSjvE/mqCWe0yvS8LIiMA7kZ6Vd5w30q8yGapA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIFXXtmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6788CC116D0;
	Tue, 25 Nov 2025 11:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764070850;
	bh=hxfa3Wz6MKpJejE1ht5kl3ss5kF2RMA0erJFOXnjR5Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RIFXXtmTc6/pRspX/ULbnOvwl3iIS4VnuPVft8CeeayY3P1i0aKLOo5cDUEXmZfM2
	 Jd1UvHwyoL6ZzoTX/Ht6L04O9vAMeQGCDonT2bgToHih8bcUHkeuKpPsIEJ0i4w9mr
	 AtBwdCV7SYXlpd2MH7f39Z9DBlxhUNEmfjHo+mHjOVc3c1fcyRNkG200e1eUjmA8TF
	 0OHYyhpiISeq9ouM2KodmxXo8Y2zVPD9WpMGExzxiA9iAhAMzy3aU5gOR1qhoT5cV8
	 kJshCAvqe056xHoRTDBPVDCwXqF+PgVF9Z35ltrZZTv9Gb8TB8WW67mAKuXOpVzliB
	 cD4eDeJ0ySZTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CDA3A8D14D;
	Tue, 25 Nov 2025 11:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6 0/5] net: dsa: microchip: Fix resource releases in
 error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176407081300.696372.2913522306370415132.git-patchwork-notify@kernel.org>
Date: Tue, 25 Nov 2025 11:40:13 +0000
References: <20251120-ksz-fix-v6-0-891f80ae7f8f@bootlin.com>
In-Reply-To: <20251120-ksz-fix-v6-0-891f80ae7f8f@bootlin.com>
To: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, arun.ramadoss@microchip.com,
 pascal.eberhard@se.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 20 Nov 2025 10:11:59 +0100 you wrote:
> Hi all,
> 
> I worked on adding PTP support for the KSZ8463. While doing so, I ran
> into a few bugs in the resource release process that occur when things go
> wrong arount IRQ initialization.
> 
> This small series fixes those bugs.
> 
> [...]

Here is the summary with links:
  - [net,v6,1/5] net: dsa: microchip: common: Fix checks on irq_find_mapping()
    https://git.kernel.org/netdev/net/c/7b3c09e16679
  - [net,v6,2/5] net: dsa: microchip: ptp: Fix checks on irq_find_mapping()
    https://git.kernel.org/netdev/net/c/9e059305be41
  - [net,v6,3/5] net: dsa: microchip: Don't free uninitialized ksz_irq
    https://git.kernel.org/netdev/net/c/25b62cc5b22c
  - [net,v6,4/5] net: dsa: microchip: Free previously initialized ports on init failures
    https://git.kernel.org/netdev/net/c/0f80e21bf622
  - [net,v6,5/5] net: dsa: microchip: Fix symetry in ksz_ptp_msg_irq_{setup/free}()
    https://git.kernel.org/netdev/net/c/d0b8fec8ae50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



