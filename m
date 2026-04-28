Return-Path: <stable+bounces-241751-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB6SM4n98GnubgEAu9opvQ
	(envelope-from <stable+bounces-241751-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 20:33:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF38448AAE8
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 20:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A47A306FD42
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 18:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DE4451076;
	Tue, 28 Apr 2026 18:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="PTecsThX"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0266444DB67
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777399359; cv=none; b=N/mam7YwU7P4yW7Dvu+OPLQWFM9cfcircMGi7aiJnQrlznLnit4GvrF5w+/dU8IK8SQ6CsTrWysND9D4aLBmSuaaL9ZWMV9JcWoeMjEp33wFOoUo2RZlbxeuE1EXjH1tC5rT+kb3Js8LHyYrmVEEDwqDdt5E5kLiK37Q/hmwjRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777399359; c=relaxed/simple;
	bh=x2yihLcpIcmqqM9XIoPnyRji7UoK1AifKPC36KIU/9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7P/Qa1Mp2O0etAifuwSFFdvr7Il28ZXTRzvG2LXzmR1Q7Uluar4ioY6c2ICLL1imZTiEdOteB+8sQaNzgpYOy2nuq1UFUamqj/TTgjYXmqBkrxWQCZNGJ9O1FasteN0Al4ZYM/SeEjvUIi3T7HAbweg0cIdkNOv++LKIhu8/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=PTecsThX; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-42ff0576868so2445122fac.1
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 11:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777399356; x=1778004156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nXl/jWJ6vP7SXrXb/xPSu9tku5aOpOrR4mI5dbC5SSY=;
        b=PTecsThXo4w3oYAmGJOorleuLt9IoRH3vQPF94d7ZfCirtcF3wvcSCHSyFECwUbuoO
         kBo21w8jcOn45z2Nfdf7wzVcnT+FKMF3mwohcS4SFUXYWhpDODTPcY2xgJpR4EkuXypC
         IuX4T9H1u2oz2HJEDhAt+mXijieux7HS8Bhzj7YIZ6yljDhlFh1zinaKnZTeffj7aLXn
         5bwW/j2tmC8hNj0Ep6HZx3MbSxdE44dgONEAxtdZcODL4h1rMPNrix2+XsDgl8f2F+tE
         ELaHz9AGy+kpf6q4bpffOdp0dJvEI9mnsJV42gT5TP0bQMG6Arl2y9uGUahHPDJCjFeL
         Kc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777399356; x=1778004156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nXl/jWJ6vP7SXrXb/xPSu9tku5aOpOrR4mI5dbC5SSY=;
        b=PW0jQfLhmyrsvvfMePJ7MWSLV/UJ+SSxhaFBkQXrE63ooryki0/InWl+WWfXY+U4Z0
         jf6USRk6mliOBYENW9xwza2DZyamngeCI3LN5MIXQ5MpNnaNijYI4xQX30eHe+jKuvPN
         9HuUPfAMyQMW/ijLNKMtY9woGX1BmTK0d1xB1PRNmV3qxLV9ZTTv5uUfCQmrqoz7e22M
         4txsDqq8UJ1bq2m1rtDn8NYUyCDexH7I2n3Z22pf5a4KhXw7IUjbJeaEnNCukbPilfq3
         j+P2PK4yGR8z66F6qncK0N9x5dxaH47vIpFJM7qbtz7upEWwYULwucvmPx+v4V0p48Qu
         ZAMw==
X-Forwarded-Encrypted: i=1; AFNElJ8MX5wf/G5GCQeYdDBTjiWrkW8SUXzZzY6DT+dkb3Gdtpk4ZG2TqeNtXavF3tM0MlyfYV9x7Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjDXGvyXrxiIWin91jbYxEeny+vyUPCsUCiom1aKhstFYGE+Xg
	1qd56+mB17z3yJLHLyK8jNjtYLgaZeb+qf6zlMiNKheB5kHNmerbOotfjuvLjlaN5ks=
X-Gm-Gg: AeBDiesewLzb+BUarWKzTdufEZdypKc+tVaX2Vq/VMhb9cMYI/TB0oNjWgZdg4QIYd5
	61zwa+baUr3sqvrLrw2va/jP5vmtq6ORB3vQ0VKy1jBWJhmLLoagXIJD+DhGASq52XZNbihsZNw
	CwjBh/3imKuZJWLMCQ3EC5QTmFIG373LbVETJCk3Ao+4ICYs5dlSm0MTBPMd/Kcwjtat9WzBeaZ
	yxwW+CX3ak5CvIu/eihNhto2X52G5NqPO1S+MhZa+O9piJqLvRGlIOC/ncJyManNQqOe7fXUPQd
	Qai1oAGnsIi3RTyI/A+AQ0zhHVXDmsg2Z6oiYMuC5Z5gw/ymVaNE3FGsmnCPyOWuY+dDE7qG/To
	WUUsvssKlihYj/7vAkCOpjGCiVxttIpzad4qlxDIPNjBSpfmEZkVvCi+FE5qcLCK9W97wPlyAOB
	YnQaJNCphULib+WBSAC+oQUg3tqXXPzS2J+xpIm4etIxgvHFWcogt3ovheP8hPMyMun4pG57uvn
	BAsdNJo8+ydUfZo0D0=
X-Received: by 2002:a05:6871:ea11:b0:42c:1cbb:5f5b with SMTP id 586e51a60fabf-433f3a530e5mr2162367fac.31.1777399355713;
        Tue, 28 Apr 2026 11:02:35 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4340d4a2cd9sm10250fac.6.2026.04.28.11.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 11:02:35 -0700 (PDT)
Message-ID: <7645db80-8a8a-4ed6-9a3a-f2406cf93322@kernel.dk>
Date: Tue, 28 Apr 2026 12:02:34 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] io_uring/kbuf: support min length left for
 incremental buffers
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: io-uring@vger.kernel.org, Martin Michaelis <code@mgjm.de>,
 stable@vger.kernel.org
References: <20260428154557.2150818-1-axboe@kernel.dk>
 <20260428154557.2150818-3-axboe@kernel.dk>
 <87ik9bj7jt.fsf@mailhost.krisman.be>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87ik9bj7jt.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EF38448AAE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-241751-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kernel.dk:mid,kernel.dk:email,mgjm.de:email,kernel-dk.20251104.gappssmtp.com:dkim]

On 4/28/26 11:53 AM, Gabriel Krisman Bertazi wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> From: Martin Michaelis <code@mgjm.de>
>>
>> Incrementally consumed buffer rings are generally fully consumed, but
>> it's quite possible that the application has a minimum size it needs to
>> meet to avoid truncation. Currently that minimum limit is 1 byte, but
>> this should be a setting that is the hands of the application. For
>> recvmsg multishot, a prime use case for incrementally consumed buffers,
>> the application may get spurious -EFAULT returned at the end of an
>> incrementally consumed buffer, as less space is available than the
>> headers need.
>>
>> Grab a u32 field in struct io_uring_buf_reg, which the application can
>> use to inform the kernel of the minimum size that should be available
>> in an incrementally consumed buffer. If less than that is available,
>> the current buffer is fully processed and the next one will be picked.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: ae98dbf43d75 ("io_uring/kbuf: add support for incremental buffer consumption")
>> Link: https://github.com/axboe/liburing/issues/1433
>> Signed-off-by: Martin Michaelis <code@mgjm.de>
>> [axboe: write commit message, change io_buffer_list member name]
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  include/uapi/linux/io_uring.h | 3 ++-
>>  io_uring/kbuf.c               | 8 +++++++-
>>  io_uring/kbuf.h               | 7 +++++++
>>  3 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
>> index 17ac1b785440..909fb7aea638 100644
>> --- a/include/uapi/linux/io_uring.h
>> +++ b/include/uapi/linux/io_uring.h
>> @@ -905,7 +905,8 @@ struct io_uring_buf_reg {
>>  	__u32	ring_entries;
>>  	__u16	bgid;
>>  	__u16	flags;
>> -	__u64	resv[3];
>> +	__u32	min_left;
>> +	__u32	resv[5];
> 
> Honest question, isn't this a property of the specific operation and/or
> fd being operated, instead of the buffer_reg?

It kind of is, in that some users may not care. But it's not currently
possible to pass this in on a per-op basis, and while I did hack that
up initially, it's almost impossible as you end up with layering
violations. In practice, this is really mostly a recvmsg multishot
issue, because we need to store the headers. Hence the solution to
stuff it in the io_uring_buf_reg instead, and make it a fixed property
of the buffer group. In practice, you may even want a larger min_left
than what the recvmsg requires, as you don't want a tiny truncated
transfer at the end, regardless of what type of recv or read operation
this is. Hence it works generically as well.

Also see the linked GH issue, that's where most of the discussion
around this have happened already.

>>  /* argument for IORING_REGISTER_PBUF_STATUS */
>> diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
>> index 43e4f8615fe8..63061aa1cab9 100644
>> --- a/io_uring/kbuf.c
>> +++ b/io_uring/kbuf.c
>> @@ -47,7 +47,7 @@ static bool io_kbuf_inc_commit(struct io_buffer_list *bl, int len)
>>  		this_len = min_t(u32, len, buf_len);
>>  		buf_len -= this_len;
>>  		/* Stop looping for invalid buffer length of 0 */
>> -		if (buf_len || !this_len) {
>> +		if (buf_len > bl->min_left_sub_one || !this_len) {
> 
> Cosmetic, but perhaps store min_left_sub_one instead of min_left itself? the
> buf_len must be >= min_left, and that is easier to read.  (buf_len &&
> buf_len >= min_left || !this_len)

Also see GH issue.

-- 
Jens Axboe


