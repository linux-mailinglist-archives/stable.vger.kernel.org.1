Return-Path: <stable+bounces-189216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 25039C05304
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 10:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE340504BEF
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 08:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A8A306D49;
	Fri, 24 Oct 2025 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="E0g3wZpF"
X-Original-To: stable@vger.kernel.org
Received: from lankhorst.se (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DA1305E14;
	Fri, 24 Oct 2025 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295479; cv=none; b=bnB7OEtTiIpr3m1cyk7XnWRz5KOh6qLHIi/tVG1Xq7Uec3N06o1WVPWpgGlsWIRf3mvjBDO+adENZt0doqoGcpZtq73Qdr5FusQU94zBuMmU7Eg9OwU8l63gfbpWn3M3HsI3+YmWpQxSvOM1eg3Q6hpKkgM93nEE8HinP5nQnS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295479; c=relaxed/simple;
	bh=TUoJkCQkDuWU8g1Ir6nd4exbmwFF4ybBTtmmLb5+OXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xjmw5SFyYqqkseChjUBC7h/nrIZsJtKn6qdp5IV1oR900cq3X36HZxwpsB078oo4Y/VMqTpzccDDOhTD+lNQpjitQPhEPgl/Doo/2QMROXiV8GJqKYECEduKA2sIQTEVq0yS15NhAmTB16dvsxVXLTCoWZiBfDU2R+qm7epY0NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=E0g3wZpF; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1761295055;
	bh=TUoJkCQkDuWU8g1Ir6nd4exbmwFF4ybBTtmmLb5+OXk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E0g3wZpFujOkzCt9XWuqS/dzfQB6Fja1x8+i2AzXY4LGFuYLe6PQ+BZfCio3HybKt
	 Qn50n+s4ottnTd1eAQ+iMmkqoPzUfSBml+rZ/8z4G9ZXzVusfjg5cjHj5zykcOuKub
	 TO1+O9m24UIsz4XOs/soybNOX/NRCXMFoj1IOzVv/topEbo8ZQPH63/cFNvAoeNCgk
	 vMnC+TkVvxkgM7nV9TJpAZtgCTB97+QPoTU+2uZJXyGrPY3Zvaq2tGm/waZlYF1fKe
	 LlWVYqXhqK/h7g86F2JxVWWnUbSfo0xvua6P/xqeyVP7EwOiqPajMJKcQTTa+P90jZ
	 Qhc5XtqfsfCmQ==
Message-ID: <c4bd0ddb-4104-4074-b04a-27577afeaa46@lankhorst.se>
Date: Fri, 24 Oct 2025 10:37:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] devcoredump: Fix circular locking dependency with
 devcd->mutex.
To: Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org
Cc: intel-xe@lists.freedesktop.org, Mukesh Ojha <quic_mojha@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 stable@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>
References: <20250723142416.1020423-1-dev@lankhorst.se>
 <e683355a9a9f700d98ae0a057063a975bb11fadc.camel@sipsolutions.net>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <e683355a9a9f700d98ae0a057063a975bb11fadc.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hey,

Den 2025-10-24 kl. 10:12, skrev Johannes Berg:
> On Wed, 2025-07-23 at 16:24 +0200, Maarten Lankhorst wrote:
>>
>> +static void __devcd_del(struct devcd_entry *devcd)
>> +{
>> +	devcd->deleted = true;
>> +	device_del(&devcd->devcd_dev);
>> +	put_device(&devcd->devcd_dev);
>> +}
>> +
>>  static void devcd_del(struct work_struct *wk)
>>  {
>>  	struct devcd_entry *devcd;
>> +	bool init_completed;
>>  
>>  	devcd = container_of(wk, struct devcd_entry, del_wk.work);
>>  
>> -	device_del(&devcd->devcd_dev);
>> -	put_device(&devcd->devcd_dev);
>> +	/* devcd->mutex serializes against dev_coredumpm_timeout */
>> +	mutex_lock(&devcd->mutex);
>> +	init_completed = devcd->init_completed;
>> +	mutex_unlock(&devcd->mutex);
>> +
>> +	if (init_completed)
>> +		__devcd_del(devcd);
> 
> I'm not sure I understand this completely right now. I think you pull
> this out of the mutex because otherwise the unlock could/would be UAF,
> right?
> 
> But also we have this:
> 
>> @@ -151,11 +160,21 @@ static int devcd_free(struct device *dev, void *data)
>>  {
>>  	struct devcd_entry *devcd = dev_to_devcd(dev);
>>  
>> +	/*
>> +	 * To prevent a race with devcd_data_write(), disable work and
>> +	 * complete manually instead.
>> +	 *
>> +	 * We cannot rely on the return value of
>> +	 * disable_delayed_work_sync() here, because it might be in the
>> +	 * middle of a cancel_delayed_work + schedule_delayed_work pair.
>> +	 *
>> +	 * devcd->mutex here guards against multiple parallel invocations
>> +	 * of devcd_free().
>> +	 */
>> +	disable_delayed_work_sync(&devcd->del_wk);
>>  	mutex_lock(&devcd->mutex);
>> -	if (!devcd->delete_work)
>> -		devcd->delete_work = true;
>> -
>> -	flush_delayed_work(&devcd->del_wk);
>> +	if (!devcd->deleted)
>> +		__devcd_del(devcd);
>>  	mutex_unlock(&devcd->mutex);
> 
> ^^^^
> 
> Which I _think_ is probably OK because devcd_free is only called with an
> extra reference held (for each/find device.)
> 
> But ... doesn't that then still have unbalanced calls to __devcd_del()
> and thus device_del()/put_device()?
> 
> CPU 0				CPU 1
> 
> dev_coredump_put()		devcd_del()
>  -> devcd_free()
>    -> locked
>      -> !deleted
>      -> __devcd_del()
> 				-> __devcd_del()
> 
> no?
> 
> johannes


Yeah don't you love the races in the design? All intricate and subtle.

In this case it's handled by disable_delayed_work_sync(),
which waits for devcd_del() to be completed. devcd_del is called from the workqueue,
and the first step devcd_free does is calling disable_delayed_work_sync, which means
devcd_del() either fully completed or was not run at all.

Best regards,
~Maarten

