Return-Path: <stable+bounces-195394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF70C75F9C
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 59A8534C9C5
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 18:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AED23F40C;
	Thu, 20 Nov 2025 18:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLpIh82A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6A41DA62E;
	Thu, 20 Nov 2025 18:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763664642; cv=none; b=mYWtEB0gyHOH3ADKjfniiNspMgSXF9R14Icr3gRyD/bemLvD5z3SlMJGBWNX+zlEKNaKoqKU/akDHnmeH0pbKhDPoku9yYcQVoYZM5Dnncn9lMfi18JrcgozjaAvQBYhEs4aaw9UbmUPLMDCbMiGE2VJEITiXCMxpnFaJMCduA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763664642; c=relaxed/simple;
	bh=YWC2QaLQIZnbvvKPn+rk+SMxZpvA1t+FyR0kuqU02KA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LJQC4WpwSBPOe3gnaeg79/AhGnbKMRRN/Z8nrHzhc8gx9XMn+fGRd0GoI4eUgs8KB5oj8Ck4jolxkwVFfs24f4VgQ4Z94IpAg65712DcH0YDRHuVplr8JGptpfHNxnV8Z+x3wmEPW/VQNQjFeiRyGq1KzBErd8dOSiNQHVuja2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLpIh82A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF406C116C6;
	Thu, 20 Nov 2025 18:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763664641;
	bh=YWC2QaLQIZnbvvKPn+rk+SMxZpvA1t+FyR0kuqU02KA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lLpIh82ApTKkcPa5DAFGjUR3FHxD+gzl/2/tjY9sFKwRGaXOhouiGSEOwvENQ6ddO
	 BC6shW7HOkL81jFMqBcTkEfUEmi36F0Lwmd1kYc8hpvbPI49PtqhIkZkVTRjtL40jR
	 VsR8eYHqfWeWZb6B5Lzhq+BtrM+gY6Z7nn+1tt2RjsKm0p6KDOK5U6mVH1wfz8J6qv
	 69Lva35wffUJrAcoQJEkFRdKyDnJnepkJlYhYjsK4lX33lFHbK/EY3gr3KNals1s6J
	 2f2GK06S56j108BVMotqoybEYjmoXradFsnthBCeiBWjEN0oj7uwfY7wXMT6D8IJ6V
	 kiT3dQrEiPi3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F663A40FE6;
	Thu, 20 Nov 2025 18:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: btusb: mediatek: Avoid
 btusb_mtk_claim_iso_intf() NULL deref
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176366460701.1748676.511972373877694762.git-patchwork-notify@kernel.org>
Date: Thu, 20 Nov 2025 18:50:07 +0000
References: 
 <20251120081227.v3.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid>
In-Reply-To: 
 <20251120081227.v3.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid>
To: Doug Anderson <dianders@chromium.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, regressions@leemhuis.info,
 regressions@lists.linux.dev, incogcyberpunk@proton.me,
 johan.hedberg@gmail.com, sean.wang@mediatek.com, stable@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 20 Nov 2025 08:12:28 -0800 you wrote:
> In btusb_mtk_setup(), we set `btmtk_data->isopkt_intf` to:
>   usb_ifnum_to_if(data->udev, MTK_ISO_IFNUM)
> 
> That function can return NULL in some cases. Even when it returns
> NULL, though, we still go on to call btusb_mtk_claim_iso_intf().
> 
> As of commit e9087e828827 ("Bluetooth: btusb: mediatek: Add locks for
> usb_driver_claim_interface()"), calling btusb_mtk_claim_iso_intf()
> when `btmtk_data->isopkt_intf` is NULL will cause a crash because
> we'll end up passing a bad pointer to device_lock(). Prior to that
> commit we'd pass the NULL pointer directly to
> usb_driver_claim_interface() which would detect it and return an
> error, which was handled.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: btusb: mediatek: Avoid btusb_mtk_claim_iso_intf() NULL deref
    https://git.kernel.org/bluetooth/bluetooth-next/c/dd6dda907d09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



