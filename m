Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000C772F371
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 06:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjFNEP5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 00:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbjFNEP4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 00:15:56 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2BE19AC
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 21:15:55 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f7364c2ed8so15631855e9.0
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 21:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686716153; x=1689308153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=slWs6prYUYxWYrgoD+knwRPr42E6kjcWFUeHsdyACNg=;
        b=J1ILsZDnacaOoW9c1dbRO/P5OPjbv9FoF93lBgDrS+yyHIAk9Eu78dOSxdhyTKilXJ
         C+KjbUGy/Hif6lyZnaFHH24xcZJqWEN6doLmKb9VMhvFciDwzNqSjPmYQVtj3K/CXq8Z
         C+OAuF3XNf82vtBzvLGToHMOxE5VPfm16Ba7kxuiWbJvL5rn51P3cO2uwgZhxGm3aKai
         6pbWWkHVggtlTPOUGrVj1iN1lv+O0bNHRg7C72DF47+8pzJu29dYouBpviEJgCi7H6uw
         e3iMJL62vJV6/Zx0a7PTnTf9VFuB2nWbza5D/4ag1p5qHWWIyFr7RYEXmsmpV8BHoxe4
         6qkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686716153; x=1689308153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slWs6prYUYxWYrgoD+knwRPr42E6kjcWFUeHsdyACNg=;
        b=MXH8si285n7sgC3waEDdDniJnT86DDgI5IDYkuOu05fH/VxEexk/y+y14Y/rKtisaZ
         BO2T2THtcj7qIKgBi7LEpaSM8DPFfGgynyL46IGN+NY0V/+2irJjQjzmmTl9fYbnzYo+
         6feGjEp8asB1FZKKqqMk4QsLYxP04rnd0qAFNs7bPoPRYHo72Vc6YZrLQ0xsLWs04XRV
         RrfP7KvKxlN7Ygodcetwmoda2BkEb/yf+H13n2tfvzYbyQQrC+tkED3oEjt4rolt+cm4
         ix+sPl8sKorqPElFymtrFdUUE9a73R5kiN2+JAGr9ra7fT0vM6yeEnnw4uenYlVJstWQ
         sdwA==
X-Gm-Message-State: AC+VfDzwx61KlPXkYOqJQsLR+xBao5ISEFtg/nS4d4EKowP0IRz9IAcI
        C+VdR3DnmN/4NeRZDSNIGWU=
X-Google-Smtp-Source: ACHHUZ4Js2toNMinMA81HgsAEcF/J7x9VxwRItMEXqSD1m2Q45new4pCNG7vYicP6CP1uR1a6nvMXg==
X-Received: by 2002:a5d:4569:0:b0:30f:d03e:3d1f with SMTP id a9-20020a5d4569000000b0030fd03e3d1fmr2213417wrc.7.1686716153354;
        Tue, 13 Jun 2023 21:15:53 -0700 (PDT)
Received: from ?IPV6:2a02:2788:416:72a:82e8:2cff:fe51:d2c8? ([2a02:2788:416:72a:82e8:2cff:fe51:d2c8])
        by smtp.gmail.com with ESMTPSA id n7-20020adff087000000b0030ae5a0516csm16892627wro.17.2023.06.13.21.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 21:15:52 -0700 (PDT)
Message-ID: <691e46df-0155-e36f-a297-81e982e8748b@gmail.com>
Date:   Wed, 14 Jun 2023 06:15:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 6.1 000/132] 6.1.34-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@denx.de>
Cc:     stable@vger.kernel.org
References: <20230612101710.279705932@linuxfoundation.org>
 <ZIde9VarEXi/BkzI@duo.ucw.cz> <2023061224-bubble-violator-ef08@gregkh>
Content-Language: fr-FR
From:   =?UTF-8?Q?Fran=c3=a7ois_Valenduc?= <francoisvalenduc@gmail.com>
In-Reply-To: <2023061224-bubble-violator-ef08@gregkh>
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

Le 12/06/23 à 20:13, Greg Kroah-Hartman a écrit :
> On Mon, Jun 12, 2023 at 08:07:49PM +0200, Pavel Machek wrote:
>> Hi!
>>
>>> This is the start of the stable review cycle for the 6.1.34 release.
>>> There are 132 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>
>> I notice that origin/queue/6.1 was not updated. Is that an oversight?
>> It was quite useful to see what is coming.
> 
> I have no idea what creates that branch, sorry, it's nothing that I do
> on my end.
> 
> greg k-h
> 
I also noticed this. Only the "review-6..." branches are updated when a 
new review round is launched for a new stable release. The queue 
branches are not updated anymore since around 10 days. Previously, the 
queue branches were updated each time the git tree for the patches 
(https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git) 
was updated.

Best regards,

François Valenduc

