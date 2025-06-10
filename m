Return-Path: <stable+bounces-152271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D49AD33DD
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 12:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 769AD7A5ADA
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 10:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F22528CF43;
	Tue, 10 Jun 2025 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IV0umCMb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD24280021;
	Tue, 10 Jun 2025 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749552226; cv=none; b=jRngHN9ch7mTnGVZMNxOsVyoYovG1G8ugWnixR7wC98se+YJWPzIAsQFdZra75YIrW9M7ov842812Jy9oga9hmJuNhuZc0M5+rlo6fxN1dQT8RVyPa0lSYwEdJqhnGUeTxtq8FyNvQczstsZgTgKj9PMNsfW7gBsa58vTW2VubI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749552226; c=relaxed/simple;
	bh=A7R2GZyqD4651NDlEsKavR7BsMMFDmWIlAxeRoLf964=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhHUwsBy2jguIHiJmeYKQ7Crk53o8X9sTYJEaHZaGL2CxTZacZorfMwCEgCF7scqhV/g5tCiJW3Wz+YldV6scMdybt/Ibfr2nQA5AdJ+uMjiGrnU6G8tEH266TKrbLdzb799OLH7xXjhu/lUm14p9naOpJ9R1madlYBTSu1XtM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IV0umCMb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749552225; x=1781088225;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A7R2GZyqD4651NDlEsKavR7BsMMFDmWIlAxeRoLf964=;
  b=IV0umCMbWbS8Is7D4XjkpmwhN6XqDos9H+7NNlCUnRRkGdclXmWR2SCr
   zSSlA1bdfsjXjeaYPN11N0b3pYazrO9eQ9vnr5kqWiAX1apcL8dRSbF/9
   FDz7qIJtzjDPg5hK77NkUiGFppQr52EAi7jTYfr2b+OUDvVtJ+mhmaBig
   /Q6gtZebb7hLMIYs0ih4Rrc5tToeGaqJbwQWU/hbClLlZIdpgM8eAWw0m
   mLgYjbxydaUpbXNdKlhEnG/0Lzdq8hg7Oruvtqcm4naylqyvb2/aa+d1b
   uP/LQVjlf+d02c6VdGR/GcxmlL8kthq1X1liT0Mmk0ZsbLu1iWR3ZD2Tg
   A==;
X-CSE-ConnectionGUID: c6EhfwkMQn+P3V8IQaa1tw==
X-CSE-MsgGUID: VY00Mt3nToSj2j8fBWD2wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51534181"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="51534181"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 03:43:45 -0700
X-CSE-ConnectionGUID: PIJVXdHNR7uwrC+aJeXHYA==
X-CSE-MsgGUID: 0XYP3sdBT8WOCNQYhg6Cnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="147303800"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa010.fm.intel.com with ESMTP; 10 Jun 2025 03:43:42 -0700
Message-ID: <f77df7da-c068-499f-8f55-bcb095b8fc4a@linux.intel.com>
Date: Tue, 10 Jun 2025 13:43:41 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: hub: fix detection of high tier USB3 devices behind
 suspended hubs
To: Oliver Neukum <oneukum@suse.com>, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
 stable@vger.kernel.org
References: <20250609122047.1945539-1-mathias.nyman@linux.intel.com>
 <66b3847a-a3b8-43fa-b448-570f60b775be@suse.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <66b3847a-a3b8-43fa-b448-570f60b775be@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.6.2025 12.34, Oliver Neukum wrote:
> On 09.06.25 14:20, Mathias Nyman wrote:
> 
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 596d789a211d ("USB: set hub's default autosuspend delay as 0")
> 
> Is that the correct breaker commit? It seems to me that it marks
> only the commit which turned the problem into the default. It
> was always possible.

True, user could trigger the issue by manually setting autosuspend delay to 0
before that patch,

Maybe a better Fixes commit would be:
2839f5bcfcfc ("USB: Turn on auto-suspend for USB 3.0 hubs.")

Both are from 2012 so not sure it really matters anymore
  
("USB: Turn on auto-suspend for USB 3.0 hubs.") was added to v3.4 kernel
("USB: set hub's default autosuspend delay as 0") was added to v3.8 kernel

Thanks
-Mathias


