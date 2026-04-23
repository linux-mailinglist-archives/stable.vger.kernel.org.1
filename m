Return-Path: <stable+bounces-240495-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJx3IfYh6mnKuwIAu9opvQ
	(envelope-from <stable+bounces-240495-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 15:43:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C5F4532E5
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 15:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FAE6303F293
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89942C11E4;
	Thu, 23 Apr 2026 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="tLbrkzTe"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753062C21F0
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951664; cv=none; b=pWiIZlCMHFXkPK3PvgWEN7cLiwmdgE1v8k+wRkFYLtG/owlMQ2fCyIcFW7TSovPd5o5hTyxyHHaorgt03t86qdk5td2mkQkYVBg9wj3i90Q4w+8BE+w0xKNDAV5WLJnmoTi0ZIwUxqKaEvJooWLRmz8uMRb/ONH34JuaBbdzd88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951664; c=relaxed/simple;
	bh=KHbkGPjyeLB4Om2TsdTE+d/BBxJhMzMDgtS9P09hd8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtT1IuIvrmEhYgLY1ViyheO7pflpukGFRC+U5i0LFhRZLmzuIdH6v70wPJx+HNcWfraMYueXy5pEOApniAt8wQ6xwbt8NXPYaIXZP5/KCzgc799TzJ5ocvs4o532VyGxAdcei/ChkvUMbJds3+YwL/dCYoON5p46kUSeWCbGiGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=tLbrkzTe; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-42321c8b8f5so5484580fac.1
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 06:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1776951661; x=1777556461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ioJ5CdUnXoI+VkUi/GtIzycQxY2QvCDY2phJmyrZvY=;
        b=tLbrkzTe7hB9BAKuvqcvzpJzZV0uHq/lK3QnWRoJhrAwCGbItqN2gC60XE3U3MLK2T
         EBBTnlSrKZcevM1uzi3KHeBXCC3VXDuUl3T6prHyVesa4f3C2DVef+lyyqNZtOIF+RWS
         ha7b79y9Eu7NOQWAnQwiIOp7iHoXKmb83yFrPQHnEOJPzxm83SJQhN+w9nzmJwpv4ZF7
         aNdHZTv3QMng9lW3Jte0uEUk1foyBtby3fcqmPHCMAgG774aNjdpeASo/2iHHvbRBlaA
         6ogx13y+xAq4ocq7mUZRzStalk/4Ogw8765o33ItPBnvZ06eyqFPK9TEa67Si8icVIeh
         ifow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776951661; x=1777556461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ioJ5CdUnXoI+VkUi/GtIzycQxY2QvCDY2phJmyrZvY=;
        b=H1xfqsPpbM3zD8drxn0xEOlinoVPgMRm3LbtJ/2kkhdc35vXVORB8H5Cf4RmRBb7yT
         P8ywG2iDBBYd9j7TgS3bhYddH1xs5pRYNAHDsTnXPIFigVLD5RLTKVzVPcDgRwLP6OC7
         c7Dsdxg4UinxDyiUpIDlJ14Dy/NicqX2JS4UfzmDtqMXv3paPBMb0iKrKpB99Iq3taGz
         2xwYOOjbbj6LFGasODhsZsZujzAA0+WU1tKMBxsNtbED3Kyh3Clgdku4txVnulLWNB6I
         9b7vVKnrPTO9kIvjyePRjCj99N3PJlqGalSoNmPsmd1cotEBzHiPON5zdnXYDQEk1EU9
         +Qxw==
X-Forwarded-Encrypted: i=1; AFNElJ9yBitcEHZKEWnD0wWRHObDDlUbsOhpV+eiVbFaNJG4mbAW031B8Ocqy7z0f+xFT8JHAc/6Vww=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrHWY6/3quUsz223gxn2Due+/yxE5mmKGsQEsfzQgKex2lKNCI
	oRfP/VRBJF2SgYwWKtlr8f1l7L1Hm99FpJnzWjg90dqSXrGwJWYBBGWTIVTyXLaa9o0=
X-Gm-Gg: AeBDiev5STb6QBau8EqjNW41bN9KeNqnxJKz+o5NVlHxZAWJrfpUGerqAq0jfxelPoZ
	6v+sGfK54mFMPYIYZ8Y2ngpWAT8dSpP8iNNtUUgUW8L8EZTPY2UGkcr1+k85zKsmgcdYoxaFK18
	sY9lF4Modka3N+orZ5qZCsw88UozFFqjvPIHjuYEH0mrxfE3C3TaQgkkEJ0/T0vwk9SPhejhTC6
	xWHWBwRvNqQkeBvbAJXOWmvpdJMA8TyowPWqnjPr8mZCWVpKiw9FJymWSj9rQTYd3yN7O/7vYJl
	0YOt29i25m5ZUpim/H4if4nNz5KlgugzP4TKkfCUMftAr/+L7vntG+HePWGq+VlsBeAtXPoI+N2
	7MJG01qU6t3H0UzXTRG9WXrVKGLgXz7DaJQTfdz7haQuJhFH53+urh/Rrr+QXcfLUtHuEoEbHgz
	Gpn/jEv6msDswaDnW14R3LKUjLCq6phC4CQMC/WGOGsiQEsP+24cLUSjsgmw7X5I0o6+1azdJAm
	U9mEkRtkPUbc2hAqmI=
X-Received: by 2002:a05:6871:b24:b0:42d:8229:ba3d with SMTP id 586e51a60fabf-42d8229deb5mr6336961fac.11.1776951661410;
        Thu, 23 Apr 2026 06:41:01 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b934a2e8esm18586587fac.10.2026.04.23.06.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 06:41:00 -0700 (PDT)
Message-ID: <b68738dd-fcd3-4387-b5fc-ab3feb4d213a@kernel.dk>
Date: Thu, 23 Apr 2026 07:40:59 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 491/491] io_uring/poll: correctly handle
 io_poll_add() return value on update
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ben Hutchings <ben@decadent.org.uk>, stable@vger.kernel.org,
 patches@lists.linux.dev,
 syzbot+641eec6b7af1f62f2b99@syzkaller.appspotmail.com
References: <20260413155819.042779211@linuxfoundation.org>
 <20260413155837.438151458@linuxfoundation.org>
 <d4b85e905345dc69e9c660c7f51775703fa83320.camel@decadent.org.uk>
 <d7d521e7-35bb-463b-b1f5-552bb931bdff@kernel.dk>
 <3512c6ae-0b99-4c50-89ed-f1087a558a25@kernel.dk>
 <2026042354-doorstep-stray-0fe0@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026042354-doorstep-stray-0fe0@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-240495-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:server fail];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,641eec6b7af1f62f2b99];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5C5F4532E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/23/26 6:38 AM, Greg Kroah-Hartman wrote:
> On Tue, Apr 21, 2026 at 04:58:52PM -0600, Jens Axboe wrote:
>> On 4/21/26 4:18 PM, Jens Axboe wrote:
>>>>> @@ -6024,16 +6035,17 @@ static int io_poll_update(struct io_kioc
>>>>>  		if (req->poll_update.update_user_data)
>>>>>  			preq->user_data = req->poll_update.new_user_data;
>>>>>  
>>>>> -		ret2 = io_poll_add(preq, issue_flags);
>>>>> +		ret2 = __io_poll_add(preq, issue_flags);
>>>>>  		/* successfully updated, don't complete poll request */
>>>>>  		if (!ret2)
>>>>>  			goto out;
>>>>> +		preq->result = ret2;
>>>>> +
>>>>>  	}
>>>>> -	req_set_fail(preq);
>>>>> -	io_req_complete(preq, -ECANCELED);
>>>>> +	if (preq->result < 0)
>>>>> +		req_set_fail(preq);
>>>>> +	io_req_complete(preq, preq->result);
>>>>
>>>> If __io_poll_add() returned an events mask then it completed preq, but
>>>> then we also complete preq here.  Is that really correct?
>>>
>>> Let me take a closer look, I do agree with you that the final result
>>> does not look entirely correct.
>>
>> As far as I can tell, these two should be applied to 5.10 and 5.15
>> stable. The first one fixes an old backporting issue that I didn't
>> notice until doing some targeted testing just now. The second one should
>> take care of the issues that Ben spotted in the current backport.
> 
> Now applied.

Thanks!

-- 
Jens Axboe

