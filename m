Return-Path: <stable+bounces-259615-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAMUOdGxHWphdAkAu9opvQ
	(envelope-from <stable+bounces-259615-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 18:22:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A0D622818
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 18:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C35A30B56CE
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 16:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699622BE05A;
	Mon,  1 Jun 2026 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FC3nFgqG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CF321B191
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330277; cv=none; b=OBDB/Yeo7cIA907YRhUtbRnKK/vQoZC4b208J7/AF3sIkL8kVtllpiZGvcFqo+FbpJozyEy2665z/kdPJv2CZWvZE6wFq98Bj3nmG+3M46DftkGwTy7/5WnpgOVly2b/PNiMHY/ixXl0ba636nRal8gYprPW0N1TuVfzQBLoX+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330277; c=relaxed/simple;
	bh=Yw3lJLrlxRPTtjk5/yb8ZfcpbEOHf5KQoIINtTurjDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7cKrAxaaiQem54A2104n9u4i0pVhEttqs3M1UgLFkEvNymei1d2eTZHHseaSBjmubCvbBw8Yq3g75nIz1qxK0t6itdvsGYP0MJtzoi0sFohY8O6EeD9l7Q10rwf9LcUb4ukTot77qO5TmcDgg3QHiJtcs/NplCIvZPkg857PcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FC3nFgqG; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780330275; x=1811866275;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Yw3lJLrlxRPTtjk5/yb8ZfcpbEOHf5KQoIINtTurjDY=;
  b=FC3nFgqGUWxn9o5UAgryhaiuKvlJ1Feg0cgbpoOAJtLOX4YIibJJi35H
   FRRW1IYo5G+QobBsVS+tlgUmUqQbQIXTlaYM4LCcjTlVAzDlE8Wu9kUgz
   93Eu5qki7YLRPNPG7dMEL9fk7oyR6SsIBtW+NUMkBR4/2ohqE2Gmt/M2y
   fYw1JeOtY+NaEBWwCAed3hXgtUtMZOA21nzT5YZLL0LFRKDAzODcQo1d/
   VFUuU8r2g9dukGHGM1uFpxqNHUtSlMb29poJ+cQDt4oDa/l4o4XMFGC81
   0eNuwqvVfBqOeT6BlVZTNxntyf4Dve85xgnbavXOcq4AxLxfYJtlk5MVu
   A==;
X-CSE-ConnectionGUID: XcpDmPG3QnyH1Lqr0/XfXQ==
X-CSE-MsgGUID: 1eMMFiNRTrKpoVUj0XVBrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="106541410"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="106541410"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 09:11:14 -0700
X-CSE-ConnectionGUID: QqKrEU9EQrm68T9Fixj4Dg==
X-CSE-MsgGUID: 8MeoP/RKRNWaDr22o+onUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="273903228"
Received: from unknown (HELO [10.245.113.115]) ([10.245.113.115])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 09:11:13 -0700
Message-ID: <b464b589-2d28-4617-baf0-eefbe14e170a@linux.intel.com>
Date: Mon, 1 Jun 2026 18:10:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Fix signed integer truncation in IPC receive
To: David Laight <david.laight.linux@gmail.com>
Cc: stable@vger.kernel.org
References: <20260529115005.131888-1-andrzej.kacprowski@linux.intel.com>
 <20260529134911.40728b88@pumpkin>
Content-Language: en-US
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
In-Reply-To: <20260529134911.40728b88@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-259615-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrzej.kacprowski@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: 38A0D622818
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 29-May-26 2:49 PM, David Laight wrote:
> On Fri, 29 May 2026 13:50:05 +0200
> Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com> wrote:
> 
>> Fix potential buffer overflow where firmware-supplied data_size is cast
>> to signed int before being used in min_t(). Large unsigned values
>> (>= 0x80000000) become negative, causing unsigned wraparound and
>> oversized memcpy operations that can overflow the stack buffer.
>>
>> Change min_t(int, ...) to min_t(u32, ...) to ensure large values are
>> properly clamped instead of becoming negative.
> 
> Just use min(), no need for the casts that min_t() adds.
> 
> This is another (slightly unusual) example of why min_t() is broken.
> Even with min() doing strict type checks the correct fix would have been to
> use (u32)sizeof(*jsm_msg) - and completely ignore what checkpatch says.
> 
> -- David
> 

Thanks for the review.
I will replace min_t() with min().

-- Andrzej
>>
>> Fixes: 3b434a3445ff ("accel/ivpu: Use threaded IRQ to handle JOB done messages")
>> Cc: <stable@vger.kernel.org> # v6.18+
>> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
>> ---
>>   drivers/accel/ivpu/ivpu_ipc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
>> index f47df092bb0d..9980a7898bed 100644
>> --- a/drivers/accel/ivpu/ivpu_ipc.c
>> +++ b/drivers/accel/ivpu/ivpu_ipc.c
>> @@ -276,7 +276,7 @@ int ivpu_ipc_receive(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
>>   	if (ipc_buf)
>>   		memcpy(ipc_buf, rx_msg->ipc_hdr, sizeof(*ipc_buf));
>>   	if (rx_msg->jsm_msg) {
>> -		u32 size = min_t(int, rx_msg->ipc_hdr->data_size, sizeof(*jsm_msg));
>> +		u32 size = min_t(u32, rx_msg->ipc_hdr->data_size, sizeof(*jsm_msg));
>>   
>>   		if (rx_msg->jsm_msg->result != VPU_JSM_STATUS_SUCCESS) {
>>   			ivpu_err(vdev, "IPC resp result error: %d\n", rx_msg->jsm_msg->result);
> 


