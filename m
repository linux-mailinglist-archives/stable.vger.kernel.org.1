Return-Path: <stable+bounces-19769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A9A8535D2
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 17:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56DA01F252E9
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 16:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504835F840;
	Tue, 13 Feb 2024 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sQtOWPuh"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EBF5DF29
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841129; cv=none; b=bgo04RJYh7T4gNBCXPa6bjKScnz0bDuWm4OnuPiBIfylbrEfMV/G1fHFEDz4Dp9aMQm05fJV1LR7i6z8Ou5BSXnKmaNzDp+20/N+toCPj0y2XHCrXvCdsvOrMCLkFcAYWXgWsjyPBr6Qrngl+Pew5SODM8Y0M//HoLJpEqwWDJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841129; c=relaxed/simple;
	bh=NGxQCqEzTqbG8KKHBN+SGaf8868OMXOidBT/nQBZVA4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=NctTXhXX3J1N9HvGC1ksYxf35cAIrBC3npx0gKwOoR1q+3CPqH0jY4ZrVkobmgM0XpJQQ5ISLVIikI11GSYzcdRS49lwivZqwWl2axsvM0T8rfkN+5kNznJA+bOKiHUM1/bXSP4JGJsdmilWP5ycxLhomuBMj2oMRpHe+NJgbqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sQtOWPuh; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7c427cba7a0so29830939f.0
        for <stable@vger.kernel.org>; Tue, 13 Feb 2024 08:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707841125; x=1708445925; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEKAf7jI7p1OQ/nVUjL80zxuCrBrIPsIihsNVp4ySy8=;
        b=sQtOWPuhINlWXkILzVXDCIl+/b4fLWfWj9YfyGUFh3w38FSFFt9iK43kdgx/xqXRCF
         Yo7EPknxpugBZuYYvMFypRQzcYZd3pEEu/kuhZlyRNzwE3TVeX1yUfU1wnRZBLcQmugE
         IfO1o/4BDephx5oVL4qesqfR6rnfjMU6qzM60htclQHQ1pCeEYtQeS6XAszFZV9glkMq
         6kxvtYObHDHKdNZlwITTlkDt786zNTGMkCkdo3tuD1ZUW5a/aU9Ni2RxrcO3gKjVsQCF
         ROGdky+m/7U8LRP3I4v6U2/y+FKVWpG8if5UesOl63NxHsQKs3d5nnNnxHAK/YByFIEf
         2zlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707841125; x=1708445925;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TEKAf7jI7p1OQ/nVUjL80zxuCrBrIPsIihsNVp4ySy8=;
        b=vyU8HnTGjJWkV9gF2tGk20ODEDRR9+cNF3BQ67bqtYIa3EjcEFucQ9ExXAEqjguUBc
         QmYIvOQDBi+vPA7fk/Qv7bVZuzrPt/OJF57P/fvF0FdnSGYlJ3q932aZoSZvLKm4FtnN
         cgCm+Cet5pEUxJ9I0X8Vi5HPy+mGU4147oLxreZkSWJmaEp206Gr4KmlirdetAuPO+NE
         SAFEbe0PyHP4ERn8cw+1CyuWxLQezTB27q83MYikaVpXhSFRm1CZYWFMuDSrXbvc1aqn
         eC0l7s9tiCiPNEosVByB7JD7VSJsXcZD6I3sE3MzyxhwyHN5W2ttHtrZY0NY3C2y1eW6
         YdUQ==
X-Gm-Message-State: AOJu0YwnKe0cBySQUb1KRYlJRaFtGSX9bJnxvT06r6cVpdOmOP5LQ3R2
	B54/pnsCA/0+n3sIRqH+jDfpCWZoATvQRW9jBEofV6KkHncq+pPLpmVlH0f7dm3Uh/QwTyJJo16
	h
X-Google-Smtp-Source: AGHT+IHd4/hfc6h4odvIBuS8+CnGzCjJFYkyVFUKqqCb9TPw3yJEJZnCzBWwC8ic5J0CGvZIdvPjdw==
X-Received: by 2002:a6b:e901:0:b0:7c4:7ff3:23f9 with SMTP id u1-20020a6be901000000b007c47ff323f9mr66704iof.1.1707841124502;
        Tue, 13 Feb 2024 08:18:44 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id fh41-20020a05663862a900b00473d32a6ca5sm177262jab.77.2024.02.13.08.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 08:18:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------80GD57gmUxtvMpQyO2oNwBmV"
Message-ID: <7181edf5-864d-48e3-98dd-93e4726c16f6@kernel.dk>
Date: Tue, 13 Feb 2024 09:18:43 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/net: limit inline multishot
 retries" failed to apply to 6.6-stable tree
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
References: <2024021330-twice-pacify-2be5@gregkh>
 <57ad4fde-f1f4-405b-a1cb-8a1af9471da4@kernel.dk>
 <2024021304-flypaper-oat-7707@gregkh>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024021304-flypaper-oat-7707@gregkh>

This is a multi-part message in MIME format.
--------------80GD57gmUxtvMpQyO2oNwBmV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/24 9:15 AM, Greg KH wrote:
> On Tue, Feb 13, 2024 at 07:52:53AM -0700, Jens Axboe wrote:
>> On 2/13/24 6:19 AM, gregkh@linuxfoundation.org wrote:
>>>
>>> The patch below does not apply to the 6.6-stable tree.
>>> If someone wants it applied there, or to any other stable or longterm
>>> tree, then please email the backport, including the original git commit
>>> id to <stable@vger.kernel.org>.
>>>
>>> To reproduce the conflict and resubmit, you may use the following commands:
>>>
>>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
>>> git checkout FETCH_HEAD
>>> git cherry-pick -x 76b367a2d83163cf19173d5cb0b562acbabc8eac
>>> # <resolve conflicts, build, test, etc.>
>>> git commit -s
>>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021330-twice-pacify-2be5@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
>>
>> Here's the series for 6.6-stable.
>>
>> -- 
>> Jens Axboe
>>
> 
>> From 582cc8795c22337041abc7ee06f9de34f1592922 Mon Sep 17 00:00:00 2001
>> From: Jens Axboe <axboe@kernel.dk>
>> Date: Mon, 29 Jan 2024 11:52:54 -0700
>> Subject: [PATCH 1/4] io_uring/poll: move poll execution helpers higher up
>>
>> Commit e84b01a880f635e3084a361afba41f95ff500d12 upstream.
>>
>> In preparation for calling __io_poll_execute() higher up, move the
>> functions to avoid forward declarations.
>>
>> No functional changes in this patch.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  io_uring/poll.c | 30 +++++++++++++++---------------
>>  1 file changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/io_uring/poll.c b/io_uring/poll.c
>> index a4084acaff91..a2f21ae093dc 100644
>> --- a/io_uring/poll.c
>> +++ b/io_uring/poll.c
>> @@ -226,6 +226,30 @@ enum {
>>  	IOU_POLL_REISSUE = 3,
>>  };
>>  
>> +static void __io_poll_execute(struct io_kiocb *req, int mask)
>> +{
>> +	io_req_set_res(req, mask, 0);
>> +	/*
>> +	 * This is useful for poll that is armed on behalf of another
>> +	 * request, and where the wakeup path could be on a different
>> +	 * CPU. We want to avoid pulling in req->apoll->events for that
>> +	 * case.
>> +	 */
>> +	if (req->opcode == IORING_OP_POLL_ADD)
>> +		req->io_task_work.func = io_poll_task_func;
>> +	else
>> +		req->io_task_work.func = io_apoll_task_func;
>> +
>> +	trace_io_uring_task_add(req, mask);
>> +	io_req_task_work_add(req);
>> +}
>> +
>> +static inline void io_poll_execute(struct io_kiocb *req, int res)
>> +{
>> +	if (io_poll_get_ownership(req))
>> +		__io_poll_execute(req, res);
>> +}
>> +
>>  /*
>>   * All poll tw should go through this. Checks for poll events, manages
>>   * references, does rewait, etc.
>> @@ -372,30 +396,6 @@ static void io_apoll_task_func(struct io_kiocb *req, bool *locked)
>>  		io_req_complete_failed(req, ret);
>>  }
>>  
>> -static void __io_poll_execute(struct io_kiocb *req, int mask)
>> -{
>> -	io_req_set_res(req, mask, 0);
>> -	/*
>> -	 * This is useful for poll that is armed on behalf of another
>> -	 * request, and where the wakeup path could be on a different
>> -	 * CPU. We want to avoid pulling in req->apoll->events for that
>> -	 * case.
>> -	 */
>> -	if (req->opcode == IORING_OP_POLL_ADD)
>> -		req->io_task_work.func = io_poll_task_func;
>> -	else
>> -		req->io_task_work.func = io_apoll_task_func;
>> -
>> -	trace_io_uring_task_add(req, mask);
>> -	io_req_task_work_add(req);
>> -}
>> -
>> -static inline void io_poll_execute(struct io_kiocb *req, int res)
>> -{
>> -	if (io_poll_get_ownership(req))
>> -		__io_poll_execute(req, res);
>> -}
>> -
> 
> This first patch fails to apply to the 6.6.y tree, are you sure you made
> it against the correct one?  These functions do not look like this to
> me.

Sorry my bad, refreshing them for 6.1-stable and I guess I did that
before I sent them out. Hence the mua used the new copy...

Here are the ones I have in my local tree, from testing.

-- 
Jens Axboe

--------------80GD57gmUxtvMpQyO2oNwBmV
Content-Type: text/x-patch; charset=UTF-8;
 name="0003-io_uring-poll-add-requeue-return-code-from-poll-mult.patch"
Content-Disposition: attachment;
 filename*0="0003-io_uring-poll-add-requeue-return-code-from-poll-mult.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAzMzBlM2JiZmU2ZTIxYjcxNWIwMjM2MmQyYTZlNDI3OTA3ZWZiNmM4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IE1vbiwgMjkgSmFuIDIwMjQgMTE6NTc6MTEgLTA3MDAKU3ViamVjdDogW1BBVENIIDMv
NF0gaW9fdXJpbmcvcG9sbDogYWRkIHJlcXVldWUgcmV0dXJuIGNvZGUgZnJvbSBwb2xsCiBt
dWx0aXNob3QgaGFuZGxpbmcKCkNvbW1pdCA3MDRlYTg4OGQ2NDZjYjlkNzE1NjYyOTQ0Y2Yz
ODljODIzMjUyZWUwIHVwc3RyZWFtLgoKU2luY2Ugb3VyIHBvbGwgaGFuZGxpbmcgaXMgZWRn
ZSB0cmlnZ2VyZWQsIG11bHRpc2hvdCBoYW5kbGVycyByZXRyeQppbnRlcm5hbGx5IHVudGls
IHRoZXkga25vdyB0aGF0IG5vIG1vcmUgZGF0YSBpcyBhdmFpbGFibGUuIEluCnByZXBhcmF0
aW9uIGZvciBsaW1pdGluZyB0aGVzZSByZXRyaWVzLCBhZGQgYW4gaW50ZXJuYWwgcmV0dXJu
IGNvZGUsCklPVV9SRVFVRVVFLCB3aGljaCBjYW4gYmUgdXNlZCB0byBpbmZvcm0gdGhlIHBv
bGwgYmFja2VuZCBhYm91dCB0aGUKaGFuZGxlciB3YW50aW5nIHRvIHJldHJ5LCBidXQgdGhh
dCB0aGlzIHNob3VsZCBoYXBwZW4gdGhyb3VnaCBhIG5vcm1hbAp0YXNrX3dvcmsgcmVxdWV1
ZSByYXRoZXIgdGhhbiBrZWVwIGhhbW1lcmluZyBvbiB0aGUgaXNzdWUgc2lkZSBmb3IgdGhp
cwpvbmUgcmVxdWVzdC4KCk5vIGZ1bmN0aW9uYWwgY2hhbmdlcyBpbiB0aGlzIHBhdGNoLCBu
b2JvZHkgaXMgdXNpbmcgdGhpcyByZXR1cm4gY29kZQpqdXN0IHlldC4KClNpZ25lZC1vZmYt
Ynk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBpb191cmluZy9pb191cmlu
Zy5oIHwgNyArKysrKysrCiBpb191cmluZy9wb2xsLmMgICAgIHwgOSArKysrKysrKy0KIDIg
ZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2lvX3VyaW5nL2lvX3VyaW5nLmggYi9pb191cmluZy9pb191cmluZy5oCmluZGV4
IGQyYmFkMWRmMzQ3ZC4uYzhjYmE3ODMxMDgzIDEwMDY0NAotLS0gYS9pb191cmluZy9pb191
cmluZy5oCisrKyBiL2lvX3VyaW5nL2lvX3VyaW5nLmgKQEAgLTMwLDYgKzMwLDEzIEBAIGVu
dW0gewogCUlPVV9PSwkJCT0gMCwKIAlJT1VfSVNTVUVfU0tJUF9DT01QTEVURQk9IC1FSU9D
QlFVRVVFRCwKIAorCS8qCisJICogUmVxdWV1ZSB0aGUgdGFza193b3JrIHRvIHJlc3RhcnQg
b3BlcmF0aW9ucyBvbiB0aGlzIHJlcXVlc3QuIFRoZQorCSAqIGFjdHVhbCB2YWx1ZSBpc24n
dCBpbXBvcnRhbnQsIHNob3VsZCBqdXN0IGJlIG5vdCBhbiBvdGhlcndpc2UKKwkgKiB2YWxp
ZCBlcnJvciBjb2RlLCB5ZXQgbGVzcyB0aGFuIC1NQVhfRVJSTk8gYW5kIHZhbGlkIGludGVy
bmFsbHkuCisJICovCisJSU9VX1JFUVVFVUUJCT0gLTMwNzIsCisKIAkvKgogCSAqIEludGVu
ZGVkIG9ubHkgd2hlbiBib3RoIElPX1VSSU5HX0ZfTVVMVElTSE9UIGlzIHBhc3NlZAogCSAq
IHRvIGluZGljYXRlIHRvIHRoZSBwb2xsIHJ1bm5lciB0aGF0IG11bHRpc2hvdCBzaG91bGQg
YmUKZGlmZiAtLWdpdCBhL2lvX3VyaW5nL3BvbGwuYyBiL2lvX3VyaW5nL3BvbGwuYwppbmRl
eCBiMGJjNzg1MjYzOTQuLjQ4Y2EwODEwYTU0YSAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvcG9s
bC5jCisrKyBiL2lvX3VyaW5nL3BvbGwuYwpAQCAtMjI2LDYgKzIyNiw3IEBAIGVudW0gewog
CUlPVV9QT0xMX05PX0FDVElPTiA9IDEsCiAJSU9VX1BPTExfUkVNT1ZFX1BPTExfVVNFX1JF
UyA9IDIsCiAJSU9VX1BPTExfUkVJU1NVRSA9IDMsCisJSU9VX1BPTExfUkVRVUVVRSA9IDQs
CiB9OwogCiBzdGF0aWMgdm9pZCBfX2lvX3BvbGxfZXhlY3V0ZShzdHJ1Y3QgaW9fa2lvY2Ig
KnJlcSwgaW50IG1hc2spCkBAIC0zMjQsNiArMzI1LDggQEAgc3RhdGljIGludCBpb19wb2xs
X2NoZWNrX2V2ZW50cyhzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgc3RydWN0IGlvX3R3X3N0YXRl
ICp0cykKIAkJCWludCByZXQgPSBpb19wb2xsX2lzc3VlKHJlcSwgdHMpOwogCQkJaWYgKHJl
dCA9PSBJT1VfU1RPUF9NVUxUSVNIT1QpCiAJCQkJcmV0dXJuIElPVV9QT0xMX1JFTU9WRV9Q
T0xMX1VTRV9SRVM7CisJCQllbHNlIGlmIChyZXQgPT0gSU9VX1JFUVVFVUUpCisJCQkJcmV0
dXJuIElPVV9QT0xMX1JFUVVFVUU7CiAJCQlpZiAocmV0IDwgMCkKIAkJCQlyZXR1cm4gcmV0
OwogCQl9CkBAIC0zNDYsOCArMzQ5LDEyIEBAIHZvaWQgaW9fcG9sbF90YXNrX2Z1bmMoc3Ry
dWN0IGlvX2tpb2NiICpyZXEsIHN0cnVjdCBpb190d19zdGF0ZSAqdHMpCiAJaW50IHJldDsK
IAogCXJldCA9IGlvX3BvbGxfY2hlY2tfZXZlbnRzKHJlcSwgdHMpOwotCWlmIChyZXQgPT0g
SU9VX1BPTExfTk9fQUNUSU9OKQorCWlmIChyZXQgPT0gSU9VX1BPTExfTk9fQUNUSU9OKSB7
CiAJCXJldHVybjsKKwl9IGVsc2UgaWYgKHJldCA9PSBJT1VfUE9MTF9SRVFVRVVFKSB7CisJ
CV9faW9fcG9sbF9leGVjdXRlKHJlcSwgMCk7CisJCXJldHVybjsKKwl9CiAJaW9fcG9sbF9y
ZW1vdmVfZW50cmllcyhyZXEpOwogCWlvX3BvbGxfdHdfaGFzaF9lamVjdChyZXEsIHRzKTsK
IAotLSAKMi40My4wCgo=
--------------80GD57gmUxtvMpQyO2oNwBmV
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-io_uring-net-un-indent-mshot-retry-path-in-io_recv_f.patch"
Content-Disposition: attachment;
 filename*0="0002-io_uring-net-un-indent-mshot-retry-path-in-io_recv_f.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAzN2RiZjAwNTZhNTg3MDNmODE1YWUwNzZiMDhkZmI5ZGE4NmM2MTBkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IE1vbiwgMjkgSmFuIDIwMjQgMTE6NTQ6MTggLTA3MDAKU3ViamVjdDogW1BBVENIIDIv
NF0gaW9fdXJpbmcvbmV0OiB1bi1pbmRlbnQgbXNob3QgcmV0cnkgcGF0aCBpbgogaW9fcmVj
dl9maW5pc2goKQoKQ29tbWl0IDkxZTVkNzY1YTgyZmIyYzlkMGI3YWQ5MzBkODk1MzIwODA4
MWRkZjEgdXBzdHJlYW0uCgpJbiBwcmVwYXJhdGlvbiBmb3IgcHV0dGluZyBzb21lIHJldHJ5
IGxvZ2ljIGluIHRoZXJlLCBoYXZlIHRoZSBkb25lCnBhdGgganVzdCBza2lwIHN0cmFpZ2h0
IHRvIHRoZSBlbmQgcmF0aGVyIHRoYW4gaGF2ZSB0b28gbXVjaCBuZXN0aW5nCmluIGhlcmUu
CgpObyBmdW5jdGlvbmFsIGNoYW5nZXMgaW4gdGhpcyBwYXRjaC4KClNpZ25lZC1vZmYtYnk6
IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBpb191cmluZy9uZXQuYyB8IDM2
ICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQs
IDIwIGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2lvX3Vy
aW5nL25ldC5jIGIvaW9fdXJpbmcvbmV0LmMKaW5kZXggNzVkNDk0ZGFkN2UyLi43NDBjNmJm
YTViNTkgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5nL25ldC5jCisrKyBiL2lvX3VyaW5nL25ldC5j
CkBAIC02NDUsMjMgKzY0NSwyNyBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaW9fcmVjdl9maW5p
c2goc3RydWN0IGlvX2tpb2NiICpyZXEsIGludCAqcmV0LAogCQlyZXR1cm4gdHJ1ZTsKIAl9
CiAKLQlpZiAoIW1zaG90X2ZpbmlzaGVkKSB7Ci0JCWlmIChpb19maWxsX2NxZV9yZXFfYXV4
KHJlcSwgaXNzdWVfZmxhZ3MgJiBJT19VUklOR19GX0NPTVBMRVRFX0RFRkVSLAotCQkJCQkq
cmV0LCBjZmxhZ3MgfCBJT1JJTkdfQ1FFX0ZfTU9SRSkpIHsKLQkJCWlvX3JlY3ZfcHJlcF9y
ZXRyeShyZXEpOwotCQkJLyogS25vd24gbm90LWVtcHR5IG9yIHVua25vd24gc3RhdGUsIHJl
dHJ5ICovCi0JCQlpZiAoY2ZsYWdzICYgSU9SSU5HX0NRRV9GX1NPQ0tfTk9ORU1QVFkgfHwK
LQkJCSAgICBtc2ctPm1zZ19pbnEgPT0gLTEpCi0JCQkJcmV0dXJuIGZhbHNlOwotCQkJaWYg
KGlzc3VlX2ZsYWdzICYgSU9fVVJJTkdfRl9NVUxUSVNIT1QpCi0JCQkJKnJldCA9IElPVV9J
U1NVRV9TS0lQX0NPTVBMRVRFOwotCQkJZWxzZQotCQkJCSpyZXQgPSAtRUFHQUlOOwotCQkJ
cmV0dXJuIHRydWU7Ci0JCX0KLQkJLyogT3RoZXJ3aXNlIHN0b3AgbXVsdGlzaG90IGJ1dCB1
c2UgdGhlIGN1cnJlbnQgcmVzdWx0LiAqLwotCX0KKwlpZiAobXNob3RfZmluaXNoZWQpCisJ
CWdvdG8gZmluaXNoOwogCisJLyoKKwkgKiBGaWxsIENRRSBmb3IgdGhpcyByZWNlaXZlIGFu
ZCBzZWUgaWYgd2Ugc2hvdWxkIGtlZXAgdHJ5aW5nIHRvCisJICogcmVjZWl2ZSBmcm9tIHRo
aXMgc29ja2V0LgorCSAqLworCWlmIChpb19maWxsX2NxZV9yZXFfYXV4KHJlcSwgaXNzdWVf
ZmxhZ3MgJiBJT19VUklOR19GX0NPTVBMRVRFX0RFRkVSLAorCQkJCSpyZXQsIGNmbGFncyB8
IElPUklOR19DUUVfRl9NT1JFKSkgeworCQlpb19yZWN2X3ByZXBfcmV0cnkocmVxKTsKKwkJ
LyogS25vd24gbm90LWVtcHR5IG9yIHVua25vd24gc3RhdGUsIHJldHJ5ICovCisJCWlmIChj
ZmxhZ3MgJiBJT1JJTkdfQ1FFX0ZfU09DS19OT05FTVBUWSB8fCBtc2ctPm1zZ19pbnEgPT0g
LTEpCisJCQlyZXR1cm4gZmFsc2U7CisJCWlmIChpc3N1ZV9mbGFncyAmIElPX1VSSU5HX0Zf
TVVMVElTSE9UKQorCQkJKnJldCA9IElPVV9JU1NVRV9TS0lQX0NPTVBMRVRFOworCQllbHNl
CisJCQkqcmV0ID0gLUVBR0FJTjsKKwkJcmV0dXJuIHRydWU7CisJfQorCS8qIE90aGVyd2lz
ZSBzdG9wIG11bHRpc2hvdCBidXQgdXNlIHRoZSBjdXJyZW50IHJlc3VsdC4gKi8KK2Zpbmlz
aDoKIAlpb19yZXFfc2V0X3JlcyhyZXEsICpyZXQsIGNmbGFncyk7CiAKIAlpZiAoaXNzdWVf
ZmxhZ3MgJiBJT19VUklOR19GX01VTFRJU0hPVCkKLS0gCjIuNDMuMAoK
--------------80GD57gmUxtvMpQyO2oNwBmV
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-poll-move-poll-execution-helpers-higher-up.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-poll-move-poll-execution-helpers-higher-up.pat";
 filename*1="ch"
Content-Transfer-Encoding: base64

RnJvbSA1ODJjYzg3OTVjMjIzMzcwNDFhYmM3ZWUwNmY5ZGUzNGYxNTkyOTIyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IE1vbiwgMjkgSmFuIDIwMjQgMTE6NTI6NTQgLTA3MDAKU3ViamVjdDogW1BBVENIIDEv
NF0gaW9fdXJpbmcvcG9sbDogbW92ZSBwb2xsIGV4ZWN1dGlvbiBoZWxwZXJzIGhpZ2hlciB1
cAoKQ29tbWl0IGU4NGIwMWE4ODBmNjM1ZTMwODRhMzYxYWZiYTQxZjk1ZmY1MDBkMTIgdXBz
dHJlYW0uCgpJbiBwcmVwYXJhdGlvbiBmb3IgY2FsbGluZyBfX2lvX3BvbGxfZXhlY3V0ZSgp
IGhpZ2hlciB1cCwgbW92ZSB0aGUKZnVuY3Rpb25zIHRvIGF2b2lkIGZvcndhcmQgZGVjbGFy
YXRpb25zLgoKTm8gZnVuY3Rpb25hbCBjaGFuZ2VzIGluIHRoaXMgcGF0Y2guCgpTaWduZWQt
b2ZmLWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcvcG9s
bC5jIHwgMzAgKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW9f
dXJpbmcvcG9sbC5jIGIvaW9fdXJpbmcvcG9sbC5jCmluZGV4IDRjMzYwYmE4NzkzYS4uYjBi
Yzc4NTI2Mzk0IDEwMDY0NAotLS0gYS9pb191cmluZy9wb2xsLmMKKysrIGIvaW9fdXJpbmcv
cG9sbC5jCkBAIC0yMjgsNiArMjI4LDIxIEBAIGVudW0gewogCUlPVV9QT0xMX1JFSVNTVUUg
PSAzLAogfTsKIAorc3RhdGljIHZvaWQgX19pb19wb2xsX2V4ZWN1dGUoc3RydWN0IGlvX2tp
b2NiICpyZXEsIGludCBtYXNrKQoreworCWlvX3JlcV9zZXRfcmVzKHJlcSwgbWFzaywgMCk7
CisJcmVxLT5pb190YXNrX3dvcmsuZnVuYyA9IGlvX3BvbGxfdGFza19mdW5jOworCisJdHJh
Y2VfaW9fdXJpbmdfdGFza19hZGQocmVxLCBtYXNrKTsKKwlpb19yZXFfdGFza193b3JrX2Fk
ZChyZXEpOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQgaW9fcG9sbF9leGVjdXRlKHN0cnVj
dCBpb19raW9jYiAqcmVxLCBpbnQgcmVzKQoreworCWlmIChpb19wb2xsX2dldF9vd25lcnNo
aXAocmVxKSkKKwkJX19pb19wb2xsX2V4ZWN1dGUocmVxLCByZXMpOworfQorCiAvKgogICog
QWxsIHBvbGwgdHcgc2hvdWxkIGdvIHRocm91Z2ggdGhpcy4gQ2hlY2tzIGZvciBwb2xsIGV2
ZW50cywgbWFuYWdlcwogICogcmVmZXJlbmNlcywgZG9lcyByZXdhaXQsIGV0Yy4KQEAgLTM2
NCwyMSArMzc5LDYgQEAgdm9pZCBpb19wb2xsX3Rhc2tfZnVuYyhzdHJ1Y3QgaW9fa2lvY2Ig
KnJlcSwgc3RydWN0IGlvX3R3X3N0YXRlICp0cykKIAl9CiB9CiAKLXN0YXRpYyB2b2lkIF9f
aW9fcG9sbF9leGVjdXRlKHN0cnVjdCBpb19raW9jYiAqcmVxLCBpbnQgbWFzaykKLXsKLQlp
b19yZXFfc2V0X3JlcyhyZXEsIG1hc2ssIDApOwotCXJlcS0+aW9fdGFza193b3JrLmZ1bmMg
PSBpb19wb2xsX3Rhc2tfZnVuYzsKLQotCXRyYWNlX2lvX3VyaW5nX3Rhc2tfYWRkKHJlcSwg
bWFzayk7Ci0JaW9fcmVxX3Rhc2tfd29ya19hZGQocmVxKTsKLX0KLQotc3RhdGljIGlubGlu
ZSB2b2lkIGlvX3BvbGxfZXhlY3V0ZShzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgaW50IHJlcykK
LXsKLQlpZiAoaW9fcG9sbF9nZXRfb3duZXJzaGlwKHJlcSkpCi0JCV9faW9fcG9sbF9leGVj
dXRlKHJlcSwgcmVzKTsKLX0KLQogc3RhdGljIHZvaWQgaW9fcG9sbF9jYW5jZWxfcmVxKHN0
cnVjdCBpb19raW9jYiAqcmVxKQogewogCWlvX3BvbGxfbWFya19jYW5jZWxsZWQocmVxKTsK
LS0gCjIuNDMuMAoK
--------------80GD57gmUxtvMpQyO2oNwBmV
Content-Type: text/x-patch; charset=UTF-8;
 name="0004-io_uring-net-limit-inline-multishot-retries.patch"
Content-Disposition: attachment;
 filename="0004-io_uring-net-limit-inline-multishot-retries.patch"
Content-Transfer-Encoding: base64

RnJvbSBhZWVjODg4NGMxNjA3YTczYjM3OWU2MTBjYzhkZTI3ZTNmNjI0NGNlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IE1vbiwgMjkgSmFuIDIwMjQgMTI6MDA6NTggLTA3MDAKU3ViamVjdDogW1BBVENIIDQv
NF0gaW9fdXJpbmcvbmV0OiBsaW1pdCBpbmxpbmUgbXVsdGlzaG90IHJldHJpZXMKCkNvbW1p
dCA3NmIzNjdhMmQ4MzE2M2NmMTkxNzNkNWNiMGI1NjJhY2JhYmM4ZWFjIHVwc3RyZWFtLgoK
SWYgd2UgaGF2ZSBtdWx0aXBsZSBjbGllbnRzIGFuZCBzb21lL2FsbCBhcmUgZmxvb2Rpbmcg
dGhlIHJlY2VpdmVzIHRvCnN1Y2ggYW4gZXh0ZW50IHRoYXQgd2UgY2FuIHJldHJ5IGEgTE9U
IGhhbmRsaW5nIG11bHRpc2hvdCByZWNlaXZlcywgdGhlbgp3ZSBjYW4gYmUgc3RhcnZpbmcg
c29tZSBjbGllbnRzIGFuZCBoZW5jZSBzZXJ2aW5nIHRyYWZmaWMgaW4gYW4KaW1iYWxhbmNl
ZCBmYXNoaW9uLgoKTGltaXQgbXVsdGlzaG90IHJldHJ5IGF0dGVtcHRzIHRvIHNvbWUgYXJi
aXRyYXJ5IHZhbHVlLCB3aG9zZSBvbmx5CnB1cnBvc2Ugc2VydmVzIHRvIGVuc3VyZSB0aGF0
IHdlIGRvbid0IGtlZXAgc2VydmluZyBhIHNpbmdsZSBjb25uZWN0aW9uCmZvciB3YXkgdG9v
IGxvbmcuIFdlIGRlZmF1bHQgdG8gMzIgcmV0cmllcywgd2hpY2ggc2hvdWxkIGJlIG1vcmUg
dGhhbgplbm91Z2ggdG8gcHJvdmlkZSBmYWlybmVzcywgeWV0IG5vdCBzbyBzbWFsbCB0aGF0
IHdlJ2xsIHNwZW5kIHRvbyBtdWNoCnRpbWUgcmVxdWV1aW5nIHJhdGhlciB0aGFuIGhhbmRs
aW5nIHRyYWZmaWMuCgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpEZXBlbmRzLW9uOiA3
MDRlYTg4OGQ2NDYgKCJpb191cmluZy9wb2xsOiBhZGQgcmVxdWV1ZSByZXR1cm4gY29kZSBm
cm9tIHBvbGwgbXVsdGlzaG90IGhhbmRsaW5nIikKRGVwZW5kcy1vbjogMWU1ZDc2NWE4MmYg
KCJpb191cmluZy9uZXQ6IHVuLWluZGVudCBtc2hvdCByZXRyeSBwYXRoIGluIGlvX3JlY3Zf
ZmluaXNoKCkiKQpEZXBlbmRzLW9uOiBlODRiMDFhODgwZjYgKCJpb191cmluZy9wb2xsOiBt
b3ZlIHBvbGwgZXhlY3V0aW9uIGhlbHBlcnMgaGlnaGVyIHVwIikKRml4ZXM6IGIzZmRlYTZl
Y2I1NSAoImlvX3VyaW5nOiBtdWx0aXNob3QgcmVjdiIpCkZpeGVzOiA5YmI2NjkwNmYyM2Ug
KCJpb191cmluZzogc3VwcG9ydCBtdWx0aXNob3QgaW4gcmVjdm1zZyIpCkxpbms6IGh0dHBz
Oi8vZ2l0aHViLmNvbS9heGJvZS9saWJ1cmluZy9pc3N1ZXMvMTA0MwpTaWduZWQtb2ZmLWJ5
OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcvbmV0LmMgfCAy
MyArKysrKysrKysrKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvbmV0LmMgYi9p
b191cmluZy9uZXQuYwppbmRleCA3NDBjNmJmYTViNTkuLmExMmZmNjllNjg0MyAxMDA2NDQK
LS0tIGEvaW9fdXJpbmcvbmV0LmMKKysrIGIvaW9fdXJpbmcvbmV0LmMKQEAgLTYwLDYgKzYw
LDcgQEAgc3RydWN0IGlvX3NyX21zZyB7CiAJdW5zaWduZWQJCQlsZW47CiAJdW5zaWduZWQJ
CQlkb25lX2lvOwogCXVuc2lnbmVkCQkJbXNnX2ZsYWdzOworCXVuc2lnbmVkCQkJbnJfbXVs
dGlzaG90X2xvb3BzOwogCXUxNgkJCQlmbGFnczsKIAkvKiBpbml0aWFsaXNlZCBhbmQgdXNl
ZCBvbmx5IGJ5ICFtc2cgc2VuZCB2YXJpYW50cyAqLwogCXUxNgkJCQlhZGRyX2xlbjsKQEAg
LTcwLDYgKzcxLDEzIEBAIHN0cnVjdCBpb19zcl9tc2cgewogCXN0cnVjdCBpb19raW9jYiAJ
CSpub3RpZjsKIH07CiAKKy8qCisgKiBOdW1iZXIgb2YgdGltZXMgd2UnbGwgdHJ5IGFuZCBk
byByZWNlaXZlcyBpZiB0aGVyZSdzIG1vcmUgZGF0YS4gSWYgd2UKKyAqIGV4Y2VlZCB0aGlz
IGxpbWl0LCB0aGVuIGFkZCB1cyB0byB0aGUgYmFjayBvZiB0aGUgcXVldWUgYW5kIHJldHJ5
IGZyb20KKyAqIHRoZXJlLiBUaGlzIGhlbHBzIGZhaXJuZXNzIGJldHdlZW4gZmxvb2Rpbmcg
Y2xpZW50cy4KKyAqLworI2RlZmluZSBNVUxUSVNIT1RfTUFYX1JFVFJZCTMyCisKIHN0YXRp
YyBpbmxpbmUgYm9vbCBpb19jaGVja19tdWx0aXNob3Qoc3RydWN0IGlvX2tpb2NiICpyZXEs
CiAJCQkJICAgICAgdW5zaWduZWQgaW50IGlzc3VlX2ZsYWdzKQogewpAQCAtNjExLDYgKzYx
OSw3IEBAIGludCBpb19yZWN2bXNnX3ByZXAoc3RydWN0IGlvX2tpb2NiICpyZXEsIGNvbnN0
IHN0cnVjdCBpb191cmluZ19zcWUgKnNxZSkKIAkJc3ItPm1zZ19mbGFncyB8PSBNU0dfQ01T
R19DT01QQVQ7CiAjZW5kaWYKIAlzci0+ZG9uZV9pbyA9IDA7CisJc3ItPm5yX211bHRpc2hv
dF9sb29wcyA9IDA7CiAJcmV0dXJuIDA7CiB9CiAKQEAgLTY1NCwxMiArNjYzLDIwIEBAIHN0
YXRpYyBpbmxpbmUgYm9vbCBpb19yZWN2X2ZpbmlzaChzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwg
aW50ICpyZXQsCiAJICovCiAJaWYgKGlvX2ZpbGxfY3FlX3JlcV9hdXgocmVxLCBpc3N1ZV9m
bGFncyAmIElPX1VSSU5HX0ZfQ09NUExFVEVfREVGRVIsCiAJCQkJKnJldCwgY2ZsYWdzIHwg
SU9SSU5HX0NRRV9GX01PUkUpKSB7CisJCXN0cnVjdCBpb19zcl9tc2cgKnNyID0gaW9fa2lv
Y2JfdG9fY21kKHJlcSwgc3RydWN0IGlvX3NyX21zZyk7CisJCWludCBtc2hvdF9yZXRyeV9y
ZXQgPSBJT1VfSVNTVUVfU0tJUF9DT01QTEVURTsKKwogCQlpb19yZWN2X3ByZXBfcmV0cnko
cmVxKTsKIAkJLyogS25vd24gbm90LWVtcHR5IG9yIHVua25vd24gc3RhdGUsIHJldHJ5ICov
Ci0JCWlmIChjZmxhZ3MgJiBJT1JJTkdfQ1FFX0ZfU09DS19OT05FTVBUWSB8fCBtc2ctPm1z
Z19pbnEgPT0gLTEpCi0JCQlyZXR1cm4gZmFsc2U7CisJCWlmIChjZmxhZ3MgJiBJT1JJTkdf
Q1FFX0ZfU09DS19OT05FTVBUWSB8fCBtc2ctPm1zZ19pbnEgPT0gLTEpIHsKKwkJCWlmIChz
ci0+bnJfbXVsdGlzaG90X2xvb3BzKysgPCBNVUxUSVNIT1RfTUFYX1JFVFJZKQorCQkJCXJl
dHVybiBmYWxzZTsKKwkJCS8qIG1zaG90IHJldHJpZXMgZXhjZWVkZWQsIGZvcmNlIGEgcmVx
dWV1ZSAqLworCQkJc3ItPm5yX211bHRpc2hvdF9sb29wcyA9IDA7CisJCQltc2hvdF9yZXRy
eV9yZXQgPSBJT1VfUkVRVUVVRTsKKwkJfQogCQlpZiAoaXNzdWVfZmxhZ3MgJiBJT19VUklO
R19GX01VTFRJU0hPVCkKLQkJCSpyZXQgPSBJT1VfSVNTVUVfU0tJUF9DT01QTEVURTsKKwkJ
CSpyZXQgPSBtc2hvdF9yZXRyeV9yZXQ7CiAJCWVsc2UKIAkJCSpyZXQgPSAtRUFHQUlOOwog
CQlyZXR1cm4gdHJ1ZTsKLS0gCjIuNDMuMAoK

--------------80GD57gmUxtvMpQyO2oNwBmV--

