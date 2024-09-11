Return-Path: <stable+bounces-75848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E19D975667
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 17:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409311C22B43
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 15:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261E019F102;
	Wed, 11 Sep 2024 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fKY1g6lj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EDE2AE90;
	Wed, 11 Sep 2024 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067242; cv=none; b=l9EjDDEPsNhxuGB93RmTK1BUa4XYZTtwyFhpGJkwnJP0nqN1IcCi92/lR6dFBcTwC3x6QqDcxRZrtaOvRoWJpTg3sNl6A11EHa0KyvC9twYutu5X9AgE/KVswFgIxufhw8/1Vvr8GJmmVXKlwsKwivPTyfDVzmgbctM+CXXYcbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067242; c=relaxed/simple;
	bh=cmThnpgJWyD6GM0ZD6Ic8qiZjE3t5L8P8LLk2F0ysFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MrbiBu2FnM0jNA44V7hQWKaeH1mt/Ktl1pNsolTj4H3HsnP5dsCJ8VQKAHfMbNdonkLrv0ZGRj1LYccfuWXZF7CklYD6tK+c0ccQgyNjlmxXZBAehk4YQRHpaW9RBcc/jKsQXoao6WZdJ6+JKWWELnrXlrl3li/VOpoT51r7s6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fKY1g6lj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726067241; x=1757603241;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cmThnpgJWyD6GM0ZD6Ic8qiZjE3t5L8P8LLk2F0ysFQ=;
  b=fKY1g6ljufVtYlg1v11w5Hjlqrpv3QuuiynQ5v2zJsAhLZwpsUrYZNWW
   s5KYTpt8jyMP3cAadjQrqiO86Dah7vU1VoKsyfoWMti6trIfF+fSwyGhD
   /dXbvY2UWhAVtMZ8lUS86zo+Rl1uNO0K66jd9vPaE3jzstux7rSA84reX
   i25moORbmIPUy+In/QIrYTL+F44BoWWU/D08XTP04+T9b2ryiWlCV+9P1
   IkYCovEKCvOeKRVlLXNrXfdltk0NY4k7Di+iecEMr+F7j7u/xMu9wmpu9
   Y8zbjeq/lND99l+s4Fa8TQsDW+4hCORfzUkmlKd4qm3AavOdUiP00LRxo
   g==;
X-CSE-ConnectionGUID: 2jedS0BGSpGNzafYaWbO3w==
X-CSE-MsgGUID: o69p6PfbQnGla2Ykd8n4GA==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="28609248"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="28609248"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 08:07:21 -0700
X-CSE-ConnectionGUID: rrS8zVvQQNGfzDo5caZUrw==
X-CSE-MsgGUID: Uh75a3uNTRq8+QsaelPOWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="67688103"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa006.jf.intel.com with ESMTP; 11 Sep 2024 08:07:18 -0700
Message-ID: <14c33b7a-19a7-4639-aa4a-c5d259e32fe1@linux.intel.com>
Date: Wed, 11 Sep 2024 18:09:25 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] xhci: Fix control transfer error on Etron xHCI host
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>,
 ki.chiang65@gmail.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mathias.nyman@intel.com, stable@vger.kernel.org
References: <20240911095233.3e4d734d@foxbook>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20240911095233.3e4d734d@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> 4. How is it even possible? As far as I see, Linux simply queues
> three TRBs for a control URB. There are 255 slots in a segemnt,
> so exactly 85 URBs should fit, and then back to the first slot.

Not all control transfers have a Data stage TRB.

-Mathias


