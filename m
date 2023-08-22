Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0211783AD5
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 09:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjHVH15 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 22 Aug 2023 03:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjHVH1t (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 Aug 2023 03:27:49 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23009132;
        Tue, 22 Aug 2023 00:27:42 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68a3082c771so1647369b3a.0;
        Tue, 22 Aug 2023 00:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692689261; x=1693294061;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OTbjyPhWofsS3uxKEauMLS7RlGyzuvbf/K2kko+lhc=;
        b=aPBBGiRGxcMbUgeWBPhGL7I0qlUtDoAqJdpzJHk91WNWjDoNiNahtuMhtyds/ph2H0
         UBgtIT1j7Ex/bDCJx50zyls7ODCR6veHDrwDbZreuLEnfJTrFVppD7bdwYnMvcsaTifd
         JYGxylc5kFA4RkHUQ7bdv5/JGVaaduOEcbbOOBCCGrjXtbJadj08XcPnB/CYQ0ri+Kwy
         5HW2ktYFbK9Fjb2g082YvwL4oXEEVvxsItQ423kESXP4j83BMVRG4Ba1qCczD3J5Az7o
         DD5YPvzE4K5eD1vr42p25d47LZ69QaMoPJEjaI93LBE0WPI7M17u6z/pEHUdGqGB9TjS
         BTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692689261; x=1693294061;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5OTbjyPhWofsS3uxKEauMLS7RlGyzuvbf/K2kko+lhc=;
        b=aSiaZy96S9Gg1zhy5mx8ZMn4ROTncjLOB6C09wQfYseXdVm2oMy0Q0LanN/ybod8k9
         OM/YV+r7GTLp6nATYwyhbVhtckLLgVKt41cuuOfuX/Wc7JEtv5SQR/PXOQQti5BVeCd6
         VkWznpR0tXdF2rS0nuO6OIrAzWDxSKfm7T/MH1FhZcmLcqyRjKNYW0tAJcTWcySbCkld
         lxkwpsT1Wx2MIT4oASucPZprsDHceBdqQTkavYguLy9GNg3m+IVE+mRn41woMHZajBl7
         eytahf4mvHPw/fQgCUqvmViUw1KoM0eKYMIcbISmeNuMd1w6/54e2qh7UVHqHuOXX/hh
         EedA==
X-Gm-Message-State: AOJu0YxO2pMOsk/L4XvipMWGk9dGA0wvfJOhWoOJa1Fy4tcvINFDT7aL
        dfh+FgNKtom7pKHiA3o2Rbg=
X-Google-Smtp-Source: AGHT+IH36Gyo+XxQL33GMRQKjYjkpRuzSDJhgbApsWGJG9HysRW3FaKcGG0iGaShVGyXLjAI0q8O1w==
X-Received: by 2002:a05:6a20:1615:b0:13d:71f4:fd8a with SMTP id l21-20020a056a20161500b0013d71f4fd8amr11807099pzj.13.1692689261476;
        Tue, 22 Aug 2023 00:27:41 -0700 (PDT)
Received: from [10.1.1.24] (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b00688435a9915sm7188566pfn.189.2023.08.22.00.27.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Aug 2023 00:27:40 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] ata: pata_falcon: fix IO base selection for Q40
To:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <20230818234903.9226-1-schmitzmic@gmail.com>
 <20230818234903.9226-2-schmitzmic@gmail.com>
 <CAMuHMdUdqRZcwHnWCb0SJ34JM3BqEyejsgWajwsbe_F+6xZMjg@mail.gmail.com>
 <07f8a1f9-e145-2b0a-61f0-ac5fe5a8fa58@gmail.com>
 <CAMuHMdWNm7RdZcTa5EaWaFZ4NhPi75y8i31C2dkzJ5Hc4rtSJA@mail.gmail.com>
Cc:     dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, will@sowerbutts.com, rz@linux-m68k.org,
        stable@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <aabc6bd8-6407-3fa3-c620-69b290b3108c@gmail.com>
Date:   Tue, 22 Aug 2023 19:27:34 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWNm7RdZcTa5EaWaFZ4NhPi75y8i31C2dkzJ5Hc4rtSJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Geert,

Am 22.08.2023 um 19:05 schrieb Geert Uytterhoeven:
>>>> +       if (base_res) {         /* only Q40 has IO resources */
>>>> +               io_offset = 0x10000;
>>>> +               reg_scale = 1;
>>>> +               base = (void __iomem *)base_res->start;
>>>> +               ctl_base = (void __iomem *)ctl_res->start;
>>>> +
>>>> +               ata_port_desc(ap, "cmd %pa ctl %pa",
>>>> +                             &base_res->start,
>>>> +                             &ctl_res->start);
>>> This can be  moved outside the else, using %px to format base and
>>> ctl_base.
>>
>> Right - do we need some additional message spelling out what address Q40
>> uses for data transfers? (Redundant for Falcon, of course ...)
>>
>> Though that could be handled outside the else, too:
>>
>> ata_port_desc(ap, "cmd %px ctl %px data %pa",
>>                base, ctl_base, &ap->ioaddr.data_addr);
>
> I guess that wouldn't hurt.

Done - I'll send out v4 tomorrow.

Cheers,

	Michael

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
