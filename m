Return-Path: <stable+bounces-240480-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHaCDmkR6mn4sgIAu9opvQ
	(envelope-from <stable+bounces-240480-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 14:32:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 360DE45200F
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 14:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4255A307BCA0
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 12:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F6A3C140E;
	Thu, 23 Apr 2026 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Hpz9y2JW"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1643EAC75
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 12:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776947408; cv=none; b=OUexprz0lk56gWKRvdFiULKtDbAJPsd/3vqgnt4hNEiZl4XBG7gv9STgqIJoQUiswdhUP4KHAz10Whrss34MjLwbucJYAbC2qikeUyByu2HYOO459pL7Qd/FIKQhBoPbfJxrv9Qnm9ztDdGcpwDL4RDsYwAhpSfq8D0EqUn/Wmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776947408; c=relaxed/simple;
	bh=zV7btV5r7l9s7hFfEdSOZMG4OSyzdzPILuSoeB73x1I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DuTUqAJ9C5i5UbTpMufaBXeJ/7TdAu0KXaqsG+cmDPIAXgVaitWlAK9ZoBNY8Wdr/iuEXJB+0NKWFFKXYf/Eg3Akzhz/Nb/210ZE+BiGXgFTUB0qF/fX1oCgHz3uPh9y9wATV44H3dAzKDcdA/ymrA7elcq4o6Lk6rpNRhioDWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Hpz9y2JW; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-42fbf95cca8so1560485fac.0
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 05:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1776947404; x=1777552204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZFm8MWUWzpEnhSEAqMMM8fUMsiyBT5avBx5Nu2gHmcA=;
        b=Hpz9y2JWiE1Qp/LmcwjM9nZICmfZ/w+qtWCkQQYTG4Ur85KbBdsXnWToE3nApMtpY4
         JFKNKkz3M7rJz+DcCUEsCasiQ14QnML3/Af6FHbGGy3z5heBnwGaFsm3KhHq6cf31YUM
         pJYJduar/52XlDE8UA/mAPKcAw8Uu2KpRYto+0SMLoQRQUZvfqrbd1/Ivop6D91ufMa3
         JpPPK4eatcnXqDlQdrRSf9ZT3UB/Vq8XTyLQdg+ZDL0elG3UvP2glmhbYN2a4McHiiKO
         tbcmgVTE/P1KYR4M7B5fyLMJrtEGFAz4dSmxpOr4LQ4cqWhxVnFWRCnE5eCOtfP25lKk
         CPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776947404; x=1777552204;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFm8MWUWzpEnhSEAqMMM8fUMsiyBT5avBx5Nu2gHmcA=;
        b=CR5Y+XgAGzPTKikqsddHBi5BweScpc3NCz24nmgMtOplcqveNcsYU06ArTo688lfU8
         WuZ1qlTvDwazeAvcUsdO6eXHOgQLjjwJVzKpR/VF54uLuX/vZ7Mep39Hy+QUvoznHzkn
         aPqNhtOrxmycKWDK8JBhL+5aLDiq32BsFTq0nMqYrizEvARxkAwwlHgI5WmntKo6Qcqa
         5fv3YoCdLFgWUGchT9zLMbEY9A8nHtgzFdwX3dxHzeInoophbFlEgob6H1uJgP/cq5gy
         J8V2HrR0gOyMxbOIDRpCPfBEl9LyTSRjocFYTuTRDNaS7vbDB6jBGVJQ7qKkr93SzXpI
         mGDA==
X-Forwarded-Encrypted: i=1; AFNElJ+fymsQTmmXBN5cejwhaM9db/X/1OJZj1Z6/OBrp4QU06TOcGs12b7YPG+py3EOWLknxmw/+yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWTRLWluN3YEnWQ+XAXFKQu3/3AFs6I9gnkNiNUvsuohnCnXok
	ycJCWUBPoOF1Ro3G9HVYaHKv8ioBYljiKPgBDhlLUj/YPT6kWjyLYgCW2CCRCeI3FM45BzLtF7p
	zPBdDhEw=
X-Gm-Gg: AeBDieuJMQ1k55CTTmRFUs2/YFxdf0Qfj/JictKII6bSlKJZcStTcv4CwWWDrnqPcCr
	ateiFmTvDY6QDLTqneK4P5OAfPf+kc6r9Lu99WrlFgV+g40UjtFkiu9lymjStOALUaoSGRIWKAw
	qRGVxflgjilTdGtmZjPK9p3TMA8Yt0ea5vi84zw3/iX4PEiVPsuNHIFkH9k74Krg6FTuv5imgx4
	mUOzISdsVxlaAu9i7Un5NGsg63bSMBMFDR5qaI0kIu81Z1JgpB4pa6RVhSiKWw0GFetU6/adyw6
	b7HE4cZwhSgaTVxrwe5W1X3RF221Fb3pp04w/YGZ38a0Pw5PWAtKmEUEECE3GkN4dqhPe1olJp8
	SHVBxNlUjk0WAWsANP/a8wv2U06HImoHd2/OqU6rFUwtUuN4KGZ3klCEN7CEQxcL290J1LhNK91
	pQkL29IAlayVaP122j8sDVL8XwWC6ii/Tw0UppBl/HWrRxYpbyDIdTLsytvmQvfwGd+bEIJX48Q
	C8Htg+j6OdlU1OLUOPX
X-Received: by 2002:a05:6870:9d88:b0:409:76e0:bd84 with SMTP id 586e51a60fabf-42aded0b29emr17008673fac.24.1776947404452;
        Thu, 23 Apr 2026 05:30:04 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42c05ca16e2sm9943048fac.15.2026.04.23.05.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 05:30:03 -0700 (PDT)
Message-ID: <97121442-388e-454c-9a85-85e4dd66cc19@kernel.dk>
Date: Thu, 23 Apr 2026 06:30:02 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 491/491] io_uring/poll: correctly handle
 io_poll_add() return value on update
From: Jens Axboe <axboe@kernel.dk>
To: Ben Hutchings <ben@decadent.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev,
 syzbot+641eec6b7af1f62f2b99@syzkaller.appspotmail.com
References: <20260413155819.042779211@linuxfoundation.org>
 <20260413155837.438151458@linuxfoundation.org>
 <d4b85e905345dc69e9c660c7f51775703fa83320.camel@decadent.org.uk>
 <d7d521e7-35bb-463b-b1f5-552bb931bdff@kernel.dk>
 <3512c6ae-0b99-4c50-89ed-f1087a558a25@kernel.dk>
Content-Language: en-US
In-Reply-To: <3512c6ae-0b99-4c50-89ed-f1087a558a25@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240480-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,641eec6b7af1f62f2b99];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 360DE45200F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/21/26 4:58 PM, Jens Axboe wrote:
> On 4/21/26 4:18 PM, Jens Axboe wrote:
>>>> @@ -6024,16 +6035,17 @@ static int io_poll_update(struct io_kioc
>>>>  		if (req->poll_update.update_user_data)
>>>>  			preq->user_data = req->poll_update.new_user_data;
>>>>  
>>>> -		ret2 = io_poll_add(preq, issue_flags);
>>>> +		ret2 = __io_poll_add(preq, issue_flags);
>>>>  		/* successfully updated, don't complete poll request */
>>>>  		if (!ret2)
>>>>  			goto out;
>>>> +		preq->result = ret2;
>>>> +
>>>>  	}
>>>> -	req_set_fail(preq);
>>>> -	io_req_complete(preq, -ECANCELED);
>>>> +	if (preq->result < 0)
>>>> +		req_set_fail(preq);
>>>> +	io_req_complete(preq, preq->result);
>>>
>>> If __io_poll_add() returned an events mask then it completed preq, but
>>> then we also complete preq here.  Is that really correct?
>>
>> Let me take a closer look, I do agree with you that the final result
>> does not look entirely correct.
> 
> As far as I can tell, these two should be applied to 5.10 and 5.15
> stable. The first one fixes an old backporting issue that I didn't
> notice until doing some targeted testing just now. The second one should
> take care of the issues that Ben spotted in the current backport.
> 
> Will be nice when 5.x is finally taken out behind the barn :-)

Greg, you adding these 2 for 5.10/5.15?

-- 
Jens Axboe


