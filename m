Return-Path: <stable+bounces-23337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDB585FBC5
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 16:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C555B24830
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 15:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DBC14C584;
	Thu, 22 Feb 2024 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YENSmMmS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99AE14A092;
	Thu, 22 Feb 2024 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614138; cv=none; b=GYZANpNksr1XLx2hDB1r1u3AmUvAv5aYoB/08Yto67aaJGjSrIcAcM+HGxbE9PXu6+NUB0X1kUuyIiXAy6HZEIXaq+/BiTyoe9183JBLyRnUxf5/cz1nmCIL/rALQcERAaz6GlsNm4ElQLS6KyRxAyGJNTrzW92tsxhSyz0GNzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614138; c=relaxed/simple;
	bh=w5mnCeymnLIC/eznEyxIwcFYzutKK+SMgOy8M+ypElw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=S4rutqg/knF6tqvSjhsN5Nw2z9skWvAR3rWEjHBhnE0PXMT58cUM8+FByzPB4SukqQMaE/XSK2JCB3uPJiaDYDQ9acRVcqaq+bD27jb/2+liV3/6ld934JsZ3yf3p9syWgn28upCQkdG2KahULyhY3ozI4HOPybDMLvsBuwuXOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YENSmMmS; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708614136; x=1740150136;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=w5mnCeymnLIC/eznEyxIwcFYzutKK+SMgOy8M+ypElw=;
  b=YENSmMmSF1H0nqVq+73uJ/ya1Vr8FXaCLydLl1pmuqrqXXxe/+Jd/t6N
   lr477ZMn0ZTRS2qL07SK4Co9S7ujW8ESmbzws4bo+PtJhxmjbjS2ekC+O
   ninYGKBZecfyawVVjIYdpXu8OwR8W+q127Q4wC1f/XKkNhVpWnPf1I4b1
   rxUbNC2NIUBggWnyurUfdQYp5kVsPZn2FR0F/89o1uuW2OrAPvaItGpk+
   kla4xaRhftq/fPEES7f5/CjHEoJArdOTQPWNzVAiPeC1MSiUMqf/xUMti
   i6mQbfd5aPkbHNyXTlDgCEZQh6lK4iBPXf8drwMjYew8eKvC4VYuMr0Qv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2951061"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2951061"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 07:02:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="936859185"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="936859185"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2024 07:01:59 -0800
Message-ID: <2989954e-fe0c-c0de-7e72-345762492ebf@linux.intel.com>
Date: Thu, 22 Feb 2024 17:03:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
 Paul Menzel <pmenzel@molgen.mpg.de>, stable@vger.kernel.org
References: <20240222133819.4149388-1-mathias.nyman@linux.intel.com>
 <20240222133819.4149388-2-mathias.nyman@linux.intel.com>
 <2024022220-untried-routine-15e5@gregkh>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH 2/2] usb: port: Don't try to peer unused USB ports based
 on location
In-Reply-To: <2024022220-untried-routine-15e5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.2.2024 16.06, Greg KH wrote:
> On Thu, Feb 22, 2024 at 03:38:19PM +0200, Mathias Nyman wrote:
>> Unused USB ports may have bogus location data in ACPI PLD tables.
>> This causes port peering failures as these unused USB2 and USB3 ports
>> location may match.
>>
>> This is seen on DELL systems where all unused ports return zeroed
>> location data.
>>
>> Don't try to peer or match ports that have connect type set to
>> USB_PORT_NOT_USED.
>>
>> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> 
> What commit does this fix?  "all" of them?

Right, git blame shows the code this fixes was added 10 years ago in 3.16

Fixes: 3bfd659baec8 ("usb: find internal hub tier mismatch via acpi")
Cc: stable@vger.kernel.org # v3.16+

Thanks
Mathias

