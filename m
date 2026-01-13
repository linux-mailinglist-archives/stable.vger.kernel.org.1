Return-Path: <stable+bounces-208301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8D4D1B988
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 23:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3525D3017663
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 22:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8890930F806;
	Tue, 13 Jan 2026 22:31:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599E921FF4D;
	Tue, 13 Jan 2026 22:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768343517; cv=none; b=WPMsbLGuLWI4QsEwrEwM+9jOFlozXUYLK0pfJRBe0yWI3nFhO5lBWPHJ3+loDwJz71gvKEZE5T5bzJaJh5zp18cTtyXZ8Y8yaTMLVsPqPBvXtzusVOUdmr4BiiYj0huliEaPHlTpGFgqzmEYngPfLwJDsPvu0XAOMmUhFGQarXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768343517; c=relaxed/simple;
	bh=bRfy4giqRiYNrUXuD2iU+wbIkkdIRnPy9TgSPsmiCa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGn8rftsmSP9pAgMAsCoi16Kt/cLZ+nL4x8Umuy6P/CcP6Ys3Uvt0eeYEEVrg+Kw5FUpaAldpR1WsNBJfg7c5I2E26+oYRy0HiwK7q2DiCCl6IiNxa+bu+kAEOm2XRO0x9ZD5/4PyOs7aT8IAlH8a1Uog5T65+boDgmTKlMRsZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.0.56.51] (unknown [62.214.191.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A1D142387DCFE;
	Tue, 13 Jan 2026 23:31:24 +0100 (CET)
Message-ID: <f0fee9dd-7236-464d-9e06-6adbeece81a8@molgen.mpg.de>
Date: Tue, 13 Jan 2026 23:31:20 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 1/2] ice: reintroduce retry
 mechanism for indirect AQ
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Jakub Staniszewski <jakub.staniszewski@linux.intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>
References: <20260113193817.582-1-dawid.osuchowski@linux.intel.com>
 <20260113193817.582-2-dawid.osuchowski@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260113193817.582-2-dawid.osuchowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[Cc: +Michal]

Dear Dawid, dear Jakub,


Am 13.01.26 um 20:38 schrieb Dawid Osuchowski:
> From: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>
> 
> Add retry mechanism for indirect Admin Queue (AQ) commands. To do so we
> need to keep the command buffer.
> 
> This technically reverts commit 43a630e37e25
> ("ice: remove unused buffer copy code in ice_sq_send_cmd_retry()"),
> but combines it with a fix in the logic by using a kmemdup() call,
> making it more robust and less likely to break in the future due to
> programmer error.
> 
> Cc: Michal Schmidt <mschmidt@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 3056df93f7a8 ("ice: Re-send some AQ commands, as result of EBUSY AQ error")
> Signed-off-by: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>
> Co-developed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> Ccing Michal, given they are the author of the "reverted" commit.

At least Michal was not in the (visible) Cc: list

>   drivers/net/ethernet/intel/ice/ice_common.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index a400bf4f239a..aab00c44e9b2 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -1879,34 +1879,40 @@ ice_sq_send_cmd_retry(struct ice_hw *hw, struct ice_ctl_q_info *cq,
>   {
>   	struct libie_aq_desc desc_cpy;
>   	bool is_cmd_for_retry;
> +	u8 *buf_cpy = NULL;
>   	u8 idx = 0;
>   	u16 opcode;
>   	int status;
>   
>   	opcode = le16_to_cpu(desc->opcode);
>   	is_cmd_for_retry = ice_should_retry_sq_send_cmd(opcode);
>   	memset(&desc_cpy, 0, sizeof(desc_cpy));
>   
>   	if (is_cmd_for_retry) {
> -		/* All retryable cmds are direct, without buf. */
> -		WARN_ON(buf);
> +		if (buf) {
> +			buf_cpy = kmemdup(buf, buf_size, GFP_KERNEL);
> +			if (!buf_cpy)
> +				return -ENOMEM;
> +		}
>   
>   		memcpy(&desc_cpy, desc, sizeof(desc_cpy));
>   	}
>   
>   	do {
>   		status = ice_sq_send_cmd(hw, cq, desc, buf, buf_size, cd);
>   
>   		if (!is_cmd_for_retry || !status ||
>   		    hw->adminq.sq_last_status != LIBIE_AQ_RC_EBUSY)
>   			break;
>   
> +		if (buf_cpy)
> +			memcpy(buf, buf_cpy, buf_size);
>   		memcpy(desc, &desc_cpy, sizeof(desc_cpy));
> -

Unrelated change?

>   		msleep(ICE_SQ_SEND_DELAY_TIME_MS);
>   
>   	} while (++idx < ICE_SQ_SEND_MAX_EXECUTE);
>   
> +	kfree(buf_cpy);
>   	return status;
>   }

The diff looks good otherwise.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

