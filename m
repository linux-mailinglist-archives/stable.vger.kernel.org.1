Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A3F715994
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 11:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjE3JK5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 05:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjE3JKz (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 05:10:55 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC852BE
        for <stable@vger.kernel.org>; Tue, 30 May 2023 02:10:52 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d2b42a8f9so3267254b3a.3
        for <stable@vger.kernel.org>; Tue, 30 May 2023 02:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685437852; x=1688029852;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=onOtf3YpfaNIv3nZ9cKNkXLIUusMOopfwbATlSrWpbw=;
        b=RXqCEEJhV6OGEnAoWVj4vRJC8JD3cre3T9CO+jViL0uO9FNvzTN050w5Z8oG6Tmoqr
         z7XpsT/LbXV0ljmTxgoOzkiCQhuMW16wT4PrWxfwGkbylDLru29va+oEv1+TXuXaUhxv
         JzH6NiDVQpVuo2C440W67g/Dlk3w1gp/6yezfwfvuc29hIgGQXRZ9GGTVB7s1pCD0W+A
         3D6uEIrIKdXrGjsfw7jz4MOO1Y7s4VFgO6U41nz5g829UKUQEItYOhhWPzCXmX+KrHZc
         yyT/gc4PMu1qDUeNg/qE7Y6JAJ14xZLC68dMtYWggnDbKZrkpN9uhdKY1m/YpUPl9OZf
         KayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685437852; x=1688029852;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=onOtf3YpfaNIv3nZ9cKNkXLIUusMOopfwbATlSrWpbw=;
        b=W6SpUWDpRwK8b7byWVlg04dhnMJDy+Gn8FFtaL7BjvzNrLSsD1WWEvoQrEuWyjpeMR
         XJmw4Em+ChXXn/PX/zhKK2CSvwJsHRTC2J/Amf9lA2CYlngTpsH5HnnzToPpo/VRvhZO
         YnJT9Qymqz9RnCPMxb+TvFgVXCzLd6Eo+Mgiw+fCvkip+QAz9t2Y0Bsbx6UCghgx+ttb
         J1oYCVNOnw1hlXHBde7+nZ06WApOveBEbx0ZBLSV3Ovl5TVaLoujDrvROEiicMH9DrVl
         9tgCtxeesERs4MIjXCt+7jerPGF57msWckltxiMkLmI0RgYo4wO71ivP/ASn3rhIrKDw
         86Zg==
X-Gm-Message-State: AC+VfDytUHJk6A/cg15EiUBjggXLhRDw7IW5jAD0OFxWmmmGRIuEUdjA
        GPaDA5RQeLt8ARrzZmHlZXjNUdzF0vI=
X-Google-Smtp-Source: ACHHUZ4Bor7htKvGfqJzdw6RI0hLi1+zrMZI6QSdVJqFo+9WzSkljqA631x4M+AQP6tv8sfi8TqYVw==
X-Received: by 2002:a05:6a20:9382:b0:111:97f:6db1 with SMTP id x2-20020a056a20938200b00111097f6db1mr2094513pzh.19.1685437852066;
        Tue, 30 May 2023 02:10:52 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-74.three.co.id. [223.255.225.74])
        by smtp.gmail.com with ESMTPSA id j21-20020a17090a589500b0024e33c69ee5sm8359465pji.5.2023.05.30.02.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 02:10:51 -0700 (PDT)
Message-ID: <eb7db3a4-1e26-353e-0b31-88e0d5f4fb12@gmail.com>
Date:   Tue, 30 May 2023 16:10:48 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: 6.1.30: thunderbolt: Clear registers properly when auto clear
 isn't in use cause call trace after resume
Content-Language: en-US
To:     beld zhang <beldzhang@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        stable@vger.kernel.org
References: <CAG7aomXv2KV9es2RiGwguesRnUTda-XzmeE42m0=GdpJ2qMOcg@mail.gmail.com>
 <ZHKW5NeabmfhgLbY@debian.me> <261a70b7-a425-faed-8cd5-7fbf807bdef7@amd.com>
 <20230529113813.GZ45886@black.fi.intel.com>
 <e37b2f7f-d204-4204-ce72-e108975c2fe0@amd.com>
 <CAG7aomWsZAfHNCg9jS2P_dWjTh2O6Umx71rG7Xri+ZvpHw8+jQ@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAG7aomWsZAfHNCg9jS2P_dWjTh2O6Umx71rG7Xri+ZvpHw8+jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 5/30/23 11:27, beld zhang wrote:
> test passed both 6.1.30 and 6.4-rc4
> comments at bugzilla.
> 

tl;dr:

> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
> 
> A: No.
> Q: Should I include quotations after my reply?
> 
> http://daringfireball.net/2007/07/on_top

Please don't top-post your reply in the future. Reply inline
with appropriate context instead.

-- 
An old man doll... just what I always wanted! - Clara

