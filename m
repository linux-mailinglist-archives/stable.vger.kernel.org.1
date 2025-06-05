Return-Path: <stable+bounces-151547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C50ACF433
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 18:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC22D167747
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 16:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D2C21C182;
	Thu,  5 Jun 2025 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XW24m4WX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89AC21A447
	for <stable@vger.kernel.org>; Thu,  5 Jun 2025 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140694; cv=none; b=I7873e7Fs15iD4VBec4Sk5/50DDePAKsk2Ty1By1AzHr+QOIxGRFvIPaVaYs/iNOqzS8RLidsj6nUJWlg17wkij4vQrgBfhkZxHDh6UGgRX57OVaxYCIH6W0wftfFiYrIenul50q64J5Biw2tFkiH/rs+9EgfOsaysJ1JlQxyxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140694; c=relaxed/simple;
	bh=QUmJDNLv4/JzLs2JYyQzQHjA0LeAO+ICOXHf6mJrw+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DqyhXMuddzTyA6bfFeJVT8tbYemncEewkYVL4QpbTjP0mVl9sTLsskln0O8zSCXoPG+KZwZy7FyU+HmwZipndVZYGRK1cGaKVeazYPFl8N6nM0/PmDS3sLRAgkzwuMjcgaNBRGbTFkPCTodfCTFcENkQIapVtZ6medyJaZMUI30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XW24m4WX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749140693; x=1780676693;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QUmJDNLv4/JzLs2JYyQzQHjA0LeAO+ICOXHf6mJrw+U=;
  b=XW24m4WX5gY6zyFMzGofPkYUTm1ZuhpR0q9+Esa6kbPG+0di9gc+Uej7
   NIvQJVEJSYx1mYq1JY3Zip0MIXQQ9ppP8HQlW8jqenxDMiCRThS0/YMy2
   U297jAdBFCq1i96Pdctqs3GarHmuWA/sZo24uylohwDqYg8uhBCSE75aG
   CgO8JJgwlsCLJ+cXVoPpIXOCWu1Gi+W6WSvRN6BiGJRjpH6YoYCS2q8xJ
   6oErB4K3FajokA6YemEmbzTe5grHPgkrquplRPg5Y4uxMlxrHLI9L2jg5
   LlntfQ5ohvQa5c3D5DblI1D1bVXGkR/MPp1QgqmbU0Yp44ojfMbkCp/ox
   Q==;
X-CSE-ConnectionGUID: oEihhLWnRHOqDAlH72QGaQ==
X-CSE-MsgGUID: E5XjX/ZUSoyUu53IY8b8qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="55076675"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="55076675"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 09:24:52 -0700
X-CSE-ConnectionGUID: cQeREChzTkKRto+gWXcbCA==
X-CSE-MsgGUID: IhtrAAEcSWyfwgZRWyBYxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="145528071"
Received: from mfalkows-mobl.ger.corp.intel.com (HELO [10.245.252.111]) ([10.245.252.111])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 09:24:50 -0700
Message-ID: <22209cdb-db72-4515-852d-9df1f4091402@linux.intel.com>
Date: Thu, 5 Jun 2025 18:24:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Reorder doorbell unregister and command queue
 destruction
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jacek.lawrynowicz@linux.intel.com,
 lizhi.hou@amd.com, Karol Wachowski <karol.wachowski@intel.com>,
 stable@vger.kernel.org
References: <20250604154450.1209596-1-maciej.falkowski@linux.intel.com>
 <0423ac43-0a12-4f0f-ade3-61364d4abf93@oss.qualcomm.com>
Content-Language: en-US
From: "Falkowski, Maciej" <maciej.falkowski@linux.intel.com>
In-Reply-To: <0423ac43-0a12-4f0f-ade3-61364d4abf93@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/4/2025 6:18 PM, Jeff Hugo wrote:

> On 6/4/2025 9:44 AM, Maciej Falkowski wrote:
>> From: Karol Wachowski <karol.wachowski@intel.com>
>>
>> Refactor ivpu_cmdq_unregister() to ensure the doorbell is unregistered
>> before destroying the command queue. The NPU firmware requires doorbells
>> to be unregistered prior to command queue destruction.
>>
>> If doorbell remains registered when command queue destroy command is 
>> sent
>> firmware will automatically unregister the doorbell, making subsequent
>> unregister attempts no-operations (NOPs).
>>
>> Ensure compliance with firmware expectations by moving the doorbell
>> unregister call ahead of the command queue destruction logic,
>> thus preventing unnecessary NOP operation.
>>
>> Fixes: 2a18ceff9482 ("accel/ivpu: Implement support for hardware 
>> scheduler")
>> Cc: <stable@vger.kernel.org> # v6.11+
>> Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
>> Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
>
> Huh?  This was posted to the list on May 15th, and Jacek applied it to 
> drm-misc-fixes on May 28th.
My apologies, you are right. I accidentally included it while checking 
latest changes.

Best regards,
Maciej
>
> -Jeff

