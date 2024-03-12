Return-Path: <stable+bounces-27430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA21C878FF9
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 09:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CB19B21180
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 08:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4FF6997B;
	Tue, 12 Mar 2024 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zf5RqzBC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6AD77F00;
	Tue, 12 Mar 2024 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710233437; cv=none; b=OxrJymGGuPA4aK4BDxsY2+Hl0tM0vJYZ5ZbB81K+lXmP4z6RU2y2CKbQgvFvY7YscGAZ11Zu8yfEaFZRdoyIJhD0P2RZD3UXXZQ2ZWN/3zz9Agk4x8zHgJ1l9egGfO3Yqy1kJcaBnLMzrZ6TLyUZpgxwHCw4/bBCt34YB5x7vwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710233437; c=relaxed/simple;
	bh=GdeE6lcRivj60/3NRRKImzQ+ghFrr2mA897OtI5eU9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Er+u12BdHVyrjwxp3W3kzcoTrMX/r/R+3kTn8xyextsc3LZ57cGshfOAWFjE1xh5rlVjmvSmxufOx0aSFMY0GFUP3R7GrSzwuUBbdpahHt+slzMOKc4Nvg7VAs1W3b8pim2zv/4d+Yj6lHW0a+Jr6CzLXrlzAOL2Vk8rL9npkF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zf5RqzBC; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710233436; x=1741769436;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GdeE6lcRivj60/3NRRKImzQ+ghFrr2mA897OtI5eU9w=;
  b=Zf5RqzBCKcy/Xr9MkxaM/FfSJPuU5uhTt8mTt7Gn3ox9s6ho/1F6QGIQ
   hCFj9gPDmyPbSuaTabO79CDDeSAB+iWWk6hLV9NXnguahfidKCOqWR5n0
   m1g4482qNb1TdIR2SC4rXr/ZjEbetycAfFxm/IENyfRD1d3D5JxJcTZl3
   PYnEJeZP/fjwFFW9HAwqdv4/qBCV7Kfx7/wayWR50Tk2I8rZT33w0VDZR
   1JKoCwVmEZo1D6SpLkDrvxMnswrM7d3LjxktMaWN4GI767QJphCFdULEG
   YCg9oj7jqxksSVyNCLchP5MMVTNx7NnnwHeAtU1ROt8v3/bAOzZMX1X3W
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4783671"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="4783671"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 01:50:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="937051422"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="937051422"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 12 Mar 2024 01:50:21 -0700
Message-ID: <b1a5498d-09a8-b979-7ae7-0820ed4297fe@linux.intel.com>
Date: Tue, 12 Mar 2024 10:52:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: 6.5.0 broke XHCI URB submissions for count >512
Content-Language: en-US
To: Chris Yokum <linux-usb@mail.totalphase.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 stable <stable@vger.kernel.org>, linux-usb <linux-usb@vger.kernel.org>,
 Niklas Neronin <niklas.neronin@linux.intel.com>
References: <949223224.833962.1709339266739.JavaMail.zimbra@totalphase.com>
 <50f3ca53-40e3-41f2-8f7a-7ad07c681eea@leemhuis.info>
 <2024030246-wife-detoxify-08c0@gregkh>
 <278587422.841245.1709394906640.JavaMail.zimbra@totalphase.com>
 <a6a04009-c3fe-e50d-d792-d075a14ff825@linux.intel.com>
 <3a560c60-ffa2-a511-98d3-d29ef807b213@linux.intel.com>
 <717413307.861315.1709596258844.JavaMail.zimbra@totalphase.com>
 <1525093096.37868.1710176587331.JavaMail.zimbra@totalphase.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <1525093096.37868.1710176587331.JavaMail.zimbra@totalphase.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.3.2024 19.03, Chris Yokum wrote:
> Hello Mathias,
> 
> Thanks for the help with this! We saw that it's made it into 6.8. Is it possible to get this into 6.6 and 6.7?
> 

Patch is tagged for stable 6.5+.
If all goes well it should end up in 6.5 and later stable kernels

https://lore.kernel.org/all/20240305132312.955171-2-mathias.nyman@linux.intel.com/

Thanks
Mathias



