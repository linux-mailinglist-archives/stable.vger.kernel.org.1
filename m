Return-Path: <stable+bounces-206112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CFECFD1D0
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 11:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 788893055035
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 10:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71B130DD2C;
	Wed,  7 Jan 2026 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hale.at header.i=@hale.at header.b="PrwA6QEc"
X-Original-To: stable@vger.kernel.org
Received: from gw.hale.at (gw.hale.at [89.26.116.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1762DF703;
	Wed,  7 Jan 2026 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.26.116.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780505; cv=none; b=jNplvITDpYysXHSBw/CReDtNU6Kox+LoCjMP8ghLbUagmhPrivbRXLpTMvIHhDpQxTeXdZ7VORrGNAHa+p3nrGpYgPKyeEUvE1shEfHas8QRrO2/01WkRnk3r3IgJAdG2FP8+GWOw5bN1AHoc829TwyEE1mullM41Ek+gIgpc5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780505; c=relaxed/simple;
	bh=2FtAYjtwemC6AXNTTViR1w+x3CC1AkWt/hYVTMmYfqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=He4+1+qQ2PuFDH+NzeNoqs/F4myCSzdrd8aeGM4Z4OCr7Oe38MW26+a5iYSLKh94YZBBfnBADhxmbghfZ5I3SN7LuFs2Gvj01jg0YQIaAKFJ+3O+fCwsOX4mGEMyTpf8mmjjmBWtopGyooPReNuPHPIVM1OJOEyGyCg23xmaxno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hale.at; spf=pass smtp.mailfrom=hale.at; dkim=pass (2048-bit key) header.d=hale.at header.i=@hale.at header.b=PrwA6QEc; arc=none smtp.client-ip=89.26.116.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hale.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hale.at
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=hale.at; i=@hale.at; q=dns/txt; s=mail;
  t=1767780502; x=1799316502;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2FtAYjtwemC6AXNTTViR1w+x3CC1AkWt/hYVTMmYfqQ=;
  b=PrwA6QEcmyFISlZV5FmZNU7uKxSDi3DNKJpNgMm/+FspMEDyPL6dmQPL
   jX+5N8B1gzDV4P08zTg4PhrSpHkplBjNVWQhFf50nF2Ot6FWYWI/QGFKJ
   fm5e78Z7KMPRQDNbfeilXdFC1TninWsFIzjyjZ5SycON7f4tpxBy7E82v
   tS4LEpoRgqTWNqqUlG5bfWcHbSJkBpMT5ogQQibDtzeLU+VpvwG9t1Jzy
   nFtJ8td+vL9el7eoCfyNJ09RtEGhJd1WwBml8Y7FPufH9Mbzy/Whcn7F6
   ql4ENp1Ksbrr4E7tNBRGhr8ijXV3QaNN9D+ZEdhqtSJMWSkK0XpV0BQMj
   Q==;
X-CSE-ConnectionGUID: LdtWPZbVQvO0uTSQwb7yYQ==
X-CSE-MsgGUID: svEX99OOT/a8GRfQ24yBsw==
IronPort-SDR: 695e3037_3PYCAJZ3HiCULLLbcMYzfxrEQYTB1dBTRFUN863/7JAaQbV
 1yktmv3B+lTOWmGAuned9dMEh0ysexRIYhA1lHg==
X-IronPort-AV: E=Sophos;i="6.21,207,1763420400"; 
   d="scan'208";a="1570736"
Received: from unknown (HELO mail4.hale.at) ([192.168.100.5])
  by mgmt.hale.at with ESMTP; 07 Jan 2026 11:06:48 +0100
Received: from mail4.hale.at (localhost.localdomain [127.0.0.1])
	by mail4.hale.at (Postfix) with ESMTPS id B4ABD1300675;
	Wed,  7 Jan 2026 11:06:27 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail4.hale.at (Postfix) with ESMTP id 9CE26130074F;
	Wed,  7 Jan 2026 11:06:27 +0100 (CET)
X-Virus-Scanned: amavis at mail4.hale.at
Received: from mail4.hale.at ([127.0.0.1])
 by localhost (mail4.hale.at [127.0.0.1]) (amavis, port 10026) with ESMTP
 id vztAj6aZBBhO; Wed,  7 Jan 2026 11:06:27 +0100 (CET)
Received: from [192.168.100.117] (entw47 [192.168.100.117])
	by mail4.hale.at (Postfix) with ESMTPSA id 7BE701300675;
	Wed,  7 Jan 2026 11:06:27 +0100 (CET)
Message-ID: <4d6a1f0b-946e-4acb-bfe4-1e9317fd144e@hale.at>
Date: Wed, 7 Jan 2026 11:06:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] net: nfc: nci: Fix parameter validation for packet
 data
To: Jakub Kicinski <kuba@kernel.org>
Cc: Deepak Sharma <deepak.sharma.472935@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Simon Horman
 <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Michael Thalmeier <michael@thalmeier.at>, stable@vger.kernel.org
References: <20251223072552.297922-1-michael.thalmeier@hale.at>
 <20260104101323.1ac8b478@kernel.org>
From: Michael Thalmeier <michael.thalmeier@hale.at>
Content-Language: en-US
In-Reply-To: <20260104101323.1ac8b478@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 04.01.26 um 19:13 schrieb Jakub Kicinski:
> On Tue, 23 Dec 2025 08:25:52 +0100 Michael Thalmeier wrote:
>> diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
>> index 418b84e2b260..a5cafcd10cc3 100644
>> --- a/net/nfc/nci/ntf.c
>> +++ b/net/nfc/nci/ntf.c
> 
>> @@ -380,6 +384,10 @@ static int nci_rf_discover_ntf_packet(struct nci_dev *ndev,
>>   	pr_debug("rf_tech_specific_params_len %d\n",
>>   		 ntf.rf_tech_specific_params_len);
>>   
>> +	if (skb->len < (data - skb->data) +
>> +			ntf.rf_tech_specific_params_len + sizeof(ntf.ntf_type))
>> +		return -EINVAL;
> 
> Are we validating ntf.rf_tech_specific_params_len against the
> extraction logic in nci_extract_rf_params_nfca_passive_poll()
> and friends?

You are right. The current patch is only validating that the received 
packet is consistent in the way that the rf_tech_specific_params_len 
number of bytes is also contained in the buffer.

There is currently no code that validates that 
nci_extract_rf_params_nfca_passive_poll and friends only access the 
given number of bytes in their logic.
And to be frank, I do not know how to implement this without either 
cluttering the code with validation logic or re-implementing half the 
parsing logic for length validation.

