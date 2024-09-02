Return-Path: <stable+bounces-72686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBFE968223
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 10:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B95283844
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 08:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18CF1865EA;
	Mon,  2 Sep 2024 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jqnikrbl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC36185952;
	Mon,  2 Sep 2024 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266250; cv=none; b=efBdPi7yk+XUDKglYam6OUH/O10KVJKjwOBdvYRhS0yIAjbqgpX6fxSQxgDj2hy+35tAo+iQvcHiXvs+bZ9u/gUCrkGbDFL+Gy/k67VCXdwCpE6v0wwmAU/0PljyGIwSweCXHDgsBBe3AzbepXVAMkNQTtUA3RkIgXSfPGki13U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266250; c=relaxed/simple;
	bh=ny5p268ylb9XxqUvmpwKxgCwaNPtmNT6ZEP5TQPr+HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pG945K7GRzSg5YketTZl1/DC+3QFy74TzZuSG7cejAEiCk9dNHKRDxYefwYJ9RgrsjDZ6E38TbQtQew5RRLhIGDbC/19/OhL4auj0Bd86CW3XBoLNb37Y9ciW5NaWvK/4BaptD5tkEtYBaEqOVHC4kXBpHMz1tPD5huV0SI/JVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jqnikrbl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725266249; x=1756802249;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ny5p268ylb9XxqUvmpwKxgCwaNPtmNT6ZEP5TQPr+HY=;
  b=jqnikrbl3S2oM5D5x5Pv+MNHPyP7yNMmAKUrkI8b8KZ2mk35syqH3iUc
   0LMncLCzxo1uAxH0RZonf1IJzDu9fjKun+7Y4prt4eB010Ss2VGbvDehI
   OXO9sjMgjDEHpVORq3PldreNayIw2z3UsCoS0UKbH+n+lFiq7rr5ZcuLl
   NACWpNzT/voQQD1b6w9WPOogDlYMCAs+YGFO3ehQOqT3oRsy7LX8myuGh
   6PyC69XvXf5nniBZGEYYhPB57a0ywc6d67mEBAhgfmvg/LdG3haNefRyV
   7y1LkrB8HTP9mUmNE9zG6m6q8EXw9/ynDPpdn2xdlh2BqHdNOuGG/QNgK
   Q==;
X-CSE-ConnectionGUID: vOon06ULSJmjv2oYfBs1vw==
X-CSE-MsgGUID: x8QOkhdaSxmE6NziQ8XqBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="46348519"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="46348519"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 01:37:29 -0700
X-CSE-ConnectionGUID: 7nBHhvGDR3Gk9cAX654KhA==
X-CSE-MsgGUID: YHtUhXiQRa6eBeDSI1lcMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="95354839"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa001.fm.intel.com with ESMTP; 02 Sep 2024 01:37:25 -0700
Message-ID: <45435906-0a30-4546-a7e3-20f1f7d50713@linux.intel.com>
Date: Mon, 2 Sep 2024 11:39:30 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: xhci: fixes lost of data for xHCI Cadence
 Controllers
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>,
 pawell@cadence.com, peter.chen@kernel.org
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mathias.nyman@intel.com, stable@vger.kernel.org
References: <20240830174504.1282f7b4@foxbook>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20240830174504.1282f7b4@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30.8.2024 18.45, Michał Pecio wrote:
> Hi,
> 
>> Field Rsvd0 is reserved field, so patch should not have impact for
>> other xHCI controllers.
> Wait, is this a case of Linux failing to zero-initialize something that
> should be zero initialized before use (why not explain it as such?), or
> are you suggesting monkeying with internal xHC data at run time, in area
> which is known to actually be used by at least one implementation?
> 

Patch is monkeying with internal xHC RsvdO field.


> There is no mention of Rsvd0 in the xHCI spec, did you mean RsvdO?
> 
> Reserved and Opaque,
> For exclusive use by the xHC.
> Software shall *not* write this, unless allowed by the vendor.
> 
> Cadence isn't the only xHC vendor...
> 

Makes sense,  Pawel Laszczak, could you make this patch Cadence
specific.

Thanks
Mathias


