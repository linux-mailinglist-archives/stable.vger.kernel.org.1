Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3026D7864F5
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 03:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbjHXByh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 21:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbjHXByL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 21:54:11 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B943012C;
        Wed, 23 Aug 2023 18:54:09 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bf0b24d925so41761865ad.3;
        Wed, 23 Aug 2023 18:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692842049; x=1693446849;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S+088DnbVZIeIeMTh1/uw7xjikGVaH/NCldfQrvljWw=;
        b=ClF1zximONU4D2aToL4V3r0KN1JPrr1qQmCaq4uwnRXq6pusOZm1mZ1otE3dsJKY+4
         hcKgx49BuNTeOUtchwIkLCF2DI9TDNopEEuxSYTUyEaEztm61TdBeRY+XQh3sN1wiBzx
         W/DucAMw5J5XeyWVBHwlxbbp0AaHZk6bSoPI9FUXZkZivwNbHhtBUwHg5AEPqcn8y5L1
         o2CfS9jFfkaBGx1Tro2sr607hHIobNnZ2DLzn0YJg3mmBX3wIJC9Ym4OH0t6FTCjpvPm
         Ffhjh9kubv3AvgbfFbIRHUzM4w3jS2ucY+jFxGwR9HuZwFGWItOoa6rewZG/DA321x5m
         gEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692842049; x=1693446849;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+088DnbVZIeIeMTh1/uw7xjikGVaH/NCldfQrvljWw=;
        b=aacfC2Jjei1Nci/6CDMCcLZsIAISoUcG8C2tvm6KbmP/UgbJUw/NSBOG1ZjmJ/L1mx
         Wr/t4T41FH6vsXUhU6oo4lFsZBug3RnEA8M5Ti/aFTRKGVL0iVZZurjZnSxHOED6F1CJ
         5hwJje2eqXgHhLRfeToxuQq8lSDWonMeKM8PpJZANqw6QzrFnNYhUfOSlrmR0Bq8tFrY
         lSDYxsNlgAjUObwsIYu7hBCimj+4D/QTkkjCEVIHOI5lV4YLq6ivDNjLf0+AXBGs7OO8
         ZTI2b7AH3n1Rh3GYN+Py1g/iGXfnBSI7bo5XNDMsxSPuMPwNrYepj6Q4ZG2rdrEQWnNP
         +JEg==
X-Gm-Message-State: AOJu0YwWrX1H35kVfIUSZbiSlMjOKBjf1FooB7gOkhP4E/RTaZohp7Xw
        EpITmYfCNl7qSdZiWee4Fm4Q4+Wlo4k=
X-Google-Smtp-Source: AGHT+IFdl0vabAnfMqbUiyDi3wrWtd/jR2UYHHM4rtEY5E0jS3DlGxgssjmaRMK4tDbafJfwt2FO2w==
X-Received: by 2002:a17:902:c101:b0:1bf:6cbc:6ead with SMTP id 1-20020a170902c10100b001bf6cbc6eadmr10107148pli.22.1692842049140;
        Wed, 23 Aug 2023 18:54:09 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:34d2:df92:ba7c:a2e2? ([2001:df0:0:200c:34d2:df92:ba7c:a2e2])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902ec8d00b001b87d3e845bsm11551146plg.149.2023.08.23.18.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 18:54:08 -0700 (PDT)
Message-ID: <dc4ddd28-d3cd-9816-44d5-450efb9e7246@gmail.com>
Date:   Thu, 24 Aug 2023 13:54:02 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/2] ata: pata_falcon: fix IO base selection for Q40
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     sergei.shtylyov@gmail.com, dlemoal@kernel.org,
        linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org,
        will@sowerbutts.com, rz@linux-m68k.org, stable@vger.kernel.org,
        Finn Thain <fthain@linux-m68k.org>
References: <20230822221359.31024-1-schmitzmic@gmail.com>
 <20230822221359.31024-2-schmitzmic@gmail.com>
 <CAMuHMdUcFprFuwyfvRdKeyvjVAG6hre9S+hU1FvoM69d9_qR-w@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <CAMuHMdUcFprFuwyfvRdKeyvjVAG6hre9S+hU1FvoM69d9_qR-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Geert,

On 23/08/23 21:05, Geert Uytterhoeven wrote:
>
> Thanks for the update!
>
>> --- a/drivers/ata/pata_falcon.c
>> +++ b/drivers/ata/pata_falcon.c
>> +       ata_port_desc(ap, "cmd %px ctl %px data %pa",
>> +                     base, ctl_base, &ap->ioaddr.data_addr);
> %px and ap->ioaddr.data_addr
>
> The rest LGTM, so with the above fixed
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Will fix this in v4.

Thanks,

     Michael

>
> Gr{oetje,eeting}s,
>
>                          Geert
>
