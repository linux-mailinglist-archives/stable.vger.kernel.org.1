Return-Path: <stable+bounces-167095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79241B21B8C
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 05:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB11C3BF74F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 03:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086E52E0B6D;
	Tue, 12 Aug 2025 03:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkkLhG6z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30442DE709;
	Tue, 12 Aug 2025 03:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754968801; cv=none; b=BgxSdQtB5zeT0ELWvVuRxyUu6V5WTM/SW+imCHl5x7Cj/ecTBxGP4aAKA+vZAinjxAskrUWVvmySi0Wk0Plv0LmYS0KhD6KfB8/fGPKVj7dW5FRNG2qoM86AgvQmdclK+9ErFSOBauah6kobywhcPgQJB5anhlExgVsEqYR5K9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754968801; c=relaxed/simple;
	bh=QOBpupb0n5GKfRVbIXgDV1H/UMshmi+E6iE3T8GMY30=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CZoCs9wd8tq68FQinkjRKYzOAmou3BALcLlq7liPRGRix8hL3XADc5U7KOAM0YSErhOIcf+uSzfacHcdjWjgAEjel78ZL5bCvfRjNhiBy9VTH08yruXsg5gwxa9gAgfIH7Un6nwHtcQeLD7oN4XZJ+x4A6jGAZCD0GhU4ihXkhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkkLhG6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883F4C4CEED;
	Tue, 12 Aug 2025 03:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754968801;
	bh=QOBpupb0n5GKfRVbIXgDV1H/UMshmi+E6iE3T8GMY30=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gkkLhG6z/R74f1c8iAmlokX3iiGdWNThJS3ULhYjQ09C0nyUoszJCGjT1ELJN+9jQ
	 /PwhDNN2bERWt53Vd8m3n9k5v9d1wXD2j3WYHDDF/O1LaK9SuNYdqEuRlVKUB6+Jhx
	 H50cvQLD7MLB2S2q39Dbpk6kDZje1xRyLb7dFcV086KE9sCreR+dVGqfCD8Rs9bDHj
	 ZWGcyHFDY/qYbMJQE7vd4hSMGcOHZkolWOJxIp2ilFTmVorv+prT6ZWSMtTZ20O3+1
	 ytlJdUOheaM41Qlqzw20vXgm7hrI9UoqFohhhzB9cMb6qDiOxQucIOOiaFgxmruSNL
	 J3jW4wyamQULg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD4D383BF51;
	Tue, 12 Aug 2025 03:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: usb: qmi_wwan: add Telit Cinterion FN990A w/audio
 composition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175496881349.1990527.15993757717285261084.git-patchwork-notify@kernel.org>
Date: Tue, 12 Aug 2025 03:20:13 +0000
References: <20250808133108.580624-1-fabio.porcedda@gmail.com>
In-Reply-To: <20250808133108.580624-1-fabio.porcedda@gmail.com>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bjorn@mork.no, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, dnlplm@gmail.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Aug 2025 15:31:08 +0200 you wrote:
> Add the following Telit Cinterion FN990A w/audio composition:
> 
> 0x1077: tty (diag) + adb + rmnet + audio + tty (AT/NMEA) + tty (AT) +
> tty (AT) + tty (AT)
> T:  Bus=01 Lev=01 Prnt=01 Port=09 Cnt=01 Dev#=  8 Spd=480 MxCh= 0
> D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1bc7 ProdID=1077 Rev=05.04
> S:  Manufacturer=Telit Wireless Solutions
> S:  Product=FN990
> S:  SerialNumber=67e04c35
> C:  #Ifs=10 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
> E:  Ad=0f(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=83(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 3 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=20 Driver=snd-usb-audio
> I:  If#= 4 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=20 Driver=snd-usb-audio
> E:  Ad=03(O) Atr=0d(Isoc) MxPS=  68 Ivl=1ms
> I:  If#= 5 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=20 Driver=snd-usb-audio
> E:  Ad=84(I) Atr=0d(Isoc) MxPS=  68 Ivl=1ms
> I:  If#= 6 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 7 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=88(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 8 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8a(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 9 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8c(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> 
> [...]

Here is the summary with links:
  - [v2] net: usb: qmi_wwan: add Telit Cinterion FN990A w/audio composition
    https://git.kernel.org/netdev/net/c/61aaca8b89fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



