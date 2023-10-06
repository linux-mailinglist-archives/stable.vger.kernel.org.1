Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1027BBF02
	for <lists+stable@lfdr.de>; Fri,  6 Oct 2023 20:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjJFSvV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 6 Oct 2023 14:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjJFSvU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Oct 2023 14:51:20 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D928BE
        for <stable@vger.kernel.org>; Fri,  6 Oct 2023 11:51:19 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c874b43123so20667465ad.2
        for <stable@vger.kernel.org>; Fri, 06 Oct 2023 11:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696618279; x=1697223079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xCV04zCvYMSRZ8PLVrYCErwlWKz0o53q1/ujh2vCW2I=;
        b=FFk1/nxTCSIyAwRQiKs1Ezb+gJEOmBaNx39KtBO3YvDg+GW25uJD5Tzv124epVi2Jw
         +9oqqTTomuxoYVyJLGjAiSeA9untb2CGDeUv1LsI3sRuzD9pVftFZi4gR35Ya+MDJrKJ
         fbObCNCaHE97KRKoj7xXMXC5KQY6U7D3/r4+Z3ZqPEsd7kg0rmJ/C3tLcHgyeq9qOKWJ
         QwGUzvOpB1L6tayyZVu/bG2xnPrCqNn+DFzyndMzmuo+Z/w3FsGhjwuEq0IWpQWk8IOS
         yZ7fC3xLkNtHfvIrJe72dktcNOLB3qsfrKf/fhBuumJ0SRpFpnLnYMh3tWIhkwIlrQLq
         /kDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618279; x=1697223079;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xCV04zCvYMSRZ8PLVrYCErwlWKz0o53q1/ujh2vCW2I=;
        b=kjGZ04zSvDbprBKXyTGkjGxn4OtgV74L5ZnJK5XIMdHAuNw1Rm54zdo+rwPvkP0orD
         VQYm1X98iniTPZFJCnQssKX/lW5ML3zO1/X3COK7oXyu8g1D2VAA4DYudw/hvQg9Oggg
         3LCB3Mx8gQGZmAzvp0JJUfkpInVCBUsSjx1fvDzSWacqxTPWdgkG0J5OrAhYVOG4T/T4
         l5Cj7+NQv/y6fU9Ax0j0zJqBB22f4GNSHH/F+9qIH3f0ETreBPbJbjqVqAaqx5aadjv7
         310NwKuDlWPPxiAwrHD+ngCKLKVhgPJEoXFhv5fufpM3G/H5ii1yKxpOnxYZWz61Xa+C
         051g==
X-Gm-Message-State: AOJu0YyqJHLQiWIN8Mx3VeYUKcHmmhKt+ilp6xpVzh3RFLJESX7f0HUz
        VzrWlkgsLz/uKsAqi3JHlhNHPQ==
X-Google-Smtp-Source: AGHT+IEFrO5y5ULP5CWa6iaqkAW2+FU1lSXIQ3Vc6+v8Jz0uz9VPVoCU5MsvSwDlydQL8BKJvZTrlQ==
X-Received: by 2002:a17:902:e5c7:b0:1c5:b855:38f with SMTP id u7-20020a170902e5c700b001c5b855038fmr10107695plf.24.1696618278642;
        Fri, 06 Oct 2023 11:51:18 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:c07e:d4ae:2d8a:ba4? ([2804:14d:5c5e:44fb:c07e:d4ae:2d8a:ba4])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902d4c100b001b9f7bc3e77sm4251840plg.189.2023.10.06.11.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 11:51:18 -0700 (PDT)
Message-ID: <c7d4fe7e-5229-71c7-b93d-f6203e163f02@mojatatu.com>
Date:   Fri, 6 Oct 2023 15:51:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [REGRESSION] Userland interface breaks due to hard HFSC_FSC
 requirement
Content-Language: en-US
To:     Christian Theune <ct@flyingcircus.io>, stable@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     regressions@lists.linux.dev, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        Jamal Hadi Salim <jhs@mojatatu.com>
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
From:   Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
> ----
> commit a1e820fc7808e42b990d224f40e9b4895503ac40
> Author: Budimir Markovic <markovicbudimir@gmail.com>
> Date: Thu Aug 24 01:49:05 2023 -0700
> 
> net/sched: sch_hfsc: Ensure inner classes have fsc curve
> 
> [ Upstream commit b3d26c5702c7d6c45456326e56d2ccf3f103e60f ]
> 
> HFSC assumes that inner classes have an fsc curve, but it is currently
> possible for classes without an fsc curve to become parents. This leads
> to bugs including a use-after-free.
> 
> Don't allow non-root classes without HFSC_FSC to become parents.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
> Signed-off-by: Budimir Markovic <markovicbudimir@gmail.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Link: https://lore.kernel.org/r/20230824084905.422-1-markovicbudimir@gmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ----
> 
> Regards,
> Christian
> 
> [1] https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.1.53
> 
> #regzbot introduced: a1e820fc7808e42b990d224f40e9b4895503ac40
> 
> 

I will take a look,
Thanks!
