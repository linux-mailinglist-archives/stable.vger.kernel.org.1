Return-Path: <stable+bounces-111112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1684FA21B81
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 12:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4EC3A22E1
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 11:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3303C19CD1E;
	Wed, 29 Jan 2025 11:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="naETcXE/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4EC1A83E6;
	Wed, 29 Jan 2025 11:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738148461; cv=none; b=fm3Vwh05afv96HgicUcZPbe08jUy58CaG1ROnp+ncBgpbMl0GGktK6w5pZUmOoHXMsbs6MJP6vxgMcL+ZquRLtBW5zXbRnoRyMPO2NtLmenDKyizO83udsshCiu+P+/LDpBZVhc5Gmd1LINW0kMnso66hjZJGAmsu2kgyAMvsSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738148461; c=relaxed/simple;
	bh=NLY9YZjD1ag07UaqOsQMc+/23yy2LzLeb1dAft7nyYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skwXw9xKqwAPkd1Gz4VTcszqHQDxiEjGTWRy24zs0DrRV5r1SES0ko7S6xFj3N2SpsTUD2qPQ/MeowFVsJo73kla52zR9v/I5NDjYFT/QDNK7bqecD+3aMQhz0SjwtpCKbQzTsgU3NvehRxtiDKvnEjV04lGIEhh5e/sZgZs5BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=naETcXE/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738148460; x=1769684460;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NLY9YZjD1ag07UaqOsQMc+/23yy2LzLeb1dAft7nyYE=;
  b=naETcXE/JZ/9a26TDI/QeXR7hVPtwMU+3QeUnS2MKF0vKJcv2nziCebD
   vfBa+vJy2+nSl1T5LSKIQrLBYcYz/ot//s0wXkd43HY7kIA7p3+QiVwLn
   VilmPNpUp3ubgirDj5HSpx7ndj72HZVmhhD+PvFKbHocD57Y39dJqHduR
   KuWH6BQbrr3bJqZ94Cl6cBFG2SRJavamc1J8d0SndukaRcQ7NMCI2A59w
   /o5mmptw67S3+2ZCPsMU4UhZcqB3ey5ioQy2GHVzXR0A+eIoN5khy1Gvq
   /0Wl3bedAzCMq4a3VX36qLvdiNfsqhABhR6P62XQ0sjJ5f93TzQ/kLILf
   w==;
X-CSE-ConnectionGUID: s5Z2iChVRGeAWDtPCnoO/Q==
X-CSE-MsgGUID: fQo9F98RQMmBS6jn7RiPqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="38687012"
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="38687012"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 03:00:59 -0800
X-CSE-ConnectionGUID: dG+oDfcPRsK/YpJ5VLsn3A==
X-CSE-MsgGUID: BpLnQVSHQDaN1B/CTQMVJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114132173"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa005.jf.intel.com with ESMTP; 29 Jan 2025 03:00:57 -0800
Message-ID: <ee229b33-2082-4e03-8f2b-df5b4a86a77d@linux.intel.com>
Date: Wed, 29 Jan 2025 13:01:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] usb: xhci port capability storage change broke
 fastboot android bootloader utility
To: Forest <forestix@nom.one>
Cc: linux-usb@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org
References: <hk8umj9lv4l4qguftdq1luqtdrpa1gks5l@sonic.net>
 <2c35ff52-78aa-4fa1-a61c-f53d1af4284d@linux.intel.com>
 <0l5mnj5hcmh2ev7818b3m0m7pokk73jfur@sonic.net>
 <3bd0e058-1aeb-4fc9-8b76-f0475eebbfe4@linux.intel.com>
 <4kb3ojp4t59rm79ui8kj3t8irsp6shlinq@sonic.net>
 <8a5bef2e-7cf9-4f5c-8281-c8043a090feb@linux.intel.com>
 <2tq7pj5g33d76j2uddbv5k8iiuakchso16@sonic.net>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <2tq7pj5g33d76j2uddbv5k8iiuakchso16@sonic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.1.2025 21.44, Forest wrote:
> On Mon, 13 Jan 2025 17:05:09 +0200, Mathias Nyman wrote:
> 
>> I'd recommend a patch that permanently adds USB_QUIRK_NO_LPM for this device.
>> Let me know if you want to submit it yourself, otherwise I can do it.
> 
> It looks like I can't contribute a patch after all, due to an issue with my
> Signed-off-by signature.
> 
> So, can you take care of the quirk patch for this device?
> 
> Thank you.

Sure, I'll send it after rc1 is out next week

Thanks
Mathias

