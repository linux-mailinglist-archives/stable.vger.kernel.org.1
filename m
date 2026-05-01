Return-Path: <stable+bounces-242539-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IA89AkYk9WnbIwIAu9opvQ
	(envelope-from <stable+bounces-242539-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 00:08:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7F54AFEBB
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 00:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21564300F9F7
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 22:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2C0329C54;
	Fri,  1 May 2026 22:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="QHjoFNEg"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E483733F5A8
	for <stable@vger.kernel.org>; Fri,  1 May 2026 22:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777673277; cv=none; b=CFM96SkCcKQb0UGm167Jq/ZVltoAFTrAj0P5gjX9Cqsi4Jue7Rhrn0fqyI5LBksvdZaw9BwZ8L9Ghn70h7qiDu2PUTPn5rp0tXqEhdTvkmbdczDRmnZrZOvKpOoAcK4Vexv3KxTpiSlGy1qMe9Z7SWXTBuE8c84eMCw52n73DAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777673277; c=relaxed/simple;
	bh=xS5gDR7pcU0pT6VL9LZrzj3cYVFPxoupzfxgBNsa1/g=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=FqlsHdn8X4hr96ECNBX1VPiBp6j5Pvf9gU48BHK+h9b5NH0+cYgiLmzXoXT0TGjltpSZgHzV+RhqRTUv4haYzdbk5RiWwGF+IhJu0a0ABNP9jvoX2C3liluJQ4k7yYozzUGFe1A0vuwdYW6d8Q9HgW/wYDeHjRffD+B9Wo//75E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=QHjoFNEg; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-47c6f914617so756971b6e.1
        for <stable@vger.kernel.org>; Fri, 01 May 2026 15:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777673273; x=1778278073; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTBJI5sNzjAKNKqgiLLQMozhodV6qu5Rb8tmUHBewUA=;
        b=QHjoFNEgke0KQUpWaPUjUcHrFkZM1aNAQeXVz6k+b3P7ofUJDvQjtgDo4K/uKWfP/k
         JENkmVCCu3kh0AOJqlkOKjDvhnOqxBNDvZXy/zWQwCM2IwU5KVPPtWER3skkKcQHEpGS
         bNZe80Ml8KeP/AQQxGKWegYCE9LQRPULDESdEa3Pi054h8hnq3Bb2h4Dbf918Z0Q5lOg
         3SF42KGMItV8ThwbSvnXhNhsa2BrZSyUfP9axwshc5BSv5nAusSoVb5CO1aV59E0DI8Z
         AGuq1La8+cAS58P1irx3O67xlGKuQgtfQSLZt+stZtIvVUeJEFTlodPzBB4wxXSFdr/z
         s+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777673273; x=1778278073;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KTBJI5sNzjAKNKqgiLLQMozhodV6qu5Rb8tmUHBewUA=;
        b=RZYYy1q8tnY5yqonZ0SyIYJqD+5YLlTJYNi36cNMNkA1vVE7vEr0wTT1pQs+SjCOr4
         VM/Hdz0xF2Ef9/O5FMy1mQuaH2vO5Nh1NoZc+qjKAYuQhJ7SuXoLMhV466zzgcP4MBUF
         zP/OPyBAg1jEaIIxr6cOZhVWfvvj/5ryw+jApRFgqFyxjMjZPeAxZZz81GaU9GNw+5mf
         TVduF90gd4T4xsmxLcw20Za4mUnYHfBWzBNIoybDSFTqhehO+2ggl7Q9u/XbqfPzl6Be
         7v96HgtM8CXAkkfsg75HrWUv27dGFOu/IS4VV1D/1gb7GQU/MbbY4hyiBS+VXLq6mdCV
         HLPg==
X-Forwarded-Encrypted: i=1; AFNElJ/daq6u6swAiJA+nlsRtxwqesS0pUiTl+6jU4vPFAdxTJI+Xq1xhbFAyvjX0z87SCqPkvqaEzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu8jF9iwgKZNzGHKGOKZ1Qanv1CWa9HLv5cpkVxFXqQqQIKYDr
	ntYWwH60CVU2c4JTCP5aubWYRm5jilNFsNB1b72ap0FhOvvOQOquf0shdPt4rZ/bAkY=
X-Gm-Gg: AeBDieseLuC1E+ygqL8be9iTPgHUQ0aw1SU7nSY23F7Oif9UekS7y2dLRi28UKVWsx2
	0lJmvHdFmNqeWMbFCMqyq2d3HKBHaRSSjUBLuaz37RS5JAS1TeRbvwVxLO8k5Vfm/Pgz6GjzBLl
	0EYzuSoK70OZ8KVeiWMK65cCgWEWOlCVIRpt1JTc8VO5zTDClhx2fRidYW4sFqiXH5368jLBCGz
	xD+8ZAHPWVtxcdThEH98t38+anodafTKdC512aZ2s5ZWQbtANglHBxUCUPmc+fXlvlLS3rmIc8A
	oa3D8JcIEJhza13OEN7jXswr8FTIuGnyLABOLgyu99OSiePpV6DuNI3IiBhFx3kxpdaETctVM5x
	6+gQRxpYSiE3UpfHWBWRDJhpQ1Dn3d3c2stWOuaGeI7g3Q2hF99akHBYkMyAkbBjv0Knch/fnEL
	uv9SWCCHpueCZMP/KAqA8UFfGQRHrVtkg2jdKlvNcoImZoCc/oLZIAj5q7ni3TUABmdCCC+E+OJ
	1WhQiAARQQfHiAyUoP2
X-Received: by 2002:a05:6808:1929:b0:467:2652:b29d with SMTP id 5614622812f47-47c88e893c8mr743079b6e.8.1777673272696;
        Fri, 01 May 2026 15:07:52 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76986f9dsm2079143b6e.16.2026.05.01.15.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 15:07:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------A8p0UoQPpNU5B0IW0tmvoTwX"
Message-ID: <fb26a75a-cb2c-4ee6-92b9-4c488a2c7ba5@kernel.dk>
Date: Fri, 1 May 2026 16:07:48 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 491/491] io_uring/poll: correctly handle
 io_poll_add() return value on update
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Ben Hutchings <ben@decadent.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev,
 syzbot+641eec6b7af1f62f2b99@syzkaller.appspotmail.com,
 lvc-project@linuxtesting.org
References: <20260501111233-b371eac52cd006bfddfbd9e5-pchelkin@ispras>
 <58103791-4c19-441c-9d4f-7ae5f9c6151a@kernel.dk>
 <20260502003658-e04f382bc8ed201a99b573e0-pchelkin@ispras>
 <20260502005417-671675fb5906578c85c3fb4f-pchelkin@ispras>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260502005417-671675fb5906578c85c3fb4f-pchelkin@ispras>
X-Rspamd-Queue-Id: 0C7F54AFEBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242539-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,641eec6b7af1f62f2b99];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dk:mid,kernel.dk:email,kernel-dk.20251104.gappssmtp.com:dkim,decadent.org.uk:email]

This is a multi-part message in MIME format.
--------------A8p0UoQPpNU5B0IW0tmvoTwX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/26 3:55 PM, Fedor Pchelkin wrote:
> On Sat, 02. May 00:50, Fedor Pchelkin wrote:
>> On Fri, 01. May 15:33, Jens Axboe wrote:
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
>>>
>>> This should all be handled in the fixup patch - yes this one ended up
>>> being broken, but that's why there's the followup fix.
>>>
>>> Now this is all pretty broken because some patches ended up in 5.15 and
>>> some in 5.10 and honestly I've almost lost track at this point. Sasha
>>> spotted some that were dropped in some broken commit from Greg. For
>>> 5.15, the two attached are what I recently asked for to be added. 5.10
>>> should ALWAYS get the exact same patches as 5.15, because of the whole
>>> sale backport that was done years ago. I always ask for that explicitly
>>> in the emails. But looks like that wasn't always done...
>>>
>>> 5.10 doesn't look like it ever got what is sha
>>> 349ef5d2e7bfb292e7000e6041a984ab56eccf28 in 5.15-stable, hence the fixup
>>> can be merged with queueing that backport.
>>>
>>> Sigh...
>>
>> Oh, for the fixup patch - it is in the 5.10-queue (or at least was when I
>> wrote up report today).  It was taken into consideration.  The concern
>> for the Fixes tag is resolved now by you, thanks for clarification.
>>
>> But that `if (preq->result) < 0` thing is not covered by the fixup patch.
>> This check is not correct in 5.10/5.15 because preq->result is unsigned.
>>
>> Taken that double complete is OK (I had doubts about that), the following
>> change should do the job now:
>>
>> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
>> index 8b0dfea96ee0..b17a26b1b5e1 100644
>> --- a/io_uring/io_uring.c
>> +++ b/io_uring/io_uring.c
>> @@ -6006,7 +6006,7 @@ static int io_poll_update(struct io_kiocb *req, unsigned int issue_flags)
>>  {
>>         struct io_ring_ctx *ctx = req->ctx;
>>         struct io_kiocb *preq;
>> -       int ret2, ret = 0;
>> +       int ret2 = -ECANCELED, ret = 0;
>>  
>>         io_ring_submit_lock(ctx, !(issue_flags & IO_URING_F_NONBLOCK));
>>  
>> @@ -6037,7 +6037,7 @@ static int io_poll_update(struct io_kiocb *req, unsigned int issue_flags)
>>                 preq->result = ret2;
>>  
>>         }
>> -       if (preq->result < 0)
>> +       if (ret2 < 0)
>>                 req_set_fail(preq);
>>         io_req_complete(preq, preq->result);
>>  out:
>>
>>
>> The fixup patch may be updated with this if the changes look OK.
>>
> 
> Or maybe this one which is less hassle:
> 
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index 8b0dfea96ee0..bb01eaa9761f 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -6037,7 +6037,7 @@ static int io_poll_update(struct io_kiocb *req, unsigned int issue_flags)
>                 preq->result = ret2;
>  
>         }
> -       if (preq->result < 0)
> +       if (preq->result)
>                 req_set_fail(preq);
>         io_req_complete(preq, preq->result);
>  out:

That'd be fine. Note that both your patches are white space damaged. I
can send out updated fixup patches, the above does improve them. But at
this point I don't even know what is queued up where. As far as I can
tell neither 5.10-stable or 5.15-stable have the fixup queued up yet,
even though I asked for it 10 days ago. Neither the fixup, nor the
EPOLL_URING_WAKE patch.

I feel like I spend a lot of time both on stable, and defending stable
against people that complain about it. And usually it's all been fine,
but lately it does seem like a bit of a mess :(, and as a maintainer, I
absolutely 100% need to rely on stable doing what they are asked to do,
and if patches fail, then I need to know about it. If patches get yanked
for whatever reason, I need to get asked. And if I ask for patches to
get included and I get an ack, I should not need to scour various stable
branches to check if that actually happened or not.

So let me make it VERY clear - apply the two attached patches to BOTH
5.10-stable and 5.15-stable. Thank you.

-- 
Jens Axboe
--------------A8p0UoQPpNU5B0IW0tmvoTwX
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-poll-fix-EPOLL_URING_WAKE-sometimes-not-bei.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-poll-fix-EPOLL_URING_WAKE-sometimes-not-bei.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAyNDAyMTFiZDgyNzBlYTQyNDQwYjE3NzVlNGQ3YmMwMDU5MDhjZDQ2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFR1ZSwgMjEgQXByIDIwMjYgMTY6NDE6MzIgLTA2MDAKU3ViamVjdDogW1BBVENIIDEv
Ml0gaW9fdXJpbmcvcG9sbDogZml4IEVQT0xMX1VSSU5HX1dBS0Ugc29tZXRpbWVzIG5vdCBi
ZWluZwogbWFza2VkIGluCgpSYXRoZXIgdGhhbiBkbyBpdCBvbmx5IHdoZW4gd2UganVtcCBz
dHJhaWdodCB0byBleGVjdXRpb24sIG1hcmsgaXQKcmVnYXJkbGVzcy4gVGhpcyBlbnN1cmVz
IGl0IGRvZXNuJ3QgZ2V0IGxvc3QuCgpGaXhlczogY2NmMDZiNWE5ODFjICgiaW9fdXJpbmc6
IHBhc3MgaW4gRVBPTExfVVJJTkdfV0FLRSBmb3IgZXZlbnRmZCBzaWduYWxpbmcgYW5kIHdh
a2V1cHMiKQpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0t
LQogaW9fdXJpbmcvaW9fdXJpbmcuYyB8IDE3ICsrKysrKysrLS0tLS0tLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2lvX3VyaW5nL2lvX3VyaW5nLmMgYi9pb191cmluZy9pb191cmluZy5jCmluZGV4IDM4ZGVj
ZmMxYTkxNC4uZGI1YzlmYmRlYzNiIDEwMDY0NAotLS0gYS9pb191cmluZy9pb191cmluZy5j
CisrKyBiL2lvX3VyaW5nL2lvX3VyaW5nLmMKQEAgLTU3OTQsMTcgKzU3OTQsMTYgQEAgc3Rh
dGljIGludCBpb19wb2xsX3dha2Uoc3RydWN0IHdhaXRfcXVldWVfZW50cnkgKndhaXQsIHVu
c2lnbmVkIG1vZGUsIGludCBzeW5jLAogCWlmIChtYXNrICYmICEobWFzayAmIHBvbGwtPmV2
ZW50cykpCiAJCXJldHVybiAwOwogCi0JaWYgKGlvX3BvbGxfZ2V0X293bmVyc2hpcChyZXEp
KSB7Ci0JCS8qCi0JCSAqIElmIHdlIHRyaWdnZXIgYSBtdWx0aXNob3QgcG9sbCBvZmYgb3Vy
IG93biB3YWtldXAgcGF0aCwKLQkJICogZGlzYWJsZSBtdWx0aXNob3QgYXMgdGhlcmUgaXMg
YSBjaXJjdWxhciBkZXBlbmRlbmN5IGJldHdlZW4KLQkJICogQ1EgcG9zdGluZyBhbmQgdHJp
Z2dlcmluZyB0aGUgZXZlbnQuCi0JCSAqLwotCQlpZiAobWFzayAmIEVQT0xMX1VSSU5HX1dB
S0UpCi0JCQlwb2xsLT5ldmVudHMgfD0gRVBPTExPTkVTSE9UOworCS8qCisJICogSWYgd2Ug
dHJpZ2dlciBhIG11bHRpc2hvdCBwb2xsIG9mZiBvdXIgb3duIHdha2V1cCBwYXRoLAorCSAq
IGRpc2FibGUgbXVsdGlzaG90IGFzIHRoZXJlIGlzIGEgY2lyY3VsYXIgZGVwZW5kZW5jeSBi
ZXR3ZWVuCisJICogQ1EgcG9zdGluZyBhbmQgdHJpZ2dlcmluZyB0aGUgZXZlbnQuCisJICov
CisJaWYgKG1hc2sgJiBFUE9MTF9VUklOR19XQUtFKQorCQlwb2xsLT5ldmVudHMgfD0gRVBP
TExPTkVTSE9UOwogCisJaWYgKGlvX3BvbGxfZ2V0X293bmVyc2hpcChyZXEpKQogCQlfX2lv
X3BvbGxfZXhlY3V0ZShyZXEsIG1hc2spOwotCX0KIAlyZXR1cm4gMTsKIH0KIAotLSAKMi41
My4wCgo=
--------------A8p0UoQPpNU5B0IW0tmvoTwX
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-io_uring-poll-fix-backport-of-io_poll_add-changes.patch"
Content-Disposition: attachment;
 filename*0="0002-io_uring-poll-fix-backport-of-io_poll_add-changes.patch"
Content-Transfer-Encoding: base64

RnJvbSA4ZjFhNDAxYjBmY2U1YTQ2OTM1MTUzZjg1NzJiMDY4MWQ1YjlhMDBkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFR1ZSwgMjEgQXByIDIwMjYgMTY6NDQ6MDYgLTA2MDAKU3ViamVjdDogW1BBVENIIDIv
Ml0gaW9fdXJpbmcvcG9sbDogZml4IGJhY2twb3J0IG9mIGlvX3BvbGxfYWRkKCkgY2hhbmdl
cwoKVGhlIDUuMTUvNS4xMCBiYWNrcG9ydCBvZiA4NDIzMGFkMmQyYWYgaGFkIGEgZmV3IGlz
c3VlcywgZHVlIHRvIHRoZQpvbGRlciBwb2xsIGJhc2UuIE5vdGFibHkgcmV0dXJuIHZhbHVl
IGhhbmRsaW5nIF9faW9fYXJtX3BvbGxfaGFuZGxlcigpCmFuZCBpbiByZXR1cm4gX19pb19w
b2xsX2FkZCgpIGFzIHdlbGwuIEZpeCB0aGVtIHVwLgoKUmVwb3J0ZWQtYnk6IEJlbiBIdXRj
aGluZ3MgPGJlbkBkZWNhZGVudC5vcmcudWs+CkZpeGVzOiAzNDllZjVkMmU3YmYgKCJpb191
cmluZy9wb2xsOiBjb3JyZWN0bHkgaGFuZGxlIGlvX3BvbGxfYWRkKCkgcmV0dXJuIHZhbHVl
IG9uIHVwZGF0ZSIpClNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5k
az4KLS0tCiBpb191cmluZy9pb191cmluZy5jIHwgMTQgKysrKystLS0tLS0tLS0KIDEgZmls
ZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvaW9fdXJpbmcvaW9fdXJpbmcuYyBiL2lvX3VyaW5nL2lvX3VyaW5nLmMKaW5kZXggZGI1
YzlmYmRlYzNiLi45N2QwZWNlYzgzMjIgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5nL2lvX3VyaW5n
LmMKKysrIGIvaW9fdXJpbmcvaW9fdXJpbmcuYwpAQCAtNjEzOCwxOSArNjEzOCwxNSBAQCBz
dGF0aWMgaW50IF9faW9fcG9sbF9hZGQoc3RydWN0IGlvX2tpb2NiICpyZXEsIHVuc2lnbmVk
IGludCBpc3N1ZV9mbGFncykKIAlpZiAoIXJldCAmJiBpcHQuZXJyb3IpCiAJCXJlcV9zZXRf
ZmFpbChyZXEpOwogCXJldCA9IHJldCA/OiBpcHQuZXJyb3I7Ci0JaWYgKHJldCA+IDApIHsK
KwlpZiAocmV0KQogCQlfX2lvX3JlcV9jb21wbGV0ZShyZXEsIGlzc3VlX2ZsYWdzLCByZXQs
IDApOwotCQlyZXR1cm4gcmV0OwotCX0KLQlyZXR1cm4gMDsKKwlyZXR1cm4gcmV0OwogfQog
CiBzdGF0aWMgaW50IGlvX3BvbGxfYWRkKHN0cnVjdCBpb19raW9jYiAqcmVxLCB1bnNpZ25l
ZCBpbnQgaXNzdWVfZmxhZ3MpCiB7Ci0JaW50IHJldDsKLQotCXJldCA9IF9faW9fcG9sbF9h
ZGQocmVxLCBpc3N1ZV9mbGFncyk7Ci0JcmV0dXJuIHJldCA8IDAgPyByZXQgOiAwOworCV9f
aW9fcG9sbF9hZGQocmVxLCBpc3N1ZV9mbGFncyk7CisJcmV0dXJuIDA7CiB9CiAKIHN0YXRp
YyBpbnQgaW9fcG9sbF91cGRhdGUoc3RydWN0IGlvX2tpb2NiICpyZXEsIHVuc2lnbmVkIGlu
dCBpc3N1ZV9mbGFncykKQEAgLTYxODgsNyArNjE4NCw3IEBAIHN0YXRpYyBpbnQgaW9fcG9s
bF91cGRhdGUoc3RydWN0IGlvX2tpb2NiICpyZXEsIHVuc2lnbmVkIGludCBpc3N1ZV9mbGFn
cykKIAkJcHJlcS0+cmVzdWx0ID0gcmV0MjsKIAogCX0KLQlpZiAocHJlcS0+cmVzdWx0IDwg
MCkKKwlpZiAocmV0MiA8IDApCiAJCXJlcV9zZXRfZmFpbChwcmVxKTsKIAlpb19yZXFfY29t
cGxldGUocHJlcSwgcHJlcS0+cmVzdWx0KTsKIG91dDoKLS0gCjIuNTMuMAoK

--------------A8p0UoQPpNU5B0IW0tmvoTwX--

