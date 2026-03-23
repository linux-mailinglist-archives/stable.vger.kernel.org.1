Return-Path: <stable+bounces-227893-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA9AOxTnwGl6OQQAu9opvQ
	(envelope-from <stable+bounces-227893-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:09:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DBD2ED4B5
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E77CE3005143
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 07:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A0635CBCB;
	Mon, 23 Mar 2026 07:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jgmIkJ4N"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAE929D26E;
	Mon, 23 Mar 2026 07:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774249742; cv=none; b=Jh/9/fvOjJwqhLy66woq3sa1x5bh8xnX3Vk30RLeXQZs0JGAMclGFbCpLizCxGC6MO449btfHzU5q8ufb+lChTW9gZIYigl5eqnA7eTMc/qsW7gmrdMoKG73duYPVwyE8D1VBdkyVDOU5pEvLsD2LvdNDA/C6ewcdNDxG51qEo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774249742; c=relaxed/simple;
	bh=2aeKNb9i2smVSQafruo5WGY9jKtH8Q0f3eHsj532Bak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSo5B9WFhUKShI7sMaYgKDOzTz/hoP+6GyPDcyGuESuwMO3zbcpRyNogP1x2wYpAeyycSdY2xbZL3JG5yFh3Cud33sliAJh8XY+zI13oHdnRzl/dmn2Zzfk7Js4nlgCpDEPprPBVgceL4VdxCGvvriiheZjSE9AsDhtSsl1F+0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jgmIkJ4N; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.94.160.76] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 11D1E20B710C;
	Mon, 23 Mar 2026 00:08:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 11D1E20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774249740;
	bh=VMWWABEFkMqr/ICkGOsyeM+f98qd7VD2QsTW3mQ2tkw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jgmIkJ4NST51MozLUu9n5J2CUDHUcJ+7j2E5UErL9ABMLBlG4IxPe1ZA7M2bhaWmT
	 kmFviR6a7PdWLg3Rzmgo6ZTV3rYtpYpaiB3XyAH5/quj++4iFiEJutC7DzGyL2dFmv
	 Qjx0g7vN15p5kCLhDdkrYqFGlDR26T7nB1k0eqlU=
Message-ID: <84ae7198-b755-4dde-b97c-978958d27b4b@linux.microsoft.com>
Date: Mon, 23 Mar 2026 12:38:57 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] EDAC/versalnet: Fix device_register() error handling
 in init_one_mc()
To: Borislav Petkov <bp@alien8.de>
Cc: shubhrajyoti.datta@amd.com, tony.luck@intel.com,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260322131107.1684647-1-ptsm@linux.microsoft.com>
 <20260322131145.1684744-1-ptsm@linux.microsoft.com>
 <20260322161052.GAacAUjFGWFwPle6c9@fat_crate.local>
Content-Language: en-US
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
In-Reply-To: <20260322161052.GAacAUjFGWFwPle6c9@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227893-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ptsm@linux.microsoft.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8DBD2ED4B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 22-03-2026 21:40, Borislav Petkov wrote:
> On Sun, Mar 22, 2026 at 06:11:45AM -0700, Prasanna Kumar T S M wrote:
>> When device_register() fails, it must be followed by put_device()
>> rather than kfree(), because device_register() calls
>> device_initialize() which sets up the device refcount. The matching
>> release function versal_edac_release() handles the actual kfree().
>>
>> Also reorder the dev allocation to after edac_mc_alloc() so the error
>> path no longer needs a separate err_dev_free label.
> 
> Nope.
> 
> edac_mc_alloc() is a lot more heavy-weight than a simple k*alloc(). Pls keep
> the ordering as it is.

Re-ordering this simplifies the error handling path. See below for details.

> 
>> Fixes: d5fe2fec6c40d ("EDAC: Add a driver for the AMD Versal NET DDR controller")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
>> ---
>>   drivers/edac/versalnet_edac.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
>> index acd51b492772..6463e88ed3d3 100644
>> --- a/drivers/edac/versalnet_edac.c
>> +++ b/drivers/edac/versalnet_edac.c
>> @@ -817,24 +817,26 @@ static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i
>>   	if (!name)
>>   		return rc;
>>   
>> -	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>> -	if (!dev)
>> -		goto err_name_free;
>> -
>>   	mci = edac_mc_alloc(i, ARRAY_SIZE(layers), layers, sizeof(struct mc_priv));
>>   	if (!mci) {
>>   		edac_printk(KERN_ERR, EDAC_MC, "Failed memory allocation for MC%d\n", i);
>> -		goto err_dev_free;
>> +		goto err_name_free;
>>   	}
>>   
>> +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>> +	if (!dev)
>> +		goto err_mc_free;
>> +
>>   	sprintf(name, "versal-net-ddrmc5-edac-%d", i);
>>   
>>   	dev->init_name = name;
>>   	dev->release = versal_edac_release;
>>   
>>   	rc = device_register(dev);
>> -	if (rc)
>> +	if (rc) {
>> +		put_device(dev);
> 
> Why here and not at the error label below?

After calling device_register(), put_device() has to be used 
irrespective of the return value. In this case, kfree(dev) will happen 
as a part of put_device().

If device_register() was not called, kfree(dev) has to be called to free 
the memory.

If kzalloc(dev) is done after edac_mc_alloc(), there is no need to 
decide between kfree(dev) or put_device(dev). This simplifies the error 
handling path. This is the reason behind re-ordering and keeping 
put_device(dev) under 'if (rc) { ... }'.

> 
>>   		goto err_mc_free;
>> +	}
>>   
>>   	mci->pdev = dev;
>>   	mc_init(mci, dev);
>> @@ -856,8 +858,6 @@ static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i
>>   	device_unregister(mci->pdev);
>>   err_mc_free:
>>   	edac_mc_free(mci);
>> -err_dev_free:
>> -	kfree(dev);
>>   err_name_free:
>>   	kfree(name);
>>   
>> -- 
>> 2.49.0
>>
> 

Do you think it is best to do edac_mc_alloc() before kzalloc(dev)?

Thanks,
Prasanna Kumar

