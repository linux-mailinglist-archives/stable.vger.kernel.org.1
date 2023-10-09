Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AB77BE4C5
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 17:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376756AbjJIPcE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 11:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376424AbjJIPcD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 11:32:03 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4783BD8
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 08:32:02 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c88b467ef8so26705085ad.0
        for <stable@vger.kernel.org>; Mon, 09 Oct 2023 08:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696865522; x=1697470322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zb8b93dv90D56oZ0oYIg7blNmShNpf/GwP56Ss+ZJmk=;
        b=mCi+C5kFlf+r+yX/403w9DJzNAmqkOWmRTZ16TVaq8iU7bRtHPUlRPSYPhaJz+DKHR
         ekCVVrpFP4VONMWp3y9OJC4xwpcZrdLLGbSKmUfgjiACiPwcZqE5aL7+B+pMkbvi+mVt
         SLD8qHXgB/pFzEEfA5tOVIcSFFyFmr+fK2zMClrgkCyQMOiOSFgSwNVhl6C257nk9+eH
         TWql9ukUcodK92/Ru2vhqRMLucFm8J1FuqACLrr7LNhZQG0VNWigBJpWRZnKBa7kot+J
         EqFlkGs/3WMy2jdd0PwjlAlhUYiLEO8HFdSJT+EBbl2ix4hKZe66wFPT9JB1kCjRA4n/
         FB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696865522; x=1697470322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zb8b93dv90D56oZ0oYIg7blNmShNpf/GwP56Ss+ZJmk=;
        b=d3rB222XcnHTz6+OTXx+ELHWd6xUSRieC/J5c1PLUKoqePb2H5FM3agg3ZYpOLUybO
         +GCpTFgcsq5EzZCBaYXDEl09TBBi8i3eQWiW9uPw/xA2ukQBwGkohKqIfLKkSpe5du21
         MbQ5w4gdUKUGzhaMZoG3elEpC7fnmz0IOaiaD160dSPswwY7bfpxpt9IKhD1gl+u4Quo
         2fTPrRYi4Ba7a0s/k1KCGbbHPNG4nDkeh+Q6wnAxM6zfreTSTsXbpEFtMVtNFRk8fdqI
         GzyebYYjQJdNAi0yJE1barKmo3Fx5S06DHZrJQ9KLfQiXbfgDhiapiZ7k74KfaxD7cN3
         XzMA==
X-Gm-Message-State: AOJu0Yzw0Vkz4axIBcYJn00JOGkq8jaMhaEV59h+nPAxNu6KL0qnKP3H
        8BP2cak6FNWu9QlcpeF8aAu7Og==
X-Google-Smtp-Source: AGHT+IHC377mUubwTCvPh8gkyBN84l2AmdH1Zyqa4Dk1ALNvx86TDEH09ZXiPwpLRMcyroxTcA6V4A==
X-Received: by 2002:a17:902:f690:b0:1bd:f314:7896 with SMTP id l16-20020a170902f69000b001bdf3147896mr16795613plg.25.1696865521720;
        Mon, 09 Oct 2023 08:32:01 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:3e90:dc7b:9e2c:258f? ([2804:14d:5c5e:44fb:3e90:dc7b:9e2c:258f])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902ce8800b001c76fcccee8sm9723461plg.156.2023.10.09.08.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 08:32:01 -0700 (PDT)
Message-ID: <da08ba06-e24c-d2c3-b9a0-8415a83ae791@mojatatu.com>
Date:   Mon, 9 Oct 2023 12:31:57 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [REGRESSION] Userland interface breaks due to hard HFSC_FSC
 requirement
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>, markovicbudimir@gmail.com
Cc:     Christian Theune <ct@flyingcircus.io>, stable@vger.kernel.org,
        netdev@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        Jamal Hadi Salim <jhs@mojatatu.com>
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
 <065a0dac-499f-7375-ddb4-1800e8ef61d1@mojatatu.com>
 <0BC2C22C-F9AA-4B13-905D-FE32F41BDA8A@flyingcircus.io>
 <20231009080646.60ce9920@kernel.org>
From:   Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20231009080646.60ce9920@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 09/10/2023 12:06, Jakub Kicinski wrote:
> On Sat, 7 Oct 2023 06:10:42 +0200 Christian Theune wrote:
>> The idea of not bricking your system by upgrading the Linux kernel
>> seems to apply here. IMHO the change could maybe done in a way that
>> keeps the system running but informs the user that something isn’t
>> working as intended?
> 
> Herm, how did we get this far without CCing the author of the patch.
> Adding Budimir.
> 
> Pedro, Budimir, any idea what the original bug was? There isn't much
> info in the commit message.

We had a UAF with a very straight forward way to trigger it.
Setting 'rt' as a parent is incorrect and the man page is explicit about 
it as it doesn't make sense 'qdisc wise'. Being able to set it has 
always been wrong unfortunately...
