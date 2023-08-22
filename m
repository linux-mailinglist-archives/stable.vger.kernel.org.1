Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DEA783BB7
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 10:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjHVI1P (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 22 Aug 2023 04:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjHVI1M (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 Aug 2023 04:27:12 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134E112C;
        Tue, 22 Aug 2023 01:27:11 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68a41035828so1472066b3a.1;
        Tue, 22 Aug 2023 01:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692692830; x=1693297630;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H82FZhA87NjWkAJ0bEHD1nwjofTts9jm2ulKk5lEn4E=;
        b=ce7P2hHuUgkiy/b8Enzv2RaqGVDa5yzrtEDXS+0SHcMqmTrG7uRwoYn1So+9ZR+v0E
         mXy2fvE99FiPdsbjQR1eanuoGn+n5ot09lZT9pXQQXIT8v04oSTAni3HPGPGwhvacNpM
         OOwGvVbX/kgEps/OMILigQBiYrqqIbvWfCbxx62tLAmOZ7VXHR70R2wp5hjxg/GhhS8/
         hW7F9+qY1e9aPZh5fTAfFwew+kbq+yeq8OwklkeFHNGdVc2sinIYbzq3h1dX4//ffK3q
         TQxDOa67lxyvkSR6n+1KH+t7HrNdSjp4MfbzfZn1M4zHMZy0mb3hsy57xaxa568vGPFY
         QiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692692830; x=1693297630;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H82FZhA87NjWkAJ0bEHD1nwjofTts9jm2ulKk5lEn4E=;
        b=KvMLiWS4RRLvsUexuOpFySW0EqRSBhIjsD9rpiGTjGqKP1sdXOc+JjHHvvTZcthlsm
         1mlR/BFSdkGIfjxf+7XgrZ5lAZafCXBIa17AKs71f77F/c01lK/yfbb+ZEQtK/xtVXsE
         KXMpmWWDubcPwMerUMmNyMQDJY0xEx25+2gA5vDGHE7f202fUyUFqVGP89MjQ49FWKNd
         ztXB4uMC3R+1Pg9uCED0Y7XrYGntM1AVvc+U3+6ZYNN/DSixV3QTSe8ZWPuE42zFtHFn
         pJHjE3RVvBd0IFUiBiZ4u7VjQzasO7vo6ewLMg+bkpQTqBb7xFhtfvseFXVcPXZ+DpbH
         b7cA==
X-Gm-Message-State: AOJu0YyBnAC/matArrLVrKWrANuztrkkA5eaLMnIX9P7PNdj27fp7Yp4
        JwvSOizOLrnRvsPXpj1Em2U=
X-Google-Smtp-Source: AGHT+IEsZKxfoPvVjUvPkJkMGeGj5E+PYJoqV5HNe4uUc3NTWUUueL5Sid2GDg/7YQ+uuF+JY8VI/A==
X-Received: by 2002:a05:6a20:3943:b0:138:92ef:78f9 with SMTP id r3-20020a056a20394300b0013892ef78f9mr8576589pzg.6.1692692830378;
        Tue, 22 Aug 2023 01:27:10 -0700 (PDT)
Received: from [10.1.1.24] (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902d3c600b001bdb0483e65sm8425540plb.265.2023.08.22.01.27.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Aug 2023 01:27:09 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] ata: pata_falcon: fix IO base selection for Q40
To:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <20230818234903.9226-1-schmitzmic@gmail.com>
 <20230818234903.9226-2-schmitzmic@gmail.com>
 <CAMuHMdUdqRZcwHnWCb0SJ34JM3BqEyejsgWajwsbe_F+6xZMjg@mail.gmail.com>
Cc:     dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, will@sowerbutts.com, rz@linux-m68k.org,
        stable@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <fd0b71fa-783e-41c0-ab2b-02656286d2ab@gmail.com>
Date:   Tue, 22 Aug 2023 20:27:03 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUdqRZcwHnWCb0SJ34JM3BqEyejsgWajwsbe_F+6xZMjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Geert,

Am 21.08.2023 um 19:50 schrieb Geert Uytterhoeven:
>> +       ap->ioaddr.data_addr = (void __iomem *)base_mem_res->start;
>> +
>> +       if (base_res) {         /* only Q40 has IO resources */
>> +               io_offset = 0x10000;
>> +               reg_scale = 1;
>> +               base = (void __iomem *)base_res->start;
>> +               ctl_base = (void __iomem *)ctl_res->start;
>> +
>> +               ata_port_desc(ap, "cmd %pa ctl %pa",
>> +                             &base_res->start,
>> +                             &ctl_res->start);
>
> This can be  moved outside the else, using %px to format base and
> ctl_base.

I get a checkpatch warning for %px, but not for %pa (used for . 
&ap->ioaddr.data_addr). What gives?


WARNING: Using vsprintf specifier '%px' potentially exposes the kernel 
memory layout, if you don't really need the address please consider 
using '%p'.
#148: FILE: drivers/ata/pata_falcon.c:194:
+	ata_port_desc(ap, "cmd %px ctl %px data %pa",
+		      base, ctl_base, &ap->ioaddr.data_addr);

Using %pa and &base, &ctl_base just to shut that up seems a little silly ...

Cheers,

	Michael

>
>> +       } else {
>> +               base = (void __iomem *)base_mem_res->start;
>> +               ctl_base = (void __iomem *)ctl_mem_res->start;
>> +
>> +               ata_port_desc(ap, "cmd %pa ctl %pa",
>> +                             &base_mem_res->start,
>> +                             &ctl_mem_res->start);
>> +       }
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
