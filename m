Return-Path: <stable+bounces-36034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FA48995AC
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 08:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D271C21156
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 06:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5F8219FC;
	Fri,  5 Apr 2024 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OYr+vmzN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A2A18659;
	Fri,  5 Apr 2024 06:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712299373; cv=none; b=uqWMeJJ0v8qOsbpK90OJc3h+2FeT29V8qonabf6Mne5t/Xj0f0TqBEEcgv882KF0uGm7CQ5QWwjwE25HOGWfb8reqQQD8yg3Q2ACbO2NZwF1Wbys3JUA+EcBPF5JzMm3BwqMz68J00MyW2wWQrJU0Z9ZYpyI4ETZd5HuPejyBss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712299373; c=relaxed/simple;
	bh=yqvRzGgJBEoPw84m3wibIRMoO901bjxYZLE2U2L0kkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nky6ik9+R85PGy/umNSUHHCJJ6fXr/MiJzFpVeue9aLWuDgGXDfFQiIJ3zVhvLL56KqM3CCG4EByjFRzEQU0ZXe038w3lNi02xbP2gOcQzyJSLCO1I1j1r5iYL36ef7UevQpIR3XrBiQevJ8wEDlJq7VchC2Fw3l1rK0sUEWrIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OYr+vmzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A43C433C7;
	Fri,  5 Apr 2024 06:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712299372;
	bh=yqvRzGgJBEoPw84m3wibIRMoO901bjxYZLE2U2L0kkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OYr+vmzNVqXaqcPNVGMFNFrMEJt80lkvX2Ld8wWVM3prY52XF4Z/NgsiEfE0gClDO
	 wsuXF2qbGz4QhwiAJ0K4NqiNrSlsFa7V4s67572GL5WWxmtuV9TvnSnjLz3Oveop09
	 zqtZmD4BaDeRTZdvaxkuy3SeaH2eWwrWNs4QA+HM=
Date: Fri, 5 Apr 2024 08:42:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Peter Collingbourne <pcc@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	stable@vger.kernel.org, VAMSHI GAJJELA <vamshigajjela@google.com>
Subject: Re: [PATCH] serial: 8250_dw: Revert: Do not reclock if already at
 correct rate
Message-ID: <2024040500-snowbound-cadet-bba2@gregkh>
References: <20240317214123.34482-1-hdegoede@redhat.com>
 <ZfgZEcg2RXSz08Gd@smile.fi.intel.com>
 <CAMn1gO4zPpwVDcv5FFiimG0MkGdni_0QRMoJH9SSA3LJAk7JqQ@mail.gmail.com>
 <35cdaf7e-ef32-470f-ab61-e5f4a3b35238@redhat.com>
 <33110d20-45d6-45b9-8af0-d3eac8c348b8@redhat.com>
 <CAMn1gO5-WD5wyPt+ZKDL-sRKhZvz1sUSPP-Mq59Do5kySpm=Sg@mail.gmail.com>
 <8cbe0f5f-0672-4bca-b539-8bff254c7c97@redhat.com>
 <2024032922-stipulate-skeleton-6f9c@gregkh>
 <1d7c3e03-fb25-4891-87bb-f4e7b8b4ee30@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d7c3e03-fb25-4891-87bb-f4e7b8b4ee30@leemhuis.info>

On Fri, Apr 05, 2024 at 08:14:03AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 29.03.24 13:12, Greg Kroah-Hartman wrote:
> > On Fri, Mar 29, 2024 at 12:42:14PM +0100, Hans de Goede wrote:
> >> On 3/29/24 3:35 AM, Peter Collingbourne wrote:
> >>> On Thu, Mar 28, 2024 at 5:35 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >>>> On 3/28/24 8:10 AM, Hans de Goede wrote:
> >>>>> On 3/18/24 7:52 PM, Peter Collingbourne wrote:
> >>>>>> On Mon, Mar 18, 2024 at 3:36 AM Andy Shevchenko
> >>>>>> <andriy.shevchenko@linux.intel.com> wrote:
> >>>>>>>
> >>>>>>> On Sun, Mar 17, 2024 at 10:41:23PM +0100, Hans de Goede wrote:
> >>>>>>>> Commit e5d6bd25f93d ("serial: 8250_dw: Do not reclock if already at
> >>>>>>>> correct rate") breaks the dw UARTs on Intel Bay Trail (BYT) and
> >>>>>>>> Cherry Trail (CHT) SoCs.
> >>>>>>>>
> >>>>>>>> Before this change the RTL8732BS Bluetooth HCI which is found
> >>>>>>>> connected over the dw UART on both BYT and CHT boards works properly:
> >>>>>>>>
> >>>>>>>> Bluetooth: hci0: RTL: examining hci_ver=06 hci_rev=000b lmp_ver=06 lmp_subver=8723
> >>>>>>>> Bluetooth: hci0: RTL: rom_version status=0 version=1
> >>>>>>>> Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_fw.bin
> >>>>>>>> Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_config-OBDA8723.bin
> >>>>>>>> Bluetooth: hci0: RTL: cfg_sz 64, total sz 24508
> >>>>>>>> Bluetooth: hci0: RTL: fw version 0x365d462e
> >>>>>>>>
> >>>>>>>> where as after this change probing it fails:
> > [...]
> >>> Acked-by: Peter Collingbourne <pcc@google.com>
> >>
> >> Thanks. Greg can we get this merged please
> >> (it is a regression fix for a 6.8 regression) ?
> > 
> > Will queue it up soon, thanks.
> 
> You are obviously busy (we really need to enhance Git so it can clone
> humans, too!), nevertheless: friendly reminder that that fix afaics
> still is not queued.

"soon" is relative :)

> Side note: there is another fix for a serial 6.8 regression I track
> waiting for review here:
> https://lore.kernel.org/linux-serial/20240325071649.27040-1-tony@atomide.com/

It's in my queue, I'll try to get to serial stuff later today, but not
promising anything...

thanks,

greg k-h

