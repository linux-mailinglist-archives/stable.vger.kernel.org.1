Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320DD776BF2
	for <lists+stable@lfdr.de>; Thu, 10 Aug 2023 00:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjHIWI4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 18:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjHIWI4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 18:08:56 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C31DFE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 15:08:55 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-564670fad4bso60195a12.1
        for <stable@vger.kernel.org>; Wed, 09 Aug 2023 15:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691618935; x=1692223735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Uzn7iiANgsupHywDv/72GtXrEumTbsw+OT2gpEL+aY=;
        b=u+xAB0RZaSkonBzG/RsKAgtENUDjoe8v+gh6FUUtjkX4rUCUtSE1DGI9Jh+E9g97zj
         kiwwG3jUIo77AEXd7Ns31ou3pYVgNgAI5Z/db9GdTfh5P9W7mLXLPeR/rEM0Ha15CywJ
         JszZ4+lgusTz5gYvnIu7crL/6Y55j+8cZvC6IuGJ/ixoJvd8QUOftiSc4i4GC0TflxeK
         BXP4saTGYw9p5YE1rupsDXzbeWbFBb0SfFZ1Anx2l3HVAy3uveILp59p3nFX40rvprK1
         cqI6EmlBiF2J2qnThDPghGZdPugiMFWR2IBpsAyj1ZGyG3x/w3x3lOULKF4VPIFOoBas
         VQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691618935; x=1692223735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Uzn7iiANgsupHywDv/72GtXrEumTbsw+OT2gpEL+aY=;
        b=XGSjpy4Gghz1AFzhhFAmvv8zggx486D7mJFD9fMOjEtORh8+MfOR2M8oi1PdGVOubN
         DZHMozzXzJ5sGurpd4m9AazIDpn+FwPQKiLXz62aAFE2H4/B7cfgQicDHN887pHFf2/p
         vODZGxBDTCTLuRp7krlFrErt4PAnp1fjOBvxhOXdhUDA7BhZZM6Ltg/wOQ97tUNsOHQe
         iGx+oxACEV0bngFY3Cip26rSKqnpYkKOPzXNjN/AIbFE2DXm/eRsYW/CnwNG4fGNlDF5
         KZb+Qe0tQM+8tXuWU6E15AaLnPkvGPTZhkqpLJ/nODxwBiT3G1tNi+BSFnrQjQXrhLBl
         8OWA==
X-Gm-Message-State: AOJu0YzHSQ/KiG4oFiYpQ2b0km9x9LmSklHTCrxKmvDYVh9RlhWvwqPY
        EcgxBP+T9te3EC83mbt8OKb+il16Qo+cIu7zHIw=
X-Google-Smtp-Source: AGHT+IGL34d9XlQ2VMdBk6Ss1oOIGVwRxDv2b6ZuBUD8gInXOHPVIp9CxDo1vptLvcsk+e/xwvAQuA==
X-Received: by 2002:a17:902:e744:b0:1b1:9272:55e2 with SMTP id p4-20020a170902e74400b001b1927255e2mr484792plf.3.1691618934738;
        Wed, 09 Aug 2023 15:08:54 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c11-20020a170902724b00b001b246dcffb7sm19206pll.300.2023.08.09.15.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 15:08:54 -0700 (PDT)
Message-ID: <94c661a6-442b-4ca2-b9e8-198069d8b635@kernel.dk>
Date:   Wed, 9 Aug 2023 16:08:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blk-crypto: dynamically allocate fallback profile
Content-Language: en-US
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, kernel-team@meta.com,
        ebiggers@kernel.org
Cc:     stable@vger.kernel.org
References: <20230809125628.529884-1-sweettea-kernel@dorminy.me>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230809125628.529884-1-sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/9/23 6:56 AM, Sweet Tea Dorminy wrote:
> blk_crypto_profile_init() calls lockdep_register_key(), which warns and
> does not register if the provided memory is a static object.
> blk-crypto-fallback currently has a static blk_crypto_profile and calls
> blk_crypto_profile_init() thereupon, resulting in the warning and
> failure to register.
> 
> Fortunately it is simple enough to use a dynamically allocated profile
> and make lockdep function correctly.
> 
> Fixes: 2fb48d88e77f ("blk-crypto: use dynamic lock class for blk_crypto_profile::lock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

The offending commit went into 6.5, so there should be no need for a
stable tag on this one. But I can edit that while applying, waiting on
Eric to ack it.

-- 
Jens Axboe

