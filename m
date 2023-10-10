Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306ED7BFEA1
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 15:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjJJN7u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 09:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjJJN7t (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 09:59:49 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE4BA7
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 06:59:46 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso1022942366b.1
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 06:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696946385; x=1697551185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FXx/Nx2Umfqqvx1+mbJjlkokHcEDmGDoBibG1vLbM2c=;
        b=cowIt9DHAdl9WF1o5/zwxZZaO+CZrezLxCFiYk8PKUe6B3tzD2Vuwgi6eRjvwQMRZW
         ic8zaOHQ05/yQuco9UH1edeKVK76CF/Kn2Vn678E+Vs9xXPb29HlYhsbfwZ+ArJlg4r5
         x9bQyDOzDMDtWlHqVORVPJx4ONaGTeLTfyHIUpOObzBlJgDdSYNY0rmkCq5NSUyk6TPc
         nx7wRbCgHlBNSTcWBKHhtFRaYBqtCkyAbIXd7cl+PeK7XJoqSRAheaGZExR40P2KrgYX
         CnKYq7QVtYe7IAcvSGmzopBBHV8XV6M0cDsAG4vmqr5v/Ynp1mKN57e1CQlk/EkWMjDg
         hx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696946385; x=1697551185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXx/Nx2Umfqqvx1+mbJjlkokHcEDmGDoBibG1vLbM2c=;
        b=VsqrfxiyoNy0Xj+D1bBB2O4A9izgtoa/2grzCnVIv6K4Ost23SDTsRNL9QaChCbxQi
         Xf4YBj5d8E/AdeZO16oHOVaaCMkPSM+XUea5BYMp1X0i7ckUxhkymBAv87jZX5KLim5W
         iWt7PP38LiGx7JH55ONdsRFNvHUmEOHRwUpHE89CkTZq99JZaMX6LdHpRDWdBOJYyh2k
         v4c89I1zRNM0i2rG5eMVtz2Isviu/ehPlvIgMmR8J0KTZfaqkeMaBQs5p75shKuTeEQQ
         q81TL/C/XT3HfNFyWgc1Rt/dMzcf/s4hVVl+6IaIE2gehqMSABdA3/z02IfJtod20CBA
         vZSw==
X-Gm-Message-State: AOJu0YzL8sdNbTDJ6AlNU207xYaZ2JYOIiWFh6owAAzag4rQlQXwuh5N
        ntmXgFdGYoSpExDH9Puc3REM6w==
X-Google-Smtp-Source: AGHT+IEZTLuEF4tR/B84ESaBI0t1Pkk/Kk6zu2q3mIk/stooA1t3MqfPi2p1F9iqETJtZxssD3PCoQ==
X-Received: by 2002:a17:906:3012:b0:99d:e617:abeb with SMTP id 18-20020a170906301200b0099de617abebmr16608511ejz.23.1696946385469;
        Tue, 10 Oct 2023 06:59:45 -0700 (PDT)
Received: from [192.168.69.115] (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr. [176.172.113.148])
        by smtp.gmail.com with ESMTPSA id p16-20020a170906b21000b009b9a1714524sm8616055ejz.12.2023.10.10.06.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 06:59:45 -0700 (PDT)
Message-ID: <7a145a7e-02b3-64c3-348c-34037d5aeca1@linaro.org>
Date:   Tue, 10 Oct 2023 15:59:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] MIPS: KVM: Fix a build warning about variable set but not
 used
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     kvm@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20231010085434.2678144-1-chenhuacai@loongson.cn>
Content-Language: en-US
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231010085434.2678144-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/10/23 10:54, Huacai Chen wrote:
> After commit 411740f5422a ("KVM: MIPS/MMU: Implement KVM_CAP_SYNC_MMU")

Date:   Tue Dec 13 16:32:39 2016 +0000

7 years ago...

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> old_pte is no longer used in kvm_mips_map_page(). So remove it to fix a
> build warning about variable set but not used:
> 
>     arch/mips/kvm/mmu.c: In function 'kvm_mips_map_page':
>>> arch/mips/kvm/mmu.c:701:29: warning: variable 'old_pte' set but not used [-Wunused-but-set-variable]
>       701 |         pte_t *ptep, entry, old_pte;
>           |                             ^~~~~~~
> 
> Cc: stable@vger.kernel.org
> Fixes: 411740f5422a960 ("KVM: MIPS/MMU: Implement KVM_CAP_SYNC_MMU")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310070530.aARZCSfh-lkp@intel.com/
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/mips/kvm/mmu.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

