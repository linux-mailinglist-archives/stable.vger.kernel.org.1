Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DB6756FAD
	for <lists+stable@lfdr.de>; Tue, 18 Jul 2023 00:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjGQWRl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 17 Jul 2023 18:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjGQWRl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 18:17:41 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21642B2
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 15:17:40 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8a462e0b0so30311755ad.3
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 15:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689632259; x=1692224259;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=et+MpedzBPqZZg2X4/iaGx2gZkKszzzSuFjxJeGvmys=;
        b=JKhxQ+O2lG6Fdyl0k39/fiyWjVPbIzmRl74uPaHu0PUazzFzOzgbfagA/ZQ8LwDqzt
         GNrGfCd/KEtJDz+oUgxqFB10htRHOw9Y6wECivKNcVATPHM0rXr9QwHpHqvsdBX4V142
         YEGDzh6q7IxnMRs+AbaZZHHSIZQjOcYk140MpBo3KOFMTvBuLF1LRg31vLwQVCgcfkYf
         E8k4vrLMAGDUv9fMsJtDzvoeQ5raz/VUupjgU+hblRvJ4DoE9qGZ1+nT+glINmJefv1Y
         kBiW0mxmVtXetB+MpR/r0h7CTxh26zi5NDf3MDTAN3DO/xrzzWkASlkzAIyiHFcdN3ND
         E3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689632259; x=1692224259;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=et+MpedzBPqZZg2X4/iaGx2gZkKszzzSuFjxJeGvmys=;
        b=h3WOTnelYgVQUySSict4V9X0ivsvT6J2eHXsjpkaftQL/UoPGVOwxnrw1vFaGao/fc
         GVo+rFGKlrvstmi8Wr8/aWUp2jkWpSZv9U+m0mNxc++Inv6bKZiPyYNwoyPdcym8++1C
         C4sDrWdAXOBNKTaKZO4sjoj7G69OFGsIUTK5ZT9tgmaoJ2S9Vi/fdMrjHvLX647g8P5Q
         21gapm1l8oJRs0sAIYM9klADjnfl3QDT/XgMGKTWyaFcqjcAWpiEM5sv96l56rGVJFpj
         DP2WDkHz6yVwltZ6pGUMZsmD2JQyoGvi23g5SahIEZQ1PGBOkz3ismTaKbOSo9H4D0ek
         soLQ==
X-Gm-Message-State: ABy/qLazsf4SK1Maaoi1R2UyyIVR9SkrpABUNrM2Sh+V+lWwNBjWeal6
        tRs8/JgHV5KHnBG6WJzzuEE=
X-Google-Smtp-Source: APBJJlEMpWjE4CQr9imo1ZNW7y4XhI7cMKReGMwmAKaJs38Qi9c0JuxpglT/XkUlNddILNwH4g94fA==
X-Received: by 2002:a17:902:ee89:b0:1bb:2d0b:1a18 with SMTP id a9-20020a170902ee8900b001bb2d0b1a18mr4107117pld.50.1689632259510;
        Mon, 17 Jul 2023 15:17:39 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:210:18ff:fe59:7883? ([2001:df0:0:200c:210:18ff:fe59:7883])
        by smtp.gmail.com with ESMTPSA id jw10-20020a170903278a00b001b8c6890623sm369335plb.7.2023.07.17.15.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 15:17:38 -0700 (PDT)
Message-ID: <f0fd6bda-7b63-ac47-a1db-4eed0164f0e3@gmail.com>
Date:   Tue, 18 Jul 2023 10:17:29 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.4.y] block: add overflow checks for Amiga partition
 support
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>
References: <2023071117-convene-mockup-27f2@gregkh>
 <20230715232656.8632-1-schmitzmic@gmail.com>
 <cbdb7cde68dc4d239861a631436dc01d@AcuMS.aculab.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <cbdb7cde68dc4d239861a631436dc01d@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi David,

On 17/07/23 20:00, David Laight wrote:
> From: Michael Schmitz
>> Sent: 16 July 2023 00:27
>>
>> The Amiga partition parser module uses signed int for partition sector
>> address and count, which will overflow for disks larger than 1 TB.
>>
>> Use u64 as type for sector address and size to allow using disks up to
>> 2 TB without LBD support, and disks larger than 2 TB with LBD. The RBD
>> format allows to specify disk sizes up to 2^128 bytes (though native
>> OS limitations reduce this somewhat, to max 2^68 bytes),
> Pretty much everything (including the mass of an proton) stops
> you having a disk with anywhere near 2^64 bytes in it.

I put my hopes on all that dark matter we still seem to be missing then.

Seriously though - RDB allows for this size, no matter how unlikely. 
2^32 heads or 2^32 sectors per track would have been seen as impossible 
when RDB was designed. On the other hand, the '16 bit address space 
ought to be enough for everybody' was probably still fresh in the mind 
of the Amiga developers at that time.

All that matters is that we get the size calculations right (and then 
let the partition core enforce the known disk size limit).

Cheers,

     Michael


>
> 	David
>
>> so check for
>> u64 overflow carefully to protect against overflowing sector_t.
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
