Return-Path: <stable+bounces-28350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A5687E767
	for <lists+stable@lfdr.de>; Mon, 18 Mar 2024 11:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086771C20E77
	for <lists+stable@lfdr.de>; Mon, 18 Mar 2024 10:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1B11E51E;
	Mon, 18 Mar 2024 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VN1k1wLX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9B62E82E;
	Mon, 18 Mar 2024 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710758169; cv=none; b=OOI2sQk1Bb9GLUT36lzi6/HzpNBKEBvEkyseazawC0/dd9+PAw2luBnyOJ6aT+HOmMwZ67weBdPZpuhaTw9tcy5ihWUcgomgKjUfBy46KUuVsSCABQOVXiknqMqxD+bai4rGndUPL/oTMn6HzjOxCNPEqi+ZllQopExNTvPO8Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710758169; c=relaxed/simple;
	bh=VjXC9bz5wKKAjRXX5ZoO8H4YYpS4TF2rETKeRQjxWr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rr5X+rrOhiJoDEqhowzO2qO2bYM7kfq3PTyOSjKz9sAAUfD1HJP/JeaSU72gduVHU5hI1BdLY2xDYH0nuaBhaaOBK6tWCYp4zRxPtlSklq3t41G5kZgxUvfTqk3Z/rMlFED9hFTELPJNiS7I8xsmgoNBDu3BsJHEEUZ3KYemWVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VN1k1wLX; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710758167; x=1742294167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VjXC9bz5wKKAjRXX5ZoO8H4YYpS4TF2rETKeRQjxWr0=;
  b=VN1k1wLXyYBgH2tDdMyWoIkzYjXoQZ89oaWWbyPxICCdA9Itzd4A+B0Z
   8WKnr1+cl48SYwrlhX3QdbnLhMBP36XKfCzj3BdG+d7dp2gF45uNX4rDH
   VIwvFINrNRBDBpLk0rb0j5rGNbjjEu0e7xvol15to9N0Tod9Mmw633iKy
   cSMWsBekUalf1i+LKGUpaZj1qgjk9yYw5XatSDSjXwxz/+GXFYPUcAj1f
   6o9LpsHTwD0jjmNYDzmd+xO//WnE8mY6cCRgSfLA5789roJyr4F1botfZ
   T7AWdJA1uOQSxquyN//RmA+JvZqHtnA1xCyO2vy5LMlHsIY5F/YEdfZQX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="17009773"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="17009773"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 03:36:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="914588077"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="914588077"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 03:36:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rmALZ-0000000DumO-3CGQ;
	Mon, 18 Mar 2024 12:36:01 +0200
Date: Mon, 18 Mar 2024 12:36:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	stable@vger.kernel.org, Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH] serial: 8250_dw: Revert: Do not reclock if already at
 correct rate
Message-ID: <ZfgZEcg2RXSz08Gd@smile.fi.intel.com>
References: <20240317214123.34482-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240317214123.34482-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Mar 17, 2024 at 10:41:23PM +0100, Hans de Goede wrote:
> Commit e5d6bd25f93d ("serial: 8250_dw: Do not reclock if already at
> correct rate") breaks the dw UARTs on Intel Bay Trail (BYT) and
> Cherry Trail (CHT) SoCs.
> 
> Before this change the RTL8732BS Bluetooth HCI which is found
> connected over the dw UART on both BYT and CHT boards works properly:
> 
> Bluetooth: hci0: RTL: examining hci_ver=06 hci_rev=000b lmp_ver=06 lmp_subver=8723
> Bluetooth: hci0: RTL: rom_version status=0 version=1
> Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_fw.bin
> Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_config-OBDA8723.bin
> Bluetooth: hci0: RTL: cfg_sz 64, total sz 24508
> Bluetooth: hci0: RTL: fw version 0x365d462e
> 
> where as after this change probing it fails:
> 
> Bluetooth: hci0: RTL: examining hci_ver=06 hci_rev=000b lmp_ver=06 lmp_subver=8723
> Bluetooth: hci0: RTL: rom_version status=0 version=1
> Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_fw.bin
> Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_config-OBDA8723.bin
> Bluetooth: hci0: RTL: cfg_sz 64, total sz 24508
> Bluetooth: hci0: command 0xfc20 tx timeout
> Bluetooth: hci0: RTL: download fw command failed (-110)
> 
> Revert the changes to fix this regression.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Note it is not entirely clear to me why this commit is causing
> this issue. Maybe probe() needs to explicitly set the clk rate
> which it just got (that feels like a clk driver issue) or maybe
> the issue is that unless setup before hand by firmware /
> the bootloader serial8250_update_uartclk() needs to be called
> at least once to setup things ?  Note that probe() does not call
> serial8250_update_uartclk(), this is only called from the
> dw8250_clk_notifier_cb()
> 
> This requires more debugging which is why I'm proposing
> a straight revert to fix the regression ASAP and then this
> can be investigated further.

Yep. When I reviewed the original submission I was got puzzled with
the CLK APIs. Now I might remember that ->set_rate() can't be called
on prepared/enabled clocks and it's possible the same limitation
is applied to ->round_rate().

I also tried to find documentation about the requirements for those
APIs, but failed (maybe was not pursuing enough, dunno). If you happen
to know the one, can you point on it?

-- 
With Best Regards,
Andy Shevchenko



