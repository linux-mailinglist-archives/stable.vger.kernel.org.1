Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B8A776B4E
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 23:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjHIV6Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 17:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjHIV6Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 17:58:24 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2911FE;
        Wed,  9 Aug 2023 14:58:23 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-686f090310dso229745b3a.0;
        Wed, 09 Aug 2023 14:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691618303; x=1692223103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RWKKYLEeNMS/4CoQ0bYmGjd+juoGt9HjkejvadPoA1o=;
        b=LAN/Qepbc25+AW8sl4f+XgY4cEyUOpiwrUF269xlyM/zjiqm+ussb/9yA1dCqYmOZ7
         LvBOBQVjZcxm3T1xq+m/qabEfFgHs2Evq2p5UIh/8fMPUorV7Hf26Pl5F4Bk2iZ83svY
         KdaW26xrNtdUcE1Fpjn+Ay3R/sLUTh8tO8Lc1KDz2gcJjVNEi7YA1g13nwkscWnw6mQw
         fTt3toa1620mwFHqCAlwHublTKbtzuy9U9Q5RA9oQ3qwf8PJLUG8KesfiJTzWTF8wRbS
         I+tNSKA1bUWfL72c/97wCo8E6m2+eOMJNTtJC2NCYCEKuNzU5OZk3DktCO4pRFeE025O
         8kpQ==
X-Gm-Message-State: AOJu0YxmO5BQkJVF2LylCDy9/IGnhn2P9EgrH04MzbPhHEJkxDAM9+MF
        HkEPleAF/0HnPinOyScxXhY=
X-Google-Smtp-Source: AGHT+IFPgDE+m64sso5/X+tFguVKB8mzsBcgB0iFGpMCipM4RN9xYpRK9uJOw8z9H0gN8yYivqwKVw==
X-Received: by 2002:a05:6a00:2e20:b0:687:570:501f with SMTP id fc32-20020a056a002e2000b006870570501fmr568582pfb.24.1691618303235;
        Wed, 09 Aug 2023 14:58:23 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7819a000000b0063f00898245sm69933pfi.146.2023.08.09.14.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 14:57:45 -0700 (PDT)
Message-ID: <bdc3956a-9ba9-3268-b822-7ea337c0e9b9@acm.org>
Date:   Wed, 9 Aug 2023 14:57:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] blk-crypto: dynamically allocate fallback profile
Content-Language: en-US
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Jens Axboe <axboe@kernel.dk>,
        Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, kernel-team@meta.com,
        ebiggers@kernel.org
Cc:     stable@vger.kernel.org
References: <20230809125628.529884-1-sweettea-kernel@dorminy.me>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230809125628.529884-1-sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/9/23 05:56, Sweet Tea Dorminy wrote:
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Signed-off-by should be followed by a real name. Sweet Tea doesn't look
like a real name to me.

Bart.

