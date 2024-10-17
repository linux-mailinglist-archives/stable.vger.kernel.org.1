Return-Path: <stable+bounces-86593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 631A99A1FD9
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 12:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05AAC1F2322B
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 10:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB451DA61E;
	Thu, 17 Oct 2024 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="jfsS9CBm"
X-Original-To: stable@vger.kernel.org
Received: from smtp77.iad3a.emailsrvr.com (smtp77.iad3a.emailsrvr.com [173.203.187.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74101D432D
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729160812; cv=none; b=loujJC4tg978wfDDGqvYcUmn749yWgxD/dNOkSv7gLWjF2hk1kbtvWUPkBR0UmlvSpF3Vdlgc30Qw73Cki1ANVdEz4HnjU24wg+Bwf/2vXHjx9arHa21EcjowmFf4YR0XrPtfKW/cAXFKeGs32x+bkljeir8WjKzZHAhxDjDmvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729160812; c=relaxed/simple;
	bh=k+nJSUkwk5gDdPhRVLKpnQy8rkKfStfm9+TBQpiqX7M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GIncXP3w2Mvrt5SmgV1E6Nz2zb1EU6WHNz+6lWhF1LgIMS8CEZxSUsFjEa8lFZ5KX6W3YHPVy6vwLko+71bRGXICstezQIaXsi1jNuFXvk3ItCqLxe4uTgcQjl+6Jv6guO2kr5wo0ppQdkD7Go0r1/kvh8Xu2p2OSiOHrwBoxeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=jfsS9CBm; arc=none smtp.client-ip=173.203.187.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1729158491;
	bh=k+nJSUkwk5gDdPhRVLKpnQy8rkKfStfm9+TBQpiqX7M=;
	h=Date:Subject:From:To:From;
	b=jfsS9CBm45aNY1mKc97yZw9PK64OCkqTc8SJy9NIquwJIG/1PNpJYOVZH3kA4XiHP
	 ixurmWBREX3f16b9u62tEtgliUrORSCQeoiO9qtaC48npzJ//F59LMXSoYoi7hff9/
	 Hfqk63J59qSpkBH2RwYe0m8g5kL2+btilOoGLenA=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp18.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id D4DCF25258;
	Thu, 17 Oct 2024 05:48:10 -0400 (EDT)
Message-ID: <cf1a2818-1b78-4422-bb76-421732c428c0@mev.co.uk>
Date: Thu, 17 Oct 2024 10:48:10 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] comedi: Flush partial mappings in error case
From: Ian Abbott <abbotti@mev.co.uk>
To: Jann Horn <jannh@google.com>, kernel test robot <lkp@intel.com>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>,
 Frank Mori Hess <fmh6jj@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241015-comedi-tlb-v2-1-cafb0e27dd9a@google.com>
 <202410170111.K30oyTWa-lkp@intel.com>
 <CAG48ez2T7i_qCAcGi3nZqQeT8A3x42YSdL=rWqXOUDy5Eyaf6A@mail.gmail.com>
 <ccc4e0a3-34f5-4793-bd05-ee0955c9c87b@mev.co.uk>
Content-Language: en-GB
Organization: MEV Ltd.
In-Reply-To: <ccc4e0a3-34f5-4793-bd05-ee0955c9c87b@mev.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Classification-ID: ce5d4bf1-6887-48ca-a9be-2492341b77e4-1-1

On 17/10/2024 10:29, Ian Abbott wrote:
> On 16/10/2024 23:05, Jann Horn wrote:
>> On Wed, Oct 16, 2024 at 8:05 PM kernel test robot <lkp@intel.com> wrote:
>>> [auto build test ERROR on 6485cf5ea253d40d507cd71253c9568c5470cd27]
>>>
>>> url:    https://github.com/intel-lab-lkp/linux/commits/Jann-Horn/ 
>>> comedi-Flush-partial-mappings-in-error-case/20241016-022809
>>> base:   6485cf5ea253d40d507cd71253c9568c5470cd27
>>> patch link:    https://lore.kernel.org/r/20241015-comedi-tlb-v2-1- 
>>> cafb0e27dd9a%40google.com
>>> patch subject: [PATCH v2] comedi: Flush partial mappings in error case
>>> config: arm-randconfig-004-20241016 (https://download.01.org/0day-ci/ 
>>> archive/20241017/202410170111.K30oyTWa-lkp@intel.com/config)
>>> compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/ 
>>> archive/20241017/202410170111.K30oyTWa-lkp@intel.com/reproduce)
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new 
>>> version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: https://lore.kernel.org/oe-kbuild- 
>>> all/202410170111.K30oyTWa-lkp@intel.com/
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>     arm-linux-gnueabi-ld: drivers/comedi/comedi_fops.o: in function 
>>> `comedi_mmap':
>>>>> comedi_fops.c:(.text+0x4be): undefined reference to `zap_vma_ptes'
>>
>> Ugh, this one is from a nommu build ("# CONFIG_MMU is not set"), it
>> makes sense that you can't zap PTEs when you don't have any PTEs at
>> all... what really impresses me about this is that the rest of the
>> code compiles on nommu. I'm pretty sure this codepath wouldn't
>> actually _work_ on nommu, but apparently compiling it works?
>>
>> I don't know what the right fix is here - should the entire comedi
>> driver be gated on CONFIG_MMU, or only a subset of the mmap handler,
>> or something else?
> 
> Given that it would also affect a lot of fbdev drivers that would also 
> benefit from zapping partial mappings, I suggest that gating on 
> CONFIG_MMU would not be the correct fix.

Perhaps just add an #ifdef CONFIG_MMU around the affected call for now?

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

