Return-Path: <stable+bounces-230082-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I/OFupNwmlLbgQAu9opvQ
	(envelope-from <stable+bounces-230082-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 09:40:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F09304D2A
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 09:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94795304F6EF
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 08:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E4A33DED9;
	Tue, 24 Mar 2026 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lQmeSENS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1FA366061
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774341155; cv=none; b=LnT+txnm3XFmNHiL6Jx4wnvNc5SuKXKlLzp3bv3fmGcDStSRUnVY0bVUIirxC2brQbc/vNz6PSWtvD/Cid7QvCYwkfJkF9xeKZXDhOx6uywBx3DETJLyqp9x+6MkQx/DcIqVvP46RX+Qj0iwjhdjQvQOqhlujg89iVAsmhSgz3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774341155; c=relaxed/simple;
	bh=0jRrOAI03t67hrsoD6qZ/ZOKagtZrC7OAtNILxB5xbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FI+rg3hgr5bqtK1VUhYMwEIPihjtBDZyQnclwfg951DwkiylizfdYFqOgRVakwvb2MCUGt9YGcAqc2f/Rta3Negk3YMhSMeE8OHAUlmJv1m6tn2DJBoFAKZabjHNun4jlzxHQ2JTojuMOqG4spw/I9J4t//BRK/+NjX8R4H5tA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lQmeSENS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774341147; x=1805877147;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0jRrOAI03t67hrsoD6qZ/ZOKagtZrC7OAtNILxB5xbE=;
  b=lQmeSENS+NhoPiUcUu8/gKm/PnTCCyVostDU/2RMkn1bKRDlfJXBYIT7
   RkUxSUuiwKnnYM1e1TxAgwp748ydajmMYfEh/Uj2VRxmyASIbVHsqrgjh
   Tkgsu7roN+IzPqBXsgRChWwD4Uj7tzkxIKMGS5kRzIQx1sbtpo9JGI9kH
   MYh8ImNmtV0IZA7VPrIjnRUYpLT29ugfXdr/p/Fim8qcpdcyODaa2I69N
   JqZ0QnYq5ytOqaEHxbQNWcWwqfq27C8+eaKR6iN/09av8PXynPFqUY0rh
   mIKOMnLLKtj9DQRuTJ4be3Zu1k55Zs1vAAGKMa+JdOOoK9lSh2GUZDqnW
   g==;
X-CSE-ConnectionGUID: kx5f+37nSIuINHxxUQkQzw==
X-CSE-MsgGUID: O+sYxlFdQGaZRyq0Dp8I3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="79207288"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="79207288"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 01:32:26 -0700
X-CSE-ConnectionGUID: 5+GSlt+8S7iEDpFZ+lGAUA==
X-CSE-MsgGUID: sVAPbTj3SJy/LxDXbosa4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="217718803"
Received: from unknown (HELO [10.102.88.30]) ([10.102.88.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 01:32:24 -0700
Message-ID: <f6ed76a2-0907-4c56-a3a7-7b0eec4a3c08@linux.intel.com>
Date: Tue, 24 Mar 2026 09:32:21 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Add disable clock relinquish workaround for
 NVL-A0
To: Lizhi Hou <lizhi.hou@amd.com>, dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 maciej.falkowski@linux.intel.com, andrzej.kacprowski@linux.intel.com,
 stable@vger.kernel.org
References: <20260323095029.64613-1-karol.wachowski@linux.intel.com>
 <0317ba0d-6260-6e4f-ad5d-514297da7d73@amd.com>
Content-Language: en-US
From: Karol Wachowski <karol.wachowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <0317ba0d-6260-6e4f-ad5d-514297da7d73@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,oss.qualcomm.com,linux.intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-230082-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karol.wachowski@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0F09304D2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/2026 5:53 PM, Lizhi Hou wrote:
> 
> On 3/23/26 02:50, Karol Wachowski wrote:
>> Turn on disable clock relinquish workaround for Nova Lake A0.
>> Without this workaround NPU may not power off correctly after
>> inference, leading to unexpected system behavior.
>>
>> Fixes: 550f4dd2cedd ("accel/ivpu: Add support for Nova Lake's NPU")
>> Cc: <stable@vger.kernel.org> # v6.19+
>>
>> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
>> ---
>>   drivers/accel/ivpu/ivpu_drv.h | 1 +
>>   drivers/accel/ivpu/ivpu_hw.c  | 6 ++++--
>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/
>> ivpu_drv.h
>> index 5b34b6f50e69..f1b6155065ff 100644
>> --- a/drivers/accel/ivpu/ivpu_drv.h
>> +++ b/drivers/accel/ivpu/ivpu_drv.h
>> @@ -35,6 +35,7 @@
>>   #define IVPU_HW_IP_60XX 60
>>     #define IVPU_HW_IP_REV_LNL_B0 4
>> +#define IVPU_HW_IP_REV_NVL_A0 0
>>     #define IVPU_HW_BTRS_MTL 1
>>   #define IVPU_HW_BTRS_LNL 2
>> diff --git a/drivers/accel/ivpu/ivpu_hw.c b/drivers/accel/ivpu/ivpu_hw.c
>> index d69cd0d93569..d4a9bcda4100 100644
>> --- a/drivers/accel/ivpu/ivpu_hw.c
>> +++ b/drivers/accel/ivpu/ivpu_hw.c
>> @@ -70,8 +70,10 @@ static void wa_init(struct ivpu_device *vdev)
>>       if (ivpu_hw_btrs_gen(vdev) == IVPU_HW_BTRS_MTL)
>>           vdev->wa.interrupt_clear_with_0 =
>> ivpu_hw_btrs_irqs_clear_with_0_mtl(vdev);
>>   -    if (ivpu_device_id(vdev) == PCI_DEVICE_ID_LNL &&
>> -        ivpu_revision(vdev) < IVPU_HW_IP_REV_LNL_B0)
>> +    if ((ivpu_device_id(vdev) == PCI_DEVICE_ID_LNL &&
>> +         ivpu_revision(vdev) < IVPU_HW_IP_REV_LNL_B0) ||
>> +        (ivpu_device_id(vdev) == PCI_DEVICE_ID_NVL &&
>> +         ivpu_revision(vdev) == IVPU_HW_IP_REV_NVL_A0))
> Reviewed-by: Lizhi.hou <lizhi.hou@amd.com>

Thank you, applied to drm-misc-fixes.

Karol

>>           vdev->wa.disable_clock_relinquish = true;
>>         if (ivpu_test_mode & IVPU_TEST_MODE_CLK_RELINQ_ENABLE)
> 


