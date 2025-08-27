Return-Path: <stable+bounces-176445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C19B3760D
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 02:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6391BA0B54
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 00:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEF71487F6;
	Wed, 27 Aug 2025 00:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIcHo2Au"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4015F219EB;
	Wed, 27 Aug 2025 00:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756254002; cv=none; b=iLbjFyBe6t8s7/RScs7PwlEIy7v0C4riPKqLL5HehximiZXqqK+xSmfnOGSUZp3nxGzJf3hYGv1EatkWhreccq6uw+VWPlXYUikb5haFpW5f4gIP2hVSG+JDy0kB6ppGJvB1EJWMZiYFaR62q+Qj16zU/B0FzRrncVz2nRnPFVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756254002; c=relaxed/simple;
	bh=CUqjJTDn42AU9aihGGGRqwzymVVnZVgyspIVU6cz4BI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BYLpszm5INdeUQxiY37c9M6/sVt9r/MFvOgKyRL9Gy5GeQ2ZtMtETOk96g6Ma1g8gpSMbVOBNE0C8Opnp2coc9hF4ge3hLQhY28tw+U4lrZdfIZJQKfR+OVFDQhGYYKXmu6W7KjWUSTaWVnvQxgfx7eeFREK56774w73niracCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIcHo2Au; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBE4C4CEF1;
	Wed, 27 Aug 2025 00:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756254000;
	bh=CUqjJTDn42AU9aihGGGRqwzymVVnZVgyspIVU6cz4BI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gIcHo2AuyWKJotZssrpdk7L0eZ//QzifIcYL1GhIYtAT+NmjTdCss/9jH7ZtQsUXE
	 o6IjhM+plquBwmvTNt6T7LTAuyYXhtQ1+FujMHDleuQfEeUdh5z2m4FVtxQmEd+AhL
	 Ch9kum+n9fBfRIRYccnpjcPQSX6csSKMP43oAyI5NkzE9vLODPhdaTUVkja8eZ/A/O
	 xfCGsBlTqhUWn0duEHZTHfNXqAQc8QsWX70DBgch7fYNPLZoGagn9bwpZz1/HxkSSr
	 gNX1sQyWV31vjgBDj7OTrWSIJp1LVx+unxAE/yeyTWiBFpSDktvNC3MKrg/vKog0qz
	 1BOmAYRinKD3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB5A9383BF70;
	Wed, 27 Aug 2025 00:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: qmi_wwan: add Telit Cinterion LE910C4-WWX new
 compositions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175625400775.147674.147296191175890132.git-patchwork-notify@kernel.org>
Date: Wed, 27 Aug 2025 00:20:07 +0000
References: <20250822091324.39558-1-Fabio.Porcedda@telit.com>
In-Reply-To: <20250822091324.39558-1-Fabio.Porcedda@telit.com>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: bjorn@mork.no, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org, dnlplm@gmail.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 Aug 2025 11:13:24 +0200 you wrote:
> From: Fabio Porcedda <fabio.porcedda@gmail.com>
> 
> Add the following Telit Cinterion LE910C4-WWX new compositions:
> 
> 0x1034: tty (AT) + tty (AT) + rmnet
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  8 Spd=480 MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1bc7 ProdID=1034 Rev=00.00
> S:  Manufacturer=Telit
> S:  Product=LE910C4-WWX
> S:  SerialNumber=93f617e7
> C:  #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=fe Prot=ff Driver=option
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=83(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=85(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> [...]

Here is the summary with links:
  - net: usb: qmi_wwan: add Telit Cinterion LE910C4-WWX new compositions
    https://git.kernel.org/netdev/net/c/e81a7f65288c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



