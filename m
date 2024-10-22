Return-Path: <stable+bounces-87733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A26339AB0E2
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 16:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D148E1C225F2
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 14:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F42001A00F8;
	Tue, 22 Oct 2024 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GRGLOJjx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35AD193409;
	Tue, 22 Oct 2024 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607489; cv=none; b=pEf9ttB6qk87H0+9CEedX/rHTc39lt8yeV+Yi1+FBpv7G5C/kGSj0XCsVU/YAQhd8KNSztEQZo7nEvePpmsPe6KKiuPa0xrmhPBl2oNDsSnsAQUcxAlDvRvGUKYPsF8x/G7T6li1GlevEY5wgB/827Io8FB3RixmJq3gAZiQHFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607489; c=relaxed/simple;
	bh=fZXbOxyaHdvHUYh+ECDwoOfE5XM+s7pGRSfNL5VSMws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9D+JULCbvsLcIiBJ1fN2hemEgCC8hitXy9nsBbNP3bwSG2Jx84/xReVYyk228MBy/u6mryIL2DrMksW8lZllLXDcvnt4KizYCvd2CEc+byUgja+hzlH7e/7mc2slq3nY+yfdtdlCYRxhwnvxBGzYtepJwr/rAy+EaXTxOQ+Bzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GRGLOJjx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729607488; x=1761143488;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fZXbOxyaHdvHUYh+ECDwoOfE5XM+s7pGRSfNL5VSMws=;
  b=GRGLOJjx8WSe3/yknZw/L7zGEFaKywU6J6698ch398lG1X6nbGQ/bYKn
   /1e/Qt404ggrSqUSCcoU9CnTZ7o3Ck/UxPJa/lN5BSI1We5PUQxbGZA0L
   AwqIMIegoDB/8dBnmgqpUKwVaFQEBobjS/sEFtsRwtcjOD5Z+TLZ1tdr6
   5CDQcdyBztpn2m2i9I7hp77wPBKqDvdv391sUNIGZBC3UGlTe55zCnjt2
   sR/5MqByuksdPiAJNYug75WKMEMeIYhPuV2XJdK+Plo8+zhxKDZ0FQLBf
   3XA3uB+Ab5rXHNy3v0gYhuadZgittG7BmNd8bBXC/cALJm74aU2HX9e1b
   Q==;
X-CSE-ConnectionGUID: 6EcSRm9rTWKSsapDb2Y45Q==
X-CSE-MsgGUID: tYU6ZCPeQfe5WviZTnV+ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="46632523"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="46632523"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 07:31:27 -0700
X-CSE-ConnectionGUID: 4Ug4VnKATU6YqzzbJEGGyg==
X-CSE-MsgGUID: xRM+iuBnQeuiw+dAWv1hwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="84680540"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa005.jf.intel.com with ESMTP; 22 Oct 2024 07:31:25 -0700
Message-ID: <118041cf-07b1-457c-ad59-b9c8d48342b9@linux.intel.com>
Date: Tue, 22 Oct 2024 17:33:37 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xhci: Fix Link TRB DMA in command ring stopped
 completion event
To: Faisal Hassan <quic_faisalh@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241021131904.20678-1-quic_faisalh@quicinc.com>
 <51a0598a-2618-4501-af40-f1e9a1463bca@linux.intel.com>
 <07744fc7-633f-477e-96e9-8f498a3b40e8@quicinc.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <07744fc7-633f-477e-96e9-8f498a3b40e8@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.10.2024 15.34, Faisal Hassan wrote:
> Hi Mathias,
> 
>> Do we in this COMP_COMMAND_RING_STOPPED case even need to check if
>> cmd_dma != (u64)cmd_dequeue_dma, or if command ring stopped on a link TRB?
>>
>> Could we just move the COMP_COMMAND_RING_STOPPED handling a bit earlier?
>>
>> if (cmd_comp_code == COMP_COMMAND_RING_STOPPED) {
>>      complete_all(&xhci->cmd_ring_stop_completion);
>>          return;
>> }
>>
>> If I remember correctly it should just turn aborted command TRBs into
>> no-ops,
>> and restart the command ring
>>
> 
> Thanks for reviewing the changes!
> 
> Yes, you’re right. As part of restarting the command ring, we just ring
> the doorbell.
> 
> If we move the event handling without validating the dequeue pointer,
> wouldn’t it be a risk if we don’t check what the xHC is holding in its
> dequeue pointer? If we are not setting it, it starts from wherever it
> stopped. What if the dequeue pointer got corrupted or is not pointing to
> any of the TRBs in the command ring?

For that to happen the xHC host would have to corrupt its internal command
ring dequeue pointer. Not impossible, but an unlikely HW flaw, and a separate
issue. A case like that could be solved by writing the address of the next valid
(non-aborted) command to the CRCR register in xhci_handle_stopped_cmd_ring() before
ringing the doorbell.

The case you found where a command abort is not handled properly due to stopping
on a link TRB is a real xhci driver issue that would be nice to get solved.

For the COMP_COMMAND_RING_STOPPED case we don't really care that much
on which command it stopped, for other commands we do.

Thanks
Mathias


