Return-Path: <stable+bounces-165763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89205B1872F
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 20:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EAA94E027A
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 18:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E34F20C004;
	Fri,  1 Aug 2025 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="WeKAwAss"
X-Original-To: stable@vger.kernel.org
Received: from server-vie001.gnuweeb.org (server-vie001.gnuweeb.org [89.58.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69987188CC9;
	Fri,  1 Aug 2025 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.62.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754071813; cv=none; b=prWYViawkycYCzSD8jY/f/sTyotv/xZL7FbzsUDLUF9PPLBSVfsbMN7f3qZqaVvV3GdYgyPxBQg1wVS5KXOGulZzDwWeUUkOy4ZOk+fraEqxuqaI+bc43bfDnxIhFe8HoeA19w6rxXxegi3r2fRbTkD1/i+JaZ50BgrxqjHoNOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754071813; c=relaxed/simple;
	bh=2HAEMP5d+fgdtvDOZtHypn4YI4WVRLhNeheht+6R9wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKTxZhp6akbAbwbCjIrc65o+BG9An5q132cl5R2y9ZR/jMz1p0E4zJkpuujjiMv3JKKTn7G5udIeTzDbybuNX/S6AtW7wHtHys3/k8T4nbBC+JMLbnRrMadvhvejpqhAxaUrpkP3aLjRkBU0gm7UrnGjd9BK0RXBrBAwVWr9u94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=WeKAwAss; arc=none smtp.client-ip=89.58.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=new2025; t=1754071802;
	bh=2HAEMP5d+fgdtvDOZtHypn4YI4WVRLhNeheht+6R9wE=;
	h=Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Message-ID:Date:From:Reply-To:Subject:To:
	 Cc:In-Reply-To:References:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:User-Agent:Content-Type:Content-Transfer-Encoding;
	b=WeKAwAss79UlIECZ8P/sZVtSjURtTlzTN+NEWcLH8YG9NetZL1T7Q6fRhSPbehe/U
	 PHtWmPg0W2SSySDup12oLDwE92ccWucUETRc3MLWBP4/RAa6/NJ1bbQNGc6eBhBEyH
	 Olz5gGBG7/2cF1H+TRWGCIEY5EceZB8cIrf0BSwAdeuc8q3jfCPcsWBWSAU/Wxrh+A
	 XrcHxGmAV/1CtfV+2Nwzwt75DCdLAuOSRcxsI3Hq7TCPyzFXuPlNUUwl0U5o3RMn1Y
	 vH2N65OcIGzM2NE5sJpTQSe21OsJyHCdhthtJFv7qtMte1zsf5jUR+MuwTKQTSD68W
	 ru6MJpQueoKWw==
Received: from [68.183.184.174] (unknown [68.183.184.174])
	by server-vie001.gnuweeb.org (Postfix) with ESMTPSA id 35D263126FCD;
	Fri,  1 Aug 2025 18:09:59 +0000 (UTC)
Message-ID: <0752dee6-43d6-4e1f-81d2-4248142cccd2@gnuweeb.org>
X-Gw-Bpl: wU/cy49Bu1yAPm0bW2qiliFUIEVf+EkEatAboK6pk2H2LSy2bfWlPAiP3YIeQ5aElNkQEhTV9Q==
Date: Sat, 2 Aug 2025 01:09:56 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: usbnet: Avoid potential RCU stall on
 LINK_CHANGE event
To: patchwork-bot+netdevbpf@kernel.org, John Ernberg <john.ernberg@actia.se>
Cc: Armando Budianto <sprite@gnuweeb.org>, Oliver Neukum <oneukum@suse.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Netdev Mailing List <netdev@vger.kernel.org>,
 Linux USB Mailing List <linux-usb@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org, GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
References: <20250723102526.1305339-1-john.ernberg@actia.se>
 <175346701201.3223523.6273511358134710495.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Autocrypt: addr=ammarfaizi2@gnuweeb.org; keydata=
 xsBNBGECqsMBCADy9cU6jMSaJECZXmbOE1Sox1zeJXEy51BRQNOEKbsR0dnRNUCl2tUR1rxd
 M+8V9TQUInBxERJcOdbUKibS8PQRy1g8LKJO/yrrMN8SFqnxYyX8M3WDz1PWuJ7DZE4gECtj
 RPuYN978y9w7Hi6micjraQeXbNp1S7MxEk5AxtlokO6u6Mrdm1WRNDytagkY61PP+5lJwiQS
 XOqiSLyT/ydEbG/hdBiOTOEN4J8MxE+p2xwhHjSTvU4ehq1b6b6N62pIA0r6NMRtdqp0c+Qv
 3SVkTV8TVHcck60ZKaNtKQTsCObqUHKRurU1qmF6i2Zs+nfL/e+EtT0NVOVEipRZrkGXABEB
 AAHNJUFtbWFyIEZhaXppIDxhbW1hcmZhaXppMkBnbnV3ZWViLm9yZz7CwI4EEwEKADgCGwMF
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTok3JtyOTA3juiAQc2T7o0/xcKSwUCZ/1d1QAK
 CRA2T7o0/xcKS6fgCADlWw9ZPvM8Qv9Zdhle6zyCnwTnoZsadBnabY3NGFAo0YVNnByUy5HN
 inN92F1W71D06IrPJr/0rcCt1mJWM8TuQiU3LdEC+1Go99XA48x94grtxkZiBKKUmGU7HU4p
 5bdTj3Ki8HYCaaHz73VeLsPGvXc6uzMtHCHubErIvbf1VsXOuGo4xhxveT/RutKrJto81YWp
 zlrvbU8DJOvRuzBbNk/N/SgpyceVT+g3hAnoySUV1nweeNdnOZZ8LsH5bjCyJ8oq0n1NfngY
 u1BXSqCNKPh/QrVsXpvlWuvWog1k/GbtxQoIJ2lizJPrxA8kjUI/oQ/S9DDejiLD7yzXeUUw
 zjgEZ/1bwhIKKwYBBAGXVQEFAQEHQELDQDfZ2b77GoJFe9RHDa2xOd3X4QZPuRcqvwu2h74j
 AwEIB8LAfAQYAQoAJhYhBOiTcm3I5MDeO6IBBzZPujT/FwpLBQJn/VvCAhsMBQkI3sMOAAoJ
 EDZPujT/FwpLC9UH/Am+C8AQsDFNpTUWzkqEwTMAcXBES9sRr9Hx3AbysOuEF28LwAGaHlx9
 pn17tiusZcDQ3TnJnbp4pdUt6n1HYZqR04Nrkz7fbirFJQ214vHFov0lc8g26OdEVHWqHtKN
 GGAryZaaT2c8aqRX3X8BraFyjj35cFLKeUJDnKBWDt4ztvQnnHPi9GH74h1O/mglcMyM3EnM
 AOWKeYsHlJf98mt8gRamko7WOG473faeN1IO/iTZIdUEjzsTmzITehrqMm6FVFPFOUtmQG4M
 9X95XOk5hOL7VvJZpLc3lZdccyaWP2yJ14AX3QMBJjZuPpfDCJCVPb7PBa8fOWMghEO8hTo=
In-Reply-To: <175346701201.3223523.6273511358134710495.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/26/25 1:10 AM, patchwork-bot+netdevbpf@kernel.org wrote:
> Here is the summary with links:
>    - [net,v2] net: usbnet: Avoid potential RCU stall on LINK_CHANGE event
>      https://git.kernel.org/netdev/net/c/0d9cfc9b8cb1


I just got bitten by this commit after syncing with Linus' tree.

It breaks my laptop. RJ45 LAN cable cannot connect. After git bisect,
it ends up with that commit.

ammarfaizi2@integral2:~/p/linux-block$ git bisect log
git bisect start
# bad: [ff82265b006e468df734a2d71f9110b73bd740f2] Merge branch 'master' into af/home (sync with mainline)
git bisect bad ff82265b006e468df734a2d71f9110b73bd740f2
# good: [b0896d43221f7858491d59383f56dfe38e7fff34] Merge tag 'kvm-x86-vmx-6.17' of https://github.com/kvm-x86/linux into af/home
git bisect good b0896d43221f7858491d59383f56dfe38e7fff34
# good: [5f5c9952b33cb4e8d25c70ef29f7a45cd26b6a9b] Merge tag 'powerpc-6.17-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect good 5f5c9952b33cb4e8d25c70ef29f7a45cd26b6a9b
# bad: [8be4d31cb8aaeea27bde4b7ddb26e28a89062ebf] Merge tag 'net-next-6.17' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
git bisect bad 8be4d31cb8aaeea27bde4b7ddb26e28a89062ebf
# good: [c2b93d6beca8526fb38ccc834def1c987afe24fc] eth: fbnic: Create ring buffer for firmware logs
git bisect good c2b93d6beca8526fb38ccc834def1c987afe24fc
# good: [077f7153fd2582874b0dec8c8fcd687677d0f4cc] gve: merge xdp and xsk registration
git bisect good 077f7153fd2582874b0dec8c8fcd687677d0f4cc
# good: [126d85fb040559ba6654f51c0b587d280b041abb] Merge tag 'wireless-next-2025-07-24' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
git bisect good 126d85fb040559ba6654f51c0b587d280b041abb
# good: [ecc383e5fe060f1aaad0e4e4ae36ad1c899e948d] Merge tag 'linux-can-next-for-6.17-20250725' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
git bisect good ecc383e5fe060f1aaad0e4e4ae36ad1c899e948d
# bad: [c58c18be8850d58fd61b0480d2355df89ce7ee59] Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect bad c58c18be8850d58fd61b0480d2355df89ce7ee59
# good: [620e2392db235ba3b9e9619912aadb8cadee15e7] net: dsa: microchip: Disable PTP function of KSZ8463
git bisect good 620e2392db235ba3b9e9619912aadb8cadee15e7
# bad: [2764ab51d5f0e8c7d3b7043af426b1883e3bde1d] stmmac: xsk: fix negative overflow of budget in zerocopy mode
git bisect bad 2764ab51d5f0e8c7d3b7043af426b1883e3bde1d
# good: [4fc7885c3a98ec4450103aef874fb1d35920c7af] Merge branch 'mlx5e-misc-fixes-2025-07-23'
git bisect good 4fc7885c3a98ec4450103aef874fb1d35920c7af
# bad: [1bbb76a899486827394530916f01214d049931b3] neighbour: Fix null-ptr-deref in neigh_flush_dev().
git bisect bad 1bbb76a899486827394530916f01214d049931b3
# bad: [165a7f5db919ab68a45ae755cceb751e067273ef] net: dsa: microchip: Fix wrong rx drop MIB counter for KSZ8863
git bisect bad 165a7f5db919ab68a45ae755cceb751e067273ef
# bad: [0d9cfc9b8cb17dbc29a98792d36ec39a1cf1395f] net: usbnet: Avoid potential RCU stall on LINK_CHANGE event
git bisect bad 0d9cfc9b8cb17dbc29a98792d36ec39a1cf1395f
# first bad commit: [0d9cfc9b8cb17dbc29a98792d36ec39a1cf1395f] net: usbnet: Avoid potential RCU stall on LINK_CHANGE event

-- 
Ammar Faizi


