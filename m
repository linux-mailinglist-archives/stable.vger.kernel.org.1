Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE8A757E39
	for <lists+stable@lfdr.de>; Tue, 18 Jul 2023 15:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjGRNxP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 18 Jul 2023 09:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjGRNxI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 18 Jul 2023 09:53:08 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4652B189
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 06:52:48 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-765a5b93b5bso525515685a.3
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 06:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689688367; x=1692280367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wOGUiiwHsSBHl12XtJ8LcCiEnJDe2YWZioBcYbS55rU=;
        b=GUVS2gtir+/tQe08uzQmG7d6ws5ez+Lo+mrnWRVxF0XAuq5WtGb+oFjzhwj5xkxqlB
         ISFj5XxG2iWJVN/RCa9xL4A2zmq3GotkbzNGmcJoTLPX1CdgCPt93oRKihNTTJYPd77X
         lGWn1avJRRwJFZeyAPUH9y5YZkQQfmYDmd7+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689688367; x=1692280367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wOGUiiwHsSBHl12XtJ8LcCiEnJDe2YWZioBcYbS55rU=;
        b=Dx3Bx4Ea6N4GoTZBO8dMJO2LWmskLYL3xMdZDUnTHEFJ+nEt3xPpVUQDydrrKqymwp
         erstKwjoXzSX+RL19V7odVmsxfZSLMvu72QXoCyOhV99zT/VLC1IbLXiBi+mO8eKRk9j
         AlWAX8cBQc72I3k4sQDuCGCFfPaDygStYf4x0N0gSCp8w5eUeUEIPVMoCWIH07rzysro
         yjDArRxhW0EGFzBZjt9YSEuIiwPSmlTl3CsF2f0mjrQJEjWcevyZkvod1PMne2r8Y7BF
         j/QYaowOMCSD5g9xgZ4WtJ/Jx/qXWH0xwSHQm+vWxtb2paLXlSIpHgnLXzcXuGBECn8R
         3IEQ==
X-Gm-Message-State: ABy/qLZvB336wXXDNQ2LJGLbgzLcwntwRqpVjBx4b7tnaa+E79++pwgt
        dgCGJ/zt8MAjKcLyYJsV/Viuyg==
X-Google-Smtp-Source: APBJJlGBpV/uo36Ay47pSxUkAS+j1aDFdq2pvCtJBGwOJdJj6BHlnc1x4ZzsliaMooTU25QjFhYC0Q==
X-Received: by 2002:a0c:f2d3:0:b0:632:25c5:6fb8 with SMTP id c19-20020a0cf2d3000000b0063225c56fb8mr13766258qvm.31.1689688367322;
        Tue, 18 Jul 2023 06:52:47 -0700 (PDT)
Received: from [192.168.0.140] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id x21-20020a0cb215000000b006301d31e315sm747136qvd.10.2023.07.18.06.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 06:52:46 -0700 (PDT)
Message-ID: <da595585-4929-2c21-7e48-f9f8cdad6cf7@joelfernandes.org>
Date:   Tue, 18 Jul 2023 09:52:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Build failures / crashes in stable queue branches
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     stable <stable@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <897ebb05-5a1f-e353-8877-49721c52d065@roeck-us.net>
 <20230715154923.GA2193946@google.com>
 <907909df-d64f-e40a-0c9c-fc5c225a235c@huaweicloud.com>
 <2023071625-parsnip-pursuable-b5c8@gregkh>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <2023071625-parsnip-pursuable-b5c8@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 7/16/23 10:30, Greg KH wrote:
> On Sun, Jul 16, 2023 at 11:20:33AM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2023/07/15 23:49, Joel Fernandes 写道:
>>> Hi Yu,
>>>
>>> On Fri, Jul 14, 2023 at 03:21:46AM -0700, Guenter Roeck wrote:
>>> [..]
>>>> ---------
>>>> 6.1.y:
>>>>
>>>> Build reference: v6.1.38-393-gb6386e7314b4
>>>> Compiler version: alpha-linux-gcc (GCC) 11.4.0
>>>> Assembler version: GNU assembler (GNU Binutils) 2.40
>>>>
>>>> Building alpha:allmodconfig ... failed
>>>> Building m68k:allmodconfig ... failed
>>>> --------------
>>>> Error log:
>>>> <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>>>> In file included from block/genhd.c:28:
>>>> block/genhd.c: In function 'disk_release':
>>>> include/linux/blktrace_api.h:88:57: error: statement with no effect [-Werror=unused-value]
>>>>      88 | # define blk_trace_remove(q)                            (-ENOTTY)
>>>>         |                                                         ^
>>>> block/genhd.c:1185:9: note: in expansion of macro 'blk_trace_remove'
>>>>    1185 |         blk_trace_remove(disk->queue);
>>>
>>> 6.1 stable is broken and gives build warning without:
>>>
>>> cbe7cff4a76b ("blktrace: use inline function for blk_trace_remove() while blktrace is disabled")
>>>
>>> Could you please submit it to stable for 6.1? (I could have done that but it
>>> looks like you already backported related patches so its best for you to do
>>> it, thanks for your help!).
>>
>> Thanks for the notice, however, I'll suggest to revert this patch for
>> now, because there are follow up fixes that is not applied yet.
> 
> Which specific patch should be dropped?
> 

Yu: Ping? ;-). Are you suggesting the original set be reverted, or Greg apply 
the above fix? Let us please keep 6.1 stable unbroken. ;-)

Apologies for my noise if the issue has already been resolved.

  - Joel


