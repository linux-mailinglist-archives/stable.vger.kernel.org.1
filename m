Return-Path: <stable+bounces-89787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A209BC571
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 07:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873121F2180B
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 06:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD0A1DB54C;
	Tue,  5 Nov 2024 06:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/PN8GDK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1B12A1A4;
	Tue,  5 Nov 2024 06:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730788283; cv=none; b=TaxpzF8Ap/eVzvWnZga8r9c1uGvjOhf/oS9sZpj9OhnkueqG+9t80zP0dlnjhxGz9uHUuloTBs0xxuSHhEeAhAJ0yOG3vq8olFro+f4/jnZH7mP43kbR/RTXIDidYCZ2VkopM0+4CkHiceKXf+dXoH+efz9Aj2Nv2F5/KHgcSGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730788283; c=relaxed/simple;
	bh=lZHQ6oeCo+3J52PhOs3n6tSzunx3c7YQEzTKcxRQXS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlY/vfqJp+0BXwqnYBuu/rpTgQev0Y82vtff3mkm5u37Y/RuN3XfXb/AyN2lk9XdNP/jx6vEONupo0vSEQ7oYxUVV/laXqBFsoX1+6kwojkLoZo0oXiVbeqkty3xC+1myTvyBcjl93b/D+E7zlwwkCy9N8emSMeDAticDXwe5Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/PN8GDK; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730788282; x=1762324282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lZHQ6oeCo+3J52PhOs3n6tSzunx3c7YQEzTKcxRQXS8=;
  b=Y/PN8GDKyZbn0mSk1ioOL5o90F817hl6mFBYc8sQp3WWSroxqehH+Z3M
   6QU+HmyL1DYE+pZdBqebo+7Fb4CZMBkD0avjXnYgnXMS1FD65mQB+6VlV
   wHY7oc65T9OBcxOnrkGFevRD+B1jygwrlKHfkgF9SnCSQom31d5sN3awC
   RnPNlF2q/6EEl+XuUjFN0ZoVLjZQiBC1B/v45957PfskE0gWtsiurCUJH
   0OHa0Lbps49fGW/E8FdsAQyTcpzQx74YoZfa2oLU258qMY1m9FkEo5Mum
   6+kux6I1UGIXVv70WhfbA8OSMo4ZrVwn0zLeFsRm8ru2DAfgNckpQw+hO
   w==;
X-CSE-ConnectionGUID: W76ydK7XTzWs2uJIp73KdA==
X-CSE-MsgGUID: lc8a/mdaQJShq2UwjJcgNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="34299444"
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="34299444"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 22:31:22 -0800
X-CSE-ConnectionGUID: aYmojHcwTECNv1lRRqwsOQ==
X-CSE-MsgGUID: myFw6ZjFQImLl09u5VEoGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="83414035"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 04 Nov 2024 22:31:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 473CB1E0; Tue, 05 Nov 2024 08:31:18 +0200 (EET)
Date: Tue, 5 Nov 2024 08:31:18 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Rick <rick@581238.xyz>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Sanath.S@amd.com,
	christian@heusel.eu, fabian@fstab.de, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: Dell WD19TB Thunderbolt Dock not working with kernel > 6.6.28-1
Message-ID: <20241105063118.GE275077@black.fi.intel.com>
References: <20241022161055.GE275077@black.fi.intel.com>
 <7f14476b-8084-4c43-81ec-e31ae3f7a3c6@581238.xyz>
 <20241023061001.GF275077@black.fi.intel.com>
 <4848c9fe-877f-4d73-84d6-e2249bb49840@581238.xyz>
 <20241028081813.GN275077@black.fi.intel.com>
 <2c27683e-aca8-48d0-9c63-f0771c6a7107@581238.xyz>
 <20241030090625.GS275077@black.fi.intel.com>
 <70d8b6b2-04b4-48a6-964d-a957b2766617@581238.xyz>
 <20241104063656.GZ275077@black.fi.intel.com>
 <effdfd51-66dd-44a4-968c-0f762ab8f93b@581238.xyz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <effdfd51-66dd-44a4-968c-0f762ab8f93b@581238.xyz>

Hi Rick,

On Mon, Nov 04, 2024 at 07:04:08PM +0100, Rick wrote:
> Hi Mika
> 
> On 04-11-2024 07:36, Mika Westerberg wrote:
> > Hi Rick,
> > 
> > On Fri, Nov 01, 2024 at 01:57:50PM +0100, Rick wrote:
> > > I compiled 6.12.0-rc5-00181-g6c52d4da1c74-dirty resulting in docking station
> > > not working.
> > > 
> > > Then I compiled 6.12.0-rc5-00181-g6c52d4da1c74-dirty without commit
> > > c6ca1ac9f472 (reverted), and now the docking station works correctly (as in
> > > screen output + USBs + Ethernet)
> > > 
> > > So it seems c6ca1ac9f472 is causing issues for my setup.
> > 
> > Okay, thanks for testing!
> > 
> > It indeed looks like there is no any kind of link issues anymore with
> > that one reverted. So my suspect is that we are taking too long before
> > we enumerate the device router which makes it to reset the link.
> > 
> > Can you try the below patch too on top of v6.12-rcX (without the revert)
> > and see if that still keeps it working? This one cuts down the delay to
> > 1ms which I'm hoping is sufficient for the device. Can you share
> > dmesg+trace from that test as well?
> > 
> > diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
> > index c6dcc23e8c16..1b740d7fc7da 100644
> > --- a/drivers/thunderbolt/usb4.c
> > +++ b/drivers/thunderbolt/usb4.c
> > @@ -48,7 +48,7 @@ enum usb4_ba_index {
> >   /* Delays in us used with usb4_port_wait_for_bit() */
> >   #define USB4_PORT_DELAY			50
> > -#define USB4_PORT_SB_DELAY		5000
> > +#define USB4_PORT_SB_DELAY		1000
> >   static int usb4_native_switch_op(struct tb_switch *sw, u16 opcode,
> >   				 u32 *metadata, u8 *status,
> 
> See below pasts without the revert, and with the above provided patch.
> 
> dmesg with patch (and without the revert):
> https://gist.github.com/ricklahaye/8412af228063546dd8375ca796fffeef
> tbtrace with patch (and without the revert):
> https://gist.github.com/ricklahaye/4b9cbeeb36b546c6686ce79a044a2d61
> 
> Seems to be working correctly with the provided patch.
> Thank you!

Thanks for testing! Yes, logs look good now.

I will submit this fix upstream today then. Do you mind providing me your
full name and email so that I can add tag like

Reported-by: Rick ...

in the commit message?

