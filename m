Return-Path: <stable+bounces-55985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7BC91AF77
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 21:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63651F22B35
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 19:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488C319B58A;
	Thu, 27 Jun 2024 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixUTG1Gp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED16019B3CF;
	Thu, 27 Jun 2024 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719515429; cv=none; b=O2nzlXFEZc/r9P5gIK086aLDIrXY4yVtn94wDvyP3kSZbz1SISWaXV0r0Hn4GrxhPzActrUIfjjggpltSixBLnoUvf1Ol4Q53tLRHT5cKtVZktSaefKz9B503QvXwwvL9gCeG95zH56ogpTA3zfU6DrqTg3KcYtVwD83To5I+XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719515429; c=relaxed/simple;
	bh=iEttqArF/Hx/Zfn1jOB2KYxEWeXhcS6OW3osUzjnvZU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g2xzfolb30ay9HIGn3QXnYgeWpsCxXy2JwmFFkl8NOwwp81ulXQtvI6WjfhYnIxO+0mlmo81w+6XhKRyhDM9p+TzwAhK7M0JfyWQ8AsomrH9X/renShrIL9uO9yoMks+sjsgrQjHzQWv4Qhi/fOX8+qG03WcNn9DJYwOVGBq4TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixUTG1Gp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9F80C4AF09;
	Thu, 27 Jun 2024 19:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719515428;
	bh=iEttqArF/Hx/Zfn1jOB2KYxEWeXhcS6OW3osUzjnvZU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ixUTG1Gp9O2o1cyF47+u+y+zc70OlQI3CizwKpCSouDBs0HpYA+13UyCs8+ua+4ep
	 kF2r9X+qF9pzSmmsFSZMeYjI27FLhqHSK1F7BJsLN7TnZxtz4Nl5hRw+tp1UWS8Jrd
	 0beXjd16kdqbF4wO/Yace0Hd2BqUsyvJYt+QVQ9nwcLg4gOHQ9CU/24JCwIULnPW3S
	 fWQle222ahZa+R5hJgqxKxgdH4/ITbNwHZaDyG/BR8lpyHIWp/uKYsJ4RYaWxmJCIx
	 vRJkdSO8cSOsG7w0Zau6pI67oSPZjfamA2U/IYqxy9T/BHTntzGUSBxa5mmtueP4jo
	 aYjyASplvbtzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8AC8C43148;
	Thu, 27 Jun 2024 19:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btusb: Add Realtek RTL8852BE support ID
 0x13d3:0x3591
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171951542875.5140.14626882814587410505.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 19:10:28 +0000
References: <632363CB00A11519+20240622040959.7567-1-wangyuli@uniontech.com>
In-Reply-To: <632363CB00A11519+20240622040959.7567-1-wangyuli@uniontech.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: guanwentao@uniontech.com, marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 22 Jun 2024 12:09:59 +0800 you wrote:
> Add the support ID(0x13d3, 0x3591) to usb_device_id table for
> Realtek RTL8852BE.
> 
> The device table is as follows:
> 
> T:  Bus=01 Lev=02 Prnt=03 Port=00 Cnt=01 Dev#=  5 Spd=12   MxCh= 0
> D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3591 Rev= 0.00
> S:  Manufacturer=Realtek
> S:  Product=Bluetooth Radio
> S:  SerialNumber=00e04c000001
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x13d3:0x3591
    https://git.kernel.org/bluetooth/bluetooth-next/c/678c5f695671

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



