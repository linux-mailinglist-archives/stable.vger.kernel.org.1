Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591287C5EFE
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 23:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbjJKVU3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 17:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjJKVUZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 17:20:25 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D79B7
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 14:20:23 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7a2874d2820so5011939f.1
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 14:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697059223; x=1697664023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ou8Z46f8D4HFatkbCIXSPvYGp0xJZP5BFrXKyDUAkb8=;
        b=UF0kV8pV6PLXJQZTfcAz8fMCCu95vvysIrVgLfw7KXN6b+rj1fvrGma2s95TnW+b4o
         dTo/1+BaNzpFZQQfebrQlIVn7wv8cTzUa0Lq2kGNOmHMinMMhpTThQG2TQW++IuRBDQr
         syji2/W3mWJgdaPef0BtqZhZuxyGfjDKlHAo+DbDFXRYhS+mMGswm64OTTnx7ZLk45gi
         HYC5Gm/vpdwTLHyhZvbLFQTjHmf5a/ckf9F1fcoRJH/0mM8C0UlyveM0BkAThZaZVdmM
         LU4H19B3lae3+MmmgCmTI4PeQsrxfkzqZenH43aFTuPii9wuPQ0GRmxjg5gVqnSlqezc
         ttuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697059223; x=1697664023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ou8Z46f8D4HFatkbCIXSPvYGp0xJZP5BFrXKyDUAkb8=;
        b=qc0vBF2LD8pNGpTEgBPMV3K6o3y3I3grHRS4EERi1iMkVfPcucIBgCfCNykRZ5BcN2
         PkQ5+EkSgvaUCT4uXepddxDbAZ1KERFTP6MIooTeTPiM+ULlbDGYs3oAkSqMnd90Qrum
         Gh9ELbpRgTbgYGCFElj505NGsU8ZJd9AsBhvzf4L5enYdXRSB863Tpzhb3Qkt4wMfk1y
         CSpLsUNQ88YK86zot0PLwaSU7vaujG9csL6fO6Je8wDBjyJzowPJsG6BUQLdo0RLFTGv
         VpV3B2MrbO7mu/6KH4M+AdV50zkxLhPWwGA0h9pMM1tiBQuE2BurQRG2lq20wtFXJ2eY
         ACbg==
X-Gm-Message-State: AOJu0Yw3jz/3OkKYvwAEefJhLQ3bGs65nEf8Trutrjt9YiUvkqswu19V
        XSjdnQnhpUAlBJ1VRP2nGocA4Q==
X-Google-Smtp-Source: AGHT+IFDYfOpCNUhep+7IgWh6NGfsroxNM+d8ImbLUEV1kcWszBBlrRw4fvIGqhVskXuEnZ7Ig6CRQ==
X-Received: by 2002:a05:6602:3a11:b0:79f:922b:3809 with SMTP id by17-20020a0566023a1100b0079f922b3809mr23781388iob.1.1697059223057;
        Wed, 11 Oct 2023 14:20:23 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c18-20020a02c9d2000000b0041fb2506011sm3547225jap.172.2023.10.11.14.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 14:20:22 -0700 (PDT)
Message-ID: <c337dd4f-e363-48d1-8ac0-a62da3e1a741@kernel.dk>
Date:   Wed, 11 Oct 2023 15:20:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: block: Don't invalidate pagecache for invalid falloc modes
Content-Language: en-US
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Sarthak Kukreti <sarthakkukreti@chromium.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        stable@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20231011201230.750105-1-sarthakkukreti@chromium.org>
 <b068c2ef-5de3-44fb-a55d-2cbe5a7f1158@kernel.dk>
 <ZScKlejOlxIXYmWI@redhat.com>
 <d5e95ca1-aa20-43da-92f8-3860e744337e@kernel.dk>
 <ZScOxR5p0Bhzy2Uk@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZScOxR5p0Bhzy2Uk@redhat.com>
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

On 10/11/23 3:08 PM, Mike Snitzer wrote:
>>>> Also, please wrap commit messages at 72-74 chars.
>>>
>>> Not seeing where the header should be wrapped.  You referring to the
>>> Fixes: line?  I've never seen those wrapped.
>>
>> I'm referring to the commit message itself.
> 
> Ah, you'd like lines extended because they are too short.

Exactly, it's way too short.

-- 
Jens Axboe

