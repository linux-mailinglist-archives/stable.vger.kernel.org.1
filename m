Return-Path: <stable+bounces-127488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C62A79D70
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 09:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0E03B12AE
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 07:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0908624113A;
	Thu,  3 Apr 2025 07:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b="BqJHnuA7"
X-Original-To: stable@vger.kernel.org
Received: from smtpcmd11116.aruba.it (smtpcmd11116.aruba.it [62.149.156.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7731C5F13
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 07:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743666742; cv=none; b=Awqx5vkuLyH+4pBjLyjp/X0P5hHKKfxKGykGWueQtH+fSNHuI8KKIPEx/V4iE/EMEzZ7jnFu7o414ESwNjlDC8TOQ5wsz9FDfVjL+783gKIp1pjv8G6uwvIMzJU89RyYW5VsLTMPDorQ9C5WBRgbOxgtJORFlSFYcXnKl3pK2RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743666742; c=relaxed/simple;
	bh=7WkQ902+KCYS/p0UfE59EQX3GK8GAxuBezBGmDR/EAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EE9S75rqsFNNIQ6J26XchP1saPtzm0HkpuIXbcuddGDahtI3NexEIw+L2Gof/bVPAZPixFV5kze3M7U5rv5AfTDx94f21XpqwikviN3KTcH64rDHf1mjJsHvARP/VvaC8hk0W/ApYEHR1XnNEKbIAGrOAQi+sp5yo5pG6lnQL/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b=BqJHnuA7; arc=none smtp.client-ip=62.149.156.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.57] ([79.0.204.227])
	by Aruba SMTP with ESMTPSA
	id 0FJzuSeGotr9d0FJzu8HdI; Thu, 03 Apr 2025 09:49:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1743666547; bh=7WkQ902+KCYS/p0UfE59EQX3GK8GAxuBezBGmDR/EAY=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=BqJHnuA7444KMjubVUqYpX9sHcg8hpddR5EO8zdlepOTWWF+gOmJwZHZKV/ZjLcfi
	 AShhpDtyUGb1vQVvgApT4lSupdDDoExEhB06K5tHlb0svlYvqfom3BGg+X+DFw0+sF
	 aUjiEgS99ZNL0QDziAjD1n92kx+jPNtO6AmBkHB+/rNBXsSH6MW00lcnqSjVrV/37+
	 64/bjTRcxgIGG5cW31+eFppCFXRu4c8tGTJBNkR3AQZx6/yjtgFMH0vD8/HzgqugjL
	 3TnpJJJukGhQn3vdEUkkLb20rkpieFAErPruFX3See1ve89VfghCCo+e504teTwSNE
	 7EMtMNbu1iL0Q==
Message-ID: <636c5ad9-25ad-44f7-9454-a7787de7a6aa@enneenne.com>
Date: Thu, 3 Apr 2025 09:49:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pps: fix poll support
Content-Language: en-US
To: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <0231dfc22dd34a5aaee09a6a19074de1@diehl.com>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <0231dfc22dd34a5aaee09a6a19074de1@diehl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHbkBv7pm3c1jDM4YSW1irVeFNQIfkTfP2aPCtOV7mxrFv9WPHTyKT8HvX83RNFMHyGcXnhHwV3EMk5qWnHEQOG7OKXpELlofHGp9qLwO/iyUsxzTZ85
 2A3DAozxNdQyhM7N3kBXg0XmlK7hWKxCzSn/7p/C58sSOgHpqGz6Pf4E3JHWVNksXQQZoNJw9yuUoweZtfG9AsUfcdcBtcM/qvAV3Zo1npT/v0A7plJ8G8NT
 ew/PNAePSE/18uc2v0lbtGat8Aaeh7QEUEgfKfds74w=

On 03/04/25 08:06, Denis OSTERLAND-HEIM wrote:
> Hi Rodolfo,
> 
> Do you think that there is a chance that this patch make it in the current merge window?

Honestly, I don't know, it's up to Greg or Andrew to proceed for inclusion.

Ciao,

Rodolfo

> -----Original Message-----
> From: Rodolfo Giometti <giometti@enneenne.com>
> Sent: Monday, March 3, 2025 12:54 PM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org; Denis OSTERLAND-HEIM <denis.osterland@diehl.com>; stable@vger.kernel.org
> Subject: [EXT] Re: [PATCH] pps: fix poll support
> 
> [EXTERNAL EMAIL]
>   
> 
> On 03/03/25 09:02, Denis OSTERLAND-HEIM wrote:
>> [BUG]
>> A user space program that calls select/poll get always an immediate data
>> ready-to-read response. As a result the intended use to wait until next
>> data becomes ready does not work.
>>
>> User space snippet:
>>
>>       struct pollfd pollfd = {
>>         .fd = open("/dev/pps0", O_RDONLY),
>>         .events = POLLIN|POLLERR,
>>         .revents = 0 };
>>       while(1) {
>>         poll(&pollfd, 1, 2000/*ms*/); // returns immediate, but should wait
>>         if(revents & EPOLLIN) { // always true
>>           struct pps_fdata fdata;
>>           memset(&fdata, 0, sizeof(memdata));
>>           ioctl(PPS_FETCH, &fdata); // currently fetches data at max speed
>>         }
>>       }
>>
>> [CAUSE]
>> pps_cdev_poll() returns unconditionally EPOLLIN.
>>
>> [FIX]
>> Remember the last fetch event counter and compare this value in
>> pps_cdev_poll() with most recent event counter
>> and return 0 if they are equal.
>>
>> Signed-off-by: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
>> Co-developed-by: Rodolfo Giometti <giometti@enneenne.com>
>> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
> 
> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
> 
> If needed. :)
> 
>> Fixes: eae9d2ba0cfc ("LinuxPPS: core support")
>> CC: stable@vger.linux.org # 5.4+
>> ---
>>    drivers/pps/pps.c          | 11 +++++++++--
>>    include/linux/pps_kernel.h |  1 +
>>    2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
>> index 6a02245ea35f..9463232af8d2 100644
>> --- a/drivers/pps/pps.c
>> +++ b/drivers/pps/pps.c
>> @@ -41,6 +41,9 @@ static __poll_t pps_cdev_poll(struct file *file, poll_table *wait)
>>    
>>    	poll_wait(file, &pps->queue, wait);
>>    
>> +	if (pps->last_fetched_ev == pps->last_ev)
>> +		return 0;
>> +
>>    	return EPOLLIN | EPOLLRDNORM;
>>    }
>>    
>> @@ -186,9 +189,11 @@ static long pps_cdev_ioctl(struct file *file,
>>    		if (err)
>>    			return err;
>>    
>> -		/* Return the fetched timestamp */
>> +		/* Return the fetched timestamp and save last fetched event  */
>>    		spin_lock_irq(&pps->lock);
>>    
>> +		pps->last_fetched_ev = pps->last_ev;
>> +
>>    		fdata.info.assert_sequence = pps->assert_sequence;
>>    		fdata.info.clear_sequence = pps->clear_sequence;
>>    		fdata.info.assert_tu = pps->assert_tu;
>> @@ -272,9 +277,11 @@ static long pps_cdev_compat_ioctl(struct file *file,
>>    		if (err)
>>    			return err;
>>    
>> -		/* Return the fetched timestamp */
>> +		/* Return the fetched timestamp and save last fetched event  */
>>    		spin_lock_irq(&pps->lock);
>>    
>> +		pps->last_fetched_ev = pps->last_ev;
>> +
>>    		compat.info.assert_sequence = pps->assert_sequence;
>>    		compat.info.clear_sequence = pps->clear_sequence;
>>    		compat.info.current_mode = pps->current_mode;
>> diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
>> index c7abce28ed29..aab0aebb529e 100644
>> --- a/include/linux/pps_kernel.h
>> +++ b/include/linux/pps_kernel.h
>> @@ -52,6 +52,7 @@ struct pps_device {
>>    	int current_mode;			/* PPS mode at event time */
>>    
>>    	unsigned int last_ev;			/* last PPS event id */
>> +	unsigned int last_fetched_ev;		/* last fetched PPS event id */
>>    	wait_queue_head_t queue;		/* PPS event queue */
>>    
>>    	unsigned int id;			/* PPS source unique ID */
> 

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


