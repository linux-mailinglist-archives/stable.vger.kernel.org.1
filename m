Return-Path: <stable+bounces-118635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 406EFA3FFB2
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 20:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A30E422AB2
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 19:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843832512F9;
	Fri, 21 Feb 2025 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="Vn8IODOe"
X-Original-To: stable@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBFE5223;
	Fri, 21 Feb 2025 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740166025; cv=none; b=AaPqYiRbaHK64uohH9NJYdC/TwXDofnkv6br5MpPkINAEzc/gXRnzjsE5L4tzrvMdig3uNoFr9fwgY0ftj3lu4tWHQfZzRsG/UW/iYk5xAm63FkWvv8azaGt7zwjybrMItWf6a3QuJCIEb472vKaG1XjwFrwEcwrj2EicybKbxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740166025; c=relaxed/simple;
	bh=ILuXRvq5uVQ5UBKoNazzH/vYwsdIKolCtj6DVuv2DsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9uLN7Gr/qUTR4qptdmYguswKe+KcCc9sxSqpT9NKsmWAUquXq61o1dqcAZVgAoHZNAkYvv0cq8yxk49ulIYJk4eayRoOsa7IiNAW97k76jdLq725pgOazdt7r278mUpTB2iSJgUpWGeq07gVTMmPIXL9+m5n0Vz653X1VZuQNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=Vn8IODOe; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1740166012; bh=ILuXRvq5uVQ5UBKoNazzH/vYwsdIKolCtj6DVuv2DsU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vn8IODOeRzPVuDRBHqP7FOIdRt2Q1U4x+ZdgNDP/Uri1oFGqztfuykzMXPc8bqons
	 2mHysco6hPF6y87701zaWbmxer4WhRBexO4RUxG3X1ftdEfslMsE0cz9XwGY8yOz16
	 m92V/ZstUP9qzWGiLIobKfzR9/AKJTL/H34ZkgVqWC9tvWALOS7wQNVMnB1WuJovCV
	 iZgpj0Pcq1pi/6ix47PBe4sw/jAi6yMyC9vTYLheDrNt5iTwO6z8jUlgZ4KTz92pJg
	 H13+uCqFwEVXV39nzpqpZd29O6hHbKY3YdR5E8w45pKwh/IY8/FidA8W0eZP/wjGW6
	 E2hVySaZcKHahbEDqSot/uopfJy9GkhZ3urqcHnoBNHTiWzGnYcn3mSnFYx6qfRmOG
	 cgm9rWdd/1qyxYq1QndSR9giuXufXXl7KnhA6JL+T41q6w9QFbgtrk9S/Gwk+hsTTu
	 4uptWD5jaWWS/l/ytmQx29kvxVnU0VtFqs/ux+OKlCQangpHtbUVfWkS22oJzBrXmi
	 LK2IFRaHMOrWPbxcRYcxXsDoJuOsboj9ve0MK1y/awb9rOlBuZnCiwsm4ffZuXNL0/
	 nRXSqg1L/8IYJ/Oo8i5jY9/z8C47iaUqMJNQnyBjoRr88wJgfSu8JaqlbOOAkKMLK6
	 12S2A+KEbgRThFF5PiLHjoUo=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 2EEBB1601E1;
	Fri, 21 Feb 2025 20:26:52 +0100 (CET)
Message-ID: <a882365c-148c-410a-ac67-b7a17dafc501@ijzerbout.nl>
Date: Fri, 21 Feb 2025 20:26:49 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: gadget: Set self-powered based on MaxPower and
 bmAttributes
To: Prashanth K <prashanth.k@oss.qualcomm.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Sabyrzhan Tasbolatov <snovitoll@gmail.com>
References: <20250217120328.2446639-1-prashanth.k@oss.qualcomm.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20250217120328.2446639-1-prashanth.k@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 17-02-2025 om 13:03 schreef Prashanth K:
> Currently the USB gadget will be set as bus-powered based solely
> on whether its bMaxPower is greater than 100mA, but this may miss
> devices that may legitimately draw less than 100mA but still want
> to report as bus-powered. Similarly during suspend & resume, USB
> gadget is incorrectly marked as bus/self powered without checking
> the bmAttributes field. Fix these by configuring the USB gadget
> as self or bus powered based on bmAttributes, and explicitly set
> it as bus-powered if it draws more than 100mA.
>
> Cc: stable@vger.kernel.org
> Fixes: 5e5caf4fa8d3 ("usb: gadget: composite: Inform controller driver of self-powered")
> Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
> ---
> Changes in v2:
> - Didn't change anything from RFC.
> - Link to RFC: https://lore.kernel.org/all/20250204105908.2255686-1-prashanth.k@oss.qualcomm.com/
>
>   drivers/usb/gadget/composite.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> index bdda8c74602d..1fb28bbf6c45 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -1050,10 +1050,11 @@ static int set_config(struct usb_composite_dev *cdev,
>   	else
>   		usb_gadget_set_remote_wakeup(gadget, 0);
>   done:
> -	if (power <= USB_SELF_POWER_VBUS_MAX_DRAW)
> -		usb_gadget_set_selfpowered(gadget);
> -	else
> +	if (power > USB_SELF_POWER_VBUS_MAX_DRAW ||
> +	    !(c->bmAttributes & USB_CONFIG_ATT_SELFPOWER))
Please check this change again. From line 983-884 there is a `goto done`.
in case `c` is NULL. So, there will be a potential NULL pointer dereference
with your change.
>   		usb_gadget_clear_selfpowered(gadget);
> +	else
> +		usb_gadget_set_selfpowered(gadget);
>   
>   	usb_gadget_vbus_draw(gadget, power);
>   	if (result >= 0 && cdev->delayed_status)
> [...]


