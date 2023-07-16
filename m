Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F8E7550E9
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjGPTTh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGPTTf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:19:35 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48771E4B
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:19:33 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bb106ad293so7307385ad.0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689535173; x=1692127173;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=apX7zIGsap3FGHSRKYLle6eu1Lq5dKhY0zPfq590z1U=;
        b=R5hDH6+VroFsmO2iwcEJWbUFHDawSNAjaEhqq3T9X6AiS6FFr9F3uOq70P9K6B4S4k
         gklbkXpcj8p1B7tbnJJflV3AGk5YENTTeUUnNNGOVhtOntLe4MIWqkyFWGfj+hDVXeJ1
         Rv0pIJP2L768/v93KkhoeNlFoPa4IMZlv1urz/8XoNCiSPHRk7HOvoRsufIo8NbGoSTj
         0o/1HHZD3SIGybxKGaR2nsTVoDcdg2YvjVJ0K1xbrLbRdYoAZkCrNVF4769PRUY21MIR
         LNGWx9l9A328MQfLTdWFVbCanYh5oNlACj2N/aH/Rw4H9/hiBidVh4PnEe0zBc7P73WP
         HoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689535173; x=1692127173;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=apX7zIGsap3FGHSRKYLle6eu1Lq5dKhY0zPfq590z1U=;
        b=CrFPigjIUIQYm05HRu3/H+DxCZSCf51XvXjIlkweWtzc4smDHlV9yUqYJznsi7MTsv
         ai37MMv6O/skijpTBvwg6aCIcypqmifktmJ3nDftNEgRkwID/92i7Uwz4n56cTwfvy7f
         fFksi1quKPADx0nPxsuaoiBzxPpbVkdC+vqkPrpkUn3irYGS+uh9jtIbZbMwKn3b3/v5
         NhqrPOkUI4x/VP2d7o4blikK+j+q4HthJbfKWxc4YZNnpazqyA5qAdO62hM9nek4Js7l
         IGcVCz3X8ouDbGRFP8Cag+3gwttXOTBE5537HP4B6qtS+ZpPrIk750Bz1OdPacjH8cIe
         mrwQ==
X-Gm-Message-State: ABy/qLayIKEMM2U2bO16W5SK8h5a+PVHdLT5Nzd6gMQVssbDbMUmLV6W
        IujV8NdF6WmiQseJUImLLVptEQ==
X-Google-Smtp-Source: APBJJlGItuJ+JN0XXlOv6Jy8dk8GUEpxm7er0XrlQHXqaz3qu3H2JfzYSaFsoXEcbqG8caH0zEgQag==
X-Received: by 2002:a17:902:f691:b0:1b8:ac61:ffcd with SMTP id l17-20020a170902f69100b001b8ac61ffcdmr5573925plg.3.1689535172797;
        Sun, 16 Jul 2023 12:19:32 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902d2cf00b001b3ce619e2esm11290749plc.179.2023.07.16.12.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 12:19:32 -0700 (PDT)
Message-ID: <46c1075b-0daf-14db-cf48-5a5105b996de@kernel.dk>
Date:   Sun, 16 Jul 2023 13:19:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: FAILED: patch "[PATCH] io_uring: Use io_schedule* in cqring wait"
 failed to apply to 6.1-stable tree
Content-Language: en-US
To:     Andres Freund <andres@anarazel.de>
Cc:     gregkh@linuxfoundation.org, asml.silence@gmail.com,
        stable@vger.kernel.org
References: <2023071620-litigate-debunk-939a@gregkh>
 <0cfb74bb-c203-39a1-eab7-abeeae724b68@kernel.dk>
 <20230716191113.waiypudo6iqwsm56@awork3.anarazel.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230716191113.waiypudo6iqwsm56@awork3.anarazel.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 7/16/23 1:11?PM, Andres Freund wrote:
> Hi,
> 
> On 2023-07-16 12:13:45 -0600, Jens Axboe wrote:
>> Here's one for 6.1-stable.
> 
> Thanks for working on that!
> 
> 
>> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
>> index cc35aba1e495..de117d3424b2 100644
>> --- a/io_uring/io_uring.c
>> +++ b/io_uring/io_uring.c
>> @@ -2346,7 +2346,7 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
>>  					  struct io_wait_queue *iowq,
>>  					  ktime_t *timeout)
>>  {
>> -	int ret;
>> +	int token, ret;
>>  	unsigned long check_cq;
>>  
>>  	/* make sure we run task_work before checking for signals */
>> @@ -2362,9 +2362,18 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
>>  		if (check_cq & BIT(IO_CHECK_CQ_DROPPED_BIT))
>>  			return -EBADR;
>>  	}
>> +
>> +	/*
>> +	 * Use io_schedule_prepare/finish, so cpufreq can take into account
>> +	 * that the task is waiting for IO - turns out to be important for low
>> +	 * QD IO.
>> +	 */
>> +	token = io_schedule_prepare();
>> +	ret = 0;
>>  	if (!schedule_hrtimeout(timeout, HRTIMER_MODE_ABS))
>> -		return -ETIME;
>> -	return 1;
>> +		ret = -ETIME;
>> +	io_schedule_finish(token);
>> +	return ret;
>>  }
> 
> To me it looks like this might have changed more than intended? Previously
> io_cqring_wait_schedule() returned 0 in case schedule_hrtimeout() returned
> non-zero, now io_cqring_wait_schedule() returns 1 in that case?  Am I missing
> something?

Ah shoot yes indeed. Greg, can you drop the 5.10/5.15/6.1 ones for now?
I'll get it sorted tomorrow. Sorry about that, and thanks for catching
that Andres!

-- 
Jens Axboe

