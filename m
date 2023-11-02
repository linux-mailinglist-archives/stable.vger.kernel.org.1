Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC5C7DF5A5
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 16:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjKBPFh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 11:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjKBPFg (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 11:05:36 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8396BDC
        for <stable@vger.kernel.org>; Thu,  2 Nov 2023 08:05:33 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7a66bf80fa3so8989939f.0
        for <stable@vger.kernel.org>; Thu, 02 Nov 2023 08:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1698937533; x=1699542333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D2a5tTRmonri7Z9XihJIqNdxldq3XxfA80Y9RfLaY0Y=;
        b=IIJYk3ZcovZ0+t7Ku8hAtlMdoWCbvH0abJSFH9P2Vm2H+khoSypebXRXGPTphUyDYx
         ssfrvtr6bt+T0nXDuok1avgo6IjYBIBjUK86zezBpwkBTeNKdWhhD7Sg44bDvdiulMmt
         E1CTNHv3surOaFIpkxfqRP4lr0HFRAiO5M8bkYTZ7SYQhmT5q4neoUH4GF6FXUGU+tKD
         mIsySOQYv4G5KqNUL34/MwzLfkkRVnY7sDnaYzs+CoHvU+1BhgvqZrFcqSplUmsKsyoG
         COL49AEW3etoGYlVxIVUArUCHj6iu/F18vyhyDBKasMq0czKcSRlkuRSvwHAO23hQxOv
         +MOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698937533; x=1699542333;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2a5tTRmonri7Z9XihJIqNdxldq3XxfA80Y9RfLaY0Y=;
        b=wN0xQoQl3t3wfTU37XylFmn+PuThMh/U6MVCFf46Ek0ZGFitFuy+o9/o2IVKoLLpEo
         lClOFeI6n01P/FMt4AjefHrFKYrqT9coAX17QYfGfb8xN8p0BpM2Mwl4VZV6B8tRgFGm
         DvkyXZZqpP9Oc/mm/CvDEIRkvuaJPNtBrxCdXV7KVBSdLBCUYPAPwzUcyAYH1YjlIfkg
         916d6SmYexD9vmFbLD2v80iGZg3/vh/EATOxcAlLhnO8B0PqkPgnEavT562fhc8AFD5g
         jOqd96kjHxvIW4HMMV3NBeE9pYn2DIyPNH5dZRCEF0nMEs1aaZ6hJloO0qTzpvMCF2+s
         +dJw==
X-Gm-Message-State: AOJu0Ywto/sLFRwyjAS602sbKuYqYgeiNjQeJH7mh432BKo3Cpixtucx
        DObVDc5I2R+e9gqKnHDEcDpxrg==
X-Google-Smtp-Source: AGHT+IFpac6P14IraImrsB4coQTupU8u1r6P3a/TAw+A0We6PTiUJQaemSGMZnM+cleKltMqggKQxA==
X-Received: by 2002:a5d:924a:0:b0:7a9:7aa9:c175 with SMTP id e10-20020a5d924a000000b007a97aa9c175mr20960142iol.1.1698937532884;
        Thu, 02 Nov 2023 08:05:32 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u1-20020a02aa81000000b0045bb982a3d2sm1615423jai.60.2023.11.02.08.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 08:05:32 -0700 (PDT)
Message-ID: <7cd11ce1-01cc-4e5a-aa6e-b55e1584c221@kernel.dk>
Date:   Thu, 2 Nov 2023 09:05:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Backport? RIP: 0010:throtl_trim_slice+0xc6/0x320
 caused kernel panic
Content-Language: en-US
To:     Christian Theune <ct@flyingcircus.io>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org
Cc:     linux-block@vger.kernel.org, yukuai3@huawei.com,
        ming.lei@redhat.com
References: <F5E0BC95-9883-4E8E-83A6-CD9962B7E90C@flyingcircus.io>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <F5E0BC95-9883-4E8E-83A6-CD9962B7E90C@flyingcircus.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 11/2/23 8:53 AM, Christian Theune wrote:
> Hi,
> 
> I hope i’m not jumping the gun, but I guess I’d be interested in a backport to said issue … ;)
> 
> We’re running on 6.1.55/57 and this has started breaking for us after we updated from 6.1.51.
> 
> The issue seems to be well-described and already fixed in
> https://lkml.kernel.org/linux-block/e1d7c106-ea6f-922f-971f-691e7e0faf9d@huaweicloud.com/T/
> but I can’t post to that thread easily and it seems backporting isn’t on the radar as of now.

The fix is already in 6.1.61:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.1.y&id=6a5b845b57b122534d051129bc4fc85eac7f4a68

-- 
Jens Axboe


