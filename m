Return-Path: <stable+bounces-56216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB6091DFAD
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 14:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B83B1C220FB
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 12:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB418158D77;
	Mon,  1 Jul 2024 12:44:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C409158D70;
	Mon,  1 Jul 2024 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837841; cv=none; b=DQlGZz6SOo5hJg0Q9I2t7faK2LGtRMPdIq7QgBXfLIRTzszQqTzFR+gWQDDnRneb6rQnF7ZTm4mfXRPv5hhG4q4FxSqewTkcQT1LrgUrk1kiC66//4jGHlWCuZ8+ZZNtrg85logRygM1XF5mPlG/X/yjyyiAe8uDMpW/milfsm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837841; c=relaxed/simple;
	bh=gziZ/YmkYT8HtuQpa9Hf7+eLTOnqdaOU3fKyu0JLdLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FSKNSAD1uQ56wdFm1O/pLnOCSCGwY4e7Y5ASAoecoUPO4r2xZn40AxKS3unpL1F4pc/VEXgDC4sh04IF98pPD9bnmzLjGFGhce3i8G0GdxCk5PXYm2g+59CvYeYEgOzwljiwE8SdmPDOdcbJ5TmIXT9lh/Dl2TjyXKwCJ9QOslw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.13.50] (g305.RadioFreeInternet.molgen.mpg.de [141.14.13.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5375661E5FE01;
	Mon,  1 Jul 2024 14:42:43 +0200 (CEST)
Message-ID: <e981261e-77be-407b-b601-f7214a4f57dd@molgen.mpg.de>
Date: Mon, 1 Jul 2024 14:42:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 1/1] igc: Fix packet still tx
 after gate close by reducing i226 MAC retry buffer
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240701100058.3301229-1-faizal.abdul.rahim@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240701100058.3301229-1-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Faizal,


Thank you for your patch.

Am 01.07.24 um 12:00 schrieb Faizal Rahim:
> AVNU testing uncovered that even when the taprio gate is closed,
> some packets still transmit.

What is AVNU? *some* would fit on the line above.

> A known i225/6 hardware errata states traffic might overflow the planned

Do you have an idea for that errata? Please document it. (I see you 
added it at the end. Maybe use [1] notation for referencing it.)

> QBV window. This happens because MAC maintains an internal buffer,
> primarily for supporting half duplex retries. Therefore, when
> the gate closes, residual MAC data in the buffer may still transmit.
> 
> To mitigate this for i226, reduce the MAC's internal buffer from
> 192 bytes to 88 bytes by modifying the RETX_CTL register value.

… to the recommended 88 bytes …

> This follows guidelines from:
> 
> a) Ethernet Controller I225/I22 Spec Update Rev 2.1 Errata Item 9:
>     TSN: Packet Transmission Might Cross Qbv Window
> b) I225/6 SW User Manual Rev 1.2.4: Section 8.11.5 Retry Buffer Control
> 
> Test Steps:
> 1. Send taprio cmd to board A
> tc qdisc replace dev enp1s0 parent root handle 100 taprio \
> num_tc 4 \
> map 3 2 1 0 3 3 3 3 3 3 3 3 3 3 3 3 \
> queues 1@0 1@1 1@2 1@3 \
> base-time 0 \
> sched-entry S 0x07 500000 \
> sched-entry S 0x0f 500000 \
> flags 0x2 \
> txtime-delay 0
> 
> - Note that for TC3, gate opens for 500us and close for another 500us
> 
> 3. Take tcpdump log on Board B
> 
> 4. Send udp packets via UDP tai app from Board A to Board B
> 
> 5. Analyze tcpdump log via wireshark log on Board B
> - Observed that the total time from the first to the last packet
> received during one cycle for TC3 does not exceed 500us

Indent the list item by four spaces? (Also above?)

> 
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

As you Cc’ed stable@vger.kernel.org, add a Fixes: tag?

> ---
>   drivers/net/ethernet/intel/igc/igc_defines.h |  6 ++++
>   drivers/net/ethernet/intel/igc/igc_tsn.c     | 34 ++++++++++++++++++++
>   2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index 5f92b3c7c3d4..511384f3ec5c 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -404,6 +404,12 @@
>   #define IGC_DTXMXPKTSZ_TSN	0x19 /* 1600 bytes of max TX DMA packet size */
>   #define IGC_DTXMXPKTSZ_DEFAULT	0x98 /* 9728-byte Jumbo frames */
>   
> +/* Retry Buffer Control */
> +#define IGC_RETX_CTL			0x041C
> +#define IGC_RETX_CTL_WATERMARK_MASK	0xF
> +#define IGC_RETX_CTL_QBVFULLTH_SHIFT	8 /* QBV Retry Buffer Full Threshold */
> +#define IGC_RETX_CTL_QBVFULLEN	0x1000 /* Enable QBV Retry Buffer Full Threshold */
> +
>   /* Transmit Scheduling Latency */
>   /* Latency between transmission scheduling (LaunchTime) and the time
>    * the packet is transmitted to the network in nanosecond.
> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
> index 22cefb1eeedf..c97d908cecc5 100644
> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
> @@ -78,6 +78,15 @@ void igc_tsn_adjust_txtime_offset(struct igc_adapter *adapter)
>   	wr32(IGC_GTXOFFSET, txoffset);
>   }
>   
> +static void igc_tsn_restore_retx_default(struct igc_adapter *adapter)
> +{
> +	struct igc_hw *hw = &adapter->hw;
> +	u32 retxctl;
> +
> +	retxctl = rd32(IGC_RETX_CTL) & IGC_RETX_CTL_WATERMARK_MASK;
> +	wr32(IGC_RETX_CTL, retxctl);
> +}
> +
>   /* Returns the TSN specific registers to their default values after
>    * the adapter is reset.
>    */
> @@ -91,6 +100,9 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
>   	wr32(IGC_TXPBS, I225_TXPBSIZE_DEFAULT);
>   	wr32(IGC_DTXMXPKTSZ, IGC_DTXMXPKTSZ_DEFAULT);
>   
> +	if (igc_is_device_id_i226(hw))
> +		igc_tsn_restore_retx_default(adapter);
> +
>   	tqavctrl = rd32(IGC_TQAVCTRL);
>   	tqavctrl &= ~(IGC_TQAVCTRL_TRANSMIT_MODE_TSN |
>   		      IGC_TQAVCTRL_ENHANCED_QAV | IGC_TQAVCTRL_FUTSCDDIS);
> @@ -111,6 +123,25 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
>   	return 0;
>   }
>   
> +/* To partially fix i226 HW errata, reduce MAC internal buffering from 192 Bytes
> + * to 88 Bytes by setting RETX_CTL register using the recommendation from:
> + * a) Ethernet Controller I225/I22 Specification Update Rev 2.1
> + *    Item 9: TSN: Packet Transmission Might Cross the Qbv Window
> + * b) I225/6 SW User Manual Rev 1.2.4: Section 8.11.5 Retry Buffer Control
> + */
> +static void igc_tsn_set_retx_qbvfullth(struct igc_adapter *adapter)

It’d put threshold in the name.

> +{
> +	struct igc_hw *hw = &adapter->hw;
> +	u32 retxctl, watermark;
> +
> +	retxctl = rd32(IGC_RETX_CTL);
> +	watermark = retxctl & IGC_RETX_CTL_WATERMARK_MASK;
> +	/* Set QBVFULLTH value using watermark and set QBVFULLEN */
> +	retxctl |= (watermark << IGC_RETX_CTL_QBVFULLTH_SHIFT) |
> +		   IGC_RETX_CTL_QBVFULLEN;
> +	wr32(IGC_RETX_CTL, retxctl);
> +}
> +
>   static int igc_tsn_enable_offload(struct igc_adapter *adapter)
>   {
>   	struct igc_hw *hw = &adapter->hw;
> @@ -123,6 +154,9 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
>   	wr32(IGC_DTXMXPKTSZ, IGC_DTXMXPKTSZ_TSN);
>   	wr32(IGC_TXPBS, IGC_TXPBSIZE_TSN);
>   
> +	if (igc_is_device_id_i226(hw))
> +		igc_tsn_set_retx_qbvfullth(adapter);
> +
>   	for (i = 0; i < adapter->num_tx_queues; i++) {
>   		struct igc_ring *ring = adapter->tx_ring[i];
>   		u32 txqctl = 0;


Kind regards,

Paul

