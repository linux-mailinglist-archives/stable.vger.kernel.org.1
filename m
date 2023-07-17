Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF41756932
	for <lists+stable@lfdr.de>; Mon, 17 Jul 2023 18:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjGQQc3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 17 Jul 2023 12:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjGQQc1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 12:32:27 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F5110D8
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 09:32:20 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-785d3a53ed6so48129339f.1
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689611539; x=1690216339;
        h=in-reply-to:references:cc:to:from:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2h9tHIdsYRxsoU7Rq7+wXws3qhaYMddvOWY/JOpRZ8=;
        b=lE5dtq3hiudwfrkABHAlrqtpOc6oYRoCKsSN4dV26zdaTe1cRdy2FZ9SjQosHDkrIZ
         56FMuA8lnokxrmDFlCx1saipEW5Q+8GH3mtAAcXosdcSZ6eWCUmchE+aVB4QdOxDG3Y+
         fVe1xZzpNIKPoRONro58Lcgrpvm8ZK+kg/Ljj2I6YlWXKY85a3615xuWCBgIy+QYp0tz
         2DdEPuq+BB4fzWNclgCpIsxBF92Pv1Y2d9quPj47ml3uWv+9keMZ9aLFHoXt8XEYg+or
         KjUzUCp/GZ5nVxXypOjK41+/nMY5JM6vrwfNArixjT9S9/cw/7yp0Qo2gAeZmpzoQlQs
         wIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689611539; x=1690216339;
        h=in-reply-to:references:cc:to:from:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y2h9tHIdsYRxsoU7Rq7+wXws3qhaYMddvOWY/JOpRZ8=;
        b=WP8yZWaPNvvyy3KjbHWsDCzWDgOYC9pLadtPFdjPaiK/lH8cLo9y9kBhyME41ed8fl
         swiz2tt3f6CRv3hBb1n/EJMVWA21ZDCB6JMPP+kKxbO/rM2p4fsMKR5V+m6uJGxYL/c3
         607+IvjfscxJGhWWWDryI94gj38HtMhIHj/comxENlc/WMGKJNOE1pinj42CWUa0XL5e
         oXRqht/zpmkgEF5TCi8rCztdixOy9OqTD1OQ3dwfdxfNKWMmnXxBruPO4R1+3CLJ7MUG
         9AD7L1BEJ8zZ/ZKeWnLPFPY8DuciNaDXzNQM8TdxLc6OyXmab/RI/9faKfIOmTzUFC3b
         qdQQ==
X-Gm-Message-State: ABy/qLYByz9MXy7OnU9rX3IpJAin4mCb2Sg/OjKyAZnEjo8nXXJVlquo
        4I+VX5FOrg72jGUSkDMhw837YA==
X-Google-Smtp-Source: APBJJlHeG/Cs9qvydOC5EEq+4rnRUPtL6PbAEHaHCAabfgGf/Ljdk3HYaXpnQ9PApCmaADer6wYHjw==
X-Received: by 2002:a05:6602:488f:b0:783:6ec1:65f6 with SMTP id ee15-20020a056602488f00b007836ec165f6mr221241iob.1.1689611539522;
        Mon, 17 Jul 2023 09:32:19 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id j3-20020a02cc63000000b0042bb2448847sm4432969jaq.53.2023.07.17.09.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 09:32:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------bCIHdkNZpUGDMtxt4dQaBki0"
Message-ID: <26f0740e-06a5-bbf1-e973-956f23f36cce@kernel.dk>
Date:   Mon, 17 Jul 2023 10:32:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: FAILED: patch "[PATCH] io_uring: Use io_schedule* in cqring wait"
 failed to apply to 6.1-stable tree
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Andres Freund <andres@anarazel.de>
Cc:     gregkh@linuxfoundation.org, asml.silence@gmail.com,
        stable@vger.kernel.org
References: <2023071620-litigate-debunk-939a@gregkh>
 <0cfb74bb-c203-39a1-eab7-abeeae724b68@kernel.dk>
 <20230716191113.waiypudo6iqwsm56@awork3.anarazel.de>
 <46c1075b-0daf-14db-cf48-5a5105b996de@kernel.dk>
In-Reply-To: <46c1075b-0daf-14db-cf48-5a5105b996de@kernel.dk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is a multi-part message in MIME format.
--------------bCIHdkNZpUGDMtxt4dQaBki0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/23 1:19?PM, Jens Axboe wrote:
> On 7/16/23 1:11?PM, Andres Freund wrote:
>> Hi,
>>
>> On 2023-07-16 12:13:45 -0600, Jens Axboe wrote:
>>> Here's one for 6.1-stable.
>>
>> Thanks for working on that!
>>
>>
>>> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
>>> index cc35aba1e495..de117d3424b2 100644
>>> --- a/io_uring/io_uring.c
>>> +++ b/io_uring/io_uring.c
>>> @@ -2346,7 +2346,7 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
>>>  					  struct io_wait_queue *iowq,
>>>  					  ktime_t *timeout)
>>>  {
>>> -	int ret;
>>> +	int token, ret;
>>>  	unsigned long check_cq;
>>>  
>>>  	/* make sure we run task_work before checking for signals */
>>> @@ -2362,9 +2362,18 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
>>>  		if (check_cq & BIT(IO_CHECK_CQ_DROPPED_BIT))
>>>  			return -EBADR;
>>>  	}
>>> +
>>> +	/*
>>> +	 * Use io_schedule_prepare/finish, so cpufreq can take into account
>>> +	 * that the task is waiting for IO - turns out to be important for low
>>> +	 * QD IO.
>>> +	 */
>>> +	token = io_schedule_prepare();
>>> +	ret = 0;
>>>  	if (!schedule_hrtimeout(timeout, HRTIMER_MODE_ABS))
>>> -		return -ETIME;
>>> -	return 1;
>>> +		ret = -ETIME;
>>> +	io_schedule_finish(token);
>>> +	return ret;
>>>  }
>>
>> To me it looks like this might have changed more than intended? Previously
>> io_cqring_wait_schedule() returned 0 in case schedule_hrtimeout() returned
>> non-zero, now io_cqring_wait_schedule() returns 1 in that case?  Am I missing
>> something?
> 
> Ah shoot yes indeed. Greg, can you drop the 5.10/5.15/6.1 ones for now?
> I'll get it sorted tomorrow. Sorry about that, and thanks for catching
> that Andres!

Greg, can you pick up these two for 5.10-stable and 5.15-stable? While
running testing, noticed another backport that was missing, so added
that as we..

-- 
Jens Axboe

--------------bCIHdkNZpUGDMtxt4dQaBki0
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-io_uring-add-reschedule-point-to-handle_tw_list.patch"
Content-Disposition: attachment;
 filename*0="0002-io_uring-add-reschedule-point-to-handle_tw_list.patch"
Content-Transfer-Encoding: base64

RnJvbSA0ZTIxNGU3ZTAxMTU4YTg3MzA4YTE3NzY2NzA2MTU5YmNhNDcyODU1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IE1vbiwgMTcgSnVsIDIwMjMgMTA6Mjc6MjAgLTA2MDAKU3ViamVjdDogW1BBVENIIDIv
Ml0gaW9fdXJpbmc6IGFkZCByZXNjaGVkdWxlIHBvaW50IHRvIGhhbmRsZV90d19saXN0KCkK
CkNvbW1pdCBmNTg2ODAwODU0NzhkZDI5MjQzNTcyNzIxMDEyMjk2MGQzOGU4MDE0IHVwc3Ry
ZWFtLgoKSWYgQ09ORklHX1BSRUVNUFRfTk9ORSBpcyBzZXQgYW5kIHRoZSB0YXNrX3dvcmsg
Y2hhaW5zIGFyZSBsb25nLCB3ZQpjb3VsZCBiZSBydW5uaW5nIGludG8gaXNzdWVzIGJsb2Nr
aW5nIG90aGVycyBmb3IgdG9vIGxvbmcuIEFkZCBhCnJlc2NoZWR1bGUgY2hlY2sgaW4gaGFu
ZGxlX3R3X2xpc3QoKSwgYW5kIGZsdXNoIHRoZSBjdHggaWYgd2UgbmVlZCB0bwpyZXNjaGVk
dWxlLgoKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyA1LjEwKwpTaWduZWQtb2ZmLWJ5
OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcvaW9fdXJpbmcu
YyB8IDcgKysrKystLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pb191cmluZy9pb191cmluZy5jIGIvaW9fdXJpbmcv
aW9fdXJpbmcuYwppbmRleCAzM2Q0YTI4NzFkYmIuLmVhZTdhM2Q4OTM5NyAxMDA2NDQKLS0t
IGEvaW9fdXJpbmcvaW9fdXJpbmcuYworKysgYi9pb191cmluZy9pb191cmluZy5jCkBAIC0y
MjE2LDkgKzIyMTYsMTIgQEAgc3RhdGljIHZvaWQgdGN0eF90YXNrX3dvcmsoc3RydWN0IGNh
bGxiYWNrX2hlYWQgKmNiKQogCQkJfQogCQkJcmVxLT5pb190YXNrX3dvcmsuZnVuYyhyZXEs
ICZsb2NrZWQpOwogCQkJbm9kZSA9IG5leHQ7CisJCQlpZiAodW5saWtlbHkobmVlZF9yZXNj
aGVkKCkpKSB7CisJCQkJY3R4X2ZsdXNoX2FuZF9wdXQoY3R4LCAmbG9ja2VkKTsKKwkJCQlj
dHggPSBOVUxMOworCQkJCWNvbmRfcmVzY2hlZCgpOworCQkJfQogCQl9IHdoaWxlIChub2Rl
KTsKLQotCQljb25kX3Jlc2NoZWQoKTsKIAl9CiAKIAljdHhfZmx1c2hfYW5kX3B1dChjdHgs
ICZsb2NrZWQpOwotLSAKMi40MC4xCgo=
--------------bCIHdkNZpUGDMtxt4dQaBki0
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-Use-io_schedule-in-cqring-wait.patch"
Content-Disposition: attachment;
 filename="0001-io_uring-Use-io_schedule-in-cqring-wait.patch"
Content-Transfer-Encoding: base64

RnJvbSBjOGM4OGQ1MjNjODllMGFjOGFmZmJmMmZkNTdkZWY4MmUwZDVkNGJmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZXMgRnJldW5kIDxhbmRyZXNAYW5hcmF6ZWwu
ZGU+CkRhdGU6IFN1biwgMTYgSnVsIDIwMjMgMTI6MDc6MDMgLTA2MDAKU3ViamVjdDogW1BB
VENIIDEvMl0gaW9fdXJpbmc6IFVzZSBpb19zY2hlZHVsZSogaW4gY3FyaW5nIHdhaXQKCkNv
bW1pdCA4YTc5NjU2NWNlYzM2MDEwNzFjYmJkMjdkNjMwNGUyMDIwMTlkMDE0IHVwc3RyZWFt
LgoKSSBvYnNlcnZlZCBwb29yIHBlcmZvcm1hbmNlIG9mIGlvX3VyaW5nIGNvbXBhcmVkIHRv
IHN5bmNocm9ub3VzIElPLiBUaGF0CnR1cm5zIG91dCB0byBiZSBjYXVzZWQgYnkgZGVlcGVy
IENQVSBpZGxlIHN0YXRlcyBlbnRlcmVkIHdpdGggaW9fdXJpbmcsCmR1ZSB0byBpb191cmlu
ZyB1c2luZyBwbGFpbiBzY2hlZHVsZSgpLCB3aGVyZWFzIHN5bmNocm9ub3VzIElPIHVzZXMK
aW9fc2NoZWR1bGUoKS4KClRoZSBsb3NzZXMgZHVlIHRvIHRoaXMgYXJlIHN1YnN0YW50aWFs
LiBPbiBteSBjYXNjYWRlIGxha2Ugd29ya3N0YXRpb24sCnQvaW9fdXJpbmcgZnJvbSB0aGUg
ZmlvIHJlcG9zaXRvcnkgZS5nLiB5aWVsZHMgcmVncmVzc2lvbnMgYmV0d2VlbiAyMCUKYW5k
IDQwJSB3aXRoIHRoZSBmb2xsb3dpbmcgY29tbWFuZDoKLi90L2lvX3VyaW5nIC1yIDUgLVgw
IC1kIDEgLXMgMSAtYyAxIC1wIDAgLVMkdXNlX3N5bmMgLVIgMCAvbW50L3QyL2Zpby93cml0
ZS4wLjAKClRoaXMgaXMgcmVwZWF0YWJsZSB3aXRoIGRpZmZlcmVudCBmaWxlc3lzdGVtcywg
dXNpbmcgcmF3IGJsb2NrIGRldmljZXMKYW5kIHVzaW5nIGRpZmZlcmVudCBibG9jayBkZXZp
Y2VzLgoKVXNlIGlvX3NjaGVkdWxlX3ByZXBhcmUoKSAvIGlvX3NjaGVkdWxlX2ZpbmlzaCgp
IGluCmlvX2NxcmluZ193YWl0X3NjaGVkdWxlKCkgdG8gYWRkcmVzcyB0aGUgZGlmZmVyZW5j
ZS4KCkFmdGVyIHRoYXQgdXNpbmcgaW9fdXJpbmcgaXMgb24gcGFyIG9yIHN1cnBhc3Npbmcg
c3luY2hyb25vdXMgSU8gKHVzaW5nCnJlZ2lzdGVyZWQgZmlsZXMgZXRjIG1ha2VzIGl0IHJl
bGlhYmx5IHdpbiwgYnV0IGFyZ3VhYmx5IGlzIGEgbGVzcyBmYWlyCmNvbXBhcmlzb24pLgoK
VGhlcmUgYXJlIG90aGVyIGNhbGxzIHRvIHNjaGVkdWxlKCkgaW4gaW9fdXJpbmcvLCBidXQg
bm9uZSBpbW1lZGlhdGVseQpqdW1wIG91dCB0byBiZSBzaW1pbGFybHkgc2l0dWF0ZWQsIHNv
IEkgZGlkIG5vdCB0b3VjaCB0aGVtLiBTaW1pbGFybHksCml0J3MgcG9zc2libGUgdGhhdCBt
dXRleF9sb2NrX2lvKCkgc2hvdWxkIGJlIHVzZWQsIGJ1dCBpdCdzIG5vdCBjbGVhciBpZgp0
aGVyZSBhcmUgY2FzZXMgd2hlcmUgdGhhdCBtYXR0ZXJzLgoKQ2M6IHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcgIyA1LjEwKwpDYzogUGF2ZWwgQmVndW5rb3YgPGFzbWwuc2lsZW5jZUBnbWFp
bC5jb20+CkNjOiBpby11cmluZ0B2Z2VyLmtlcm5lbC5vcmcKQ2M6IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogQW5kcmVzIEZyZXVuZCA8YW5kcmVzQGFu
YXJhemVsLmRlPgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjMwNzA3MTYy
MDA3LjE5NDA2OC0xLWFuZHJlc0BhbmFyYXplbC5kZQpbYXhib2U6IG1pbm9yIHN0eWxlIGZp
eHVwXQpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQog
aW9fdXJpbmcvaW9fdXJpbmcuYyB8IDE0ICsrKysrKysrKysrLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgMTEgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pb191
cmluZy9pb191cmluZy5jIGIvaW9fdXJpbmcvaW9fdXJpbmcuYwppbmRleCBlNjMzNzk5Yzlj
ZWEuLjMzZDRhMjg3MWRiYiAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvaW9fdXJpbmcuYworKysg
Yi9pb191cmluZy9pb191cmluZy5jCkBAIC03Nzg1LDcgKzc3ODUsNyBAQCBzdGF0aWMgaW5s
aW5lIGludCBpb19jcXJpbmdfd2FpdF9zY2hlZHVsZShzdHJ1Y3QgaW9fcmluZ19jdHggKmN0
eCwKIAkJCQkJICBzdHJ1Y3QgaW9fd2FpdF9xdWV1ZSAqaW93cSwKIAkJCQkJICBrdGltZV90
ICp0aW1lb3V0KQogewotCWludCByZXQ7CisJaW50IHRva2VuLCByZXQ7CiAKIAkvKiBtYWtl
IHN1cmUgd2UgcnVuIHRhc2tfd29yayBiZWZvcmUgY2hlY2tpbmcgZm9yIHNpZ25hbHMgKi8K
IAlyZXQgPSBpb19ydW5fdGFza193b3JrX3NpZygpOwpAQCAtNzc5NSw5ICs3Nzk1LDE3IEBA
IHN0YXRpYyBpbmxpbmUgaW50IGlvX2NxcmluZ193YWl0X3NjaGVkdWxlKHN0cnVjdCBpb19y
aW5nX2N0eCAqY3R4LAogCWlmICh0ZXN0X2JpdCgwLCAmY3R4LT5jaGVja19jcV9vdmVyZmxv
dykpCiAJCXJldHVybiAxOwogCisJLyoKKwkgKiBVc2UgaW9fc2NoZWR1bGVfcHJlcGFyZS9m
aW5pc2gsIHNvIGNwdWZyZXEgY2FuIHRha2UgaW50byBhY2NvdW50CisJICogdGhhdCB0aGUg
dGFzayBpcyB3YWl0aW5nIGZvciBJTyAtIHR1cm5zIG91dCB0byBiZSBpbXBvcnRhbnQgZm9y
IGxvdworCSAqIFFEIElPLgorCSAqLworCXRva2VuID0gaW9fc2NoZWR1bGVfcHJlcGFyZSgp
OworCXJldCA9IDE7CiAJaWYgKCFzY2hlZHVsZV9ocnRpbWVvdXQodGltZW91dCwgSFJUSU1F
Ul9NT0RFX0FCUykpCi0JCXJldHVybiAtRVRJTUU7Ci0JcmV0dXJuIDE7CisJCXJldCA9IC1F
VElNRTsKKwlpb19zY2hlZHVsZV9maW5pc2godG9rZW4pOworCXJldHVybiByZXQ7CiB9CiAK
IC8qCi0tIAoyLjQwLjEKCg==

--------------bCIHdkNZpUGDMtxt4dQaBki0--
