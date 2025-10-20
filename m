Return-Path: <stable+bounces-187954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F52DBEFC7B
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 10:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904293BAF28
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 08:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62B22E4274;
	Mon, 20 Oct 2025 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Woa9Vjam"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898482DF3F2;
	Mon, 20 Oct 2025 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947243; cv=none; b=QMw9OkYA4FIzc8iTmD6J/pCqeP8PbwyMp4eoALZ58+AOeiwCvnjBDjutgsfZ87rgvvLJwi54YlguD/oFtQsMpBAL2G69eAyM9ZcHlRd+aEkuFg9HVhsvKdBQf8RpN+NIlxCyIz49NUgF8IlxZwwZwS6k/cl+CtQTAGy+zxQzOx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947243; c=relaxed/simple;
	bh=IhmP+X5k86qh5MYrAym8Tf1Hkwa4L9XTBkqYTlnOAKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBUR0CR5yD/wgiLMAQHU5qfu19nihjYnZXkLMx6zwsHR8ZEYQeCScIausGrJck9Nvcxi4Eh6x33WP72iQgFYRYzSwUeKgr8hdg8TvLz2bfK2ZOcADQ7dBr9Qe3usapXpPsvfUVIaFb7M0/pS06YrtWv3awYDcJmuHjo8h0syh6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Woa9Vjam; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760947242; x=1792483242;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IhmP+X5k86qh5MYrAym8Tf1Hkwa4L9XTBkqYTlnOAKc=;
  b=Woa9VjamlpialDzuFsawWY19foRx2ugx3o3g7g5ctQT5IngXOa2dCLey
   RE0u6R05/ksPEptRmSsbdpVQqrT+TrogG4mj9l3BBI5kLJI3SpMrqAlJ6
   y2TUtYPSTG1nYuulaXmnPUSLzlhns6E74OMTEGT8x6MWX2evu+zUv78Bj
   OEja1eSQmrGX53J5lPaGBpFdIJawxtfPrQY7Iz8R9bYS/aSy9n4+oCYB6
   rODb8me3MtG3eF3+ZxvdbQG8/o78Sqru/ouguhIuQwBn8Lbc2jHVbjCI7
   N6VbQvUM1zSQs1ve+VOBez39ik9h28C7oCvIp+3nwX/RRsCBDv85J9Fl3
   Q==;
X-CSE-ConnectionGUID: aeSedktgQ3SCjPbtU7YV4A==
X-CSE-MsgGUID: 1L/J6iPHTNqYzaF+qBDrRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="63102123"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="63102123"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 01:00:41 -0700
X-CSE-ConnectionGUID: /Yni10HYTvGTdkeeXnTdzw==
X-CSE-MsgGUID: S5gGU7U0TLuvt6nVn2QuRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="183287057"
Received: from krybak-mobl1.ger.corp.intel.com (HELO [10.245.246.246]) ([10.245.246.246])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 01:00:39 -0700
Message-ID: <c22ce363-4ba9-4b6b-b3e2-a3b2d23dbdd9@linux.intel.com>
Date: Mon, 20 Oct 2025 11:00:42 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ASoC: SOF: ipc4-topology: Correct the minimum host
 DMA buffer size
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
 kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
 stable@vger.kernel.org
References: <20251002125322.15692-1-peter.ujfalusi@linux.intel.com>
 <20251002125322.15692-2-peter.ujfalusi@linux.intel.com>
 <de8f8b56-ef5d-4d58-92ec-38280badcfb0@sirena.org.uk>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <de8f8b56-ef5d-4d58-92ec-38280badcfb0@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 20/10/2025 04:41, Mark Brown wrote:
> On Thu, Oct 02, 2025 at 03:53:20PM +0300, Peter Ujfalusi wrote:
>> The firmware has changed the minimum host buffer size from 2 periods to
>> 4 periods (1 period is 1ms) which was missed by the kernel side.
>>
>> Adjust the SOF_IPC4_MIN_DMA_BUFFER_SIZE to 4 ms to align with firmware.
> 
> This doesn't apply as a fix, please check and resend.

I think you have already taken this patch, it is in 6.18-rc1:
a7fe5ff832d6 ("ASoC: SOF: ipc4-topology: Correct the minimum host DMA
buffer size")

-- 
Péter


