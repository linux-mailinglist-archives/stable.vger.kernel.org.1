Return-Path: <stable+bounces-203030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC4CCCD93F
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 21:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76E76302C5DA
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 20:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51B6352947;
	Thu, 18 Dec 2025 20:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="26V+nrVJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF34352954
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 20:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090703; cv=none; b=msBCwu/BtPRWRlgsBKlOUWC9uUkA3OdiaMP+YN6X5YtM2ucYJ9J8sMKbJghpStu9XxrPU4Qiiqpn4zjIn0zxhFqcL7IqJDfDRVbE+s6B9GmQJdIQ1IA440cAEvdTLulQczDLWGvnvOtWDD75UXv9Dzojr1ZX1hlbrXY3y5NZOps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090703; c=relaxed/simple;
	bh=hxdyEoRAt3GAfwhKgxiNv1wl7oVIYwsDbSGze+lKbBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZKmELsyDT4p9ZUgZvJk9IRpNWFnSmh/cAuXEndFhAtZ/eL0ndU5Ep+N6pi9bmtVaNNYk88HPU6HO5pap2nercm68P9mxRRw3eF0iNob/n4hf7uZaSvfogYMO0QOs7EbVtSB0vZK4pf+SlHHymQ3YXuyH0tygNAE+yVGn3VX2ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=26V+nrVJ; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7c6d3676455so469929a34.2
        for <stable@vger.kernel.org>; Thu, 18 Dec 2025 12:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766090699; x=1766695499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fBCUu4u/Yok2HpILA3UQoQtwdHQIiMmu2UId7ekcYW8=;
        b=26V+nrVJxiP+w/zAw1caldDWE03MKBpMk6JZP6PyBspw5zyQagLSfK48DHZaAex2Ro
         HlfjYsBUK+E10MwhEM1KQ6Qv6/zWzxLqEmU8jM8d4smefiQzD8s9iF1oJzIBuRI88MiD
         qZUrYWBgE8WaJV7TVlYS+yGPtKf4ooNMJaNzeAxLpLIvvHxANKUojSeH5JbPnS4hM+qV
         kt+RI2zg+ocGo5sKRsOUtNUdUwatBKCyK8qaQnXEeN11E4V+CcbErbbrJqOs8ZIom9CO
         9RVgWapbeRLZ87SnIChGNWJT2w+p+R+gJDpXkyDBgE4N5cm0UIgrmPuQSKrafsrqiWs4
         E3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766090699; x=1766695499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fBCUu4u/Yok2HpILA3UQoQtwdHQIiMmu2UId7ekcYW8=;
        b=tIT7rT/eLlSMcj9HnUrgxfYyfrS6pQuiHy682I/iYOXPHs4qNLh/bN8OQ0FWvlsZ99
         G1NHGCF/CosJtsK/A4Hzl5tsT1wPQDHhBHIP7fZn+7+MPr5t1tBUtMAfPx8C8yw97T1d
         S7DCa5CzjVYWm0l3/5hp0xgtbdvd0OFv69NbyD6pLlexnB1ab6FbstBF00IwCRPDFf1D
         BnlfZgKtxYiq+vhUIFDeEXm3gurfxTJYek9Pgm2yyjkh2rCMUV4AnNvUwpF+8EMvAp7a
         C7cn+aPFou7aO/jJG1vEZC6Z8KjPMUd/YFjuWMNdQsWPkbVSnPEEw9t82WxCIypqXvhs
         uw+A==
X-Forwarded-Encrypted: i=1; AJvYcCV13JDouIA8oYm/8bHxpdL2oRv63sHMqXrj2G9pmBCLU90x76azRJ2ZlF3+wxGYAf6Dd0rl67w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywpb3V8Gw8/izhTG3Ikro/23HNgwA8s0XRVs73/fWMM/DaHV15
	Wy4/GqCsQoy7/1umTJgFOwUPxUJdvr6ryxmJy365ZQd3uLFdLlVRjrIy6xPArFR8Wrw=
X-Gm-Gg: AY/fxX5xVBp4NV9sRKmTQYeXp+pJQUE6cSlAGSzBKzsLT0/sCsX5W5D/E5HBXL03jXf
	5jtsLQAiyiZ+tqJj3uyXlWAAZdzK7sHM0/f50dh4mcbhxmIdVQvLz2OZ751dJaQg97MW2gbECOS
	R4BfM0edXOafzqDdBxkLDwgVdHGMWoaNX93gl9XjfTsFB/IJ7yfgAd7StR70Jmy6yZHxciXpO7k
	mVkNnZOvAuOxXq3eb0khXFC6m3H9kUwfCRIoaeMT3DYZpIMpoTBAA+RXZSX3ErwuXuUoU4+Auy+
	LR92snErRymDlY+NiZ8i6MgKfgUPzAb081N5cWie8D0oXGgI/VMeIyVTHrheg0rtPaHLvvofmB7
	SyrjtD0mFLs2pzbYTOBD36p8SLuBa6RnJB7lEUccsNyy2+peeMMLqmxuUox9wXjOzgECIao5J3f
	+o1EklDAi5
X-Google-Smtp-Source: AGHT+IFawL3v6fvfLFMk3e/U9FU/svP0NWIIO/mFK6ctWIhTbkl//sTKeQF17gtp45rMIWiu0Tz81g==
X-Received: by 2002:a05:6830:6609:b0:7c7:69c8:2ce with SMTP id 46e09a7af769-7cc66a12323mr274721a34.27.1766090699664;
        Thu, 18 Dec 2025 12:44:59 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc6673bdabsm327468a34.10.2025.12.18.12.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 12:44:59 -0800 (PST)
Message-ID: <2ed38b2d-6f87-4878-b988-450cd95f8679@kernel.dk>
Date: Thu, 18 Dec 2025 13:44:57 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] af_unix: don't post cmsg for SO_INQ unless explicitly
 asked for
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: io-uring@vger.kernel.org, kuba@kernel.org, kuniyu@google.com,
 willemb@google.com, stable@vger.kernel.org, Julian Orth <ju.orth@gmail.com>
References: <20251218150114.250048-1-axboe@kernel.dk>
 <20251218150114.250048-2-axboe@kernel.dk>
 <willemdebruijn.kernel.2e22e5d8453bd@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <willemdebruijn.kernel.2e22e5d8453bd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/25 1:35 PM, Willem de Bruijn wrote:
> Jens Axboe wrote:
>> A previous commit added SO_INQ support for AF_UNIX (SOCK_STREAM), but
>> it posts a SCM_INQ cmsg even if just msg->msg_get_inq is set. This is
>> incorrect, as ->msg_get_inq is just the caller asking for the remainder
>> to be passed back in msg->msg_inq, it has nothing to do with cmsg. The
>> original commit states that this is done to make sockets
>> io_uring-friendly", but it's actually incorrect as io_uring doesn't
>> use cmsg headers internally at all, and it's actively wrong as this
>> means that cmsg's are always posted if someone does recvmsg via
>> io_uring.
>>
>> Fix that up by only posting cmsg if u->recvmsg_inq is set.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: df30285b3670 ("af_unix: Introduce SO_INQ.")
>> Reported-by: Julian Orth <ju.orth@gmail.com>
>> Link: https://github.com/axboe/liburing/issues/1509
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  net/unix/af_unix.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>> index 55cdebfa0da0..110d716087b5 100644
>> --- a/net/unix/af_unix.c
>> +++ b/net/unix/af_unix.c
>> @@ -3086,12 +3086,16 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>>  
>>  	mutex_unlock(&u->iolock);
>>  	if (msg) {
>> +		bool do_cmsg;
>> +
>>  		scm_recv_unix(sock, msg, &scm, flags);
>>  
>> -		if (READ_ONCE(u->recvmsg_inq) || msg->msg_get_inq) {
>> +		do_cmsg = READ_ONCE(u->recvmsg_inq);
>> +		if (do_cmsg || msg->msg_get_inq) {
>>  			msg->msg_inq = READ_ONCE(u->inq_len);
>> -			put_cmsg(msg, SOL_SOCKET, SCM_INQ,
>> -				 sizeof(msg->msg_inq), &msg->msg_inq);
>> +			if (do_cmsg)
>> +				put_cmsg(msg, SOL_SOCKET, SCM_INQ,
>> +					 sizeof(msg->msg_inq), &msg->msg_inq);
> 
> Is it intentional that msg_inq is set also if msg_get_inq is not set,
> but do_cmsg is?

It doesn't really matter, what matters is the actual cmsg posting be
guarded. The msg_inq should only be used for a successful return anyway,
I think we're better off reading it unconditionally than having multiple
branches.

Not really important, if you prefer to keep them consistent, that's fine
with me too.

> 
> It just seems a bit surprising behavior.
> 
> That is an entangling of two separate things.
> - msg_get_inq sets msg_inq, and
> - cmsg_flags & TCP_CMSG_INQ inserts TCP_CM_INQ cmsg
> 
> The original TCP patch also entangles them, but in another way.
> The cmsg is written only if msg_get_inq is requested.

The cmsg is written iff TCP_CMSG_INQ is set, not if ->msg_get_inq is the
only thing set. That part is important.

But yes, both need the data left.

-- 
Jens Axboe

