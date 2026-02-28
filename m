Return-Path: <stable+bounces-220032-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA6eKHdEomnd1QQAu9opvQ
	(envelope-from <stable+bounces-220032-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 02:27:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 200261BFB8B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 02:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 713D430BFF5B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 01:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1587E2F0673;
	Sat, 28 Feb 2026 01:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rtckxnbD"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638C42E9EA4
	for <stable@vger.kernel.org>; Sat, 28 Feb 2026 01:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772242014; cv=none; b=rfcgAGU1Q/QA7gkxLIOntP3dEh9mYHcarilSltG/Q65OI5wirGQIv5fIywxv+h5wlC7A4mRKfehYyjD9dorwhwnDilSAeCPomx3VduGrTZRU/fGhQsK977z3Y+9JWXgN1syjtryDNELi4qZHxwD92G5pPIQBDiczwVH4ME8GM4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772242014; c=relaxed/simple;
	bh=lXLhSRRA5YZbKIl0t5NVBWC6lTnl8DyEsTVmuMSzBUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W7VaoxD072JmlM9Biem157koj2X3lpYp9H0JKnhlGCdRMlWwSMPhaM4THft+e9TkqkRPKmnwIi64MbcdwI92AoDizaAivGK8SGXHsmcgfA23Yxo507/aOQ2v/zAadvg788cB9AQRG6dYd942T7BKKq67CDJHIu9i6C2UAfHkEjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rtckxnbD; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <752b26fc-45e2-4c4b-aa9b-48a1112b837a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772242001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JzPgLVkG9dTK690PZGw5C90SAV1zSq/w4UZoKr/PnZ0=;
	b=rtckxnbD06OPnnA2KbUoSAgL9X/HDUWLHffqnR6ug1sq4qBVMPV27aYvqvSdjOFeIElAej
	gC3gexolxrW+wB8bFCfkfmy1xAjw032/yYz/XcD2g5Rf3j/6x1TX5nDFMrF/L0//RivDl5
	HehNZ5e7ryhId9oDosn1G6bU07A9JQE=
Date: Fri, 27 Feb 2026 17:26:33 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mmc: sdhci-pci-gli: fix GL9750 DMA write corruption
To: Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Ben Chuang <ben.chuang@genesyslogic.com.tw>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260227075909.3860183-1-matthew.schwartz@linux.dev>
 <1e71a22b-48d5-4a5f-87d5-860a6cb9a04d@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <1e71a22b-48d5-4a5f-87d5-860a6cb9a04d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220032-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.schwartz@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 200261BFB8B
X-Rspamd-Action: no action

On 2/27/26 1:16 AM, Adrian Hunter wrote:
> On 27/02/2026 09:59, Matthew Schwartz wrote:
>> The GL9750 SD host controller has intermittent data corruption during
>> DMA write operations. The GM_BURST register's R_OSRC_Lmt field
>> (bits 17:16), which limits outstanding DMA read requests from system
>> memory, is not being cleared during initialization. The Windows driver
>> sets R_OSRC_Lmt to zero, limiting requests to the smallest unit.
>>
>> Clear R_OSRC_Lmt to match the Windows driver behavior. This eliminates
>> write corruption verified with f3write/f3read tests while maintaining
>> DMA performance.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: e51df6ce668a ("mmc: host: sdhci-pci: Add Genesys Logic GL975x support")
>> Closes: https://lore.kernel.org/linux-mmc/33d12807-5c72-41ce-8679-57aa11831fad@linux.dev/
>> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> 
> Ben wrote "So I think your patch setting R_OSRC_Lmt to zero is reasonable."
> Can be have a Reviewed-by tag also?

Wasn't sure about the etiquette of adding a Reviewed-by without an explicit tag in an email,
but happy to re-spin a v2 and add that if it's wanted.

> 
> Nevertheless:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
>> ---
>> Link to RFC: https://lore.kernel.org/all/20260117234800.931664-1-matthew.schwartz@linux.dev/
>> Changes from RFC -> v1: use the proper name for the register field 
>> ---
>>  drivers/mmc/host/sdhci-pci-gli.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
>> index b0f91cc9e40e4..7a7be3f7bee6b 100644
>> --- a/drivers/mmc/host/sdhci-pci-gli.c
>> +++ b/drivers/mmc/host/sdhci-pci-gli.c
>> @@ -26,6 +26,9 @@
>>  #define   GLI_9750_WT_EN_ON	    0x1
>>  #define   GLI_9750_WT_EN_OFF	    0x0
>>  
>> +#define SDHCI_GLI_9750_GM_BURST_SIZE		  0x510
>> +#define   SDHCI_GLI_9750_GM_BURST_SIZE_R_OSRC_LMT	    GENMASK(17, 16)
>> +
>>  #define SDHCI_GLI_9750_CFG2          0x848
>>  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
>>  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
>> @@ -629,6 +632,11 @@ static void gl9750_hw_setting(struct sdhci_host *host)
>>  
>>  	gl9750_wt_on(host);
>>  
>> +	/* clear R_OSRC_Lmt to avoid DMA write corruption */
>> +	value = sdhci_readl(host, SDHCI_GLI_9750_GM_BURST_SIZE);
>> +	value &= ~SDHCI_GLI_9750_GM_BURST_SIZE_R_OSRC_LMT;
>> +	sdhci_writel(host, value, SDHCI_GLI_9750_GM_BURST_SIZE);
>> +
>>  	value = sdhci_readl(host, SDHCI_GLI_9750_CFG2);
>>  	value &= ~SDHCI_GLI_9750_CFG2_L1DLY;
>>  	/* set ASPM L1 entry delay to 7.9us */
> 


