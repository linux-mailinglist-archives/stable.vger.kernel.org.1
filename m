Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38182787CBF
	for <lists+stable@lfdr.de>; Fri, 25 Aug 2023 03:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbjHYBHe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 21:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbjHYBHW (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 21:07:22 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1AAE77;
        Thu, 24 Aug 2023 18:07:20 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-56b2e689968so204383a12.0;
        Thu, 24 Aug 2023 18:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692925640; x=1693530440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CKYa+3X3JabVkVHxyWUBbj2WV3S2CJNPGlv/WYPAI28=;
        b=N0o32FSq1iKsPBAO3ebMoee2G2qWDDsVPbuKU9b+mGcHl1UENRVGZmBCUX3PuyujQR
         PC1ZdMRs0PcwBd367AFyE5WDY7coAJzywnKrTK2nyfzri16UADPqwPp7GOxdQCvdjhkb
         rUtIaLDkehETyB1VO04aDNQexxiW14igKx8zUif7i3rwvanIxOOOWSBrf2zCj182Z+Hy
         AHv25trSg1l440p+LXVw3LsZNJwefNo4J4bcpdczTxy+B8ugUBDkMEmGgNhGnGiN0nkV
         /5ShVATMQZuvQYa/Xu3H/9oE6m5uvfEx5WCnKlkmJBXWOdP4zy527LgZxhI+8XmCuBwZ
         t6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692925640; x=1693530440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CKYa+3X3JabVkVHxyWUBbj2WV3S2CJNPGlv/WYPAI28=;
        b=jkGHG6PfNoFw7ua734r56/H+m35CCMFyKvo0q7iRQYcLWwxZiCgFw9nCx0ej0B8DK6
         jCNTV8cef9fZpYL/sKceOJOW4sT6PkF000ufvThYcQXJSPDdFoRF/maCUFcHHRZl9V7S
         etNvEXiDTgNJlYWD5vIx8NxMUigVoBkyCfRU1guvgZbRUebESUgIs60xCrUPF30+cRWy
         FaqZWvlrb2bLdipryFrYeDfx0mxHcbpSiYUSyMCJgKRBeEYfGUMkBS+AzVhaWEKCzlKU
         90dziXEALR43pwQSvG/RWcMG1gQNnaTxYgsWF+8m93eQGbSD7ak2xLc32UHRGQ+JEccY
         JpXg==
X-Gm-Message-State: AOJu0YydDS4hpX4BuDCakYQg8dMDzMDGm2vmt/QYOa0/hqUORxnGGBbd
        qpYaY0Ho4rp8OLwAVJyceNk=
X-Google-Smtp-Source: AGHT+IEGU90qsf0QL1Ib6zl4pemUa+2lEczxlADmCbjzknZe5wry0ZP8y6GwR45zF0xe7DjTu2q/3g==
X-Received: by 2002:a05:6a21:78aa:b0:148:184c:d4e8 with SMTP id bf42-20020a056a2178aa00b00148184cd4e8mr18569220pzc.2.1692925640103;
        Thu, 24 Aug 2023 18:07:20 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:cd10:2fec:7ce0:fe0a? ([2001:df0:0:200c:cd10:2fec:7ce0:fe0a])
        by smtp.gmail.com with ESMTPSA id y17-20020aa78051000000b0064d74808738sm340759pfm.214.2023.08.24.18.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 18:07:19 -0700 (PDT)
Message-ID: <a705cc9e-4f0b-ac3d-217e-3aa4abbb8bec@gmail.com>
Date:   Fri, 25 Aug 2023 13:07:13 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/2] ata: pata_falcon: fix IO base selection for Q40
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, dlemoal@kernel.org,
        linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        stable@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
References: <20230822221359.31024-1-schmitzmic@gmail.com>
 <20230822221359.31024-2-schmitzmic@gmail.com>
 <34db6315-ed69-6775-efc1-97a351198713@omp.ru>
 <0d490219-a0e2-94d9-4427-39c151fb90b5@gmail.com>
 <082127a7-1c38-1045-df28-0ad43dcde0d8@omp.ru>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <082127a7-1c38-1045-df28-0ad43dcde0d8@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Sergey,

thanks for clarifying, I'll correct that for v5.

Cheers,

     Michael

On 24/08/23 22:00, Sergey Shtylyov wrote:
> On 8/24/23 4:56 AM, Michael Schmitz wrote:
> [...]
>
>>>      I prefer CCing my OMP account when you send the PATA patches,
>>> as is returned by scripts/get_maintainer.pl...
>> Sorry, I was left with the impression OMP was rejecting list messages from linux-ide ...
>     No, it rejected my reply to you for some reason.
>     However, the msgs from linux-ide seem to be still stuck somewhere
> as well...
>
> MBR, Sergey
