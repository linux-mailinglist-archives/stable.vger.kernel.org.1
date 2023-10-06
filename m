Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49567BC216
	for <lists+stable@lfdr.de>; Sat,  7 Oct 2023 00:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjJFWMx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 6 Oct 2023 18:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJFWMw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Oct 2023 18:12:52 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6891BF
        for <stable@vger.kernel.org>; Fri,  6 Oct 2023 15:12:50 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c874b43123so22103555ad.2
        for <stable@vger.kernel.org>; Fri, 06 Oct 2023 15:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696630370; x=1697235170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHQtvCOqet4K+ZxgJSgWcab3IirKmkpaYjS7FQ4Cvcc=;
        b=D2RfmYGl8b8qjw74OumE1KeEPBqg/v3XzlcSTvg2OBueTmFN0aHBeAlem543lpoUai
         zKgLTR4VJGyqnID4JASC4+YoW8+0bM2or+5vxQCEO8JAu4T3bCjyaHmcEAhtCkZW80e3
         T4QCOR0erfHIMaJm2ynMWar4e6SVQJ/NANLqw6Xp9kcw0B/bfGglNHZ7HbHSuijIKZiF
         HU3mjr65wXatbgzjAmdGugvnhfnmI4cxX1LbILlq2aEUKcHcwuswjheCuGck+gyuzNWI
         4m6BgnmR9ownByprzb+tAZ6EGH5cTCyW43qIcB4ghq8TYkzkSO8E0+/KLTrpYBcGGJ+n
         Wcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696630370; x=1697235170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHQtvCOqet4K+ZxgJSgWcab3IirKmkpaYjS7FQ4Cvcc=;
        b=IGUd0Wi4ZosFIMmMvZ0qNElaSOdgL+x0rnGYQIXsGBxAvzuQGZ3I1VoYt+Aa4NYgd9
         8/6ZaZTY5DsPod2+vgaMA+nO5jXLrPyj/47vQNqRWfPpitilJCM6NVZ19DcqDJCfd6kZ
         3wnOgCaOlpAWzS3BN5A6IDBeCDdloZ9SeFiJHBiX5T5gmDwlxFq0gGmW1beBqw9nUhOQ
         fAlOaVeC3RVWcpTaqewRGe2NCFAZVNfeWmWDiKFUchXUApwBWF2xebV9Mt0a8F/mqnUH
         qiVUOnQsIx0cO7hUKcYpLfT7O5M8VgaHIOcwsAn/ZWcGooadJXXA9kvSSGCRcE9AkZWn
         KX+g==
X-Gm-Message-State: AOJu0YxTleIraI/Wlo/Heel5tTrl2/xglujEeMA8vWQu1/GZqqHJ3QKQ
        61Z6XgmqqQ0LEoM8hfvnnvKISA==
X-Google-Smtp-Source: AGHT+IFch0L2eBB11k+yQ7Pp4uZMeyMYYxH4y9b95LG8JPljPZHp5HnbtE3E2Lg41WF/o5h824lBjA==
X-Received: by 2002:a17:902:8f8b:b0:1c5:f0fd:51be with SMTP id z11-20020a1709028f8b00b001c5f0fd51bemr8305666plo.69.1696630370236;
        Fri, 06 Oct 2023 15:12:50 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:4bb6:b4ed:3ecb:e6a6? ([2804:14d:5c5e:44fb:4bb6:b4ed:3ecb:e6a6])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001c20c608373sm4411655plf.296.2023.10.06.15.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 15:12:49 -0700 (PDT)
Message-ID: <065a0dac-499f-7375-ddb4-1800e8ef61d1@mojatatu.com>
Date:   Fri, 6 Oct 2023 19:12:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [REGRESSION] Userland interface breaks due to hard HFSC_FSC
 requirement
Content-Language: en-US
To:     Christian Theune <ct@flyingcircus.io>, stable@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     regressions@lists.linux.dev, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
From:   Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 06/10/2023 05:37, Christian Theune wrote:
> Hi,
> 
> (prefix, I was not aware of the regression reporting process and incorrectly reported this informally with the developers mentioned in the change)
> 
> I upgraded from 6.1.38 to 6.1.55 this morning and it broke my traffic shaping script, leaving me with a non-functional uplink on a remote router.
> 
> The script errors out like this:
> 
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + ext=ispA
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + ext_ingress=ifb0
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + modprobe ifb
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + modprobe act_mirred
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc del dev ispA root
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2061]: Error: Cannot delete qdisc with handle of zero.
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc del dev ispA ingress
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2064]: Error: Cannot find specified qdisc on specified device.
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc del dev ifb0 root
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2066]: Error: Cannot delete qdisc with handle of zero.
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc del dev ifb0 ingress
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2067]: Error: Cannot find specified qdisc on specified device.
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + true
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc add dev ispA handle ffff: ingress
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + ifconfig ifb0 up
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc filter add dev ispA parent ffff: protocol all u32 match u32 0 0 action mirred egress redirect dev ifb0
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc qdisc add dev ifb0 root handle 1: hfsc default 1
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc class add dev ifb0 parent 1: classid 1:999 hfsc rt m2 2.5gbit
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2053]: + tc class add dev ifb0 parent 1:999 classid 1:1 hfsc sc rate 50mbit
> Oct 06 05:49:22 wendy00 isp-setup-shaping-start[2077]: Error: Invalid parent - parent class must have FSC.
> 
> The error message is also a bit weird (but that’s likely due to iproute2 being weird) as the CLI interface for `tc` and the error message do not map well. (I think I would have to choose `hfsc sc` on the parent to enable the FSC option which isn’t mentioned anywhere in the hfsc manpage).
> 
> The breaking change was introduced in 6.1.53[1] and a multitude of other currently supported kernels:
> 

Hi,

Your script is actually incorrect.
`man 7 tc-hfsc` goes in depth into why, but I just wanna highlight this 
section:
SEPARATE LS / RT SCs
        Another difference from the original HFSC paper is that RT and 
LS SCs can be specified separately. Moreover, leaf classes are
        allowed to have only either RT SC or LS SC. For interior 
classes, only LS SCs make sense: any RT SC will be ignored.

The last part ("For interior classes...") was what the referenced patch 
fixed. We were mistakenly allowing RTs into "interior classes" which the 
implementation never accounted for and this was a source of crashes. I'm 
surprised you were lucky enough to never crash the kernel ;)
-=
I believe the script could be updated to the following and still achieve 
the same results:
tc class add dev ifb0 parent 1: classid 1:999 hfsc ls m2 2.5gbit
tc class add dev ifb0 parent 1:999 classid 1:1 hfsc rt rate 50mbit


