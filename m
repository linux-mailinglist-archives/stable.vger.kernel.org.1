Return-Path: <stable+bounces-95952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3979DFD88
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 10:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77DB81627D3
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 09:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F20381AA;
	Mon,  2 Dec 2024 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OiC2QbVN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6261F9EB9
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132806; cv=none; b=tvtQjpDg+XZuK4ORkKeM2xTqJPHNAByGBeGI19E4TjbMa/RiCoTak30+SGryQM0uWrxgMZiG/ldNJ34s6sUxitX/BlVVqNvxCrcRtwBdWq1pfHHifZucx9I9ENnX3s5OpHf79VqF/XWnENexfTZPgu/p6jucmnX+NqyaqeQDAIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132806; c=relaxed/simple;
	bh=s9lPN4pkXnhj3Wrf0AOiwioncdJn0agIeGcSHoFsoYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQQIGlnslCvGRcPuQj4z3HPVbWqblb5gKkSjJNqJfHLuTXv5SwegMq2d2OUPlzToRRjitc7fQYdxL5vUXrZEUUeF67otBbk5sI+oib1/WnTXsJNLuwNf7QMtxdSfAsau9pQojGwqFOYMpzjDLhikbKug1Prh0MDtQiwUbgcqS3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OiC2QbVN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733132805; x=1764668805;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s9lPN4pkXnhj3Wrf0AOiwioncdJn0agIeGcSHoFsoYY=;
  b=OiC2QbVNFTMgcjRuNwpmHlxc11ZjDGJkK27sUFrqtq55Zx0cScfpXx4V
   4/s8Wi0AQDTA93KUbWrRDn9n0pSqab6GB0iwns9zXueuDQ3EeWwynnq60
   crBjSdMlQIMT0yCl44Lz1F0BXlGBTXngnn3XG//MHNjWZoqOKiz5mymmJ
   nGepOW5DLvJDJe8Qp/iSwBlJdaow81hKYyi8Y6IWmFVeOeeCU2pXc+tED
   YByR5+Fbs7qIOMJZSbzA5mgBcknBBBgYSS17/ACerBkj8FHKYmb1nwK/0
   1ucdbqaZ+wrCOFGl+Tbkw6M0hqpQtJcNPYh3Mls37d+p6HfxOp8ldSs9g
   g==;
X-CSE-ConnectionGUID: OQf0M3J1SeiYvNwjF3b4uA==
X-CSE-MsgGUID: 7r4u06vlT02SwGFXwK6ObQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11273"; a="44670289"
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="44670289"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 01:46:44 -0800
X-CSE-ConnectionGUID: sEBl+ielTi6tCPGxieBELw==
X-CSE-MsgGUID: QVaUcmteRT+CUM9h+AkDCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="123910279"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa002.jf.intel.com with ESMTP; 02 Dec 2024 01:46:43 -0800
Message-ID: <d2db04ca-3323-4684-a4c9-a4e85b9461e9@linux.intel.com>
Date: Mon, 2 Dec 2024 11:49:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xhci: dbc: Fix STALL transfer event handling
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, hadrosaur@google.com,
 =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
References: <20241122154146.3694205-1-mathias.nyman@linux.intel.com>
 <2024120238-comma-freely-23ab@gregkh>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <2024120238-comma-freely-23ab@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2.12.2024 11.13, Greg KH wrote:
> On Fri, Nov 22, 2024 at 05:41:46PM +0200, Mathias Nyman wrote:
>> commit 9044ad57b60b0556d42b6f8aa218a68865e810a4 upstream
>> Backport targeted specifically for linux-6.6.y stable kernel.
>> Resolve minor conflict due to 10-patch dbc cleanup series in 6.8
> 
> Breaks the build :(
> 

Sorry about that, turns out I had removed DbC from kernel config in my stable repo.

I'll send an updated version

Thanks
Mathias

