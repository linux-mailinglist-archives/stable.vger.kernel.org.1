Return-Path: <stable+bounces-53826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F017990E8F8
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86BF1F21F04
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 11:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9574C135A6D;
	Wed, 19 Jun 2024 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U5eHszd2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB6175811;
	Wed, 19 Jun 2024 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718795243; cv=none; b=fTkMokPr5d231LRZRes3ToWZ9ZwSrLRnlYYcdQ9o+5SuUUhaF46g125ZE2OtJUcDGn9fVKvAPlJo33zgj/LzqO+qJF1dvCgH3ENH17vCAMv/bMeWKZSsYJiru7ah30DxaA8ioHjweD+0el7wEUS+9Ot0mMKkRzrs3WHyN8sU++k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718795243; c=relaxed/simple;
	bh=rDc/rfrtzolpD0LTP1ks60v9uPUWCXxUWHIpdqLAbDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJZwOYt2/xKbxo1MsOV+fcfQECuP/xpwaTBSVZrOIQKLMh84eAnlDd/RIrE8Qhcs+VzlBnYeUPDZrP1tqeF6PG56zS1YJxfJ7U1ihfhFdrt0q+g3mj2xXEylQJPjEkUhxNlMQzq99RbWvQWnJtP/Q4Tgew7J2iATDP3LYBcA6Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U5eHszd2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718795241; x=1750331241;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rDc/rfrtzolpD0LTP1ks60v9uPUWCXxUWHIpdqLAbDQ=;
  b=U5eHszd2znRX6Tmh5paU8lmROzpypjvQqE6EFeOt1mDg59iJD+W3uV5a
   YxGnMaAdHgcGtCacIF3mxSed2T9pRW2gDvF/hOLgqSyqkm0Q2JG/Kmx3o
   YYRrRj91q7dhsG44UhnLW5TBxcTXFKwEVbO1tFCfvsFPmJMdj4W+12epg
   4dwG36aOPdNVDjLDPdFe2OVPnOUHi9N13FjDuRqH0aGCaiRv34J43zONa
   ynMXDPX5jG2smKS0tXk2lshFUMUg3uMxSNL8oNNWLy1b5mNMyiabFAu7i
   hH6FjR+Kil+oVrl1yoiq6KLAJKF9qUYB0Y7GaEFZw8EyGRjFGGU9ZOueg
   A==;
X-CSE-ConnectionGUID: RkIeyIerTZqxULtHBtMFWA==
X-CSE-MsgGUID: QGmPf0MkSeyiVP9UuJW0mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="41131497"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="41131497"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 04:07:20 -0700
X-CSE-ConnectionGUID: OaSuUQ2bTlm4Ss3wYCm8Hg==
X-CSE-MsgGUID: c1s9mH8ZTE6nKxCOZt8zvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="79364591"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa001.jf.intel.com with ESMTP; 19 Jun 2024 04:07:19 -0700
Message-ID: <18cb1377-dc56-bd19-e634-fbded8965f3d@linux.intel.com>
Date: Wed, 19 Jun 2024 14:09:17 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2] xhci: Apply XHCI_RESET_TO_DEFAULT quirk to TGL
Content-Language: en-US
To: Reka Norman <rekanorman@chromium.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20240614002917.4014146-1-rekanorman@chromium.org>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20240614002917.4014146-1-rekanorman@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.6.2024 3.28, Reka Norman wrote:
> TGL systems have the same issue as ADL, where a large boot firmware
> delay is seen if USB ports are left in U3 at shutdown. So apply the
> XHCI_RESET_TO_DEFAULT quirk to TGL as well.
> 
> The issue it fixes is a ~20s boot time delay when booting from S5. It
> affects TGL devices, and TGL support was added starting from v5.3.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Reka Norman <rekanorman@chromium.org>

Added to queue

Thanks
Mathias




