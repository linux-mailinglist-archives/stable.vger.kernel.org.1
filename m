Return-Path: <stable+bounces-146435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B20AC4F7F
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 15:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5113B189D38C
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 13:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ED5271453;
	Tue, 27 May 2025 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAWi7hRI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFAF139E;
	Tue, 27 May 2025 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748351995; cv=none; b=I2KTqJeV4H1ptRx/tgQJHSrOSJJpojeMBzQrIo3zMOwXKd2efN0IhNpY7c1dyrI8vb8i8vpx2MOSlxqC4OHI/H3Swbxc88/DxjtvI5apiNVZhr+yV1ohjFVMmqCp7Xjnu8NjeZ3pYbO92vyVb7hdGYaPpjMhxPQmUCnqzFCb0J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748351995; c=relaxed/simple;
	bh=M4XbxB728daJwQckqZMnCDk8GrjCwlrgBra1xDznme0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rwa7k1GRdHLmHfdXtPhLgu/Ou5PrTgN5KDeMH8HYrlYwhqQsIFRpnd+/a6NzYB7/d4lvhu+1rybbM/nl47haULZ+NbpqEH3j5s8iMilaeA+RQlUhQ55sVdlrLC2XDM/8soAicmsdhASR1uFwf9IgyWECtk8KBq0c83Wia9QxKwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAWi7hRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F31C4CEE9;
	Tue, 27 May 2025 13:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748351994;
	bh=M4XbxB728daJwQckqZMnCDk8GrjCwlrgBra1xDznme0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HAWi7hRI7u7qrntI2T4mSJdCzH2TW2G5vpcmihi0HjLq9qEJ2SEkcvLzgf3ArWqNh
	 MBKXg/FhibFiT6AcjgvnDNYrIBLAAlbL+VaJHnBbuoy0DRW62YjJgd8o4fJZ4tWTCP
	 RoQEyIUua7tRNqDFGjob3bbBtVSFYf19W1/Eq20VWdEXPslbPaD43nvG/3Qlp4kcHj
	 0v297DVChvsaFu+COzZtQtTeU5VipDzVq+Er1Q899Dk94woVGaUEUryasj3iTQEeEc
	 yUQmlFcXdDYe0k986yUdxXer9jwReKva3c65Cy3OyvyItYr97HRLmox1bvVSD0kkVO
	 u3Ek6V83x/+fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C8E380AAE2;
	Tue, 27 May 2025 13:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add USB ID 3625:010b for TP-LINK Archer
 TX10UB Nano
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174835202898.1634553.17396092504323562306.git-patchwork-notify@kernel.org>
Date: Tue, 27 May 2025 13:20:28 +0000
References: <20250521013020.1983-1-zenmchen@gmail.com>
In-Reply-To: <20250521013020.1983-1-zenmchen@gmail.com>
To: Zenm Chen <zenmchen@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 pkshih@realtek.com, max.chou@realtek.com, hildawu@realtek.com,
 rtl8821cerfe2@gmail.com, usbwifi2024@gmail.com, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 21 May 2025 09:30:20 +0800 you wrote:
> Add USB ID 3625:010b for TP-LINK Archer TX10UB Nano which is based on
> a Realtek RTL8851BU chip.
> 
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below:
> 
> T: Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 9 Spd=480 MxCh= 0
> D: Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs= 1
> P: Vendor=3625 ProdID=010b Rev= 0.00
> S: Manufacturer=Realtek
> S: Product=802.11ax WLAN Adapter
> S: SerialNumber=00e04c000001
> C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=500mA
> A: FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=01
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=81(I) Atr=03(Int.) MxPS= 16 Ivl=1ms
> E: Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E: Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=03(O) Atr=01(Isoc) MxPS= 0 Ivl=1ms
> E: Ad=83(I) Atr=01(Isoc) MxPS= 0 Ivl=1ms
> I: If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=03(O) Atr=01(Isoc) MxPS= 9 Ivl=1ms
> E: Ad=83(I) Atr=01(Isoc) MxPS= 9 Ivl=1ms
> I: If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=03(O) Atr=01(Isoc) MxPS= 17 Ivl=1ms
> E: Ad=83(I) Atr=01(Isoc) MxPS= 17 Ivl=1ms
> I: If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=03(O) Atr=01(Isoc) MxPS= 25 Ivl=1ms
> E: Ad=83(I) Atr=01(Isoc) MxPS= 25 Ivl=1ms
> I: If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=03(O) Atr=01(Isoc) MxPS= 33 Ivl=1ms
> E: Ad=83(I) Atr=01(Isoc) MxPS= 33 Ivl=1ms
> I: If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=03(O) Atr=01(Isoc) MxPS= 49 Ivl=1ms
> E: Ad=83(I) Atr=01(Isoc) MxPS= 49 Ivl=1ms
> I: If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=03(O) Atr=01(Isoc) MxPS= 63 Ivl=1ms
> E: Ad=83(I) Atr=01(Isoc) MxPS= 63 Ivl=1ms
> I:* If#= 2 Alt= 0 #EPs= 8 Cls=ff(vend.) Sub=ff Prot=ff Driver=rtl8851bu
> E: Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E: Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E: Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E: Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E: Ad=09(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E: Ad=0a(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E: Ad=0b(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E: Ad=0c(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add USB ID 3625:010b for TP-LINK Archer TX10UB Nano
    https://git.kernel.org/bluetooth/bluetooth-next/c/59d081048c15

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



